import hashlib, secrets
from datetime import timedelta
from django.contrib.auth.hashers import check_password, make_password
from django.conf import settings
from foundation import db

DUMMY = make_password(secrets.token_urlsafe(24))


def authenticate(username, password):
    username = username.strip().lower()
    key = hashlib.sha256(username.encode()).hexdigest()
    with db.tx() as c:
        c.execute(
            "INSERT INTO nen_tang.gioi_han_dang_nhap(khoa_da_bam) VALUES(%s) ON CONFLICT DO NOTHING",
            (key,),
        )
        limit = c.execute(
            "SELECT * FROM nen_tang.gioi_han_dang_nhap WHERE khoa_da_bam=%s FOR UPDATE", (key,)
        ).fetchone()
        expired = limit["thoi_diem_bat_dau"] < db.now() - timedelta(minutes=15)
        if expired:
            c.execute(
                "UPDATE nen_tang.gioi_han_dang_nhap SET so_lan_sai=0,thoi_diem_bat_dau=now() WHERE khoa_da_bam=%s",
                (key,),
            )
        if not expired and limit["so_lan_sai"] >= 5:
            return None
        account = c.execute(
            "SELECT a.* FROM truy_cap.tai_khoan_dang_nhap a JOIN truy_cap.dinh_danh_nguoi p ON p.ma_dinh_danh=a.ma_nguoi_that WHERE lower(a.ten_dang_nhap)=%s AND a.trang_thai_xu_ly='dang_su_dung' AND p.trang_thai_xu_ly='dang_su_dung' FOR SHARE OF a",
            (username,),
        ).fetchone()
        if not check_password(
            password, account["ban_bam_thong_tin_xac_thuc"] if account else DUMMY
        ):
            c.execute(
                "UPDATE nen_tang.gioi_han_dang_nhap SET so_lan_sai=so_lan_sai+1 WHERE khoa_da_bam=%s",
                (key,),
            )
            return None
        c.execute(
            "UPDATE nen_tang.gioi_han_dang_nhap SET so_lan_sai=0 WHERE khoa_da_bam=%s", (key,)
        )
        raw = secrets.token_urlsafe(40)
        db.insert(
            c,
            "truy_cap.phien_dang_nhap",
            {
                "ma_dinh_danh": db.uid(),
                "ma_tai_khoan": account["ma_dinh_danh"],
                "ban_bam_ma_phien_dang_nhap": hashlib.sha256(raw.encode()).hexdigest(),
                "thoi_diem_cap_phien": db.now(),
                "thoi_diem_het_hieu_luc": db.now() + timedelta(hours=settings.ERP_SESSION_HOURS),
                "so_phien_ban_quyen_khi_cap_phien": account["so_phien_ban_quyen_xac_thuc"],
            },
        )
        return raw


def session(c, raw, lock=False):
    if not raw:
        return None
    return c.execute(
        """SELECT a.ma_dinh_danh id,a.ten_dang_nhap,a.ma_nguoi_that,a.so_phien_ban_quyen_xac_thuc,p.ten_hien_thi,s.ma_dinh_danh phien
 FROM truy_cap.phien_dang_nhap s JOIN truy_cap.tai_khoan_dang_nhap a ON a.ma_dinh_danh=s.ma_tai_khoan JOIN truy_cap.dinh_danh_nguoi p ON p.ma_dinh_danh=a.ma_nguoi_that
 WHERE s.ban_bam_ma_phien_dang_nhap=%s AND s.thoi_diem_thu_hoi_quyen IS NULL AND s.thoi_diem_het_hieu_luc>now() AND a.trang_thai_xu_ly='dang_su_dung' AND p.trang_thai_xu_ly='dang_su_dung' AND s.so_phien_ban_quyen_khi_cap_phien=a.so_phien_ban_quyen_xac_thuc"""
        + (" FOR SHARE OF a" if lock else ""),
        (hashlib.sha256(raw.encode()).hexdigest(),),
    ).fetchone()


def require_session(c, user, raw):
    current = session(c, raw, True)
    if not current or current["id"] != user["id"]:
        raise PermissionError("Phiên đăng nhập hết hiệu lực. Vui lòng đăng nhập lại.")


def revoke(c, actor, workspace, target):
    db.require(c, workspace, "truy_cap.cap_vai_tro", "dieu_chinh")
    acct = db.get(c, "truy_cap.tai_khoan_dang_nhap", target, True)
    if not acct or acct["ma_nguoi_that"] == actor["ma_nguoi_that"]:
        raise ValueError("Không tự thay đổi quyền của mình.")
    # Revocation affects sessions immediately; applies only after a reviewed access decision.
    db.update(
        c,
        "truy_cap.tai_khoan_dang_nhap",
        target,
        {
            "trang_thai_xu_ly": "ngung_su_dung",
            "so_phien_ban_quyen_xac_thuc": acct["so_phien_ban_quyen_xac_thuc"] + 1,
        },
    )
    c.execute(
        "UPDATE truy_cap.phien_dang_nhap SET thoi_diem_thu_hoi_quyen=now() WHERE ma_tai_khoan=%s",
        (target,),
    )
