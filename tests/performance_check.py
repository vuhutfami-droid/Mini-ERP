"""Synthetic load only in mini_erp_test, never the presentation dataset."""

import os, sys, json, time, statistics, platform, threading
from pathlib import Path
from concurrent.futures import ThreadPoolExecutor

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from psycopg.conninfo import conninfo_to_dict, make_conninfo

env = json.loads((ROOT / ".runtime/environment.json").read_text())
os.environ.update(env)
for k in ("ERP_DATABASE_URL", "ERP_ADMIN_DATABASE_URL"):
    args = conninfo_to_dict(os.environ[k])
    args["dbname"] = "mini_erp_test"
    os.environ[k] = make_conninfo(**args)
os.environ["DJANGO_SETTINGS_MODULE"] = "erp.settings"
import django

django.setup()
from foundation import db
from django.test import Client

creds = json.loads((ROOT / ".runtime/test-credentials.json").read_text())
w = creds["giamdoc"]["ma_bo_du_lieu"]
with db.tx(admin=True) as c:
    kg = c.execute(
        "SELECT ma_dinh_danh FROM dung_chung.don_vi_tinh WHERE ma_bo_du_lieu=%s AND ma_nghiep_vu='KG'",
        (w,),
    ).fetchone()["ma_dinh_danh"]
    for table, target in [("danh_muc.mat_hang", 100), ("dung_chung.doi_tac", 1000)]:
        from psycopg import sql

        n = c.execute(
            sql.SQL("SELECT count(*) n FROM {} WHERE ma_bo_du_lieu=%s").format(
                sql.Identifier(*table.split("."))
            ),
            (w,),
        ).fetchone()["n"]
        for i in range(n, target):
            data = {
                "ma_dinh_danh": db.uid(),
                "ma_bo_du_lieu": w,
                "ma_nghiep_vu": f"TAI-GIA-LAP-{i:04}",
                "ten": f"Hồ sơ tải giả lập {i:04}",
            }
            data.update(
                {"loai_mat_hang": "vat_tu", "loai": "vat_tu", "ma_don_vi_co_so": kg}
                if table == "danh_muc.mat_hang"
                else {"cac_vai_tro": "khach_hang"}
            )
            db.insert(c, table, data)
    db.audit(
        c,
        w,
        None,
        "du_lieu_kiem_tai",
        reason="Chỉ trong mini_erp_test: 50 người, 100 mặt hàng, 1000 đối tác. Không nguồn doanh nghiệp.",
    )
results = []
for count in (5, 10):
    clients = []
    for i in range(count):
        role = ["giamdoc", "kho", "sanxuat", "taichinh", "quantri"][i % 5]
        cli = Client()
        r = cli.post("/dang-nhap/", {"username": role, "password": creds[role]["mat_khau"]})
        assert r.status_code == 302
        clients.append((role, cli))
    barrier = threading.Barrier(count)

    def run(pair):
        role, cli = pair
        barrier.wait()
        samples = []
        for _ in range(10):
            start = time.perf_counter()
            r = cli.get("/" if role == "quantri" else "/danh-muc/doi-tac/")
            assert r.status_code == 200
            samples.append((time.perf_counter() - start) * 1000)
        return samples

    with ThreadPoolExecutor(count) as pool:
        samples = sum(list(pool.map(run, clients)), [])
    p95 = sorted(samples)[int(len(samples) * 0.95) - 1]
    results.append(
        {
            "phien_dong_thoi": count,
            "so_mau": len(samples),
            "p50_ms": round(statistics.median(samples), 2),
            "p95_ms": round(p95, 2),
            "max_ms": round(max(samples), 2),
            "dat_muc_tieu_server_2s": p95 < 2000,
        }
    )
report = {
    "pham_vi": "Django request + template + PostgreSQL; chưa gồm độ trễ Internet hoặc trình duyệt",
    "du_lieu": {"nhan_su": 50, "mat_hang": 100, "doi_tac": 1000, "dong_moi_trang": 50},
    "may": {
        "cpu_logic": os.cpu_count(),
        "nen_tang": platform.system(),
        "python": platform.python_version(),
    },
    "ket_qua": results,
}
(ROOT / "docs/implementation/performance.json").write_text(
    json.dumps(report, ensure_ascii=False, indent=2) + "\n"
)
print(json.dumps(report, ensure_ascii=False))
assert all(x["dat_muc_tieu_server_2s"] for x in results)
