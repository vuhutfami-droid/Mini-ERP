import csv, io, json, uuid, hashlib, functools
from datetime import timedelta
from pathlib import Path
from django.conf import settings
from django import forms
from django.http import JsonResponse, FileResponse, HttpResponse, HttpResponseForbidden
from django.shortcuts import render, redirect
from django.urls import reverse
from django.core import signing
from django.middleware.csrf import rotate_token
from django.views.decorators.http import require_POST
from django.core.paginator import Paginator
from psycopg import sql, IntegrityError, OperationalError, errors
from psycopg.types.json import Jsonb
from openpyxl import load_workbook, Workbook
from foundation import db, auth, services
from foundation.labels import label
from foundation.catalog import REGISTRY, FIELDS, form_class, draft_fields

COOKIE = "mini_erp_phien"


class ContextMiddleware:
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        request.user_info = None
        request.workspace = None
        request.workspaces = []
        try:
            with db.tx() as c:
                request.user_info = auth.session(c, request.COOKIES.get(COOKIE))
                if request.user_info:
                    c.execute(
                        "SELECT set_config('erp.tai_khoan',%s,true)",
                        (str(request.user_info["id"]),),
                    )
                    request.workspaces = c.execute(
                        "SELECT * FROM nen_tang.cac_bo_duoc_cap()"
                    ).fetchall()
                    chosen = request.COOKIES.get("mini_erp_bo")
                    request.workspace = next(
                        (x for x in request.workspaces if str(x["ma_dinh_danh"]) == chosen),
                        request.workspaces[0] if request.workspaces else None,
                    )
        except OperationalError:
            return render(
                request,
                "foundation/error.html",
                {
                    "message": "Dịch vụ dữ liệu tạm gián đoạn. Vui lòng thử lại; chưa có thao tác được xác nhận."
                },
                status=503,
            )
        response = self.get_response(request)
        response["Cache-Control"] = "no-store, private"
        response["X-Frame-Options"] = "DENY"
        response["Content-Security-Policy"] = (
            "default-src 'self'; img-src 'self' data:; style-src 'self'; script-src 'self'; frame-ancestors 'none'; base-uri 'self'; form-action 'self'"
        )
        return response


def context(request):
    return {
        "user_info": getattr(request, "user_info", None),
        "workspace": getattr(request, "workspace", None),
        "workspaces": getattr(request, "workspaces", []),
        "nav": getattr(request, "nav", []),
    }


def secured(fn):
    @functools.wraps(fn)
    def wrapped(request, *args, **kwargs):
        if not request.user_info:
            return redirect("login")
        if not request.workspace:
            return render(
                request,
                "foundation/error.html",
                {"message": "Chưa có bộ demo được cấp. Liên hệ người phụ trách truy cập."},
                status=403,
            )
        try:
            with db.tx(request.user_info["id"], request.workspace["ma_dinh_danh"]) as c:
                auth.require_session(c, request.user_info, request.COOKIES.get(COOKIE))
                request.conn = c
                request.w = request.workspace["ma_dinh_danh"]
                if request.method == "POST":
                    posted_workspace = (
                        json.loads(request.body).get("workspace")
                        if request.content_type == "application/json"
                        else request.POST.get("form_workspace")
                    )
                    if posted_workspace != str(request.w):
                        raise ValueError(
                            "Bộ demo đã đổi ở tab khác. Hãy tải lại biểu mẫu trước khi lưu; chưa ghi dữ liệu."
                        )
                request.nav = [
                    s for s in REGISTRY.values() if db.allowed(c, request.w, s["table"], "xem")
                ]
                return fn(request, *args, **kwargs)
        except PermissionError as e:
            return render(request, "foundation/error.html", {"message": str(e)}, status=403)
        except (ValueError, forms.ValidationError) as e:
            if request.headers.get("X-Requested-With") == "XMLHttpRequest":
                return JsonResponse({"error": str(e)}, status=409)
            return render(request, "foundation/error.html", {"message": str(e)}, status=409)
        except (IntegrityError, errors.DeadlockDetected):
            return render(
                request,
                "foundation/error.html",
                {
                    "message": "Nguồn hoặc phiên bản không hợp lệ, mã trùng hoặc dữ liệu đã thay đổi. Hãy kiểm tra lại; thao tác này đã được hoàn tác."
                },
                status=409,
            )

    return wrapped


class LoginForm(forms.Form):
    username = forms.CharField(label="Tên đăng nhập", max_length=100)
    password = forms.CharField(label="Mật khẩu", widget=forms.PasswordInput)


def login(request):
    if request.user_info:
        return redirect("home")
    form = LoginForm(request.POST or None)
    message = ""
    if request.method == "POST" and form.is_valid():
        token = auth.authenticate(form.cleaned_data["username"], form.cleaned_data["password"])
        if token:
            rotate_token(request)
            r = redirect("home")
            r.set_cookie(
                COOKIE,
                token,
                httponly=True,
                secure=not settings.DEBUG,
                samesite="Lax",
                max_age=settings.ERP_SESSION_HOURS * 3600,
            )
            return r
        message = (
            "Không thể đăng nhập. Kiểm tra thông tin hoặc thử lại sau nếu đã nhập sai nhiều lần."
        )
    return render(request, "foundation/login.html", {"form": form, "message": message})


@require_POST
def logout(request):
    if request.user_info:
        with db.tx() as c:
            c.execute(
                "UPDATE truy_cap.phien_dang_nhap SET thoi_diem_thu_hoi_quyen=now() WHERE ma_dinh_danh=%s",
                (request.user_info["phien"],),
            )
    r = redirect("login")
    r.delete_cookie(COOKIE)
    r.delete_cookie("mini_erp_bo")
    rotate_token(request)
    return r


@secured
def home(request):
    c = request.conn
    cards = []
    for slug in ["san-pham", "doi-tac", "nhan-su", "ca-lam"]:
        s = REGISTRY[slug]
        if db.allowed(c, request.w, s["table"], "xem"):
            count = c.execute(
                sql.SQL("SELECT count(*) n FROM {}").format(sql.Identifier(*s["table"].split(".")))
            ).fetchone()["n"]
            cards.append({"label": s["title"], "value": count, "slug": slug})
    waiting = c.execute(
        "SELECT count(*) n FROM dung_chung.chung_tu WHERE trang_thai_phe_duyet='da_trinh'"
    ).fetchone()["n"]
    return render(
        request,
        "foundation/home.html",
        {"cards": cards, "waiting": waiting, "title": "Tổng quan nền hệ thống"},
    )


@secured
@require_POST
def switch(request):
    candidate = request.POST.get("workspace")
    if not any(str(w["ma_dinh_danh"]) == candidate for w in request.workspaces):
        raise PermissionError("Bộ dữ liệu chưa được cấp quyền.")
    r = redirect("home")
    r.set_cookie("mini_erp_bo", candidate, httponly=True, secure=not settings.DEBUG, samesite="Lax")
    return r


