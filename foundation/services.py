import uuid, json, hashlib
from datetime import date
from decimal import Decimal
from psycopg import sql
from django.contrib.auth.hashers import make_password
from django.conf import settings
from foundation import db, auth
from foundation.catalog import FIELDS, REGISTRY

HEAD = "dung_chung.chung_tu"
EMP = "nhan_su.nhan_vien"


def employee(c, account):
    row = c.execute("SELECT nen_tang.nhan_vien_hien_tai() ma_dinh_danh").fetchone()
    if not row or not row["ma_dinh_danh"]:
        raise ValueError("Chưa có hồ sơ nhân sự cho người xác nhận trong bộ này.")
    return row["ma_dinh_danh"]


def head(c, w, actor, code, kind, reason, **extras):
    key = db.uid()
    db.insert(
        c,
        HEAD,
        {
            "ma_dinh_danh": key,
            "ma_bo_du_lieu": w,
            "ma_nghiep_vu": code,
            "loai": kind,
            "so_phien_ban_chung_tu": 1,
            "trang_thai_phe_duyet": "nhap",
            "ma_tai_khoan_lap_chung_tu": actor,
            "ma_tai_khoan_thuc_hien": actor,
            "ly_do": reason,
            **extras,
        },
    )
    return key


def save_catalog(c, w, user, spec, data, key=None, version=None):
    table = spec["table"]
    action = "dieu_chinh" if key else "tao"
    db.require(c, w, table, action)
    data = {k: (None if v == "" else v) for k, v in data.items() if k in spec["fields"]}
    if table == "danh_muc.mat_hang":
        if data.get("loai_mat_hang") == "bien_the":
            if not data.get("ma_nhom_mau") or not data.get("ma_don_vi_co_so"):
                raise ValueError("Biến thể cần nhóm mẫu và đơn vị cơ sở.")
            unit = db.get(c, "dung_chung.don_vi_tinh", data["ma_don_vi_co_so"])
            if (
                data.get("nhom_san_pham") in ("ngoi", "gach_terrazzo")
                and unit["dai_luong"] != "vien"
            ):
                raise ValueError("Ngói và Terrazzo quản lý theo viên.")
        if (
            data.get("dang_su_dung")
            and data.get("loai_mat_hang") == "bien_the"
            and not data.get("ma_phien_ban_quy_cach")
        ):
            approved = bool(
                key
                and c.execute(
                    "SELECT 1 FROM dung_chung.chung_tu WHERE loai='quyet_dinh_danh_muc' AND pham_vi=%s AND trang_thai_phe_duyet='da_duyet'",
                    ("mat_hang:" + str(key),),
                ).fetchone()
            )
            if not approved:
                raise ValueError(
                    "Biến thể cần quyết định quy cách trước khi đưa vào sử dụng; lưu chưa sử dụng trước."
                )
        if data.get("dang_su_dung") and data.get("loai_mat_hang") == "bien_the":
            if (
                not key
                or not c.execute(
                    "SELECT 1 FROM dung_chung.chung_tu WHERE loai='quyet_dinh_danh_muc' AND pham_vi=%s AND trang_thai_phe_duyet='da_duyet'",
                    ("mat_hang:" + str(key),),
                ).fetchone()
            ):
                raise ValueError(
                    "Lưu biến thể chưa sử dụng, rồi lập đề nghị duyệt đúng mặt hàng trước khi kích hoạt."
                )
        if data.get("dang_su_dung") and data.get("ma_phien_ban_quy_cach"):
            policy = db.get(c, "dung_chung.phien_ban_chinh_sach", data["ma_phien_ban_quy_cach"])
            if not policy or not policy["ma_phe_duyet"]:
                raise ValueError("Quy cách quan trọng cần chính sách đã duyệt.")
    if table == "dung_chung.vi_tri_giu_hang":
        if data.get("ma_kho_vat_ly") and data["ma_kho_vat_ly"] != "KHO-01":
            raise ValueError("Bộ demo dùng một kho KHO-01; tạo vùng trong kho hiện có.")
        if (
            data.get("loai") == "xuong"
            and c.execute(
                "SELECT 1 FROM dung_chung.vi_tri_giu_hang WHERE loai=%s AND ma_dinh_danh<>%s",
                ("xuong", key or uuid.UUID(int=0)),
            ).fetchone()
        ):
            raise ValueError("Mô hình đã chốt chỉ có một xưởng.")
    if table == "nhan_su.ngay_va_ca_lam_viec":
        intervals = data.get("cac_khoang_lam_viec_trong_ca") or []
        for a, b in zip(
            sorted(intervals, key=lambda x: x.get("gio_bat_dau", "")),
            sorted(intervals, key=lambda x: x.get("gio_bat_dau", ""))[1:],
        ):
            if a["gio_ket_thuc"] > b["gio_bat_dau"]:
                raise ValueError("Các khoảng trong ca không được chồng nhau.")
    if table == "san_xuat.lich_nguoi_va_nguon_luc":
        data["loai"] = "du_kien"
        data["trang_thai_xu_ly"] = "du_kien"
        begin, end = data["thoi_diem_bat_dau_khoang"], data["thoi_diem_ket_thuc_khoang"]
        if begin >= end:
            raise ValueError("Khoảng lịch phải có thời điểm kết thúc sau bắt đầu.")
        field = "ma_nhan_vien" if data["doi_tuong_lich"] == "nhan_vien" else "ma_nguon_luc"
        other = "ma_nguon_luc" if field == "ma_nhan_vien" else "ma_nhan_vien"
        if not data.get(field) or data.get(other):
            raise ValueError("Lịch phải có đúng một người hoặc nguồn lực.")
        c.execute(
            "SELECT pg_advisory_xact_lock(%s)",
            (int.from_bytes(hashlib.sha256(str(data[field]).encode()).digest()[:8], signed=True),),
        )
        overlap = c.execute(
            sql.SQL(
                "SELECT 1 FROM san_xuat.lich_nguoi_va_nguon_luc WHERE {}=%s AND trang_thai_xu_ly<>'da_huy' AND thoi_diem_bat_dau_khoang<%s AND thoi_diem_ket_thuc_khoang>%s AND ma_dinh_danh<>%s"
            ).format(sql.Identifier(field)),
            (data[field], end, begin, key or uuid.UUID(int=0)),
        ).fetchone()
        if overlap:
            raise ValueError("Người/nguồn lực đã có lịch chồng khoảng này.")
    if table == "nhan_su.ho_so_ky_nang_va_an_toan":
        data["trang_thai_xu_ly"] = "cho_xu_ly"
    if table == "danh_muc.quy_doi_don_vi" and (
        data.get("he_so", 0) <= 0
        or data.get("ma_don_vi_quy_doi_nguon") == data.get("ma_don_vi_quy_doi_dich")
    ):
        raise ValueError("Quy đổi phải có hệ số dương và hai đơn vị khác nhau.")
    if table == "dung_chung.phien_ban_chinh_sach":
        data["ma_nguoi_khai_bao_du_lieu"] = employee(c, user)
        data["gia_lap"] = True
        data["thoi_diem_khai_bao"] = db.now()
    if key:
        old = db.get(c, table, key, True)
        if not old:
            raise PermissionError("Không có hồ sơ trong phạm vi được cấp.")
        if old.get("so_phien_ban_ghi_dong_thoi", 1) != int(version):
            raise ValueError("Có người đã cập nhật bản này. Hãy tải lại trước khi sửa.")
        if old.get("ma_phe_duyet"):
            raise ValueError("Nguồn đã duyệt cần lập bản thay, không sửa đè.")
        if table == "danh_muc.mat_hang" and (
            c.execute("SELECT 1 FROM kho.lo_hang WHERE ma_mat_hang=%s", (key,)).fetchone()
            or c.execute(
                "SELECT 1 FROM dung_chung.chung_tu WHERE loai='quyet_dinh_danh_muc' AND pham_vi=%s AND trang_thai_phe_duyet='da_duyet'",
                ("mat_hang:" + str(key),),
            ).fetchone()
        ):
            if any(k != "dang_su_dung" and data[k] != old[k] for k in data):
                raise ValueError("Mặt hàng đã dùng trong lô: giữ quy cách cũ, tạo biến thể mới.")
        if "so_phien_ban_ghi_dong_thoi" in FIELDS[table]:
            data["so_phien_ban_ghi_dong_thoi"] = int(version) + 1
        db.update(c, table, key, data)
    else:
        key = db.uid()
        if table in ("nhan_su.ho_so_lam_viec_theo_hieu_luc", "nhan_su.ho_so_ky_nang_va_an_toan"):
            key = head(
                c,
                w,
                user["id"],
                "HS-" + str(key)[:8],
                "ho_so_lam_viec" if table.endswith("hieu_luc") else "ky_nang",
                "Khai báo nguồn hồ sơ D01",
            )
            db.update(c, HEAD, key, {"trang_thai_phe_duyet": "khong_yeu_cau"})
        data.update(ma_dinh_danh=key, ma_bo_du_lieu=w)
        if "ma_tai_khoan_thuc_hien" in FIELDS[table]:
            data["ma_tai_khoan_thuc_hien"] = user["id"]
        db.insert(c, table, data)
    db.audit(c, w, user["id"], action, fields=spec["fields"], reason=spec["title"])
    return {"cac_ma_chung_tu": [], "cac_ma_dong": [], "cac_ma_su_kien": [key]}


