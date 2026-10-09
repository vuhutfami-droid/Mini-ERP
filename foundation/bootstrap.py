import json, uuid, csv, secrets
from pathlib import Path
from datetime import timedelta, date
from django.contrib.auth.hashers import make_password
from foundation import db

ROOT = Path(__file__).resolve().parents[1]


def bootstrap(workspace_code="NASAKI-D01", credentials_path=None):
    with db.tx(admin=True) as c:
        if c.execute(
            "SELECT 1 FROM dung_chung.bo_du_lieu_mo_phong WHERE ma_nghiep_vu=%s", (workspace_code,)
        ).fetchone():
            return
        w = db.uid()
        now = db.now()
        db.insert(
            c,
            "dung_chung.bo_du_lieu_mo_phong",
            {
                "ma_dinh_danh": w,
                "ma_nghiep_vu": workspace_code,
                "phien_ban_bo_mo_phong": "D01-nguon-moi-1",
                "che_do": "dau_ky",
                "ma_kich_ban_kiem_tra": "Khai báo giả lập D01, không nhập bộ kiểm cũ",
                "thoi_diem_moc_goc": now,
                "trang_thai_xu_ly": "chuan_bi_vao_lam",
            },
        )
        company = db.uid()
        db.insert(
            c,
            "dung_chung.doanh_nghiep",
            {
                "ma_dinh_danh": company,
                "ma_bo_du_lieu": w,
                "ma_nghiep_vu": "NASAKI-DEMO",
                "ten": "Nasaki — doanh nghiệp giả lập",
                "mui_gio": "Asia/Ho_Chi_Minh",
                "tien_te": "VND",
                "che_do": "mo_phong",
            },
        )

        def add(t, **v):
            return db.insert(c, t, {"ma_dinh_danh": db.uid(), "ma_bo_du_lieu": w, **v})

        depts = {}
        for code, name in [
            ("BGD", "Ban giám đốc"),
            ("KD", "Kinh doanh"),
            ("KHO", "Mua hàng và kho"),
            ("SX", "Sản xuất và chất lượng"),
            ("TCNS", "Tài chính và nhân sự"),
        ]:
            depts[code] = add(
                "dung_chung.bo_phan",
                ma_nghiep_vu=code,
                ten=name,
                ma_doanh_nghiep=company,
                dang_su_dung=True,
            )
        locations = {}
        for code, kind, warehouse in [
            ("KHO-TP", "vung_trong_kho", "KHO-01"),
            ("KHO-VT", "vung_trong_kho", "KHO-01"),
            ("KHO-CC", "vung_trong_kho", "KHO-01"),
            ("XUONG-01", "xuong", None),
        ]:
            locations[code] = add(
                "dung_chung.vi_tri_giu_hang",
                ma_nghiep_vu=code,
                loai=kind,
                ma_kho_vat_ly=warehouse,
                ma_doanh_nghiep=company,
                dang_su_dung=True,
            )
        units = {}
        for code, kind, dec in [
            ("VIEN", "vien", 0),
            ("KG", "hang_loat", 3),
            ("LIT", "the_tich", 3),
            ("PHUT", "thoi_gian", 0),
        ]:
            units[code] = add(
                "dung_chung.don_vi_tinh",
                ma_nghiep_vu=code,
                dai_luong=kind,
                so_chu_so_thap_phan_duoc_phep=dec,
            )
        for code, name, group in [
            ("NGOI", "Ngói demo", "ngoi"),
            ("TERRAZZO", "Terrazzo demo", "gach_terrazzo"),
        ]:
            parent = add(
                "danh_muc.mat_hang",
                ma_nghiep_vu=code,
                ten=name,
                nhom_san_pham=group,
                loai_mat_hang="nhom_mau",
                dang_su_dung=True,
            )
            # Catalog declarations, not QC/production approval. Important specs await approval.
            add(
                "danh_muc.mat_hang",
                ma_nghiep_vu=code + "-MAU",
                ten=name + " — biến thể mẫu chưa duyệt",
                nhom_san_pham=group,
                loai="thanh_pham",
                loai_mat_hang="bien_the",
                ma_nhom_mau=parent,
                ma_don_vi_co_so=units["VIEN"],
                ma_mau="Màu giả lập",
                ma_quy_cach="Chưa xác nhận",
                dang_su_dung=False,
            )
        add(
            "danh_muc.mat_hang",
            ma_nghiep_vu="XM-DEMO",
            ten="Xi măng giả lập",
            loai="vat_tu",
            loai_mat_hang="vat_tu",
            ma_don_vi_co_so=units["KG"],
            dang_su_dung=True,
        )
        add(
            "dung_chung.doi_tac",
            ma_nghiep_vu="KH-DEMO",
            ten="Khách hàng giả lập",
            cac_vai_tro="khach_hang",
            nhom_khach_hang="dai_ly",
            dang_su_dung=True,
        )
        add(
            "tai_chinh.quy_va_tai_khoan_tien",
            ma_nghiep_vu="QUY-DEMO",
            loai="tien_mat",
            tien_te="VND",
            dang_su_dung=True,
        )
        add(
            "san_xuat.nguon_luc_san_xuat",
            ma_nghiep_vu="MAY-DEMO",
            loai="may",
            ma_vi_tri=locations["XUONG-01"],
        )
        add(
            "nhan_su.ngay_va_ca_lam_viec",
            ngay_lam_viec=date.today(),
            loai_ngay_theo_lich="lam_viec",
            ma_ca="CA-DEMO",
            cac_khoang_lam_viec_trong_ca=[
                {"gio_bat_dau": "08:00", "gio_ket_thuc": "12:00"},
                {"gio_bat_dau": "13:00", "gio_ket_thuc": "17:00"},
            ],
        )
        employees = []
        for i in range(1, 51):
            person = db.uid()
            db.insert(
                c,
                "truy_cap.dinh_danh_nguoi",
                {
                    "ma_dinh_danh": person,
                    "ma_dinh_danh_nguoi": workspace_code + f"-NGUOI-{i:03}",
                    "ten_hien_thi": f"Nhân sự giả lập {i:02}",
                    "gia_lap": True,
                    "trang_thai_xu_ly": "dang_su_dung",
                },
            )
            employee = add(
                "nhan_su.nhan_vien",
                ma_nghiep_vu=f"E{i:03}",
                ten=f"Nhân sự giả lập {i:02}",
                ma_nguoi_that=person,
                ngay_vao_lam=date(2026, 9, 1),
            )
            head = add(
                "dung_chung.chung_tu",
                ma_nghiep_vu=f"HS-E{i:03}",
                loai="ho_so_lam_viec",
                so_phien_ban_chung_tu=1,
                trang_thai_phe_duyet="khong_yeu_cau",
                ly_do="Khai báo giả lập D01, không hợp đồng hoặc bảng công Nasaki thật",
            )
            db.insert(
                c,
                "nhan_su.ho_so_lam_viec_theo_hieu_luc",
                {
                    "ma_dinh_danh": head,
                    "ma_bo_du_lieu": w,
                    "ma_nhan_vien": employee,
                    "ma_bo_phan": depts["SX"] if i > 6 else list(depts.values())[(i - 1) % 5],
                    "thoi_diem_bat_dau_hieu_luc": date(2026, 9, 1),
                    "vi_tri_cong_viec": "Vị trí giả lập",
                    "tinh_trang_lam_viec": "dang_su_dung",
                },
            )
            employees.append((person, employee))
        allfields = {
            r["ten_bang"] for r in csv.DictReader((ROOT / "docs/database/fields.csv").open())
        }
        common = {
            "dung_chung.chung_tu",
            "dung_chung.dong_chung_tu",
            "dung_chung.lien_ket_chung_tu",
            "dung_chung.trao_doi_va_ban_giao",
            "dung_chung.de_nghi_va_quyet_dinh_phe_duyet",
            "dung_chung.chung_cu_dinh_kem",
            "dung_chung.nhat_ky_thao_tac",
            "truy_cap.bien_nhan_xac_nhan_giao_dich",
        }
        catalog = {
            "danh_muc.mat_hang",
            "danh_muc.ma_goi_khac",
            "danh_muc.quy_doi_don_vi",
            "dung_chung.doi_tac",
            "dung_chung.lien_he_doi_tac",
            "dung_chung.don_vi_tinh",
            "dung_chung.vi_tri_giu_hang",
            "dung_chung.bo_phan",
            "dung_chung.doanh_nghiep",
            "dung_chung.can_cu_dai_dien",
        }
        hr = {t for t in allfields if t.startswith("nhan_su.")} & {
            "nhan_su.nhan_vien",
            "nhan_su.ho_so_lam_viec_theo_hieu_luc",
            "nhan_su.ho_so_ky_nang_va_an_toan",
            "nhan_su.ngay_va_ca_lam_viec",
        }
        production = {"san_xuat.lich_nguoi_va_nguon_luc", "san_xuat.nguon_luc_san_xuat"}
        stock = {
            "kho.lo_hang",
            "kho.phan_lo_hang",
            "kho.dong_van_dong_hang",
            "kho.su_kien_giu_khoa_va_dang_ve",
        }
        qc = {"chat_luong.phieu_kiem_tra_chat_luong", "chat_luong.ket_qua_tung_tieu_chi_kiem_tra"}
        finance = {
            "tai_chinh.quy_va_tai_khoan_tien",
            "tai_chinh.bien_dong_tien_thuc",
            "tai_chinh.bien_dong_gia_tri",
        }
        d01 = (
            catalog
            | hr
            | production
            | stock
            | qc
            | finance
            | common
            | {
                "dung_chung.phien_ban_chinh_sach",
                "dung_chung.ky_nghiep_vu",
                "dung_chung.bo_du_lieu_mo_phong",
                "truy_cap.cap_vai_tro",
                "truy_cap.uy_quyen",
            }
        )
        common.add("dung_chung.phien_ban_chinh_sach")
        roles = [
            ("giamdoc", "Giám đốc", d01, d01),
            ("kinhdoanh", "Kinh doanh", catalog | common, catalog | common),
            (
                "kho",
                "Mua hàng/kho",
                catalog | common | stock | qc | finance,
                common | stock | catalog,
            ),
            (
                "sanxuat",
                "Sản xuất/chất lượng",
                catalog | common | stock | qc | hr | production,
                common | qc | production,
            ),
            (
                "taichinh",
                "Tài chính/nhân sự",
                catalog | common | hr | production | finance | stock,
                common | hr | finance,
            ),
            (
                "quantri",
                "Quản trị truy cập",
                common | {"truy_cap.cap_vai_tro", "truy_cap.uy_quyen"},
                common | {"truy_cap.cap_vai_tro", "truy_cap.uy_quyen"},
            ),
        ]
        creds = {}
        for i, (username, label, reads, writes) in enumerate(roles):
            role = db.uid()
            db.insert(
                c,
                "truy_cap.vai_tro_cong_viec",
                {"ma_dinh_danh": role, "ma_nghiep_vu": "D01-" + username, "ten": label},
            )
            for table in reads | common:
                for action in (
                    ["xem", "xuat_khau"]
                    + (["tao", "dieu_chinh", "xac_nhan"] if table in writes else [])
                    + (["phe_duyet"] if username == "giamdoc" else [])
                ):
                    db.insert(
                        c,
                        "truy_cap.quyen_thao_tac",
                        {
                            "ma_dinh_danh": db.uid(),
                            "ma_vai_tro": role,
                            "loai_doi_tuong_phan_quyen": table,
                            "hanh_dong": action,
                            "pham_vi": "doanh_nghiep",
                        },
                    )
            account = db.uid()
            password = secrets.token_urlsafe(16)
            db.insert(
                c,
                "truy_cap.tai_khoan_dang_nhap",
                {
                    "ma_dinh_danh": account,
                    "ten_dang_nhap": username,
                    "ban_bam_thong_tin_xac_thuc": make_password(password),
                    "trang_thai_xu_ly": "dang_su_dung",
                    "so_phien_ban_quyen_xac_thuc": 1,
                    "ma_nguoi_that": employees[i][0],
                },
            )
            add(
                "truy_cap.cap_vai_tro",
                ma_tai_khoan=account,
                ma_vai_tro=role,
                thoi_diem_bat_dau_hieu_luc=now,
            )
            creds[username] = {
                "mat_khau": password,
                "ten": label,
                "ma_tai_khoan": str(account),
                "ma_bo_du_lieu": str(w),
            }
        db.audit(
            c,
            w,
            None,
            "khoi_tao_ky_thuat",
            reason="Khai báo giả lập D01: một công ty/xưởng/kho, 50 hồ sơ; 6 tài khoản vai trò, không duyệt nghiệp vụ, không nạp fixture cũ, không công/lương/QC hoặc số dư giả.",
        )
        # QC may update the quality conclusion, never confirm physical quantity.
        sx = c.execute(
            "SELECT ma_dinh_danh FROM truy_cap.vai_tro_cong_viec WHERE ma_nghiep_vu='D01-sanxuat'"
        ).fetchone()["ma_dinh_danh"]
        db.insert(
            c,
            "truy_cap.quyen_thao_tac",
            {
                "ma_dinh_danh": db.uid(),
                "ma_vai_tro": sx,
                "loai_doi_tuong_phan_quyen": "kho.phan_lo_hang",
                "hanh_dong": "dieu_chinh",
                "pham_vi": "doanh_nghiep",
            },
        )
        path = Path(credentials_path) if credentials_path else ROOT / ".runtime/credentials.json"
        path.write_text(json.dumps(creds, ensure_ascii=False))
        path.chmod(0o600)