def choices(c, w, spec):
    out = {}
    for n in spec["fields"]:
        dest = FIELDS[spec["table"]][n]["lien_ket_bang"]
        if dest == "truy_cap.dinh_danh_nguoi" and spec["table"] == "nhan_su.nhan_vien":
            rows = c.execute(
                "SELECT ma_dinh_danh,ten_hien_thi nhan FROM truy_cap.dinh_danh_nguoi ORDER BY ten_hien_thi LIMIT 500"
            ).fetchall()
            out[n] = [(str(r["ma_dinh_danh"]), r["nhan"]) for r in rows]
            continue
        if not dest or not db.allowed(c, w, dest, "xem"):
            continue
        cols = FIELDS[dest]
        label = (
            "ten" if "ten" in cols else "ma_nghiep_vu" if "ma_nghiep_vu" in cols else "ma_dinh_danh"
        )
        extra = sql.SQL("")
        if dest == "danh_muc.mat_hang" and n == "ma_nhom_mau":
            extra = sql.SQL("WHERE loai_mat_hang='nhom_mau'")
        rows = c.execute(
            sql.SQL("SELECT ma_dinh_danh,{} AS nhan FROM {} {} ORDER BY {} LIMIT 500").format(
                sql.Identifier(label),
                sql.Identifier(*dest.split(".")),
                extra,
                sql.Identifier(label),
            )
        ).fetchall()
        out[n] = [(str(r["ma_dinh_danh"]), str(r["nhan"])) for r in rows]
    return out


@secured
def catalog_list(request, slug):
    spec = REGISTRY.get(slug)
    if not spec:
        raise PermissionError("Chức năng chưa được mở.")
    c = request.conn
    db.require(c, request.w, spec["table"], "xem")
    term = request.GET.get("q", "").strip()[:150]
    display = [n for n in spec["fields"] if n not in ["tham_so", "cac_khoang_lam_viec_trong_ca"]][
        :6
    ]
    # Only explicit UI columns: no salary/password/source content leaks.
    select = ["ma_dinh_danh", *display]
    clauses = []
    params = []
    textfields = [n for n in display if FIELDS[spec["table"]][n]["kieu_du_lieu"] == "Văn bản"]
    if term and textfields:
        clauses.append(
            sql.SQL("(")
            + sql.SQL(" OR ").join(
                sql.SQL("{} ILIKE %s").format(sql.Identifier(n)) for n in textfields
            )
            + sql.SQL(")")
        )
        params.extend(["%" + term + "%"] * len(textfields))
    where = sql.SQL(" WHERE ") + sql.SQL(" AND ").join(clauses) if clauses else sql.SQL("")
    total = c.execute(
        sql.SQL("SELECT count(*) n FROM {} {}").format(
            sql.Identifier(*spec["table"].split(".")), where
        ),
        params,
    ).fetchone()["n"]
    try:
        page = max(1, int(request.GET.get("page", "1")))
    except ValueError:
        page = 1
    rows = c.execute(
        sql.SQL("SELECT {} FROM {} {} ORDER BY ma_dinh_danh LIMIT 50 OFFSET %s").format(
            sql.SQL(",").join(map(sql.Identifier, select)),
            sql.Identifier(*spec["table"].split(".")),
            where,
        ),
        params + [(page - 1) * 50],
    ).fetchall()
    refmaps = {n: dict(xs) for n, xs in choices(c, request.w, {**spec, "fields": display}).items()}
    viewrows = [
        {
            "id": r["ma_dinh_danh"],
            "cells": [
                (
                    ("Có" if r[n] else "Không")
                    if isinstance(r[n], bool)
                    else (
                        refmaps.get(n, {}).get(str(r[n]), "Nguồn đã chọn")
                        if FIELDS[spec["table"]][n]["lien_ket_bang"] and r[n] is not None
                        else str(label(r[n])) if r[n] is not None else "—"
                    )
                )
                for n in display
            ],
        }
        for r in rows
    ]
    return render(
        request,
        "foundation/list.html",
        {
            "title": spec["title"],
            "spec": spec,
            "rows": viewrows,
            "labels": [FIELDS[spec["table"]][n]["nhan_tieng_viet"] for n in display],
            "q": term,
            "total": total,
            "page": page,
            "has_next": page * 50 < total,
            "prev": max(1, page - 1),
            "next": page + 1,
            "can_create": db.allowed(c, request.w, spec["table"], "tao"),
            "can_export": db.allowed(c, request.w, spec["table"], "xuat_khau"),
        },
    )


@secured
def catalog_edit(request, slug, key=None):
    spec = REGISTRY.get(slug)
    if not spec:
        raise PermissionError("Chức năng chưa được mở.")
    c = request.conn
    writable = db.allowed(c, request.w, spec["table"], "dieu_chinh" if key else "tao")
    db.require(
        c,
        request.w,
        spec["table"],
        ("dieu_chinh" if key else "tao") if request.method == "POST" or not key else "xem",
    )
    record = db.get(c, spec["table"], key) if key else None
    if key and not record:
        raise PermissionError("Không có hồ sơ trong phạm vi.")
    if key and not writable:
        return render(
            request,
            "foundation/detail.html",
            {
                "title": spec["title"],
                "values": [
                    (FIELDS[spec["table"]][n]["nhan_tieng_viet"], record[n]) for n in spec["fields"]
                ],
            },
        )
    Form = form_class(spec, choices(c, request.w, spec))
    form = Form(request.POST if request.method == "POST" else None, initial=record or {})
    if request.method == "POST" and form.is_valid():
        result = db.idempotent(
            c,
            request.w,
            request.user_info["id"],
            request.POST.get("request_key"),
            {
                "slug": slug,
                "id": str(key or ""),
                "version": request.POST.get("version"),
                "data": form.cleaned_data,
            },
            "dieu_chinh" if key else "tao",
            lambda: services.save_catalog(
                c,
                request.w,
                request.user_info,
                spec,
                form.cleaned_data,
                key,
                request.POST.get("version"),
            ),
        )
        return redirect("catalog", slug=slug)
    draft_id = request.POST.get("draft_id") or request.GET.get("draft") or str(db.uid())
    return render(
        request,
        "foundation/form.html",
        {
            "title": ("Sửa " if key else "Thêm ") + spec["title"].lower(),
            "form": form,
            "spec": spec,
            "record": record,
            "version": request.POST.get("version")
            or (record or {}).get("so_phien_ban_ghi_dong_thoi", 1),
            "request_key": request.POST.get("request_key") or str(db.uid()),
            "draft_id": draft_id,
            "entity_id": str(key or ""),
            "form_kind": slug,
        },
    )