def create_document(c, w, user, code, kind, reason, scope=""):
    db.require(c, w, HEAD, "tao")
    if kind not in (
        "quyet_dinh_danh_muc",
        "quyet_dinh_chinh_sach",
        "quyet_dinh_cap_quyen",
        "phan_cong",
        "ho_so_lam_viec",
        "ky_nang",
    ):
        raise ValueError("Loại chứng từ chưa được triển khai trong D01.")
    if not reason.strip():
        raise ValueError("Cần ghi căn cứ hoặc nội dung đề nghị.")
    key = head(c, w, user["id"], code, kind, reason, pham_vi=scope)
    db.audit(c, w, user["id"], "tao_chung_tu", key)
    return {"cac_ma_chung_tu": [key], "cac_ma_dong": [], "cac_ma_su_kien": []}


def document_action(c, w, user, key, action, version, reason=""):
    h = db.get(c, HEAD, key, True)
    if not h:
        raise PermissionError("Không được truy cập chứng từ này.")
    if h["so_phien_ban_ghi_dong_thoi"] != int(version):
        raise ValueError("Chứng từ đã đổi phiên bản.")
    actor = employee(c, user)
    if action == "trinh":
        db.require(c, w, HEAD, "tao")
        if h["trang_thai_phe_duyet"] not in ("nhap", "da_tu_choi"):
            raise ValueError("Không thể trình bản này.")
        db.update(
            c,
            HEAD,
            key,
            {"trang_thai_phe_duyet": "da_trinh", "so_phien_ban_ghi_dong_thoi": int(version) + 1},
        )
    elif action in ("duyet", "tu_choi"):
        db.require(c, w, HEAD, "phe_duyet")
        if h["trang_thai_phe_duyet"] != "da_trinh":
            raise ValueError("Chỉ quyết định bản đã trình.")
        if not reason.strip():
            raise ValueError("Cần ghi lý do quyết định.")
        if h["loai"] == "quyet_dinh_cap_quyen":
            parts = (h["pham_vi"] or "").split(":")
            if parts[0] == "uy_quyen" and len(parts) == 4:
                target_employee = db.get(c, EMP, parts[1])
                if not target_employee or target_employee["ma_nguoi_that"] == user["ma_nguoi_that"]:
                    raise ValueError("Không tự duyệt ủy quyền cho mình.")
                target = None
            elif len(parts) != 3 or parts[0] not in ("cap", "thu_hoi"):
                raise ValueError("Phạm vi quyền phải xác định tài khoản và vai trò.")
            if parts[0] != "uy_quyen":
                target = db.get(c, "truy_cap.tai_khoan_dang_nhap", parts[1])
            if parts[0] != "uy_quyen" and (
                not target or target["ma_nguoi_that"] == user["ma_nguoi_that"]
            ):
                raise ValueError("Không tự duyệt quyền của chính mình, kể cả tài khoản khác.")
        decision = db.uid()
        proposer = c.execute(
            "SELECT e.ma_dinh_danh FROM nhan_su.nhan_vien e JOIN truy_cap.tai_khoan_dang_nhap a ON a.ma_nguoi_that=e.ma_nguoi_that WHERE a.ma_dinh_danh=%s",
            (h["ma_tai_khoan_lap_chung_tu"],),
        ).fetchone()
        db.insert(
            c,
            "dung_chung.de_nghi_va_quyet_dinh_phe_duyet",
            {
                "ma_dinh_danh": decision,
                "ma_bo_du_lieu": w,
                "ma_phien_ban_chung_tu": key,
                "hanh_dong": "phe_duyet",
                "trang_thai_xu_ly": "da_duyet" if action == "duyet" else "da_tu_choi",
                "ma_nhan_vien_de_nghi": proposer["ma_dinh_danh"] if proposer else None,
                "ma_nhan_vien_quyet_dinh": actor,
                "thoi_diem_de_nghi": h["thoi_diem_tao"],
                "thoi_diem_quyet_dinh": db.now(),
                "ly_do": reason,
                "ma_tai_khoan_thuc_hien": user["id"],
            },
        )
        if action == "duyet":
            if h["loai"] == "quyet_dinh_danh_muc" and (h["pham_vi"] or "").startswith("mat_hang:"):
                target = uuid.UUID(h["pham_vi"].split(":")[1])
                m = db.get(c, "danh_muc.mat_hang", target, True)
                if not m:
                    raise ValueError("Mặt hàng cần duyệt không tồn tại trong bộ.")
                db.update(c, "danh_muc.mat_hang", target, {"dang_su_dung": True})
            policies = c.execute(
                "SELECT * FROM dung_chung.phien_ban_chinh_sach WHERE ma_chung_tu_can_cu_khai_bao=%s",
                (key,),
            ).fetchall()
            for policy in policies:
                if not policy["tham_so"] or not policy["thoi_diem_bat_dau_hieu_luc"]:
                    raise ValueError("Chính sách thiếu tham số/hiệu lực.")
                db.update(
                    c,
                    "dung_chung.phien_ban_chinh_sach",
                    policy["ma_dinh_danh"],
                    {"ma_phe_duyet": decision},
                )
        db.update(
            c,
            HEAD,
            key,
            {
                "trang_thai_phe_duyet": "da_duyet" if action == "duyet" else "da_tu_choi",
                "ma_phe_duyet": decision,
                "thoi_diem_co_hieu_luc": db.now(),
                "so_phien_ban_ghi_dong_thoi": int(version) + 1,
            },
        )
    else:
        raise ValueError("Thao tác chưa được hỗ trợ.")
    db.audit(c, w, user["id"], action, key, reason=reason)
    return {"cac_ma_chung_tu": [key], "cac_ma_dong": [], "cac_ma_su_kien": []}


