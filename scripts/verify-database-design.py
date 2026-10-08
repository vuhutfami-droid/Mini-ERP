#!/usr/bin/env python3
"""Verify the B29 design files; does not create or connect to a database."""
import csv
import hashlib
import io
import json
import re
import subprocess
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
DB = ROOT / 'docs/database'

def read(name):
    with (DB / name).open() as f:
        return list(csv.DictReader(f))

def require(condition, message):
    if not condition:
        raise AssertionError(message)

fields = read('fields.csv')
index = {(f['ten_bang'], f['ten_truong']): f for f in fields}
tables = {f['ten_bang'] for f in fields}
require(len(fields) == len(index) == 931, 'Field count/duplicate')
require(len(tables) == 74, 'Table count')
require(len({t.split('.')[0] for t in tables}) == 11, 'Storage groups')
for f in fields:
    for key in ['ten_bang', 'ten_truong', 'nhan_tieng_viet', 'kieu_du_lieu', 'mo_ta', 'phan_loai_nguon', 'can_cu_phat_sinh', 'nguoi_phu_trach', 'dieu_kien_ghi', 'quy_tac']:
        require(bool(f[key].strip()), f'Missing {key}: {f}')
    for name in [*f['ten_bang'].split('.'), f['ten_truong']]:
        require(bool(re.fullmatch('[a-z][a-z0-9_]*', name)) and len(name.encode()) <= 63, f'Name: {name}')
    if f['lien_ket_bang']:
        require((f['lien_ket_bang'], 'ma_dinh_danh') in index, f'FK destination: {f}')
        require(f['kieu_du_lieu'] == index[(f['lien_ket_bang'], 'ma_dinh_danh')]['kieu_du_lieu'] == 'Mã UUID', f'FK type: {f}')
    if f['kieu_du_lieu'] == 'Phân loại có danh sách đóng':
        require(bool(f['gia_tri_cho_phep']), f'No closed values: {f}')
    require('Danh sách có cấu trúc đóng' != f['kieu_du_lieu'], 'New JSON ledger detected')
rels = read('relationships.csv')
expected = {(f['ten_bang'], f['ten_truong'], f['lien_ket_bang']) for f in fields if f['lien_ket_bang']}
actual = {(r['bang_con'], r['truong_lien_ket'], r['bang_nguon']) for r in rels}
require(actual == expected and len(actual) == len(rels) == 402, 'Relationship mismatch')
require(all(r['truong_nguon'] == 'ma_dinh_danh' for r in rels), 'FK source key')
review = read('optimization-review.csv')
mapping = read('name-mapping.csv')
# Compare to the actual committed B28 source, not the generator's derived copy.
previous = list(csv.DictReader(io.StringIO(subprocess.check_output(['git', 'show', '02632e4:docs/database/fields.csv'], cwd=ROOT, text=True))))
old_fields = {(f['ten_bang'], f['ten_truong']) for f in previous}
require(len(review) == 91 and len({r['bang_truoc_b29'] for r in review}) == 91, '91-table audit missing/duplicate')
require({r['bang_truoc_b29'] for r in review} == {f['ten_bang'] for f in previous}, 'Old-table audit differs from Git')
require(len(mapping) == len(old_fields) == 1139, 'Old-field map count')
require({(m['bang_truoc_b29'], m['truong_truoc_b29']) for m in mapping} == old_fields, 'Incomplete historical map')
for m in mapping:
    require((m['bang_hien_hanh'], m['truong_hien_hanh']) in index, f'Missing mapped field: {m}')
    require(bool(m['cach_chuyen']), f'Missing mapping reason: {m}')
    old = next(f for f in previous if f['ten_bang'] == m['bang_truoc_b29'] and f['ten_truong'] == m['truong_truoc_b29'])
    require(old['kieu_du_lieu'] == index[(m['bang_hien_hanh'], m['truong_hien_hanh'])]['kieu_du_lieu'], 'Historical field type changed')
require({r['bang_hien_hanh'] for r in review} == tables, 'Table outcomes mismatch')
require(sum(r['quyet_dinh'] == 'Gộp' for r in review) == 17, 'Merge count')
inputs = read('input-responsibility.csv')
require(len(inputs) == len(tables) and {r['ten_bang'] for r in inputs} == tables, 'Input responsibility mismatch')
require(len({r['ma_bang'] for r in inputs}) == len(inputs), 'Input IDs')
dictionary = (DB / 'data-dictionary.md').read_text()
require(len(re.findall(r'^### T\d{3} ', dictionary, re.M)) == 74, 'Dictionary headings')
for r in inputs:
    require(f"**Tên bảng:** `{r['ten_bang']}`" in dictionary, f'Dictionary table missing: {r}')
    require(f"| {r['ma_bang']} |" in (DB / 'input-responsibility.md').read_text(), 'Input readable view missing')
for f in fields:
    require(f"| `{f['ten_truong']}` |" in dictionary, 'Dictionary field missing')
structured = [f for f in fields if f['kieu_du_lieu'] == 'Nội dung có cấu trúc đóng']
require(len(structured) == 7, 'Structured field inventory')
for f in structured:
    spec = (DB / 'structured-fields.md').read_text()
    require(f['ten_bang'] in spec and f['ten_truong'] in spec, 'Closed structured field missing specification')