@secured
@require_POST
def draft(request):
    c = request.conn
    payload = json.loads(request.body)
    spec = REGISTRY.get(payload.get("kind"))
    if not spec:
        raise ValueError("Biểu mẫu nháp không hợp lệ.")
    db.require(c, request.w, spec["table"], "dieu_chinh" if payload.get("entity") else "tao")
    fields = payload.get("fields", {})
    if not isinstance(fields, dict) or set(fields) - draft_fields(spec):
        raise ValueError("Nháp chứa trường ngoài phạm vi.")
    if len(db.canonical(fields)) > 30000:
        raise ValueError("Nháp quá lớn.")
    key = uuid.UUID(payload["id"])
    old = c.execute(
        "SELECT * FROM nen_tang.ban_nhap_bieu_mau WHERE ma_dinh_danh=%s FOR UPDATE", (key,)
    ).fetchone()
    if old:
        if old["so_phien_ban"] != payload.get("version"):
            raise ValueError("Nháp đã đổi ở tab khác; không ghi đè.")
        c.execute(
            "UPDATE nen_tang.ban_nhap_bieu_mau SET noi_dung_nhap=%s,so_phien_ban=so_phien_ban+1,thoi_diem_cap_nhat=now() WHERE ma_dinh_danh=%s",
            (Jsonb(fields), key),
        )
        version = old["so_phien_ban"] + 1
    else:
        db.insert(
            c,
            "nen_tang.ban_nhap_bieu_mau",
            {
                "ma_dinh_danh": key,
                "ma_bo_du_lieu": request.w,
                "ma_tai_khoan": request.user_info["id"],
                "loai_bieu_mau": payload["kind"],
                "noi_dung_nhap": fields,
            },
        )
        version = 1
    return JsonResponse({"saved": True, "version": version})


@secured
def draft_load(request, key):
    r = request.conn.execute(
        "SELECT * FROM nen_tang.ban_nhap_bieu_mau WHERE ma_dinh_danh=%s AND thoi_diem_cap_nhat>now()-interval '7 days'",
        (key,),
    ).fetchone()
    if not r:
        raise PermissionError("Không có nháp hoặc nháp đã hết hạn.")
    s = REGISTRY[r["loai_bieu_mau"]]
    db.require(request.conn, request.w, s["table"], "tao")
    return JsonResponse({"fields": r["noi_dung_nhap"], "version": r["so_phien_ban"]})


@secured
def catalog_export(request, slug):
    s = REGISTRY.get(slug)
    if not s:
        raise PermissionError("Không có biểu mẫu này.")
    db.require(request.conn, request.w, s["table"], "xuat_khau")
    wb = Workbook()
    sheet = wb.active
    sheet.title = "Danh sách"
    fields = s["fields"]
    sheet.append([FIELDS[s["table"]][n]["nhan_tieng_viet"] for n in fields])
    rows = request.conn.execute(
        sql.SQL("SELECT {} FROM {} ORDER BY ma_dinh_danh LIMIT 10000").format(
            sql.SQL(",").join(map(sql.Identifier, fields)), sql.Identifier(*s["table"].split("."))
        )
    ).fetchall()
    for r in rows:
        row = []
        for n in fields:
            value = r[n]
            v = str(value) if value is not None else ""
            # Spreadsheet formula injection protection.
            row.append("'" + v if v.startswith(("=", "+", "-", "@")) else v)
        sheet.append(row)
    stream = io.BytesIO()
    wb.save(stream)
    db.audit(request.conn, request.w, request.user_info["id"], "xuat_danh_muc", reason=s["title"])
    r = HttpResponse(
        stream.getvalue(),
        content_type="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
    )
    r["Content-Disposition"] = f'attachment; filename="{slug}.xlsx"'
    return r


@secured
def documents(request):
    c = request.conn
    db.require(c, request.w, services.HEAD, "xem")
    rows = c.execute(
        "SELECT * FROM dung_chung.chung_tu ORDER BY thoi_diem_tao DESC LIMIT 100"
    ).fetchall()
    for r in rows:
        r["nhan_loai"] = label(r["loai"])
        r["nhan_trang_thai"] = label(r["trang_thai_phe_duyet"])
    return render(
        request,
        "foundation/documents.html",
        {
            "title": "Chứng từ và việc cần xử lý",
            "rows": rows,
            "can_create": db.allowed(c, request.w, services.HEAD, "tao"),
        },
    )


class DocumentForm(forms.Form):
    code = forms.CharField(label="Mã hồ sơ", max_length=100)
    kind = forms.ChoiceField(
        label="Loại công việc",
        choices=[
            ("quyet_dinh_danh_muc", "Đề nghị danh mục quan trọng"),
            ("quyet_dinh_chinh_sach", "Đề nghị chính sách"),
            ("quyet_dinh_cap_quyen", "Đề nghị cấp/thu hồi quyền"),
            ("phan_cong", "Phân công"),
            ("ho_so_lam_viec", "Hồ sơ làm việc"),
            ("ky_nang", "Kỹ năng/an toàn"),
        ],
    )
    reason = forms.CharField(label="Nội dung và căn cứ", widget=forms.Textarea)
    scope = forms.CharField(
        label="Phạm vi áp dụng (nội dung công việc)", required=False, max_length=500
    )
    product = forms.UUIDField(label="Mặt hàng cần giám đốc duyệt quy cách", required=False)


@secured
def new_document(request):
    db.require(request.conn, request.w, services.HEAD, "tao")
    form = DocumentForm(request.POST or None)
    select_field(
        form, "product", request.conn, "danh_muc.mat_hang", "ten", "WHERE loai_mat_hang='bien_the'"
    )
    form.fields["product"].required = False
    if request.method == "POST" and form.is_valid():
        x = form.cleaned_data
        if x["kind"] == "quyet_dinh_cap_quyen":
            return redirect("access_request")
        r = db.idempotent(
            request.conn,
            request.w,
            request.user_info["id"],
            request.POST.get("request_key"),
            x,
            "tao",
            lambda: services.create_document(
                request.conn,
                request.w,
                request.user_info,
                x["code"],
                x["kind"],
                x["reason"],
                (
                    "mat_hang:" + str(x["product"])
                    if x["kind"] == "quyet_dinh_danh_muc" and x["product"]
                    else x["scope"]
                ),
            ),
        )
        return redirect("document", key=r["cac_ma_chung_tu"][0])
    return render(
        request,
        "foundation/form.html",
        {
            "title": "Lập hồ sơ nguồn",
            "form": form,
            "request_key": request.POST.get("request_key") or str(db.uid()),
        },
    )


@secured
def document(request, key):
    c = request.conn
    h = db.get(c, services.HEAD, key)
    if not h:
        raise PermissionError("Chứng từ ngoài phạm vi.")
    files = c.execute(
        "SELECT ma_dinh_danh,loai_dinh_dang_tep,dung_luong_tep_tinh_theo_byte FROM dung_chung.chung_cu_dinh_kem WHERE ma_phien_ban_chung_tu=%s",
        (key,),
    ).fetchall()
    history = c.execute(
        "SELECT hanh_dong,thoi_diem_he_thong_ghi_nhan,ly_do FROM dung_chung.nhat_ky_thao_tac WHERE ma_phien_ban_chung_tu=%s ORDER BY thoi_diem_he_thong_ghi_nhan",
        (key,),
    ).fetchall()
    handoffs = c.execute(
        "SELECT * FROM dung_chung.trao_doi_va_ban_giao WHERE ma_phien_ban_chung_tu=%s ORDER BY thoi_diem_tao",
        (key,),
    ).fetchall()
    h["nhan_loai"] = label(h["loai"])
    h["nhan_trang_thai"] = label(h["trang_thai_phe_duyet"])
    h["nhan_ghi_so"] = label(h["trang_thai_ghi_so"])
    for b in handoffs:
        b["nhan_trang_thai"] = label(b["trang_thai_xu_ly"])
    return render(
        request,
        "foundation/document.html",
        {
            "title": h["ma_nghiep_vu"],
            "h": h,
            "files": files,
            "history": history,
            "handoffs": handoffs,
            "employee_id": services.employee(c, request.user_info),
            "can_approve": db.allowed(c, request.w, services.HEAD, "phe_duyet"),
            "request_key": str(db.uid()),
        },
    )


