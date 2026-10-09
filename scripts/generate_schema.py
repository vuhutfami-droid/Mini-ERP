"""Compile B29's explicit field/relationship dictionaries into a reviewed SQL migration.
Never loads sample transactions. Regeneration must be reviewed before deployment.
"""

import csv, hashlib
from collections import defaultdict
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
TYPES = {
    "Mã UUID": "uuid",
    "Văn bản": "text",
    "Phân loại có danh sách đóng": "text",
    "Thời điểm có múi giờ": "timestamptz",
    "Số nguyên": "bigint",
    "Số nguyên nhỏ": "smallint",
    "Có/không": "boolean",
    "Số lượng chính xác": "numeric(24,6)",
    "Số tiền VND nguyên đồng": "numeric(24,0)",
    "Nội dung có cấu trúc đóng": "jsonb",
    "Ngày địa phương": "date",
    "Số thập phân chính xác": "numeric(24,8)",
    "Tỷ lệ từ 0 đến 1": "numeric(12,10)",
}


def ident(s):
    return ".".join('"' + x + '"' for x in s.split("."))


def literal(s):
    return "'" + s.replace("'", "''") + "'"


def short(prefix, *s):
    return prefix + "_" + hashlib.sha256("|".join(s).encode()).hexdigest()[:18]


rows = list(csv.DictReader((ROOT / "docs/database/fields.csv").open()))
tables = defaultdict(list)
for r in rows:
    tables[r["ten_bang"]].append(r)
cols = {t: {r["ten_truong"] for r in rs} for t, rs in tables.items()}
out = ["-- B29: 74 business tables / 931 columns. Future-domain tables stay empty in D01."]
for schema in sorted({t.split(".")[0] for t in tables}):
    out.append(f"CREATE SCHEMA {ident(schema)};")
out.append("CREATE SCHEMA nen_tang;")
for t, rs in tables.items():
    parts = []
    for r in rs:
        n = r["ten_truong"]
        spec = ident(n) + " " + TYPES[r["kieu_du_lieu"]]
        if n == "ma_dinh_danh":
            spec += " PRIMARY KEY DEFAULT gen_random_uuid()"
        elif n == "ma_bo_du_lieu":
            spec += " NOT NULL"
        elif n == "thoi_diem_tao":
            spec += " NOT NULL DEFAULT now()"
        elif n == "so_phien_ban_ghi_dong_thoi":
            spec += " NOT NULL DEFAULT 1 CHECK (" + ident(n) + ">0)"
        if r["gia_tri_cho_phep"]:
            opts = sorted(set(v.strip() for v in r["gia_tri_cho_phep"].split(";") if v.strip()))
            spec += " CHECK (" + ident(n) + " IN (" + ",".join(map(literal, opts)) + "))"
        if r["kieu_du_lieu"] == "Tỷ lệ từ 0 đến 1":
            spec += " CHECK (" + ident(n) + " BETWEEN 0 AND 1)"
        parts.append(spec)
    if "ma_bo_du_lieu" in cols[t]:
        parts.append("UNIQUE (ma_dinh_danh,ma_bo_du_lieu)")
    out.append(f"CREATE TABLE {ident(t)} (\n  " + ",\n  ".join(parts) + "\n);")
    for r in rs:
        out.append(
            f'COMMENT ON COLUMN {ident(t)}.{ident(r["ten_truong"])} IS {literal(r["nhan_tieng_viet"]+": "+r["mo_ta"])};'
        )
    if "ma_nghiep_vu" in cols[t] and t not in [
        "dung_chung.chung_tu",
        "dung_chung.phien_ban_chinh_sach",
        "dung_chung.bo_du_lieu_mo_phong",
    ]:
        scope = "ma_bo_du_lieu," if "ma_bo_du_lieu" in cols[t] else ""
        out.append(f'CREATE UNIQUE INDEX {short("ma",t)} ON {ident(t)} ({scope}ma_nghiep_vu);')
    out.append(
        f'COMMENT ON TABLE {ident(t)} IS {literal("Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.")};'
    )
for r in csv.DictReader((ROOT / "docs/database/relationships.csv").open()):
    t, n, target, k = r["bang_con"], r["truong_lien_ket"], r["bang_nguon"], r["truong_nguon"]
    scoped = "ma_bo_du_lieu" in cols[t] and "ma_bo_du_lieu" in cols[target] and n != "ma_bo_du_lieu"
    out.append(
        f'ALTER TABLE {ident(t)} ADD CONSTRAINT {short("fk",t,n)} FOREIGN KEY ({ident(n)}'
        + (",ma_bo_du_lieu)" if scoped else ")")
        + f" REFERENCES {ident(target)} ({ident(k)}"
        + (",ma_bo_du_lieu)" if scoped else ")")
        + " ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;"
    )
    out.append(f'CREATE INDEX {short("lk",t,n)} ON {ident(t)} ({ident(n)});')
