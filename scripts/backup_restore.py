"""Offline foundation recovery drill; target is a separate test database, never live."""

import os, json, hashlib, subprocess, shutil
from pathlib import Path
import psycopg
from psycopg import sql
from psycopg.conninfo import conninfo_to_dict
from psycopg.rows import dict_row

ROOT = Path(__file__).resolve().parents[1]


def binary(name):
    if shutil.which(name):
        return shutil.which(name)
    import pgserver

    matches = list(Path(pgserver.__file__).parent.rglob(name))
    if not matches:
        raise RuntimeError("Thiếu công cụ PostgreSQL: " + name)
    return str(matches[0])


def command(name, uri, args):
    config = conninfo_to_dict(uri)
    env = dict(os.environ)
    for key, var in [
        ("host", "PGHOST"),
        ("port", "PGPORT"),
        ("dbname", "PGDATABASE"),
        ("user", "PGUSER"),
        ("password", "PGPASSWORD"),
    ]:
        if key in config:
            env[var] = config[key]
    r = subprocess.run(
        [binary(name), *args], env=env, stdout=subprocess.PIPE, stderr=subprocess.PIPE
    )
    if r.returncode:
        raise RuntimeError(f"{name} không hoàn thành (chi tiết chỉ lưu nội bộ).")


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def backup(uri, directory, media):
    directory = Path(directory)
    directory.mkdir(parents=True, exist_ok=False)
    directory.chmod(0o700)
    command(
        "pg_dump", uri, ["-Fc", "--no-owner", "--no-acl", "-f", str(directory / "du_lieu.dump")]
    )
    (
        shutil.copytree(media, directory / "tep", dirs_exist_ok=True)
        if Path(media).exists()
        else (directory / "tep").mkdir()
    )
    manifest = {
        "phien_ban": "D01",
        "co_so_du_lieu": sha(directory / "du_lieu.dump"),
        "tep": {
            str(p.relative_to(directory / "tep")): sha(p)
            for p in (directory / "tep").rglob("*")
            if p.is_file()
        },
    }
    with psycopg.connect(uri) as c:
        manifest["migration"] = [
            list(x)
            for x in c.execute(
                "SELECT ma_phien_ban,ma_kiem_toan_ven FROM nen_tang.phien_ban_cau_truc ORDER BY ma_phien_ban"
            )
        ]
    (directory / "ban_ke.json").write_text(json.dumps(manifest, ensure_ascii=False, indent=2))
    return manifest


IAM = ["dinh_danh_nguoi", "vai_tro_cong_viec", "quyen_thao_tac", "tai_khoan_dang_nhap"]