@secured
@require_POST
def document_action(request, key):
    x = {k: request.POST.get(k, "") for k in ["action", "version", "reason"]}
    db.idempotent(
        request.conn,
        request.w,
        request.user_info["id"],
        request.POST.get("request_key"),
        {"id": str(key), **x},
        "phe_duyet" if x["action"] in ["duyet", "tu_choi"] else "tao",
        lambda: services.document_action(
            request.conn, request.w, request.user_info, key, x["action"], x["version"], x["reason"]
        ),
    )
    return redirect("document", key=key)


@secured
@require_POST
def upload(request, key):
    if "file" not in request.FILES:
        raise ValueError("Chưa chọn tệp.")
    f = request.FILES["file"]
    digest = hashlib.sha256(f.read(settings.ERP_UPLOAD_MAX + 1)).hexdigest()
    f.seek(0)
    db.idempotent(
        request.conn,
        request.w,
        request.user_info["id"],
        request.POST.get("request_key"),
        {"document": str(key), "digest": digest},
        "tao",
        lambda: {
            "cac_ma_chung_tu": [key],
            "cac_ma_dong": [],
            "cac_ma_su_kien": [services.attach(request.conn, request.w, request.user_info, key, f)],
        },
    )
    return redirect("document", key=key)


@secured
def file_download(request, key):
    c = request.conn
    db.require(c, request.w, "dung_chung.chung_cu_dinh_kem", "xem")
    r = db.get(c, "dung_chung.chung_cu_dinh_kem", key)
    if not r or r["muc_nhay_cam"] == "thu_nhap":
        raise PermissionError("Không được tải chứng cứ này.")
    path = settings.ERP_MEDIA_ROOT / r["khoa_tep_trong_noi_luu"]
    if not path.is_file() or hashlib.sha256(path.read_bytes()).hexdigest() != r["ma_kiem_toan_ven"]:
        raise ValueError("Tệp không toàn vẹn.")
    return FileResponse(
        path.open("rb"), as_attachment=True, filename="chung-cu." + r["loai_dinh_dang_tep"]
    )


@secured
def audit_list(request):
    c = request.conn
    db.require(c, request.w, "dung_chung.nhat_ky_thao_tac", "xem")
    rows = c.execute(
        "SELECT hanh_dong,thoi_diem_he_thong_ghi_nhan,ly_do,ma_phien_ban_chung_tu FROM dung_chung.nhat_ky_thao_tac ORDER BY thoi_diem_he_thong_ghi_nhan DESC LIMIT 100"
    ).fetchall()
    return render(request, "foundation/audit.html", {"title": "Lịch sử thao tác", "rows": rows})


@secured
def health(request):
    request.conn.execute("SELECT 1")
    return JsonResponse({"status": "ok", "phase": "D01", "database": "PostgreSQL"})


class StockForm(forms.Form):
    code = forms.CharField(label="Mã biên bản tồn đầu", max_length=80)
    item = forms.UUIDField(label="Mặt hàng")
    position = forms.UUIDField(label="Vị trí trong KHO-01")
    quantity = forms.DecimalField(
        label="Lượng đếm thực theo đơn vị cơ sở", max_digits=24, decimal_places=6, min_value=0
    )
    reason = forms.CharField(label="Căn cứ, ngày đếm và mô tả nguồn giả lập", widget=forms.Textarea)


class CashForm(forms.Form):
    code = forms.CharField(label="Mã biên bản tiền đầu", max_length=80)
    fund = forms.UUIDField(label="Quỹ")
    amount = forms.DecimalField(
        label="Số dư được đối chiếu (VND)", max_digits=24, decimal_places=0, min_value=0
    )
    reason = forms.CharField(label="Căn cứ đối chiếu, mốc và nguồn giả lập", widget=forms.Textarea)


def select_field(form, field, c, table, label, condition=""):
    rows = (
        c.execute("SELECT * FROM nen_tang.danh_sach_nguoi_ban_giao()").fetchall()
        if table == "nhan_su.nhan_vien"
        and not db.allowed(
            c,
            uuid.UUID(c.execute("SELECT current_setting('erp.bo') bo").fetchone()["bo"]),
            table,
            "xem",
        )
        else c.execute(
            sql.SQL("SELECT ma_dinh_danh,{} nhan FROM {} {} ORDER BY {}").format(
                sql.Identifier(label),
                sql.Identifier(*table.split(".")),
                sql.SQL(condition),
                sql.Identifier(label),
            )
        ).fetchall()
    )
    form.fields[field] = forms.TypedChoiceField(
        label=form.fields[field].label,
        choices=[("", "— Chọn —")] + [(str(r["ma_dinh_danh"]), str(r["nhan"])) for r in rows],
        coerce=uuid.UUID,
    )


@secured
def openings(request):
    c = request.conn
    stocks = c.execute(
        """SELECT d.ma_dinh_danh,d.so_luong_do_theo_don_vi_co_so,h.ma_nghiep_vu,h.trang_thai_ghi_so,h.ma_chung_tu_goc,p.tinh_trang_chat_luong,m.ten,m.dang_su_dung,p.quyen_so_huu,
 (SELECT sum(g.so_tien) FROM tai_chinh.bien_dong_gia_tri g WHERE g.ma_dong_van_dong_hang=d.ma_dinh_danh) gia_tri
 FROM kho.dong_van_dong_hang d JOIN dung_chung.chung_tu h ON h.ma_dinh_danh=d.ma_phieu_van_dong_hang JOIN kho.phan_lo_hang p ON p.ma_dinh_danh=d.ma_phan_lo_dich JOIN kho.lo_hang l ON l.ma_dinh_danh=p.ma_lo_hang JOIN danh_muc.mat_hang m ON m.ma_dinh_danh=l.ma_mat_hang WHERE h.loai_van_dong_kho='dau_ky' ORDER BY h.thoi_diem_tao DESC LIMIT 100"""
    ).fetchall()
    cash = c.execute(
        "SELECT t.*,q.ma_nghiep_vu FROM tai_chinh.bien_dong_tien_thuc t JOIN tai_chinh.quy_va_tai_khoan_tien q ON q.ma_dinh_danh=t.ma_quy_hoac_tai_khoan_tien ORDER BY t.thoi_diem_he_thong_ghi_nhan DESC LIMIT 100"
    ).fetchall()
    for r in stocks:
        r["nhan_chat_luong"] = label(r["tinh_trang_chat_luong"])
        r["nhan_ghi_so"] = label(r["trang_thai_ghi_so"])
        r["usable"] = (
            r["trang_thai_ghi_so"] == "da_ghi_so"
            and r["tinh_trang_chat_luong"] == "dat"
            and r["dang_su_dung"]
            and r["quyen_so_huu"] == "doanh_nghiep"
        )
    for r in cash:
        r["nhan_ghi_so"] = label(r["trang_thai_ghi_so"])
    return render(
        request,
        "foundation/openings.html",
        {
            "title": "Nguồn tồn kho và tiền mở đầu",
            "stocks": stocks,
            "cash": cash,
            "can_stock": db.allowed(c, request.w, "kho.dong_van_dong_hang", "tao"),
            "can_cash": db.allowed(c, request.w, "tai_chinh.bien_dong_tien_thuc", "tao"),
            "can_qc": db.allowed(c, request.w, "chat_luong.phieu_kiem_tra_chat_luong", "xac_nhan"),
            "can_value": db.allowed(c, request.w, "tai_chinh.bien_dong_gia_tri", "xac_nhan"),
            "request_key": str(db.uid()),
        },
    )


