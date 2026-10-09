import os, json, sys
from pathlib import Path
from psycopg.conninfo import conninfo_to_dict, make_conninfo

ROOT = Path(__file__).resolve().parents[1]
env = json.loads((ROOT / ".runtime/environment.json").read_text())
args = conninfo_to_dict(env["ERP_DATABASE_URL"])
args["dbname"] = "mini_erp_test"
env["ERP_DATABASE_URL"] = make_conninfo(**args)
env.pop("ERP_ADMIN_DATABASE_URL", None)
env.pop("APP_DB_PASSWORD", None)
env["ERP_MEDIA_ROOT"] = str(ROOT / ".runtime/test-media")
os.environ.update(env)
os.execv(
    str(ROOT / ".venv/bin/python"),
    [
        str(ROOT / ".venv/bin/python"),
        str(ROOT / "manage.py"),
        "runserver",
        "127.0.0.1:8001",
        "--noreload",
    ],
)