def attach(c, w, user, document, upload):
    db.require(c, w, "dung_chung.chung_cu_dinh_kem", "tao")
    h = db.get(c, HEAD, document, True)
    if (
        not h
        or h.get("trang_thai_ghi_so") == "da_ghi_so"
        or h["trang_thai_phe_duyet"] == "da_duyet"
    ):
        raise ValueError("Nguồn đã chốt không thêm/sửa chứng cứ.")
    raw = upload.read(settings.ERP_UPLOAD_MAX + 1)
    if len(raw) > settings.ERP_UPLOAD_MAX:
        raise ValueError("Tệp tối đa 5 MB.")
    suffix = upload.name.rsplit(".", 1)[-1].lower()
    good = (
        (suffix == "pdf" and raw.startswith(b"%PDF-"))
        or (suffix == "png" and raw.startswith(b"\x89PNG\r\n\x1a\n"))
        or (suffix in ("jpg", "jpeg") and raw.startswith(b"\xff\xd8\xff"))
        or (suffix == "txt" and b"\x00" not in raw)
    )
    if not good:
        raise ValueError(
            "Chỉ nhận PDF, PNG, JPEG hoặc văn bản UTF-8; nội dung phải đúng định dạng."
        )
    if suffix == "txt":
        raw.decode("utf-8")
    digest = hashlib.sha256(raw).hexdigest()
    path = settings.ERP_MEDIA_ROOT / str(w) / digest
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_bytes(raw)
    key = db.uid()
    db.insert(
        c,
        "dung_chung.chung_cu_dinh_kem",
        {
            "ma_dinh_danh": key,
            "ma_bo_du_lieu": w,
            "ma_phien_ban_chung_tu": document,
            "khoa_tep_trong_noi_luu": f"{w}/{digest}",
            "ma_kiem_toan_ven": digest,
            "loai_dinh_dang_tep": suffix,
            "dung_luong_tep_tinh_theo_byte": len(raw),
            "muc_nhay_cam": "noi_bo",
            "gia_lap": True,
            "ma_tai_khoan_thuc_hien": user["id"],
        },
    )
    db.audit(c, w, user["id"], "them_chung_cu", document)
    return key