@secured
def opening_new(request, kind):
    c = request.conn
    if kind == "stock":
        db.require(c, request.w, "kho.dong_van_dong_hang", "tao")
        form = StockForm(request.POST or None)
        select_field(form, "item", c, "danh_muc.mat_hang", "ten", "WHERE loai_mat_hang<>'nhom_mau'")
        select_field(
            form,
            "position",
            c,
            "dung_chung.vi_tri_giu_hang",
            "ma_nghiep_vu",
            "WHERE ma_kho_vat_ly='KHO-01'",
        )
    else:
        db.require(c, request.w, "tai_chinh.bien_dong_tien_thuc", "tao")
        form = CashForm(request.POST or None)
        select_field(form, "fund", c, "tai_chinh.quy_va_tai_khoan_tien", "ma_nghiep_vu")
    if request.method == "POST" and form.is_valid():
        x = form.cleaned_data

        def work(receipt):
            if kind == "stock":
                return services.opening_stock(
                    c,
                    request.w,
                    request.user_info,
                    x["code"],
                    x["item"],
                    x["position"],
                    x["quantity"],
                    x["reason"],
                )
            return services.opening_cash(
                c,
                request.w,
                request.user_info,
                x["code"],
                x["fund"],
                x["amount"],
                x["reason"],
                receipt,
            )

        r = db.idempotent(
            c,
            request.w,
            request.user_info["id"],
            request.POST.get("request_key"),
            {"kind": kind, **x},
            "tao",
            work,
        )
        return redirect("document", key=r["cac_ma_chung_tu"][0])
    return render(
        request,
        "foundation/form.html",
        {
            "title": "Lập nguồn tồn đầu" if kind == "stock" else "Lập nguồn tiền đầu",
            "form": form,
            "request_key": request.POST.get("request_key") or str(db.uid()),
            "note": "Lưu nguồn chưa thay số dư. Đính kèm biên bản rồi người đúng quyền xác nhận.",
        },
    )


@secured
@require_POST
def opening_post(request, key, kind):
    c = request.conn
    fn = services.post_opening if kind == "stock" else services.post_cash
    db.idempotent(
        c,
        request.w,
        request.user_info["id"],
        request.POST.get("request_key"),
        {"id": str(key), "kind": kind},
        "xac_nhan",
        lambda receipt: fn(c, request.w, request.user_info, key, receipt),
    )
    return redirect("openings")


class QcForm(forms.Form):
    policy = forms.UUIDField(label="Bộ tiêu chí đã duyệt")
    result = forms.ChoiceField(
        label="Kết luận cho toàn bộ phần mở đầu",
        choices=[("", "— Chọn kết luận —"), ("dat", "Đạt"), ("loi", "Lỗi")],
    )
    observation = forms.CharField(
        label="Nội dung biên bản và kết luận chung", widget=forms.Textarea
    )


@secured
def opening_qc(request, key):
    c = request.conn
    db.require(c, request.w, "chat_luong.phieu_kiem_tra_chat_luong", "xac_nhan")
    form = QcForm(request.POST or None)
    select_field(
        form,
        "policy",
        c,
        "dung_chung.phien_ban_chinh_sach",
        "ma_nghiep_vu",
        "WHERE loai='kiem_chat_luong' AND ma_phe_duyet IS NOT NULL",
    )
    selected = request.POST.get("policy") or request.GET.get("policy")
    criteria = []
    if selected:
        policy = db.get(c, "dung_chung.phien_ban_chinh_sach", uuid.UUID(selected))
        if policy:
            criteria = [
                str(x["gia_tri"])
                for x in policy["tham_so"]["cac_tham_so"]
                if x["ten_tham_so"] == "ma_tieu_chi"
            ]
    for i, criterion in enumerate(criteria):
        form.fields[f"quan_sat_{i}"] = forms.CharField(
            label="Quan sát tiêu chí " + criterion, widget=forms.Textarea
        )
        form.fields[f"ket_qua_{i}"] = forms.ChoiceField(
            label="Kết quả " + criterion, choices=[("dat", "Đạt"), ("loi", "Không đạt")]
        )
    if request.method == "POST" and form.is_valid():
        x = form.cleaned_data
        observations = {
            criterion: {"observation": x[f"quan_sat_{i}"], "result": x[f"ket_qua_{i}"]}
            for i, criterion in enumerate(criteria)
        }
        db.idempotent(
            c,
            request.w,
            request.user_info["id"],
            request.POST.get("request_key"),
            {"line": str(key), **x},
            "xac_nhan",
            lambda: services.opening_qc(
                c,
                request.w,
                request.user_info,
                key,
                x["result"],
                x["observation"],
                x["policy"],
                observations,
            ),
        )
        return redirect("openings")
    return render(
        request,
        "foundation/form.html",
        {
            "title": "Kiểm chất lượng nguồn mở đầu",
            "form": form,
            "qc_select": True,
            "request_key": request.POST.get("request_key") or str(db.uid()),
            "note": "Đợt nền kiểm phần mở đầu theo biên bản. Không kết luận từ tỷ lệ kế hoạch hoặc mẫu chưa được xác nhận.",
        },
    )


class ValueForm(forms.Form):
    amount = forms.DecimalField(
        label="Giá trị mở đầu theo hồ sơ (VND)", max_digits=24, decimal_places=0, min_value=0
    )
    reason = forms.CharField(label="Căn cứ định giá", widget=forms.Textarea)


