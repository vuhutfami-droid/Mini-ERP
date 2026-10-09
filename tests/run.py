"""Isolated real PostgreSQL runner, refuses any live database reset."""

import os, sys, json, unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from psycopg.conninfo import conninfo_to_dict, make_conninfo
from psycopg import sql
import psycopg

env = json.loads((ROOT / ".runtime/environment.json").read_text())
owner = conninfo_to_dict(env["ERP_ADMIN_DATABASE_URL"])
app = conninfo_to_dict(env["ERP_DATABASE_URL"])
owner["dbname"] = app["dbname"] = "mini_erp_test"
os.environ.update(env)
os.environ["ERP_ADMIN_DATABASE_URL"] = make_conninfo(**owner)
os.environ["ERP_DATABASE_URL"] = make_conninfo(**app)
os.environ["ERP_MEDIA_ROOT"] = str(ROOT / ".runtime/test-media")
os.environ["DJANGO_SETTINGS_MODULE"] = "erp.settings"
with psycopg.connect(os.environ["ERP_ADMIN_DATABASE_URL"]) as c:
    schemas = c.execute(
        "SELECT schema_name FROM information_schema.schemata WHERE schema_name NOT LIKE 'pg_%' AND schema_name NOT IN ('information_schema','public')"
    ).fetchall()
    for (schema,) in schemas:
        c.execute(sql.SQL("DROP SCHEMA {} CASCADE").format(sql.Identifier(schema)))
from scripts.install_db import migrate, grant_runtime

migrate()
with psycopg.connect(os.environ["ERP_ADMIN_DATABASE_URL"]) as c:
    grant_runtime(c)

import django

django.setup()
from foundation.bootstrap import bootstrap

bootstrap("NASAKI-TEST", ROOT / ".runtime/test-credentials.json")
result = unittest.TextTestRunner(verbosity=2).run(
    unittest.defaultTestLoader.discover(str(ROOT / "tests"), pattern="test_*.py")
)
sys.exit(not result.wasSuccessful())