def evidence(c, h):
    row = c.execute(
        "SELECT * FROM dung_chung.chung_cu_dinh_kem WHERE ma_phien_ban_chung_tu=%s", (h,)
    ).fetchone()
    if not row:
        raise ValueError("Cần đính kèm biên bản nguồn trước xác nhận.")
    path = settings.ERP_MEDIA_ROOT / row["khoa_tep_trong_noi_luu"]
    if (
        not path.is_file()
        or hashlib.sha256(path.read_bytes()).hexdigest() != row["ma_kiem_toan_ven"]
    ):
        raise ValueError("Tệp nguồn thiếu hoặc không toàn vẹn.")


def opening_stock(c, w, user, code, item, position, quantity, reason):
    db.require(c, w, "kho.dong_van_dong_hang", "tao")
    m = db.get(c, "danh_muc.mat_hang", item, True)
    p = db.get(c, "dung_chung.vi_tri_giu_hang", position)
    quantity = Decimal(quantity)
    if (
        not m
        or m["loai_mat_hang"] == "nhom_mau"
        or not m["ma_don_vi_co_so"]
        or not p
        or p["ma_kho_vat_ly"] != "KHO-01"
        or quantity <= 0
        or not reason.strip()
    ):
        raise ValueError("Cần mặt hàng, vị trí KHO-01, lượng dương và căn cứ.")
    unit = db.get(c, "dung_chung.don_vi_tinh", m["ma_don_vi_co_so"])
    if quantity.as_tuple().exponent < -int(unit["so_chu_so_thap_phan_duoc_phep"]):
        raise ValueError("Số lẻ vượt độ chính xác đơn vị cơ sở.")
    source = head(c, w, user["id"], code, "ton_dau", reason)
    movement = head(
        c,
        w,
        user["id"],
        code + "-NHAP",
        "van_dong_hang",
        reason,
        loai_van_dong_kho="dau_ky",
        trang_thai_ghi_so="nhap",
        ma_chung_tu_goc=source,
    )
    lot = db.uid()
    part = db.uid()
    line = db.uid()
    db.insert(
        c,
        "kho.lo_hang",
        {
            "ma_dinh_danh": lot,
            "ma_bo_du_lieu": w,
            "ma_nghiep_vu": code + "-LO",
            "ma_mat_hang": item,
            "loai_nguon_hinh_thanh_lo": "dau_ky",
            "ma_chung_tu_hinh_thanh_lo": source,
            "ma_tai_khoan_thuc_hien": user["id"],
        },
    )
    db.insert(
        c,
        "kho.phan_lo_hang",
        {
            "ma_dinh_danh": part,
            "ma_bo_du_lieu": w,
            "ma_lo_hang": lot,
            "tinh_trang_chat_luong": "cho_xu_ly",
            "quyen_so_huu": "doanh_nghiep",
            "ma_tai_khoan_thuc_hien": user["id"],
        },
    )
    db.insert(
        c,
        "dung_chung.dong_chung_tu",
        {
            "ma_dinh_danh": line,
            "ma_bo_du_lieu": w,
            "ma_phien_ban_chung_tu": movement,
            "so_thu_tu_dong": 1,
            "loai": "dong_van_dong",
            "ma_tai_khoan_thuc_hien": user["id"],
        },
    )
    db.insert(
        c,
        "kho.dong_van_dong_hang",
        {
            "ma_dinh_danh": line,
            "ma_bo_du_lieu": w,
            "ma_phieu_van_dong_hang": movement,
            "ma_phan_lo_dich": part,
            "ma_vi_tri_dich": position,
            "ma_don_vi_nhap": m["ma_don_vi_co_so"],
            "so_luong_theo_don_vi_nhap": quantity,
            "so_luong_do_theo_don_vi_co_so": quantity,
            "he_so_quy_doi_tai_lan_ghi_nhan": 1,
            "ly_do": reason,
        },
    )
    db.audit(c, w, user["id"], "lap_nguon_ton_dau", source)
    return {
        "cac_ma_chung_tu": [source, movement],
        "cac_ma_dong": [line],
        "cac_ma_su_kien": [lot, part],
    }