@secured
def opening_value(request, key):
    c = request.conn
    db.require(c, request.w, "tai_chinh.bien_dong_gia_tri", "xac_nhan")
    form = ValueForm(request.POST or None)
    if request.method == "POST" and form.is_valid():
        x = form.cleaned_data
        db.idempotent(
            c,
            request.w,
            request.user_info["id"],
            request.POST.get("request_key"),
            {"line": str(key), **x},
            "xac_nhan",
            lambda: services.opening_value(
                c, request.w, request.user_info, key, x["amount"], x["reason"]
            ),
        )
        return redirect("openings")
    return render(
        request,
        "foundation/form.html",
        {
            "title": "Xác nhận giá trị nguồn tồn đầu",
            "form": form,
            "request_key": request.POST.get("request_key") or str(db.uid()),
        },
    )


class PasswordForm(forms.Form):
    old = forms.CharField(label="Mật khẩu hiện tại", widget=forms.PasswordInput)
    new = forms.CharField(
        label="Mật khẩu mới (ít nhất 12 ký tự)", min_length=12, widget=forms.PasswordInput
    )
    confirm = forms.CharField(label="Nhập lại mật khẩu mới", widget=forms.PasswordInput)


@secured
def password(request):
    from django.contrib.auth.hashers import check_password, make_password

    c = request.conn
    form = PasswordForm(request.POST or None)
    if request.method == "POST" and form.is_valid():
        a = db.get(c, "truy_cap.tai_khoan_dang_nhap", request.user_info["id"], True)
        x = form.cleaned_data
        if (
            not check_password(x["old"], a["ban_bam_thong_tin_xac_thuc"])
            or x["new"] != x["confirm"]
        ):
            form.add_error(None, "Mật khẩu hiện tại hoặc xác nhận không đúng.")
        else:
            db.update(
                c,
                "truy_cap.tai_khoan_dang_nhap",
                a["ma_dinh_danh"],
                {
                    "ban_bam_thong_tin_xac_thuc": make_password(x["new"]),
                    "so_phien_ban_quyen_xac_thuc": a["so_phien_ban_quyen_xac_thuc"] + 1,
                },
            )
            c.execute(
                "UPDATE truy_cap.phien_dang_nhap SET thoi_diem_thu_hoi_quyen=now() WHERE ma_tai_khoan=%s",
                (a["ma_dinh_danh"],),
            )
            db.audit(c, request.w, a["ma_dinh_danh"], "doi_mat_khau")
            r = redirect("login")
            r.delete_cookie(COOKIE)
            return r
    return render(
        request,
        "foundation/form.html",
        {"title": "Đổi mật khẩu", "form": form, "request_key": str(db.uid())},
    )


@secured
def access(request):
    c = request.conn
    db.require(c, request.w, "truy_cap.cap_vai_tro", "xem")
    rows = c.execute(
        "SELECT g.ma_dinh_danh,g.ma_tai_khoan,g.thoi_diem_thu_hoi_quyen,g.thoi_diem_ket_thuc_hieu_luc,a.ten_dang_nhap,v.ten FROM truy_cap.cap_vai_tro g JOIN truy_cap.tai_khoan_dang_nhap a ON a.ma_dinh_danh=g.ma_tai_khoan JOIN truy_cap.vai_tro_cong_viec v ON v.ma_dinh_danh=g.ma_vai_tro ORDER BY a.ten_dang_nhap"
    ).fetchall()
    decisions = c.execute(
        "SELECT ma_dinh_danh,ma_nghiep_vu FROM dung_chung.chung_tu WHERE loai='quyet_dinh_cap_quyen' AND trang_thai_phe_duyet='da_duyet' ORDER BY thoi_diem_tao DESC"
    ).fetchall()
    return render(
        request,
        "foundation/access.html",
        {
            "title": "Tài khoản và phạm vi truy cập",
            "rows": rows,
            "decisions": decisions,
            "can_apply": db.allowed(c, request.w, "truy_cap.cap_vai_tro", "dieu_chinh"),
            "request_key": str(db.uid()),
        },
    )


@secured
@require_POST
def apply_access(request, key):
    c = request.conn
    db.require(c, request.w, "truy_cap.cap_vai_tro", "dieu_chinh")
    h = db.get(c, services.HEAD, key, True)
    if not h or h["loai"] != "quyet_dinh_cap_quyen" or h["trang_thai_phe_duyet"] != "da_duyet":
        raise ValueError("Cần quyết định cấp/thu hồi quyền đã duyệt đúng bản.")
    if (h["pham_vi"] or "").startswith("uy_quyen:"):
        return apply_delegation(request, h)
    mode, target, role = (h["pham_vi"] or "").split(":")
    target = uuid.UUID(target)
    role = uuid.UUID(role)
    account = db.get(c, "truy_cap.tai_khoan_dang_nhap", target, True)
    if account["ma_nguoi_that"] == request.user_info["ma_nguoi_that"]:
        raise ValueError("Không tự áp dụng thay đổi quyền cho mình.")

    def work():
        events = []
        if mode == "thu_hoi":
            rows = c.execute(
                "SELECT ma_dinh_danh FROM truy_cap.cap_vai_tro WHERE ma_tai_khoan=%s AND ma_vai_tro=%s AND thoi_diem_thu_hoi_quyen IS NULL FOR UPDATE",
                (target, role),
            ).fetchall()
            for r in rows:
                db.update(
                    c,
                    "truy_cap.cap_vai_tro",
                    r["ma_dinh_danh"],
                    {"thoi_diem_thu_hoi_quyen": db.now()},
                )
                events.append(r["ma_dinh_danh"])
        elif mode == "cap":
            if h.get("thoi_diem_moc_doi_chieu") and h["thoi_diem_moc_doi_chieu"] <= db.now():
                raise ValueError("Quyết định cấp quyền đã hết hạn; cần đề nghị mới.")
            if c.execute(
                "SELECT 1 FROM truy_cap.cap_vai_tro WHERE ma_tai_khoan=%s AND ma_vai_tro=%s AND thoi_diem_thu_hoi_quyen IS NULL",
                (target, role),
            ).fetchone():
                raise ValueError("Tài khoản đã có vai trò còn hiệu lực.")
            grant = db.uid()
            db.insert(
                c,
                "truy_cap.cap_vai_tro",
                {
                    "ma_dinh_danh": grant,
                    "ma_bo_du_lieu": request.w,
                    "ma_tai_khoan": target,
                    "ma_vai_tro": role,
                    "ma_phe_duyet": h["ma_phe_duyet"],
                    "thoi_diem_bat_dau_hieu_luc": db.now(),
                    "thoi_diem_ket_thuc_hieu_luc": h.get("thoi_diem_moc_doi_chieu"),
                    "ma_tai_khoan_thuc_hien": request.user_info["id"],
                },
            )
            events.append(grant)
        else:
            raise ValueError("Phạm vi quyết định không đúng.")
        db.update(
            c,
            "truy_cap.tai_khoan_dang_nhap",
            target,
            {"so_phien_ban_quyen_xac_thuc": account["so_phien_ban_quyen_xac_thuc"] + 1},
        )
        c.execute(
            "UPDATE truy_cap.phien_dang_nhap SET thoi_diem_thu_hoi_quyen=now() WHERE ma_tai_khoan=%s",
            (target,),
        )
        db.audit(c, request.w, request.user_info["id"], "ap_dung_quyen", key)
        return {"cac_ma_chung_tu": [key], "cac_ma_dong": [], "cac_ma_su_kien": events}

    db.idempotent(
        c,
        request.w,
        request.user_info["id"],
        request.POST.get("request_key"),
        {"decision": str(key)},
        "xac_nhan",
        work,
    )
    return redirect("access")


