"""Codex-only development persistence check; never a production operation."""
import sys,json
from pathlib import Path
ROOT=Path(__file__).resolve().parents[1];sys.path.insert(0,str(ROOT))
from scripts.backup_restore import command
import psycopg
env=json.loads((ROOT/'.runtime/environment.json').read_text());uri=env['ERP_ADMIN_DATABASE_URL']
with psycopg.connect(uri) as c:before=c.execute('SELECT count(*) FROM dung_chung.doi_tac').fetchone()[0]
command('pg_ctl',uri,['restart','-D',str(ROOT/'.runtime/postgres'),'-m','fast','-w','-l',str(ROOT/'.runtime/postgres-restart.log')])
with psycopg.connect(uri) as c:after=c.execute('SELECT count(*) FROM dung_chung.doi_tac').fetchone()[0]
assert before==after and after>1
print('PASS PostgreSQL restart: saved partner rows preserved:',after)