def opening_qc(c, w, user, line_id, result, observation, policy_id, observations=None):
    db.require(c, w, "chat_luong.phieu_kiem_tra_chat_luong", "xac_nhan")
    line = db.get(c, "kho.dong_van_dong_hang", line_id, True)
    if not line:
        raise PermissionError("Không có nguồn kho trong phạm vi.")
    h = db.get(c, HEAD, line["ma_phieu_van_dong_hang"])
    if h["loai_van_dong_kho"] != "dau_ky":
        raise ValueError("Chỉ kiểm nguồn mở đầu ở đợt nền.")
    evidence(c, h["ma_chung_tu_goc"])
    part = db.get(c, "kho.phan_lo_hang", line["ma_phan_lo_dich"], True)
    if part["ma_phieu_ket_luan_chat_luong"]:
        raise ValueError("Đã có kết luận; cần nguồn điều chỉnh riêng.")
    policy = db.get(c, "dung_chung.phien_ban_chinh_sach", policy_id)
    if (
        not policy
        or policy["loai"] != "kiem_chat_luong"
        or not policy["ma_phe_duyet"]
        or not policy["thoi_diem_bat_dau_hieu_luc"]
        or policy["thoi_diem_bat_dau_hieu_luc"] > db.now()
        or (
            policy["thoi_diem_ket_thuc_hieu_luc"]
            and policy["thoi_diem_ket_thuc_hieu_luc"] <= db.now()
        )
    ):
        raise ValueError("Cần bộ tiêu chí QC đã duyệt và còn hiệu lực.")
    if result not in ("dat", "loi") or not observation.strip():
        raise ValueError("Cần kết luận và quan sát thực của người kiểm.")
    qty = line["so_luong_do_theo_don_vi_co_so"]
    qc = head(c, w, user["id"], "QC-" + str(db.uid())[:8], "kiem_chat_luong", observation)
    db.insert(
        c,
        "chat_luong.phieu_kiem_tra_chat_luong",
        {
            "ma_dinh_danh": qc,
            "ma_bo_du_lieu": w,
            "loai_kiem_tra_chat_luong": "dau_vao",
            "ma_lo_hang": part["ma_lo_hang"],
            "ma_dong_nguon_nghiep_vu": line_id,
            "ma_phien_ban_bo_tieu_chi": policy_id,
            "ma_nhan_vien_kiem_chat_luong": employee(c, user),
            "pham_vi_kiem": "toan_bo",
            "so_luong_thuc_kiem": qty,
            "so_luong_ket_luan_dat": qty if result == "dat" else 0,
            "so_luong_ket_luan_loi": qty if result == "loi" else 0,
            "so_luong_cho_ket_luan": 0,
            "tinh_trang_xac_nhan_ket_luan": "da_xac_nhan",
            "thoi_diem_xac_nhan_ket_luan": db.now(),
        },
    )
    params = policy["tham_so"]["cac_tham_so"]
    criteria = [p["gia_tri"] for p in params if p["ten_tham_so"] == "ma_tieu_chi"]
    if not criteria:
        raise ValueError("Chính sách chưa khai báo tiêu chí kiểm.")
    observations = observations or (
        {str(criteria[0]): {"observation": observation, "result": result}}
        if len(criteria) == 1
        else {}
    )
    if set(observations) != set(map(str, criteria)) or any(
        not x.get("observation", "").strip() or x.get("result") not in ("dat", "loi")
        for x in observations.values()
    ):
        raise ValueError("Cần quan sát và kết quả riêng cho tất cả tiêu chí.")
    if (result == "dat") != all(x["result"] == "dat" for x in observations.values()):
        raise ValueError("Kết luận chung không khớp kết quả từng tiêu chí.")
    for criterion in criteria:
        db.insert(
            c,
            "chat_luong.ket_qua_tung_tieu_chi_kiem_tra",
            {
                "ma_dinh_danh": db.uid(),
                "ma_bo_du_lieu": w,
                "ma_phieu_kiem_chat_luong": qc,
                "ma_tieu_chi_kiem": str(criterion),
                "noi_dung_quan_sat_thuc": observations[str(criterion)]["observation"],
                "ket_qua": (
                    "dat" if observations[str(criterion)]["result"] == "dat" else "khong_dat"
                ),
                "so_luong_bi_anh_huong": (
                    0 if observations[str(criterion)]["result"] == "dat" else qty
                ),
                "ma_tai_khoan_thuc_hien": user["id"],
            },
        )
    db.update(
        c,
        "kho.phan_lo_hang",
        part["ma_dinh_danh"],
        {"tinh_trang_chat_luong": result, "ma_phieu_ket_luan_chat_luong": qc},
    )
    db.update(
        c,
        HEAD,
        qc,
        {
            "trang_thai_phe_duyet": "khong_yeu_cau",
            "trang_thai_ghi_so": "da_ghi_so",
            "thoi_diem_he_thong_ghi_nhan": db.now(),
        },
    )
    db.audit(c, w, user["id"], "ket_luan_QC_mo_dau", qc)
    return {"cac_ma_chung_tu": [qc], "cac_ma_dong": [], "cac_ma_su_kien": []}