class HandoffForm(forms.Form):
    receiver = forms.UUIDField(label="Người nhận công việc")
    content = forms.CharField(label="Nội dung và điều kiện bàn giao", widget=forms.Textarea)


@secured
def handoff_new(request, key):
    c = request.conn
    db.require(c, request.w, "dung_chung.trao_doi_va_ban_giao", "tao")
    f = HandoffForm(request.POST or None)
    select_field(f, "receiver", c, "nhan_su.nhan_vien", "ten")
    if request.method == "POST" and f.is_valid():
        x = f.cleaned_data
        db.idempotent(
            c,
            request.w,
            request.user_info["id"],
            request.POST.get("request_key"),
            {"source": str(key), **x},
            "tao",
            lambda: services.handoff(
                c, request.w, request.user_info, key, x["receiver"], x["content"]
            ),
        )
        return redirect("document", key=key)
    return render(
        request,
        "foundation/form.html",
        {
            "title": "Bàn giao công việc từ hồ sơ",
            "form": f,
            "request_key": request.POST.get("request_key") or str(db.uid()),
        },
    )


@secured
@require_POST
def handoff_reply(request, key):
    x = {k: request.POST.get(k, "") for k in ("content", "version", "accepted")}
    r = db.idempotent(
        request.conn,
        request.w,
        request.user_info["id"],
        request.POST.get("request_key"),
        {"id": str(key), **x},
        "xac_nhan",
        lambda: services.handoff(
            request.conn,
            request.w,
            request.user_info,
            None,
            None,
            x["content"],
            key,
            x["version"],
            x["accepted"] == "yes",
        ),
    )
    return redirect("document", key=r["cac_ma_chung_tu"][0])


class AccountForm(forms.Form):
    person = forms.UUIDField(label="Người được tạo tài khoản")
    username = forms.RegexField(label="Tên đăng nhập", regex=r"^[a-zA-Z0-9._-]{3,50}$")
    password = forms.CharField(
        label="Mật khẩu ban đầu (ít nhất 12 ký tự)", min_length=12, widget=forms.PasswordInput
    )


@secured
def account_new(request):
    c = request.conn
    db.require(c, request.w, "truy_cap.cap_vai_tro", "tao")
    f = AccountForm(request.POST or None)
    select_field(f, "person", c, "truy_cap.dinh_danh_nguoi", "ten_hien_thi")
    if request.method == "POST" and f.is_valid():
        x = f.cleaned_data
        db.idempotent(
            c,
            request.w,
            request.user_info["id"],
            request.POST.get("request_key"),
            {
                "person": str(x["person"]),
                "username": x["username"],
                "password_digest": hashlib.sha256(x["password"].encode()).hexdigest(),
            },
            "tao",
            lambda: services.create_account(
                c, request.w, request.user_info, x["person"], x["username"], x["password"]
            ),
        )
        return redirect("access")
    return render(
        request,
        "foundation/form.html",
        {
            "title": "Tạo tài khoản cá nhân chưa cấp quyền",
            "form": f,
            "request_key": request.POST.get("request_key") or str(db.uid()),
        },
    )


class AccessRequestForm(forms.Form):
    code = forms.CharField(label="Mã đề nghị", max_length=100)
    mode = forms.ChoiceField(
        label="Công việc", choices=[("cap", "Cấp vai trò"), ("thu_hoi", "Thu hồi vai trò")]
    )
    account = forms.UUIDField(label="Tài khoản cần thay đổi quyền")
    role = forms.UUIDField(label="Vai trò công việc")
    until = forms.DateTimeField(
        label="Hết hạn quyền (bỏ trống nếu lâu dài)",
        required=False,
        widget=forms.DateTimeInput(format="%Y-%m-%dT%H:%M", attrs={"type": "datetime-local"}),
    )
    reason = forms.CharField(label="Lý do và căn cứ", widget=forms.Textarea)


@secured
def access_request(request):
    c = request.conn
    db.require(c, request.w, "truy_cap.cap_vai_tro", "tao")
    f = AccessRequestForm(request.POST or None)
    select_field(f, "account", c, "truy_cap.tai_khoan_dang_nhap", "ten_dang_nhap")
    select_field(f, "role", c, "truy_cap.vai_tro_cong_viec", "ten")
    if request.method == "POST" and f.is_valid():
        x = f.cleaned_data
        if x["until"] and x["until"] <= db.now():
            raise ValueError("Hết hạn phải sau thời điểm hiện tại.")

        def work():
            r = services.create_document(
                c,
                request.w,
                request.user_info,
                x["code"],
                "quyet_dinh_cap_quyen",
                x["reason"],
                ":".join([x["mode"], str(x["account"]), str(x["role"])]),
            )
            db.update(
                c, services.HEAD, r["cac_ma_chung_tu"][0], {"thoi_diem_moc_doi_chieu": x["until"]}
            )
            return r

        r = db.idempotent(
            c, request.w, request.user_info["id"], request.POST.get("request_key"), x, "tao", work
        )
        return redirect("document", key=r["cac_ma_chung_tu"][0])
    return render(
        request,
        "foundation/form.html",
        {
            "title": "Đề nghị thay đổi quyền để giám đốc duyệt",
            "form": f,
            "request_key": request.POST.get("request_key") or str(db.uid()),
        },
    )


@secured
def status(request):
    db.require(request.conn, request.w, services.HEAD, "xem")
    n = request.conn.execute(
        "SELECT count(*) n FROM dung_chung.chung_tu WHERE trang_thai_phe_duyet='da_trinh'"
    ).fetchone()["n"]
    return JsonResponse({"waiting": n, "time": db.now().isoformat()})


class ImportForm(forms.Form):
    file = forms.FileField(label="Tệp Excel theo mẫu xuất của danh mục")
    source = forms.CharField(label="Căn cứ và người lập dữ liệu", widget=forms.Textarea)


