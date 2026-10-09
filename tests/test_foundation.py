import unittest, json, uuid, os, io, hashlib, threading
from pathlib import Path
from datetime import timedelta
from concurrent.futures import ThreadPoolExecutor
import psycopg
from psycopg import sql
from django.test import Client as DjangoClient
from django.core.files.uploadedfile import SimpleUploadedFile
from foundation import db, services, auth
from foundation.catalog import REGISTRY, FIELDS

ROOT = Path(__file__).resolve().parents[1]
CREDS = json.loads((ROOT / ".runtime/test-credentials.json").read_text())
W = uuid.UUID(CREDS["giamdoc"]["ma_bo_du_lieu"])


def user(role):
    a = CREDS[role]
    with db.tx() as c:
        r = db.get(c, "truy_cap.tai_khoan_dang_nhap", uuid.UUID(a["ma_tai_khoan"]))
        return {"id": r["ma_dinh_danh"], "ma_nguoi_that": r["ma_nguoi_that"]}


class Client(DjangoClient):
    def post(self, path, data=None, *args, **kwargs):
        if isinstance(data, dict):
            data = {"form_workspace": str(W), **data}
        return super().post(path, data, *args, **kwargs)


def client(role="giamdoc"):
    c = Client()
    a = CREDS[role]
    r = c.post("/dang-nhap/", {"username": role, "password": a["mat_khau"]})
    assert r.status_code == 302
    return c