for ix, r in enumerate(csv.DictReader((ROOT / "docs/database/source-contracts.csv").open())):
    t, n, target, dis, values = (
        r["bang_con"],
        r["truong_lien_ket"],
        r["bang_nguon"],
        r["truong_phan_loai"],
        r["gia_tri_duoc_phep"].split("|"),
    )
    name = f"nguon_{ix:02}"
    if dis == "@loai_phieu_cha":
        query = f"SELECT p.loai_van_dong_kho FROM {ident(target)} d JOIN dung_chung.chung_tu p ON p.ma_dinh_danh=d.ma_phieu_van_dong_hang WHERE d.ma_dinh_danh=NEW.{ident(n)}"
    else:
        query = f"SELECT {ident(dis)} FROM {ident(target)} WHERE ma_dinh_danh=NEW.{ident(n)}"
    out.append(
        f"""CREATE FUNCTION nen_tang.{name}() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW.{ident(n)} IS NOT NULL THEN {query} INTO v; IF v IS NULL OR v NOT IN ({','.join(map(literal,values))}) THEN RAISE EXCEPTION 'Nguồn không đúng loại: {name}' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER {name} AFTER INSERT OR UPDATE ON {ident(t)} DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.{name}();"""
    )
out += [
    "CREATE UNIQUE INDEX ten_tai_khoan ON truy_cap.tai_khoan_dang_nhap(lower(ten_dang_nhap));",
    "CREATE UNIQUE INDEX ma_nguoi ON truy_cap.dinh_danh_nguoi(ma_dinh_danh_nguoi);",
    "CREATE UNIQUE INDEX ma_phien ON truy_cap.phien_dang_nhap(ban_bam_ma_phien_dang_nhap);",
    "CREATE UNIQUE INDEX khoa_bien_nhan ON truy_cap.bien_nhan_xac_nhan_giao_dich(ma_bo_du_lieu,ma_tai_khoan,khoa_chong_xac_nhan_lap);",
    "CREATE UNIQUE INDEX ma_ban_chung_tu ON dung_chung.chung_tu(ma_bo_du_lieu,ma_nghiep_vu,so_phien_ban_chung_tu);",
    "CREATE UNIQUE INDEX ma_ban_chinh_sach ON dung_chung.phien_ban_chinh_sach(ma_bo_du_lieu,ma_nghiep_vu,so_phien_ban);",
    "CREATE UNIQUE INDEX mot_doanh_nghiep ON dung_chung.doanh_nghiep(ma_bo_du_lieu);",
    "CREATE UNIQUE INDEX ma_bo ON dung_chung.bo_du_lieu_mo_phong(ma_nghiep_vu,phien_ban_bo_mo_phong,che_do);",
    "ALTER TABLE danh_muc.mat_hang ADD CHECK (loai_mat_hang <> 'bien_the' OR (ma_nhom_mau IS NOT NULL AND ma_don_vi_co_so IS NOT NULL));",
    "ALTER TABLE kho.dong_van_dong_hang ADD CHECK (so_luong_do_theo_don_vi_co_so>0 AND so_luong_theo_don_vi_nhap>0 AND he_so_quy_doi_tai_lan_ghi_nhan>0);",
    "ALTER TABLE tai_chinh.bien_dong_tien_thuc ADD CHECK (so_tien>=0);",
    "ALTER TABLE tai_chinh.bien_dong_gia_tri ADD CHECK (so_tien>=0);",
    "ALTER TABLE chat_luong.phieu_kiem_tra_chat_luong ADD CHECK (so_luong_thuc_kiem>=0 AND so_luong_ket_luan_dat>=0 AND so_luong_ket_luan_loi>=0 AND so_luong_cho_ket_luan>=0 AND so_luong_thuc_kiem=so_luong_ket_luan_dat+so_luong_ket_luan_loi+so_luong_cho_ket_luan);",
    """CREATE TABLE nen_tang.phien_ban_cau_truc (ma_phien_ban text PRIMARY KEY,ma_kiem_toan_ven text NOT NULL,thoi_diem_ap_dung timestamptz NOT NULL DEFAULT now());
 CREATE TABLE nen_tang.ban_nhap_bieu_mau (ma_dinh_danh uuid PRIMARY KEY,ma_bo_du_lieu uuid NOT NULL REFERENCES dung_chung.bo_du_lieu_mo_phong(ma_dinh_danh),ma_tai_khoan uuid NOT NULL REFERENCES truy_cap.tai_khoan_dang_nhap(ma_dinh_danh),loai_bieu_mau text NOT NULL,noi_dung_nhap jsonb NOT NULL,so_phien_ban bigint NOT NULL DEFAULT 1,thoi_diem_cap_nhat timestamptz NOT NULL DEFAULT now(), UNIQUE(ma_bo_du_lieu,ma_tai_khoan,ma_dinh_danh));
 CREATE TABLE nen_tang.gioi_han_dang_nhap (khoa_da_bam text PRIMARY KEY,so_lan_sai integer NOT NULL DEFAULT 0,thoi_diem_bat_dau timestamptz NOT NULL DEFAULT now());""",
]
path = ROOT / ".runtime/schema-preview.sql"
path.parent.mkdir(exist_ok=True)
path.write_text("\n".join(out) + "\n")
print("Generated", path, "74 tables, 931 columns, 402 FK, 43 source-type triggers")