def restore(directory, target, current, media_target):
    directory = Path(directory)
    manifest = json.loads((directory / "ban_ke.json").read_text())
    source_cfg = conninfo_to_dict(current)
    dest_cfg = conninfo_to_dict(target)
    if dest_cfg.get("dbname") != "mini_erp_restore" or (
        source_cfg.get("dbname"),
        source_cfg.get("host"),
        source_cfg.get("port"),
    ) == (dest_cfg.get("dbname"), dest_cfg.get("host"), dest_cfg.get("port")):
        raise ValueError("Chỉ khôi phục môi trường kiểm mini_erp_restore riêng biệt.")
    if sha(directory / "du_lieu.dump") != manifest["co_so_du_lieu"]:
        raise ValueError("Backup DB không toàn vẹn.")
    for path, digest in manifest["tep"].items():
        p = directory / "tep" / path
        if not p.resolve().is_relative_to((directory / "tep").resolve()) or sha(p) != digest:
            raise ValueError("Backup tệp không toàn vẹn.")
    command(
        "pg_restore",
        target,
        [
            "--clean",
            "--if-exists",
            "--no-owner",
            "--no-acl",
            "--exit-on-error",
            "-d",
            dest_cfg["dbname"],
            str(directory / "du_lieu.dump"),
        ],
    )
    # Reconcile CURRENT identities/permissions. Never log in with sessions from backup.
    with psycopg.connect(current, row_factory=dict_row) as live, psycopg.connect(
        target, row_factory=dict_row
    ) as dest:
        live.execute("SELECT ma_dinh_danh FROM truy_cap.tai_khoan_dang_nhap FOR SHARE")
        current_ids = set()
        for table in IAM:
            for row in live.execute(
                sql.SQL("SELECT * FROM truy_cap.{}").format(sql.Identifier(table))
            ):
                if table == "tai_khoan_dang_nhap":
                    current_ids.add(row["ma_dinh_danh"])
                cols = list(row)
                updates = [k for k in cols if k != "ma_dinh_danh"]
                dest.execute(
                    sql.SQL(
                        "INSERT INTO truy_cap.{} ({}) VALUES ({}) ON CONFLICT(ma_dinh_danh) DO UPDATE SET {}"
                    ).format(
                        sql.Identifier(table),
                        sql.SQL(",").join(map(sql.Identifier, cols)),
                        sql.SQL(",").join(sql.Placeholder() for _ in cols),
                        sql.SQL(",").join(
                            sql.SQL("{}=EXCLUDED.{}").format(sql.Identifier(k), sql.Identifier(k))
                            for k in updates
                        ),
                    ),
                    list(row.values()),
                )
        # Removed roles/actions cannot survive in the snapshot.
        perms = [
            r["ma_dinh_danh"]
            for r in live.execute("SELECT ma_dinh_danh FROM truy_cap.quyen_thao_tac")
        ]
        dest.execute(
            "DELETE FROM truy_cap.quyen_thao_tac WHERE NOT(ma_dinh_danh=ANY(%s::uuid[]))", (perms,)
        )
        dest.execute(
            "UPDATE truy_cap.tai_khoan_dang_nhap SET trang_thai_xu_ly='ngung_su_dung' WHERE NOT(ma_dinh_danh=ANY(%s::uuid[]))",
            (list(current_ids),),
        )
        grants = {r["ma_dinh_danh"]: r for r in live.execute("SELECT * FROM truy_cap.cap_vai_tro")}
        for old in dest.execute("SELECT * FROM truy_cap.cap_vai_tro").fetchall():
            cur = grants.get(old["ma_dinh_danh"])
            dest.execute(
                "UPDATE truy_cap.cap_vai_tro SET thoi_diem_thu_hoi_quyen=%s,thoi_diem_ket_thuc_hieu_luc=%s WHERE ma_dinh_danh=%s",
                (
                    (
                        cur["thoi_diem_thu_hoi_quyen"]
                        if cur
                        else __import__("datetime").datetime.now(
                            __import__("datetime").timezone.utc
                        )
                    ),
                    (
                        cur["thoi_diem_ket_thuc_hieu_luc"]
                        if cur
                        else old["thoi_diem_ket_thuc_hieu_luc"]
                    ),
                    old["ma_dinh_danh"],
                ),
            )
        delegations = {
            r["ma_dinh_danh"]: r for r in live.execute("SELECT * FROM truy_cap.uy_quyen")
        }
        for old in dest.execute("SELECT * FROM truy_cap.uy_quyen").fetchall():
            cur = delegations.get(old["ma_dinh_danh"])
            dest.execute(
                "UPDATE truy_cap.uy_quyen SET thoi_diem_thu_hoi_quyen=%s,thoi_diem_ket_thuc_hieu_luc=%s WHERE ma_dinh_danh=%s",
                (
                    (
                        cur["thoi_diem_thu_hoi_quyen"]
                        if cur
                        else __import__("datetime").datetime.now(
                            __import__("datetime").timezone.utc
                        )
                    ),
                    (
                        cur["thoi_diem_ket_thuc_hieu_luc"]
                        if cur
                        else old["thoi_diem_ket_thuc_hieu_luc"]
                    ),
                    old["ma_dinh_danh"],
                ),
            )
        dest.execute("UPDATE truy_cap.phien_dang_nhap SET thoi_diem_thu_hoi_quyen=now()")
        # Preview/draft snapshot can be stale: remove transient drafts before reopening.
        dest.execute("DELETE FROM nen_tang.ban_nhap_bieu_mau")
    from scripts.install_db import migrate, grant_runtime

    migrate(target)
    with psycopg.connect(target) as c:
        grant_runtime(c)
    media_target = Path(media_target)
    if media_target.exists():
        shutil.rmtree(media_target)
    shutil.copytree(directory / "tep", media_target)
    return {
        "tep_da_kiem": len(manifest["tep"]),
        "quyen": "Quyền hiện hành; cấp mới sau backup không tự khôi phục khi thiếu nguồn quyết định.",
    }
