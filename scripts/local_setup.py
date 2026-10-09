"""Codex-only local setup. Real PostgreSQL, isolated data, no Docker/root needed.
Never use this development bootstrap against production or import old fixtures.
"""

import sys, os, secrets, json, uuid
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
import pgserver, psycopg
from psycopg.conninfo import conninfo_to_dict, make_conninfo
from psycopg import sql
from psycopg.rows import dict_row
from django.contrib.auth.hashers import make_password
from scripts.install_db import migrate, grant_runtime

os.environ.setdefault("DJANGO_SETTINGS_MODULE", "erp.settings")
state = ROOT / ".runtime"
state.mkdir(exist_ok=True)
state.chmod(0o700)
secretfile = state / "environment.json"
if secretfile.exists():
    env = json.loads(secretfile.read_text())
else:
    env = {
        "ERP_SECRET_KEY": secrets.token_urlsafe(48),
        "APP_DB_PASSWORD": secrets.token_urlsafe(32),
    }
srv = pgserver.get_server(state / "postgres", cleanup_mode=None)
base = srv.get_uri()
with psycopg.connect(base, autocommit=True) as c:
    for dbname in ["mini_erp", "mini_erp_test", "mini_erp_restore"]:
        if not c.execute("SELECT 1 FROM pg_database WHERE datname=%s", (dbname,)).fetchone():
            c.execute(sql.SQL("CREATE DATABASE {}").format(sql.Identifier(dbname)))
    if not c.execute("SELECT 1 FROM pg_roles WHERE rolname='mini_erp_app'").fetchone():
        c.execute(
            sql.SQL(
                "CREATE ROLE mini_erp_app LOGIN PASSWORD {} NOSUPERUSER NOCREATEDB NOCREATEROLE NOINHERIT NOBYPASSRLS"
            ).format(sql.Literal(env["APP_DB_PASSWORD"]))
        )
args = conninfo_to_dict(base)
args["dbname"] = "mini_erp"
owner = make_conninfo(**args)
app = {**args, "user": "mini_erp_app", "password": env["APP_DB_PASSWORD"]}
env.update(
    ERP_ADMIN_DATABASE_URL=owner,
    ERP_DATABASE_URL=make_conninfo(**app),
    ERP_DEBUG="1",
    ERP_ALLOWED_HOSTS="localhost,127.0.0.1,testserver",
)
secretfile.write_text(json.dumps(env))
secretfile.chmod(0o600)
os.environ.update(env)
migrate(owner)
with psycopg.connect(owner) as c:
    c.execute("GRANT CONNECT ON DATABASE mini_erp TO mini_erp_app")
    grant_runtime(c)
# Bootstrap source/roles are declared simulation + technical setup, not CEO decisions.
from foundation.bootstrap import bootstrap

bootstrap()
print("D01 development DB ready. Private runtime configuration: .runtime/environment.json")
