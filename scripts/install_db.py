"""Apply immutable numbered migrations with owner credentials, never the web role."""

import os, hashlib, sys
from pathlib import Path
import psycopg
from psycopg import sql

ROOT = Path(__file__).resolve().parents[1]


def migrate(uri=None):
    with psycopg.connect(uri or os.environ["ERP_ADMIN_DATABASE_URL"]) as c:
        c.execute("SELECT pg_advisory_xact_lock(79190401)")
        present = c.execute("SELECT to_regclass('nen_tang.phien_ban_cau_truc')").fetchone()[0]
        for path in sorted((ROOT / "database/migrations").glob("*.sql")):
            digest = hashlib.sha256(path.read_bytes()).hexdigest()
            old = (
                c.execute(
                    "SELECT ma_kiem_toan_ven FROM nen_tang.phien_ban_cau_truc WHERE ma_phien_ban=%s",
                    (path.name,),
                ).fetchone()
                if present
                else None
            )
            if old:
                if old[0] != digest:
                    raise RuntimeError("Migration đã áp dụng bị sửa: " + path.name)
                continue
            c.execute(path.read_text())
            present = True
            c.execute(
                "INSERT INTO nen_tang.phien_ban_cau_truc(ma_phien_ban,ma_kiem_toan_ven) VALUES (%s,%s)",
                (path.name, digest),
            )
        # Apply FORCE RLS to scoped tables; owner/backup never used by web processes.
        scoped = c.execute(
            "SELECT table_schema,table_name FROM information_schema.columns WHERE column_name='ma_bo_du_lieu' AND table_schema NOT IN ('nen_tang')"
        ).fetchall()
        for schema, table in scoped:
            name = schema + "." + table
            i = sql.Identifier(schema, table)
            c.execute(sql.SQL("ALTER TABLE {} ENABLE ROW LEVEL SECURITY").format(i))
            c.execute(sql.SQL("ALTER TABLE {} FORCE ROW LEVEL SECURITY").format(i))
            c.execute(sql.SQL("DROP POLICY IF EXISTS pham_vi ON {}").format(i))
            has_doc = c.execute(
                "SELECT 1 FROM information_schema.columns WHERE table_schema=%s AND table_name=%s AND column_name=%s",
                (schema, table, "ma_phien_ban_chung_tu"),
            ).fetchone()
            guard = (
                sql.SQL(" AND nen_tang.co_quyen_loai_ho_so(ma_bo_du_lieu,loai)")
                if name == "dung_chung.chung_tu"
                else (
                    sql.SQL(
                        " AND (ma_phien_ban_chung_tu IS NULL OR nen_tang.co_quyen_ho_so(ma_bo_du_lieu,ma_phien_ban_chung_tu))"
                    )
                    if has_doc
                    else sql.SQL("")
                )
            )
            c.execute(
                sql.SQL(
                    "CREATE POLICY pham_vi ON {} USING (ma_bo_du_lieu::text=current_setting('erp.bo',true) AND nen_tang.co_quyen(ma_bo_du_lieu,{},'xem'){}) WITH CHECK (ma_bo_du_lieu::text=current_setting('erp.bo',true) AND (nen_tang.co_quyen(ma_bo_du_lieu,{},'tao') OR nen_tang.co_quyen(ma_bo_du_lieu,{},'dieu_chinh') OR nen_tang.co_quyen(ma_bo_du_lieu,{},'xac_nhan') OR nen_tang.co_quyen(ma_bo_du_lieu,{},'phe_duyet')){})"
                ).format(i, sql.Literal(name), guard, *[sql.Literal(name)] * 4, guard)
            )
            c.execute(sql.SQL("DROP TRIGGER IF EXISTS bao_toan ON {}").format(i))
            c.execute(
                sql.SQL(
                    "CREATE TRIGGER bao_toan BEFORE UPDATE OR DELETE ON {} FOR EACH ROW EXECUTE FUNCTION nen_tang.bao_toan_nguon()"
                ).format(i)
            )
        c.execute("ALTER TABLE nen_tang.ban_nhap_bieu_mau ENABLE ROW LEVEL SECURITY")
        c.execute("ALTER TABLE nen_tang.ban_nhap_bieu_mau FORCE ROW LEVEL SECURITY")
        c.execute("DROP POLICY IF EXISTS chu_nhap ON nen_tang.ban_nhap_bieu_mau")
        c.execute(
            "CREATE POLICY chu_nhap ON nen_tang.ban_nhap_bieu_mau USING (ma_bo_du_lieu::text=current_setting('erp.bo',true) AND ma_tai_khoan::text=current_setting('erp.tai_khoan',true)) WITH CHECK(ma_bo_du_lieu::text=current_setting('erp.bo',true) AND ma_tai_khoan::text=current_setting('erp.tai_khoan',true))"
        )
    print("Migrations + scoped RLS applied")


if __name__ == "__main__":
    migrate()


def grant_runtime(c):
    """Restore exactly the web role's baseline grants, including after --no-acl restore."""
    schemas = c.execute(
        "SELECT schema_name FROM information_schema.schemata WHERE schema_name NOT LIKE 'pg_%' AND schema_name NOT IN ('information_schema','public')"
    ).fetchall()
    for row in schemas:
        schema = row["schema_name"] if isinstance(row, dict) else row[0]
        c.execute(
            sql.SQL("GRANT USAGE ON SCHEMA {} TO mini_erp_app").format(sql.Identifier(schema))
        )
        c.execute(
            sql.SQL("GRANT SELECT,INSERT,UPDATE ON ALL TABLES IN SCHEMA {} TO mini_erp_app").format(
                sql.Identifier(schema)
            )
        )
    c.execute("REVOKE INSERT,UPDATE ON nen_tang.phien_ban_cau_truc FROM mini_erp_app")
    c.execute("GRANT DELETE ON nen_tang.ban_nhap_bieu_mau TO mini_erp_app")
    c.execute("REVOKE EXECUTE ON ALL FUNCTIONS IN SCHEMA nen_tang FROM PUBLIC")
    for signature in [
        "co_quyen(uuid,text,text)",
        "nhan_vien_hien_tai()",
        "cac_bo_duoc_cap()",
        "co_quyen_ho_so(uuid,uuid)",
        "co_quyen_loai_ho_so(uuid,text)",
        "danh_sach_nguoi_ban_giao()",
        "kiem_cau_truc(jsonb,text)",
        "kiem_cau_truc_khoa(jsonb,text)",
        "json_dung_khoa(jsonb,text[])",
    ]:
        c.execute(sql.SQL("GRANT EXECUTE ON FUNCTION nen_tang." + signature + " TO mini_erp_app"))