@secured
def catalog_import(request, slug):
    from foundation.imports import preview

    s = REGISTRY.get(slug)
    if slug not in ("san-pham", "doi-tac"):
        raise PermissionError("Đợt nền nhập Excel cho mặt hàng và đối tác.")
    c = request.conn
    db.require(c, request.w, s["table"], "tao")
    f = ImportForm(request.POST or None, request.FILES or None)
    if request.method == "POST" and request.POST.get("preview_token"):
        try:
            payload = signing.loads(request.POST["preview_token"], salt="erp-import", max_age=1800)
        except signing.BadSignature:
            raise ValueError("Bản xem trước hết hạn hoặc đã đổi. Hãy xem trước lại.")
        if (
            payload["actor"] != str(request.user_info["id"])
            or payload["workspace"] != str(request.w)
            or payload["slug"] != slug
        ):
            raise PermissionError("Bản xem trước thuộc người hoặc bộ khác.")

        def work():
            events = []
            Form = form_class(s, choices(c, request.w, s))
            for data in payload["rows"]:
                form = Form(data)
                if not form.is_valid():
                    raise ValueError("Dữ liệu tham chiếu đã đổi; cần xem trước lại.")
                result = services.save_catalog(
                    c, request.w, request.user_info, s, form.cleaned_data
                )
                events += result["cac_ma_su_kien"]
            db.audit(c, request.w, request.user_info["id"], "nhap_Excel", reason=payload["source"])
            return {"cac_ma_chung_tu": [], "cac_ma_dong": [], "cac_ma_su_kien": events}

        db.idempotent(c, request.w, request.user_info["id"], payload["key"], payload, "tao", work)
        return redirect("catalog", slug=slug)
    if request.method == "POST" and f.is_valid():
        upload = f.cleaned_data["file"]
        rows = preview(
            upload.name, upload.read(settings.ERP_UPLOAD_MAX + 1), s, choices(c, request.w, s)
        )
        payload = {
            "actor": str(request.user_info["id"]),
            "workspace": str(request.w),
            "slug": slug,
            "source": f.cleaned_data["source"],
            "rows": rows,
            "key": str(db.uid()),
        }
        return render(
            request,
            "foundation/import.html",
            {
                "title": "Đối chiếu trước khi nhập",
                "rows": [list(x.values()) for x in rows],
                "headers": [FIELDS[s["table"]][n]["nhan_tieng_viet"] for n in s["fields"]],
                "token": signing.dumps(payload, salt="erp-import", compress=True),
                "source": payload["source"],
            },
        )
    return render(
        request,
        "foundation/form.html",
        {
            "title": "Nhập Excel có kiểm tra nguồn",
            "form": f,
            "multipart": True,
            "request_key": str(db.uid()),
            "note": "Xem trước, kiểm tra và xác nhận riêng. Lỗi một dòng hoàn tác toàn bộ lần nhập. Mặt hàng mới chưa duyệt để trạng thái chưa sử dụng.",
        },
    )


class DelegationForm(forms.Form):
    code = forms.CharField(label="Mã đề nghị ủy quyền")
    receiver = forms.UUIDField(label="Người nhận ủy quyền")
    target = forms.ChoiceField(label="Công việc được giao")
    until = forms.DateTimeField(
        label="Hết hạn ủy quyền (bắt buộc)",
        widget=forms.DateTimeInput(format="%Y-%m-%dT%H:%M", attrs={"type": "datetime-local"}),
    )
    reason = forms.CharField(label="Căn cứ và giới hạn công việc", widget=forms.Textarea)


@secured
def delegation_request(request):
    c = request.conn
    db.require(c, request.w, "truy_cap.uy_quyen", "tao")
    f = DelegationForm(request.POST or None)
    select_field(f, "receiver", c, "nhan_su.nhan_vien", "ten")
    possible = [
        (s["table"] + "|" + a, s["title"] + " — " + label)
        for s in REGISTRY.values()
        for a, label in [("xem", "xem"), ("tao", "khai báo"), ("dieu_chinh", "sửa khai báo")]
        if db.allowed(c, request.w, s["table"], a)
    ]
    f.fields["target"].choices = possible
    if request.method == "POST" and f.is_valid():
        x = f.cleaned_data
        if x["until"] <= db.now():
            raise ValueError("Hết hạn phải sau hiện tại.")

        def work():
            table, action = x["target"].split("|")
            r = services.create_document(
                c,
                request.w,
                request.user_info,
                x["code"],
                "quyet_dinh_cap_quyen",
                x["reason"],
                ":".join(["uy_quyen", str(x["receiver"]), table, action]),
            )
            db.update(
                c, services.HEAD, r["cac_ma_chung_tu"][0], {"thoi_diem_moc_doi_chieu": x["until"]}
            )
            return r

        r = db.idempotent(
            c, request.w, request.user_info["id"], request.POST.get("request_key"), x, "tao", work
        )
        return redirect("document", key=r["cac_ma_chung_tu"][0])
    return render(
        request,
        "foundation/form.html",
        {
            "title": "Đề nghị ủy quyền công việc nền có hạn",
            "form": f,
            "request_key": request.POST.get("request_key") or str(db.uid()),
            "note": "Đợt nền ủy quyền khai báo/xem danh mục đã xây; không ủy quyền quản trị truy cập hoặc tự duyệt.",
        },
    )


def apply_delegation(request, h):
    c = request.conn
    db.require(c, request.w, "truy_cap.uy_quyen", "tao")
    _, receiver, table, action = h["pham_vi"].split(":")
    receiver = uuid.UUID(receiver)
    proposer = db.get(c, "truy_cap.tai_khoan_dang_nhap", h["ma_tai_khoan_lap_chung_tu"])
    giver = c.execute(
        "SELECT ma_dinh_danh,ma_nguoi_that FROM nhan_su.nhan_vien WHERE ma_nguoi_that=%s",
        (proposer["ma_nguoi_that"],),
    ).fetchone()
    target = db.get(c, services.EMP, receiver)
    if (
        not giver
        or not target
        or target["ma_nguoi_that"]
        in (request.user_info["ma_nguoi_that"], proposer["ma_nguoi_that"])
    ):
        raise ValueError("Không tự áp dụng ủy quyền cho mình.")
    if (
        table.startswith("truy_cap.")
        or action not in ("xem", "tao", "dieu_chinh")
        or not h["thoi_diem_moc_doi_chieu"]
        or h["thoi_diem_moc_doi_chieu"] <= db.now()
    ):
        raise ValueError("Ủy quyền không thuộc công việc nền hoặc hết hạn.")

    def work():
        key = db.uid()
        db.insert(
            c,
            "truy_cap.uy_quyen",
            {
                "ma_dinh_danh": key,
                "ma_bo_du_lieu": request.w,
                "hanh_dong": action,
                "loai_doi_tuong_phan_quyen": table,
                "ma_nhan_vien_giao_uy_quyen": giver["ma_dinh_danh"],
                "ma_nhan_vien_nhan_uy_quyen": receiver,
                "ma_phien_ban_chung_tu": h["ma_dinh_danh"],
                "ma_phe_duyet": h["ma_phe_duyet"],
                "thoi_diem_bat_dau_hieu_luc": db.now(),
                "thoi_diem_ket_thuc_hieu_luc": h["thoi_diem_moc_doi_chieu"],
                "ma_tai_khoan_thuc_hien": request.user_info["id"],
            },
        )
        db.audit(c, request.w, request.user_info["id"], "ap_dung_uy_quyen", h["ma_dinh_danh"])
        return {"cac_ma_chung_tu": [h["ma_dinh_danh"]], "cac_ma_dong": [], "cac_ma_su_kien": [key]}

    db.idempotent(
        c,
        request.w,
        request.user_info["id"],
        request.POST.get("request_key"),
        {"decision": str(h["ma_dinh_danh"])},
        "xac_nhan",
        work,
    )
    return redirect("access")