def post_opening(c, w, user, line_id, receipt=None):
    db.require(c, w, "kho.dong_van_dong_hang", "xac_nhan")
    line = db.get(c, "kho.dong_van_dong_hang", line_id, True)
    if not line:
        raise PermissionError("Không có dòng nguồn này.")
    h = db.get(c, HEAD, line["ma_phieu_van_dong_hang"], True)
    source = db.get(c, HEAD, h["ma_chung_tu_goc"], True)
    if h["trang_thai_ghi_so"] != "nhap":
        raise ValueError("Nguồn đã ghi sổ.")
    evidence(c, source["ma_dinh_danh"])
    db.update(
        c,
        HEAD,
        source["ma_dinh_danh"],
        {
            "ma_bien_nhan_xac_nhan_giao_dich": receipt,
            "trang_thai_phe_duyet": "khong_yeu_cau",
            "trang_thai_ghi_so": "da_ghi_so",
            "thoi_diem_thuc_hien_nghiep_vu": db.now(),
        },
    )
    db.update(
        c,
        HEAD,
        h["ma_dinh_danh"],
        {
            "ma_bien_nhan_xac_nhan_giao_dich": receipt,
            "trang_thai_phe_duyet": "khong_yeu_cau",
            "trang_thai_ghi_so": "da_ghi_so",
            "thoi_diem_thuc_hien_nghiep_vu": db.now(),
            "thoi_diem_he_thong_ghi_nhan": db.now(),
        },
    )
    db.audit(c, w, user["id"], "xac_nhan_ton_dau", source["ma_dinh_danh"])
    return {
        "cac_ma_chung_tu": [source["ma_dinh_danh"], h["ma_dinh_danh"]],
        "cac_ma_dong": [line_id],
        "cac_ma_su_kien": [],
    }