contracts = read('source-contracts.csv')
require(len({(c['bang_con'], c['truong_lien_ket']) for c in contracts}) == len(contracts), 'Duplicate type guard')
for c in contracts:
    key = (c['bang_con'], c['truong_lien_ket'])
    require(key in index and index[key]['lien_ket_bang'] == c['bang_nguon'], f'Type guard FK: {c}')
    if c['truong_phan_loai'] == '@loai_phieu_cha':
        require(c['bang_nguon'] == 'kho.dong_van_dong_hang', 'Indirect type guard target')
        require(index[('kho.dong_van_dong_hang', 'ma_phieu_van_dong_hang')]['lien_ket_bang'] == 'dung_chung.chung_tu', 'Indirect parent link')
        values = index[('dung_chung.chung_tu', 'loai_van_dong_kho')]['gia_tri_cho_phep']
    else:
        target = (c['bang_nguon'], c['truong_phan_loai'])
        require(target in index, f'Type guard field: {c}')
        values = index[target]['gia_tri_cho_phep']
    require(set(c['gia_tri_duoc_phep'].split('|')) <= set(values.split('; ')), f'Type guard values: {c}')
    require(all(c[k] for k in ['dieu_kien', 'duong_dan_kiem_loai', 'cach_cuong_che']), 'Incomplete type guard')
# Critical distinctions that must survive consolidating the schema.
for name in ['tai_chinh.bien_dong_tien_thuc', 'tai_chinh.nghia_vu_va_dieu_chinh', 'tai_chinh.su_kien_su_dung_nguon_tien', 'tai_chinh.nguon_chi_phi', 'tai_chinh.phan_bo_chi_phi', 'tai_chinh.bien_dong_gia_tri', 'kho.lo_hang', 'kho.phan_lo_hang', 'nhan_su.khoang_cong_thuc_te', 'nhan_su.de_nghi_nghi', 'nhan_su.su_kien_phep', 'chat_luong.ket_qua_tung_tieu_chi_kiem_tra', 'nhan_su.khoan_thu_nhap_co_can_cu', 'truy_cap.quyen_thao_tac']:
    require(name in tables, f'Independent source lost: {name}')
for name in ['truy_cap.tai_khoan_dang_nhap', 'truy_cap.vai_tro_cong_viec', 'truy_cap.quyen_thao_tac', 'truy_cap.phien_dang_nhap', 'truy_cap.dinh_danh_nguoi']:
    require((name, 'ma_bo_du_lieu') not in index, 'Global identity incorrectly scoped')
require(index[('kinh_doanh.dong_tu_van_bao_gia_va_don_hang', 'ma_dinh_danh')]['lien_ket_bang'] == 'dung_chung.dong_chung_tu', 'Commercial line shared identity')
trace = list(csv.DictReader((ROOT / 'docs/design/traceability.csv').open()))
coverage = read('coverage.csv')
require({c['ma_yeu_cau'] for c in coverage} == {f'FR{i:02d}' for i in range(1, 34)} and len(coverage) == 33, 'FR scope')
require(len(set(' '.join(c['cac_man_hinh'] for c in coverage).split())) == 22, 'SC scope')
require(set(' '.join(c['cac_tieu_chi'] for c in coverage).split()) == {f'A{i:02d}' for i in range(1, 33)} | {f'X{i:02d}' for i in range(1, 25)}, 'Acceptance scope')
for c in coverage:
    related = [t for t in trace if t['requirement_id'] == c['ma_yeu_cau']]
    require(set(c['cac_man_hinh'].split()) == set(' '.join(t['screen_ids'] for t in related).split()), 'FR-screen trace')
    require(set(c['cac_tieu_chi'].split()) == {t['acceptance_id'] for t in related}, 'FR-acceptance trace')
    require(bool(c['cac_bang_du_lieu']) and set(c['cac_bang_du_lieu'].split()) <= tables, 'Coverage table missing')
policy = json.loads((ROOT / 'docs/demo-data/source-policy.json').read_text())
require(policy['cho_phep_nap_nguyen_bo'] is False and policy['du_lieu_nasaki_that'] is False, 'Source policy weakened')
for f in policy['cac_tep']:
    path = ROOT / 'docs/demo-data' / f['tep']
    require(hashlib.sha256(path.read_bytes()).hexdigest() == f['ma_kiem_toan_ven_sha256'] and f['duoc_nap_truc_tiep'] is False, f'Fixture/source policy changed: {path}')
require(len(read('source-review.csv')) == 481, 'Historical source inventory')
# All local documentation links must resolve; HTTP and fragments do not touch the filesystem.
for file in [ROOT / 'README.md', *ROOT.glob('docs/**/*.md')]:
    for href in re.findall(r'\]\(([^\s)]+)(?:\s+"[^"]*")?\)', file.read_text()):
        if '://' in href or href.startswith('#'):
            continue
        target = href.split('#')[0]
        require((file.parent / target).exists(), f'Broken local link {file}: {href}')
print(f'PASS: {len(tables)} tables, {len(fields)} fields, {len(rels)} FK; 91 old tables/1139 fields mapped; {len(contracts)} type-source guards; 33 FR/22 SC/56 acceptance; 5 fixture hashes; local links. Input groups: {dict(Counter(r["nhom_nhap_lieu"] for r in inputs))}')
print('Design verification only: no SQL, database, app, performance, concurrency or permission execution tested.')