class FoundationTests(unittest.TestCase):
    def test_01_physical_schema_and_bootstrap(self):
        with db.tx(admin=True) as c:
            for table, fields in FIELDS.items():
                schema, name = table.split(".")
                cols = c.execute(
                    "SELECT column_name FROM information_schema.columns WHERE table_schema=%s AND table_name=%s",
                    (schema, name),
                ).fetchall()
                self.assertEqual(set(fields), {r["column_name"] for r in cols})
            self.assertEqual(
                c.execute("SELECT count(*) n FROM nhan_su.nhan_vien").fetchone()["n"], 50
            )
            self.assertEqual(
                c.execute("SELECT count(*) n FROM truy_cap.tai_khoan_dang_nhap").fetchone()["n"], 6
            )
            for t in [
                "nhan_su.khoang_cong_thuc_te",
                "nhan_su.thu_nhap_nhan_vien",
                "kinh_doanh.bao_gia_va_don_hang",
            ]:
                self.assertEqual(
                    c.execute(
                        sql.SQL("SELECT count(*) n FROM {}").format(sql.Identifier(*t.split(".")))
                    ).fetchone()["n"],
                    0,
                )
        from foundation.bootstrap import bootstrap

        bootstrap("NASAKI-TEST", ROOT / ".runtime/test-credentials.json")

    def test_02_login_csrf_expiry_logout(self):
        c = client()
        self.assertEqual(c.get("/").status_code, 200)
        self.assertEqual(c.post("/dang-xuat/").status_code, 302)
        self.assertEqual(c.get("/").url, "/dang-nhap/")
        protected = Client(enforce_csrf_checks=True)
        self.assertEqual(protected.post("/dang-nhap/", {"username": "giamdoc"}).status_code, 403)
        token = auth.authenticate("giamdoc", CREDS["giamdoc"]["mat_khau"])
        with db.tx() as conn:
            conn.execute(
                "UPDATE truy_cap.phien_dang_nhap SET thoi_diem_het_hieu_luc=now()-interval '1 second' WHERE ban_bam_ma_phien_dang_nhap=%s",
                (hashlib.sha256(token.encode()).hexdigest(),),
            )
            self.assertIsNone(auth.session(conn, token))

    def test_03_catalog_repeat_stale_permissions(self):
        c = client("kinhdoanh")
        data = {
            "ma_nghiep_vu": "KH-TEST-NEW",
            "ten": "Đối tác mới",
            "cac_vai_tro": "khach_hang",
            "dang_su_dung": "on",
            "request_key": "new-partner-1",
        }
        self.assertEqual(c.post("/danh-muc/doi-tac/them/", data).status_code, 302)
        self.assertEqual(c.post("/danh-muc/doi-tac/them/", data).status_code, 302)
        self.assertEqual(
            c.post("/danh-muc/doi-tac/them/", {**data, "ten": "Khác"}).status_code, 409
        )
        with db.tx(user("kinhdoanh")["id"], W) as conn:
            r = conn.execute(
                "SELECT * FROM dung_chung.doi_tac WHERE ma_nghiep_vu='KH-TEST-NEW'"
            ).fetchone()
        update = {**data, "ten": "Đã sửa", "version": 1, "request_key": "update-1"}
        self.assertEqual(c.post(f"/danh-muc/doi-tac/{r['ma_dinh_danh']}/", update).status_code, 302)
        self.assertEqual(
            c.post(
                f"/danh-muc/doi-tac/{r['ma_dinh_danh']}/",
                {**update, "ten": "Ghi đè", "request_key": "update-2"},
            ).status_code,
            409,
        )
        self.assertEqual(client("quantri").get("/danh-muc/nhan-su/").status_code, 403)
        self.assertEqual(
            client("kinhdoanh").post("/mo-dau/them/cash/", {"amount": 100}).status_code, 403
        )
        self.assertEqual(c.get("/danh-muc/doi-tac/xuat/").status_code, 200)

    def test_04_rollback_and_concurrent_idempotency(self):
        u = user("giamdoc")
        key = str(db.uid())

        def fail():
            with db.tx(u["id"], W) as c:

                def work():
                    services.head(c, W, u["id"], "ROLLBACK-TEST", "phan_cong", "Nguồn kiểm")
                    db.audit(c, W, u["id"], "rollback_marker")
                    raise ValueError("fault")

                db.idempotent(c, W, u["id"], key, {"a": 1}, "tao", work)

        self.assertRaises(ValueError, fail)
        with db.tx(admin=True) as c:
            self.assertIsNone(
                c.execute(
                    "SELECT 1 FROM dung_chung.chung_tu WHERE ma_nghiep_vu='ROLLBACK-TEST'"
                ).fetchone()
            )
            self.assertIsNone(
                c.execute(
                    "SELECT 1 FROM truy_cap.bien_nhan_xac_nhan_giao_dich WHERE khoa_chong_xac_nhan_lap=%s",
                    (key,),
                ).fetchone()
            )
        barrier = threading.Barrier(2)

        def send(_):
            with db.tx(u["id"], W) as c:
                barrier.wait()
                return db.idempotent(
                    c,
                    W,
                    u["id"],
                    "parallel-key",
                    {"p": 2},
                    "tao",
                    lambda: services.create_document(
                        c, W, u, "PARALLEL", "phan_cong", "Nguồn kiểm"
                    ),
                )

        with ThreadPoolExecutor(2) as pool:
            results = list(pool.map(send, [1, 2]))
        self.assertEqual(results[0], results[1])

    def test_05_source_kind_scope_and_closed_json(self):
        u = user("giamdoc")

        def bad_json():
            with db.tx(u["id"], W) as c:
                db.insert(
                    c,
                    "nhan_su.ngay_va_ca_lam_viec",
                    {
                        "ma_dinh_danh": db.uid(),
                        "ma_bo_du_lieu": W,
                        "ma_ca": "SAI",
                        "cac_khoang_lam_viec_trong_ca": [{"gio_bat_dau": "08:00"}],
                    },
                )

        self.assertRaises(psycopg.IntegrityError, bad_json)

        def wrong_source():
            with db.tx(u["id"], W) as c:
                h = services.head(c, W, u["id"], "WRONG-QC", "phan_cong", "Sai loại")
                db.insert(
                    c,
                    "chat_luong.phieu_kiem_tra_chat_luong",
                    {"ma_dinh_danh": h, "ma_bo_du_lieu": W},
                )

        self.assertRaises(psycopg.IntegrityError, wrong_source)
        with db.tx() as c:
            self.assertEqual(
                c.execute("SELECT count(*) n FROM dung_chung.doi_tac").fetchone()["n"], 0
            )
        foreign = db.uid()
        with db.tx(admin=True) as c:
            db.insert(
                c,
                "dung_chung.bo_du_lieu_mo_phong",
                {"ma_dinh_danh": foreign, "ma_nghiep_vu": "BRANCH", "che_do": "dau_ky"},
            )
            partner = db.uid()
            db.insert(
                c,
                "dung_chung.doi_tac",
                {
                    "ma_dinh_danh": partner,
                    "ma_bo_du_lieu": foreign,
                    "ma_nghiep_vu": "BRANCH-KH",
                    "ten": "Bộ khác",
                },
            )
        with db.tx(u["id"], W) as c:
            self.assertIsNone(db.get(c, "dung_chung.doi_tac", partner))

        def mixed():
            with db.tx(u["id"], W) as c:
                db.insert(
                    c,
                    "dung_chung.lien_he_doi_tac",
                    {
                        "ma_dinh_danh": db.uid(),
                        "ma_bo_du_lieu": W,
                        "ma_doi_tac": partner,
                        "ten": "Sai bộ",
                    },
                )

        self.assertRaises(psycopg.IntegrityError, mixed)

    def test_06_full_opening_sources_and_immutability(self):
        u = user("giamdoc")
        keeper = user("kho")
        qcuser = user("sanxuat")
        finance = user("taichinh")
        with db.tx(u["id"], W) as c:
            h = services.create_document(
                c, W, u, "QC-POLICY", "quyet_dinh_chinh_sach", "Tiêu chí giả lập do người khai báo"
            )["cac_ma_chung_tu"][0]
            params = {
                "loai_chinh_sach": "chat_luong",
                "cac_tham_so": [
                    {
                        "ten_tham_so": "ma_tieu_chi",
                        "gia_tri": x,
                        "kieu_gia_tri": "van_ban",
                        "don_vi": "",
                        "can_cu_khai_bao": "Biên bản giả lập test",
                    }
                    for x in ["BE-MAT", "MAU"]
                ],
            }
            policy = db.uid()
            db.insert(
                c,
                "dung_chung.phien_ban_chinh_sach",
                {
                    "ma_dinh_danh": policy,
                    "ma_bo_du_lieu": W,
                    "ma_nghiep_vu": "QC-POLICY",
                    "loai": "kiem_chat_luong",
                    "so_phien_ban": 1,
                    "tham_so": params,
                    "ma_chung_tu_can_cu_khai_bao": h,
                    "ma_nguoi_khai_bao_du_lieu": services.employee(c, u),
                    "gia_lap": True,
                    "thoi_diem_bat_dau_hieu_luc": db.now() - timedelta(days=1),
                },
            )
            services.document_action(c, W, u, h, "trinh", 1)
            services.document_action(c, W, u, h, "duyet", 2, "Đã kiểm tiêu chí giả lập")
        for index, (code, result, quantity) in enumerate(
            [("NGOI-MAU", "dat", "100"), ("TERRAZZO-MAU", "loi", "40"), ("XM-DEMO", None, "1.125")]
        ):
            with db.tx(keeper["id"], W) as c:
                item = c.execute(
                    "SELECT ma_dinh_danh FROM danh_muc.mat_hang WHERE ma_nghiep_vu=%s", (code,)
                ).fetchone()["ma_dinh_danh"]
                pos = c.execute(
                    "SELECT ma_dinh_danh FROM dung_chung.vi_tri_giu_hang WHERE ma_nghiep_vu='KHO-TP'"
                ).fetchone()["ma_dinh_danh"]
                r = db.idempotent(
                    c,
                    W,
                    keeper["id"],
                    f"opening-{index}",
                    {"code": code},
                    "tao",
                    lambda: services.opening_stock(
                        c,
                        W,
                        keeper,
                        f"TON-{index}",
                        item,
                        pos,
                        quantity,
                        "Biên bản giả lập mới; không số liệu Nasaki",
                    ),
                )
                source = r["cac_ma_chung_tu"][0]
                line = r["cac_ma_dong"][0]
            with db.tx(keeper["id"], W) as c:
                services.attach(
                    c,
                    W,
                    keeper,
                    source,
                    SimpleUploadedFile(
                        "bien-ban.txt",
                        b"Nguon gia lap D01 moi; dem va doi chieu, khong du lieu Nasaki.",
                    ),
                )
            with db.tx(keeper["id"], W) as c:
                db.idempotent(
                    c,
                    W,
                    keeper["id"],
                    f"post-{index}",
                    {"id": line},
                    "xac_nhan",
                    lambda receipt: services.post_opening(c, W, keeper, line, receipt),
                )
            if result:
                with db.tx(qcuser["id"], W) as c:
                    db.idempotent(
                        c,
                        W,
                        qcuser["id"],
                        f"qc-{index}",
                        {"id": line},
                        "xac_nhan",
                        lambda: services.opening_qc(
                            c,
                            W,
                            qcuser,
                            line,
                            result,
                            "Đã kiểm toàn bộ theo nguồn giả lập",
                            policy,
                            {
                                x: {"observation": "Quan sát riêng " + x, "result": result}
                                for x in ["BE-MAT", "MAU"]
                            },
                        ),
                    )
            with db.tx(finance["id"], W) as c:
                services.opening_value(
                    c, W, finance, line, 100000 * (index + 1), "Hồ sơ định giá giả lập nguồn mới"
                )

            def overwrite():
                with db.tx(keeper["id"], W) as c:
                    db.update(
                        c,
                        "kho.dong_van_dong_hang",
                        uuid.UUID(line),
                        {"so_luong_do_theo_don_vi_co_so": 999},
                    )

            self.assertRaises(psycopg.IntegrityError, overwrite)

            def overwrite_product_without_stock_read():
                kd = user("kinhdoanh")
                with db.tx(kd["id"], W) as conn:
                    db.update(conn, "danh_muc.mat_hang", item, {"ma_mau": "Đổi nguồn trái phép"})

            self.assertRaises(psycopg.IntegrityError, overwrite_product_without_stock_read)
        with db.tx(finance["id"], W) as c:
            fund = c.execute(
                "SELECT ma_dinh_danh FROM tai_chinh.quy_va_tai_khoan_tien LIMIT 1"
            ).fetchone()["ma_dinh_danh"]
            cash = db.idempotent(
                c,
                W,
                finance["id"],
                "cash-1",
                {"a": 1},
                "tao",
                lambda receipt: services.opening_cash(
                    c,
                    W,
                    finance,
                    "TIEN-DAU",
                    fund,
                    10000000,
                    "Đối chiếu giả lập tại mốc mở đầu",
                    receipt,
                ),
            )
            source = cash["cac_ma_chung_tu"][0]
            line = cash["cac_ma_su_kien"][0]
            services.attach(
                c, W, finance, source, SimpleUploadedFile("quy.txt", b"Bien ban quy gia lap moi.")
            )
        with db.tx(finance["id"], W) as c:
            db.idempotent(
                c,
                W,
                finance["id"],
                "post-cash",
                {"a": 1},
                "xac_nhan",
                lambda receipt: services.post_cash(c, W, finance, line, receipt),
            )
        with db.tx(admin=True) as c:
            self.assertEqual(
                c.execute("SELECT count(*) n FROM tai_chinh.dong_ghi_nhan_ban").fetchone()["n"], 0
            )
        self.assertEqual(client("giamdoc").get("/mo-dau/").status_code, 200)

    def test_07_legacy_source_policy(self):
        from foundation.imports import reject_old, POLICY

        for r in POLICY["cac_tep"]:
            self.assertRaises(
                ValueError, reject_old, r["tep"], (ROOT / "docs/demo-data" / r["tep"]).read_bytes()
            )
        self.assertRaises(ValueError, reject_old, "source.xlsx", b"OTHER-001")

    def test_08_handoff(self):
        sender = user("giamdoc")
        recipient = user("sanxuat")
        with db.tx(sender["id"], W) as c:
            h = services.create_document(c, W, sender, "HANDOFF", "phan_cong", "Công việc giả lập")[
                "cac_ma_chung_tu"
            ][0]
            r = services.handoff(
                c,
                W,
                sender,
                h,
                c.execute(
                    "SELECT ma_dinh_danh FROM nhan_su.nhan_vien WHERE ma_nguoi_that=%s",
                    (recipient["ma_nguoi_that"],),
                ).fetchone()["ma_dinh_danh"],
                "Rà nguồn QC mở đầu",
            )
            key = r["cac_ma_su_kien"][0]
        with db.tx(recipient["id"], W) as c:
            services.handoff(c, W, recipient, None, None, "Đã nhận đủ nguồn", key, 1, True)
        from scripts.backup_restore import backup
        import shutil

        directory = ROOT / ".runtime/test-backup"
        if directory.exists():
            shutil.rmtree(directory)
        backup(os.environ["ERP_ADMIN_DATABASE_URL"], directory, ROOT / ".runtime/test-media")

    def test_09_access_same_person_and_revocation(self):
        ceo = user("giamdoc")
        admin = user("quantri")
        target = user("kinhdoanh")
        with db.tx(ceo["id"], W) as c:
            role = c.execute(
                "SELECT ma_dinh_danh FROM truy_cap.vai_tro_cong_viec WHERE ma_nghiep_vu='D01-kinhdoanh'"
            ).fetchone()["ma_dinh_danh"]
            h = services.create_document(
                c,
                W,
                ceo,
                "SELF-RIGHTS",
                "quyet_dinh_cap_quyen",
                "Không tự duyệt",
                f"cap:{ceo['id']}:{role}",
            )["cac_ma_chung_tu"][0]
            services.document_action(c, W, ceo, h, "trinh", 1)
        with self.assertRaises(ValueError):
            with db.tx(ceo["id"], W) as c:
                services.document_action(c, W, ceo, h, "duyet", 2, "Sai tự duyệt")
        c = client("kinhdoanh")
        with db.tx(ceo["id"], W) as conn:
            h = services.create_document(
                conn,
                W,
                ceo,
                "REVOKE-KD",
                "quyet_dinh_cap_quyen",
                "Kiểm thu hồi",
                f"thu_hoi:{target['id']}:{role}",
            )["cac_ma_chung_tu"][0]
            services.document_action(conn, W, ceo, h, "trinh", 1)
            services.document_action(conn, W, ceo, h, "duyet", 2, "Chấp thuận thu hồi")
        admin_client = client("quantri")
        self.assertEqual(
            admin_client.post(f"/truy-cap/{h}/ap-dung/", {"request_key": "revoke-kd"}).status_code,
            302,
        )
        self.assertIn(c.get("/").status_code, [302, 403])
        self.assertEqual(
            c.post("/danh-muc/doi-tac/them/", {"ma_nghiep_vu": "AFTER-REVOKE"}).status_code, 302
        )

    def test_10_restore_db_files_current_rights(self):
        from scripts.backup_restore import restore
        from psycopg.conninfo import conninfo_to_dict, make_conninfo

        args = conninfo_to_dict(os.environ["ERP_ADMIN_DATABASE_URL"])
        args["dbname"] = "mini_erp_restore"
        uri = make_conninfo(**args)
        result = restore(
            ROOT / ".runtime/test-backup",
            uri,
            os.environ["ERP_ADMIN_DATABASE_URL"],
            ROOT / ".runtime/restore-media",
        )
        self.assertGreater(result["tep_da_kiem"], 0)
        with psycopg.connect(uri) as c:
            self.assertEqual(
                c.execute(
                    "SELECT count(*) FROM tai_chinh.bien_dong_tien_thuc WHERE trang_thai_ghi_so='da_ghi_so'"
                ).fetchone()[0],
                1,
            )
            self.assertEqual(
                c.execute(
                    "SELECT count(*) FROM truy_cap.phien_dang_nhap WHERE thoi_diem_thu_hoi_quyen IS NULL"
                ).fetchone()[0],
                0,
            )
            self.assertEqual(
                c.execute(
                    "SELECT count(*) FROM truy_cap.cap_vai_tro g JOIN truy_cap.tai_khoan_dang_nhap a ON a.ma_dinh_danh=g.ma_tai_khoan WHERE a.ten_dang_nhap='kinhdoanh' AND g.thoi_diem_thu_hoi_quyen IS NULL"
                ).fetchone()[0],
                0,
            )
        app_args = conninfo_to_dict(os.environ["ERP_DATABASE_URL"])
        app_args["dbname"] = "mini_erp_restore"
        with psycopg.connect(make_conninfo(**app_args)) as c:
            c.execute("SELECT set_config('erp.bo',%s,true)", (str(W),))
            c.execute("SELECT set_config('erp.tai_khoan',%s,true)", (str(user("giamdoc")["id"]),))
            self.assertEqual(
                c.execute(
                    "SELECT count(*) FROM tai_chinh.bien_dong_tien_thuc WHERE trang_thai_ghi_so='da_ghi_so'"
                ).fetchone()[0],
                1,
            )
        with psycopg.connect(make_conninfo(**app_args)) as c:
            c.execute("SELECT set_config('erp.bo',%s,true)", (str(W),))
            c.execute("SELECT set_config('erp.tai_khoan',%s,true)", (str(user("kinhdoanh")["id"]),))
            self.assertEqual(c.execute("SELECT count(*) FROM dung_chung.doi_tac").fetchone()[0], 0)
        self.assertRaises(
            ValueError,
            restore,
            ROOT / ".runtime/test-backup",
            os.environ["ERP_ADMIN_DATABASE_URL"],
            os.environ["ERP_ADMIN_DATABASE_URL"],
            ROOT / ".runtime/unsafe-media",
        )

    def test_11_excel_preview_confirm_and_repeat(self):
        from foundation.imports import preview

        self.assertRaises(
            ValueError, preview, "invalid.xlsx", b"not-an-excel-file", REGISTRY["doi-tac"], {}
        )
        from openpyxl import Workbook

        spec = REGISTRY["doi-tac"]
        book = Workbook()
        book.active.append([FIELDS[spec["table"]][f]["nhan_tieng_viet"] for f in spec["fields"]])
        book.active.append(["EXCEL-NEW", "Đối tác Excel", "khach_hang", "dai_ly", "true"])
        out = io.BytesIO()
        book.save(out)
        c = client()
        r = c.post(
            "/danh-muc/doi-tac/nhap-excel/",
            {
                "file": SimpleUploadedFile("danh-muc.xlsx", out.getvalue()),
                "source": "Danh mục giả lập do người dùng khai báo",
            },
        )
        self.assertEqual(r.status_code, 200)
        import re, html

        token = html.unescape(
            re.search(r"name='preview_token' value='([^']+)'", r.content.decode()).group(1)
        )
        self.assertEqual(
            c.post("/danh-muc/doi-tac/nhap-excel/", {"preview_token": token}).status_code, 302
        )
        self.assertEqual(
            c.post("/danh-muc/doi-tac/nhap-excel/", {"preview_token": token}).status_code, 302
        )
        with db.tx(admin=True) as conn:
            self.assertEqual(
                conn.execute(
                    "SELECT count(*) n FROM dung_chung.doi_tac WHERE ma_nghiep_vu='EXCEL-NEW'"
                ).fetchone()["n"],
                1,
            )

    def test_12_private_source_and_file_guards(self):
        ceo = user("giamdoc")
        with db.tx(ceo["id"], W) as conn:
            h = conn.execute(
                "SELECT ma_dinh_danh FROM dung_chung.chung_tu WHERE ma_nghiep_vu='HS-E010'"
            ).fetchone()["ma_dinh_danh"]
            f = services.attach(
                conn, W, ceo, h, SimpleUploadedFile("ho-so.txt", b"Ho so gia lap rieng tu.")
            )
        self.assertEqual(client("kho").get(f"/tep/{f}/").status_code, 403)
        self.assertEqual(client("kho").get(f"/chung-tu/{h}/").status_code, 403)
        self.assertEqual(client().get(f"/tep/{f}/").status_code, 200)
        with self.assertRaises(ValueError):
            with db.tx(ceo["id"], W) as conn:
                services.attach(
                    conn, W, ceo, h, SimpleUploadedFile("evil.pdf", b"<script>bad</script>")
                )

    def test_13_calendar_no_overlap_and_variant_unit(self):
        u = user("giamdoc")
        with db.tx(u["id"], W) as conn:
            resource = conn.execute(
                "SELECT ma_dinh_danh FROM san_xuat.nguon_luc_san_xuat LIMIT 1"
            ).fetchone()["ma_dinh_danh"]
            begin = db.now() + timedelta(days=1)
            data = {
                "doi_tuong_lich": "nguon_luc",
                "ma_nguon_luc": resource,
                "thoi_diem_bat_dau_khoang": begin,
                "thoi_diem_ket_thuc_khoang": begin + timedelta(hours=1),
                "muc_dich": "lam_viec",
            }
            services.save_catalog(conn, W, u, REGISTRY["lich"], data)
        with self.assertRaises(ValueError):
            with db.tx(u["id"], W) as conn:
                services.save_catalog(conn, W, u, REGISTRY["lich"], data)
        with self.assertRaises(ValueError):
            with db.tx(u["id"], W) as conn:
                parent = conn.execute(
                    "SELECT ma_dinh_danh FROM danh_muc.mat_hang WHERE ma_nghiep_vu='NGOI'"
                ).fetchone()["ma_dinh_danh"]
                kg = conn.execute(
                    "SELECT ma_dinh_danh FROM dung_chung.don_vi_tinh WHERE ma_nghiep_vu='KG'"
                ).fetchone()["ma_dinh_danh"]
                services.save_catalog(
                    conn,
                    W,
                    u,
                    REGISTRY["san-pham"],
                    {
                        "ma_nghiep_vu": "WRONG-UNIT",
                        "ten": "Sai đơn vị",
                        "loai_mat_hang": "bien_the",
                        "nhom_san_pham": "ngoi",
                        "ma_nhom_mau": parent,
                        "ma_don_vi_co_so": kg,
                    },
                )

    def test_14_delegation_expiry_and_authority(self):
        ceo = user("giamdoc")
        target = user("quantri")
        with db.tx(ceo["id"], W) as c:
            receiver = c.execute(
                "SELECT ma_dinh_danh FROM nhan_su.nhan_vien WHERE ma_nguoi_that=%s",
                (target["ma_nguoi_that"],),
            ).fetchone()["ma_dinh_danh"]
        cli = client()
        r = cli.post(
            "/truy-cap/uy-quyen/",
            {
                "code": "UY-QUYEN-TEST",
                "receiver": str(receiver),
                "target": "dung_chung.doi_tac|xem",
                "until": (db.now() + timedelta(days=1)).isoformat(),
                "reason": "Ủy quyền xem danh mục giả lập có hạn",
                "request_key": "delegate-test",
            },
        )
        self.assertEqual(r.status_code, 302)
        h = r.url.split("/")[-2]
        with db.tx(ceo["id"], W) as c:
            services.document_action(c, W, ceo, h, "trinh", 1)
            services.document_action(c, W, ceo, h, "duyet", 2, "Chấp thuận công việc nền có hạn")
        self.assertEqual(
            cli.post(f"/truy-cap/{h}/ap-dung/", {"request_key": "apply-delegate"}).status_code, 302
        )
        with db.tx(target["id"], W) as c:
            self.assertTrue(db.allowed(c, W, "dung_chung.doi_tac", "xem"))
            self.assertFalse(db.allowed(c, W, "dung_chung.doi_tac", "tao"))
        with db.tx(admin=True) as c:
            c.execute(
                "UPDATE truy_cap.uy_quyen SET thoi_diem_ket_thuc_hieu_luc=now()-interval '1 second' WHERE ma_phien_ban_chung_tu=%s",
                (h,),
            )
        with db.tx(target["id"], W) as c:
            self.assertFalse(db.allowed(c, W, "dung_chung.doi_tac", "xem"))

    def test_15_cross_tab_workspace_binding(self):
        cli = client()
        self.assertEqual(
            cli.post(
                "/danh-muc/doi-tac/them/",
                {
                    "form_workspace": str(db.uid()),
                    "ma_nghiep_vu": "WRONG-WORKSPACE",
                    "ten": "Sai bộ",
                    "cac_vai_tro": "khach_hang",
                    "request_key": "wrong-workspace",
                },
            ).status_code,
            409,
        )
        with db.tx(admin=True) as c:
            self.assertIsNone(
                c.execute(
                    "SELECT 1 FROM dung_chung.doi_tac WHERE ma_nghiep_vu='WRONG-WORKSPACE'"
                ).fetchone()
            )

    def test_16_expired_grant_decision(self):
        ceo = user("giamdoc")
        target = user("quantri")
        with db.tx(ceo["id"], W) as c:
            role = c.execute(
                "SELECT ma_dinh_danh FROM truy_cap.vai_tro_cong_viec WHERE ma_nghiep_vu='D01-kinhdoanh'"
            ).fetchone()["ma_dinh_danh"]
            h = services.create_document(
                c,
                W,
                ceo,
                "CAP-HET-HAN",
                "quyet_dinh_cap_quyen",
                "Đề nghị đã hết hạn kiểm",
                f"cap:{target['id']}:{role}",
            )["cac_ma_chung_tu"][0]
            db.update(
                c, services.HEAD, h, {"thoi_diem_moc_doi_chieu": db.now() - timedelta(minutes=1)}
            )
            services.document_action(c, W, ceo, h, "trinh", 1)
            services.document_action(c, W, ceo, h, "duyet", 2, "Kiểm quyết định đã hết hạn")
        self.assertEqual(
            client().post(f"/truy-cap/{h}/ap-dung/", {"request_key": "expired-grant"}).status_code,
            409,
        )

    def test_17_same_person_with_second_account(self):
        ceo = user("giamdoc")
        admin = user("quantri")
        with db.tx(admin["id"], W) as c:
            alias = services.create_account(
                c,
                W,
                admin,
                ceo["ma_nguoi_that"],
                "ceo.alias",
                __import__("secrets").token_urlsafe(20),
            )["cac_ma_su_kien"][0]
        with db.tx(ceo["id"], W) as c:
            role = c.execute(
                "SELECT ma_dinh_danh FROM truy_cap.vai_tro_cong_viec WHERE ma_nghiep_vu='D01-giamdoc'"
            ).fetchone()["ma_dinh_danh"]
            h = services.create_document(
                c,
                W,
                ceo,
                "CAP-ALIAS-SELF",
                "quyet_dinh_cap_quyen",
                "Kiểm tự duyệt bằng tài khoản khác",
                f"cap:{alias}:{role}",
            )["cac_ma_chung_tu"][0]
            services.document_action(c, W, ceo, h, "trinh", 1)
        with self.assertRaises(ValueError):
            with db.tx(ceo["id"], W) as c:
                services.document_action(c, W, ceo, h, "duyet", 2, "Không cho tự duyệt")
