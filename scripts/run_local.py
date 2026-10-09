import json, os, sys
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
env = json.loads((ROOT / ".runtime/environment.json").read_text())
os.environ.update(env)
# Web commands never receive migration/backup owner credentials.
os.environ.pop("ERP_ADMIN_DATABASE_URL", None)
os.environ.pop("APP_DB_PASSWORD", None)
os.execv(
    str(ROOT / ".venv/bin/python"),
    [str(ROOT / ".venv/bin/python"), str(ROOT / "manage.py"), *sys.argv[1:]],
)