def opening_value(c, w, user, line_id, amount, reason):
    db.require(c, w, "tai_chinh.bien_dong_gia_tri", "xac_nhan")
    line = db.get(c, "kho.dong_van_dong_hang", line_id, True)
    if not line:
        raise ValueError("Thiếu nguồn kho.")
    h = db.get(c, HEAD, line["ma_phieu_van_dong_hang"])
    if h["trang_thai_ghi_so"] != "da_ghi_so":
        raise ValueError("Lượng mở đầu chưa xác nhận.")
    if c.execute(
        "SELECT 1 FROM tai_chinh.bien_dong_gia_tri WHERE ma_dong_van_dong_hang=%s", (line_id,)
    ).fetchone():
        raise ValueError("Đã ghi giá trị mở đầu.")
    evidence(c, h["ma_chung_tu_goc"])
    amount = Decimal(amount)
    if amount < 0 or amount != amount.to_integral_value() or not reason.strip():
        raise ValueError("Cần số tiền nguyên đồng và căn cứ định giá.")
    lot = db.get(
        c, "kho.lo_hang", db.get(c, "kho.phan_lo_hang", line["ma_phan_lo_dich"])["ma_lo_hang"]
    )
    key = db.uid()
    db.insert(
        c,
        "dung_chung.dong_chung_tu",
        {
            "ma_dinh_danh": key,
            "ma_bo_du_lieu": w,
            "ma_phien_ban_chung_tu": h["ma_chung_tu_goc"],
            "so_thu_tu_dong": 1,
            "loai": "dong_gia_tri",
            "ma_tai_khoan_thuc_hien": user["id"],
        },
    )
    db.insert(
        c,
        "tai_chinh.bien_dong_gia_tri",
        {
            "ma_dinh_danh": key,
            "ma_bo_du_lieu": w,
            "ma_mat_hang": lot["ma_mat_hang"],
            "ma_dong_van_dong_hang": line_id,
            "nhom_gia_tri_nguon": "nguon_dau_vao",
            "nhom_gia_tri_dich": "ton_hang",
            "so_tien": amount,
            "tinh_trang_xac_nhan_dinh_gia": "da_xac_nhan",
            "quy_tac_lam_tron_da_ap_dung": "Nguồn nguyên đồng: " + reason,
            "thoi_diem_thuc_hien_nghiep_vu": db.now(),
            "thoi_diem_he_thong_ghi_nhan": db.now(),
        },
    )
    db.audit(c, w, user["id"], "xac_nhan_gia_tri_dau", h["ma_chung_tu_goc"], reason=reason)
    return {"cac_ma_chung_tu": [h["ma_chung_tu_goc"]], "cac_ma_dong": [], "cac_ma_su_kien": [key]}


def opening_cash(c, w, user, code, fund, amount, reason, receipt=None):
    db.require(c, w, "tai_chinh.bien_dong_tien_thuc", "tao")
    if not db.get(c, "tai_chinh.quy_va_tai_khoan_tien", fund):
        raise ValueError("Quỹ chưa tồn tại.")
    amount = Decimal(amount)
    if amount < 0 or amount != amount.to_integral_value() or not reason.strip():
        raise ValueError("Cần số dư nguyên đồng và căn cứ.")
    doc = head(c, w, user["id"], code, "tien_dau", reason)
    line = db.uid()
    db.insert(
        c,
        "dung_chung.dong_chung_tu",
        {
            "ma_dinh_danh": line,
            "ma_bo_du_lieu": w,
            "ma_phien_ban_chung_tu": doc,
            "so_thu_tu_dong": 1,
            "loai": "dong_tien_thuc",
            "ma_tai_khoan_thuc_hien": user["id"],
        },
    )
    db.insert(
        c,
        "tai_chinh.bien_dong_tien_thuc",
        {
            "ma_dinh_danh": line,
            "ma_bo_du_lieu": w,
            "ma_bien_nhan_xac_nhan_giao_dich": receipt,
            "ma_quy_hoac_tai_khoan_tien": fund,
            "so_tien": amount,
            "chieu_tang_giam": "dau_ky",
            "trang_thai_ghi_so": "nhap",
            "pham_vi_xac_dinh_chu_nguon_tien": "noi_bo",
            "ma_doi_chieu_ben_ngoai": str(doc),
            "thoi_diem_thuc_hien_nghiep_vu": db.now(),
            "thoi_diem_he_thong_ghi_nhan": db.now(),
        },
    )
    db.audit(c, w, user["id"], "lap_nguon_tien_dau", doc)
    return {"cac_ma_chung_tu": [doc], "cac_ma_dong": [], "cac_ma_su_kien": [line]}


