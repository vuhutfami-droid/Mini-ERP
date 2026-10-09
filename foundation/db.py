import os, uuid, hashlib, json, inspect
from contextlib import contextmanager
from datetime import datetime, timezone
import psycopg
from psycopg.rows import dict_row
from psycopg import sql
from psycopg.types.json import Jsonb


def now():
    return datetime.now(timezone.utc)


def uid():
    return uuid.uuid4()


def connect(admin=False):
    return psycopg.connect(
        os.environ["ERP_ADMIN_DATABASE_URL" if admin else "ERP_DATABASE_URL"], row_factory=dict_row
    )


@contextmanager
def tx(actor=None, workspace=None, admin=False):
    with connect(admin) as c:
        if actor:
            c.execute("SELECT set_config('erp.tai_khoan',%s,true)", (str(actor),))
        if workspace:
            c.execute("SELECT set_config('erp.bo',%s,true)", (str(workspace),))
        if actor:
            # Serialize every write against permission/session revocation on this account.
            a = c.execute(
                "SELECT a.* FROM truy_cap.tai_khoan_dang_nhap a JOIN truy_cap.dinh_danh_nguoi p ON p.ma_dinh_danh=a.ma_nguoi_that WHERE a.ma_dinh_danh=%s AND a.trang_thai_xu_ly='dang_su_dung' AND p.trang_thai_xu_ly='dang_su_dung' FOR SHARE OF a",
                (actor,),
            ).fetchone()
            if not a:
                raise PermissionError("Tài khoản đã ngừng sử dụng.")
        yield c


def insert(c, table, data):
    data = {k: (Jsonb(v) if isinstance(v, (dict, list)) else v) for k, v in data.items()}
    c.execute(
        sql.SQL("INSERT INTO {} ({}) VALUES ({})").format(
            sql.Identifier(*table.split(".")),
            sql.SQL(",").join(map(sql.Identifier, data)),
            sql.SQL(",").join(sql.Placeholder() for _ in data),
        ),
        list(data.values()),
    )
    return data.get("ma_dinh_danh")


def update(c, table, key, data):
    values = [Jsonb(v) if isinstance(v, (dict, list)) else v for v in data.values()]
    c.execute(
        sql.SQL("UPDATE {} SET {} WHERE ma_dinh_danh=%s").format(
            sql.Identifier(*table.split(".")),
            sql.SQL(",").join(sql.SQL("{}=%s").format(sql.Identifier(k)) for k in data),
        ),
        values + [key],
    )


def get(c, table, key, lock=False):
    return c.execute(
        sql.SQL("SELECT * FROM {} WHERE ma_dinh_danh=%s {}").format(
            sql.Identifier(*table.split(".")), sql.SQL("FOR UPDATE" if lock else "")
        ),
        (key,),
    ).fetchone()


def allowed(c, workspace, table, action):
    return c.execute(
        "SELECT nen_tang.co_quyen(%s,%s,%s) ok", (workspace, table, action)
    ).fetchone()["ok"]


def require(c, w, t, a):
    if not allowed(c, w, t, a):
        raise PermissionError("Anh/chị chưa được cấp quyền cho công việc này.")


def audit(c, w, actor, action, document=None, fields=(), reason=""):
    insert(
        c,
        "dung_chung.nhat_ky_thao_tac",
        {
            "ma_dinh_danh": uid(),
            "ma_bo_du_lieu": w,
            "ma_tai_khoan_thuc_hien": actor,
            "hanh_dong": action,
            "thoi_diem_he_thong_ghi_nhan": now(),
            "ma_phien_ban_chung_tu": document,
            "ly_do": reason,
            "noi_dung_thay_doi_da_luoc_du_lieu_nhay_cam": {
                "cac_truong": [
                    {
                        "ten_truong": f,
                        "gia_tri_cu_da_luoc": "[đã lược]",
                        "gia_tri_moi_da_luoc": "[đã lược]",
                    }
                    for f in fields
                ]
            },
        },
    )


def canonical(v):
    return json.dumps(v, sort_keys=True, ensure_ascii=False, default=str, separators=(",", ":"))


def idempotent(c, w, actor, key, payload, action, work):
    if not key or len(str(key)) > 128:
        raise ValueError("Thiếu mã chống gửi lặp; hãy mở lại biểu mẫu.")
    digest = hashlib.sha256(canonical(payload).encode()).hexdigest()
    lock = int.from_bytes(hashlib.sha256(f"{w}:{actor}:{key}".encode()).digest()[:8], signed=True)
    c.execute("SELECT pg_advisory_xact_lock(%s)", (lock,))
    old = c.execute(
        "SELECT * FROM truy_cap.bien_nhan_xac_nhan_giao_dich WHERE ma_bo_du_lieu=%s AND ma_tai_khoan=%s AND khoa_chong_xac_nhan_lap=%s",
        (w, actor, key),
    ).fetchone()
    if old:
        if old["ban_bam_noi_dung_yeu_cau"] != digest:
            raise ValueError("Mã gửi lại có nội dung khác. Hãy kiểm tra nguồn trước khi gửi mới.")
        return old["cac_ma_ket_qua_da_ghi_nhan"]
    receipt = uid()
    c.execute("SET CONSTRAINTS ALL DEFERRED")
    result = work(receipt) if len(inspect.signature(work).parameters) else work()
    result = {k: [str(x) for x in xs] for k, xs in result.items()}
    insert(
        c,
        "truy_cap.bien_nhan_xac_nhan_giao_dich",
        {
            "ma_dinh_danh": receipt,
            "ma_bo_du_lieu": w,
            "ma_tai_khoan": actor,
            "ma_tai_khoan_thuc_hien": actor,
            "khoa_chong_xac_nhan_lap": key,
            "hanh_dong": action,
            "ban_bam_noi_dung_yeu_cau": digest,
            "trang_thai_xu_ly": "da_ghi_toan_phan",
            "thoi_diem_ghi_nhan_toan_phan": now(),
            "thoi_diem_he_thong_ghi_nhan": now(),
            "ma_phien_ban_chung_tu": (
                result.get("cac_ma_chung_tu", [None])[0] if result.get("cac_ma_chung_tu") else None
            ),
            "cac_ma_ket_qua_da_ghi_nhan": result,
        },
    )
    return result