def post_cash(c, w, user, cash_id, receipt=None):
    db.require(c, w, "tai_chinh.bien_dong_tien_thuc", "xac_nhan")
    cash = db.get(c, "tai_chinh.bien_dong_tien_thuc", cash_id, True)
    if not cash or cash["trang_thai_ghi_so"] != "nhap":
        raise ValueError("Nguồn tiền không còn là nháp.")
    source_receipt = (
        db.get(c, "truy_cap.bien_nhan_xac_nhan_giao_dich", cash["ma_bien_nhan_xac_nhan_giao_dich"])
        if cash["ma_bien_nhan_xac_nhan_giao_dich"]
        else None
    )
    if not source_receipt:
        raise ValueError("Thiếu biên nhận liên kết hồ sơ nguồn tiền.")
    doc = source_receipt["ma_phien_ban_chung_tu"]
    h = db.get(c, HEAD, doc, True)
    if not h or h["loai"] != "tien_dau":
        raise ValueError("Nguồn tiền mở đầu không hợp lệ.")
    evidence(c, doc)
    c.execute(
        "SELECT pg_advisory_xact_lock(%s)",
        (
            int.from_bytes(
                hashlib.sha256(str(cash["ma_quy_hoac_tai_khoan_tien"]).encode()).digest()[:8],
                signed=True,
            ),
        ),
    )
    if c.execute(
        "SELECT 1 FROM tai_chinh.bien_dong_tien_thuc WHERE ma_quy_hoac_tai_khoan_tien=%s AND chieu_tang_giam='dau_ky' AND trang_thai_ghi_so='da_ghi_so'",
        (cash["ma_quy_hoac_tai_khoan_tien"],),
    ).fetchone():
        raise ValueError("Quỹ đã có số dư đầu xác nhận.")
    db.update(
        c,
        "tai_chinh.bien_dong_tien_thuc",
        cash_id,
        {"trang_thai_ghi_so": "da_ghi_so", "ma_bien_nhan_xac_nhan_giao_dich": receipt},
    )
    db.update(
        c,
        HEAD,
        doc,
        {
            "trang_thai_phe_duyet": "khong_yeu_cau",
            "trang_thai_ghi_so": "da_ghi_so",
            "thoi_diem_he_thong_ghi_nhan": db.now(),
        },
    )
    db.audit(c, w, user["id"], "xac_nhan_tien_dau", doc)
    return {"cac_ma_chung_tu": [doc], "cac_ma_dong": [], "cac_ma_su_kien": [cash_id]}


def handoff(c, w, user, document, receiver, content, key=None, version=None, accepted=None):
    table = "dung_chung.trao_doi_va_ban_giao"
    db.require(c, w, table, "dieu_chinh" if key else "tao")
    actor = employee(c, user)
    if key:
        row = db.get(c, table, key, True)
        if not row or row["ma_nhan_vien_nhan_ban_giao"] != actor:
            raise PermissionError("Chỉ người nhận được trả lời bàn giao.")
        if row["trang_thai_xu_ly"] != "da_gui" or row["so_phien_ban_ghi_dong_thoi"] != int(version):
            raise ValueError("Bàn giao đã được xử lý hoặc đổi bản.")
        if not content.strip():
            raise ValueError("Cần ghi kết quả nhận hoặc phần còn thiếu.")
        db.update(
            c,
            table,
            key,
            {
                "trang_thai_xu_ly": "da_chap_nhan" if accepted else "can_bo_sung",
                "thoi_diem_nhan": db.now(),
                "ly_do_con_thieu": content,
                "so_phien_ban_ghi_dong_thoi": int(version) + 1,
            },
        )
        document = row["ma_phien_ban_chung_tu"]
    else:
        h = db.get(c, HEAD, document)
        r = db.get(c, EMP, receiver)
        if not h or not r or not content.strip():
            raise ValueError("Cần hồ sơ nguồn, người nhận và nội dung bàn giao.")
        key = db.uid()
        db.insert(
            c,
            table,
            {
                "ma_dinh_danh": key,
                "ma_bo_du_lieu": w,
                "ma_phien_ban_chung_tu": document,
                "loai_trao_doi": "ban_giao_cong_viec",
                "ma_nhan_vien_ban_giao": actor,
                "ma_nhan_vien_nhan_ban_giao": receiver,
                "noi_dung_tiep_nhan": content,
                "trang_thai_xu_ly": "da_gui",
                "ma_tai_khoan_thuc_hien": user["id"],
            },
        )
    db.audit(
        c, w, user["id"], "nhan_ban_giao" if version else "gui_ban_giao", document, reason=content
    )
    return {"cac_ma_chung_tu": [document], "cac_ma_dong": [], "cac_ma_su_kien": [key]}


def create_account(c, w, user, person, username, password):
    db.require(c, w, "truy_cap.cap_vai_tro", "tao")
    p = db.get(c, "truy_cap.dinh_danh_nguoi", person)
    if not p or p["ma_dinh_danh"] == user["ma_nguoi_that"]:
        raise ValueError("Chọn định danh người khác đã khai báo.")
    if len(password) < 12 or not username.strip():
        raise ValueError("Cần tên đăng nhập và mật khẩu ít nhất 12 ký tự.")
    key = db.uid()
    db.insert(
        c,
        "truy_cap.tai_khoan_dang_nhap",
        {
            "ma_dinh_danh": key,
            "ten_dang_nhap": username.strip().lower(),
            "ma_nguoi_that": person,
            "ban_bam_thong_tin_xac_thuc": make_password(password),
            "trang_thai_xu_ly": "dang_su_dung",
            "so_phien_ban_quyen_xac_thuc": 1,
            "ma_tai_khoan_thuc_hien": user["id"],
        },
    )
    # No role until a separate CEO access decision is approved/applied.
    db.audit(c, w, user["id"], "tao_tai_khoan", reason="Định danh có nguồn; chưa cấp vai trò.")
    return {"cac_ma_chung_tu": [], "cac_ma_dong": [], "cac_ma_su_kien": [key]}
