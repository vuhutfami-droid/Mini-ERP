"""Preview-only parsing of human declarations. Never load the historic fixtures."""

import hashlib, json, io, zipfile
from pathlib import Path
from django.core import signing
from openpyxl import load_workbook
from foundation.catalog import ROOT, FIELDS, form_class

POLICY = json.loads((ROOT / "docs/demo-data/source-policy.json").read_text())


def reject_old(name, raw):
    digest = hashlib.sha256(raw).hexdigest()
    if any(
        Path(name).name == x["tep"] or digest == x["ma_kiem_toan_ven_sha256"]
        for x in POLICY["cac_tep"]
    ):
        raise ValueError("Tệp mẫu kiểm cũ không phải nguồn nhập. Cần khai báo nguồn mới có căn cứ.")
    if b"OTHER-001" in raw:
        raise ValueError("OTHER-001 chưa có hồ sơ nguồn, không được nhập.")


def preview(name, raw, spec, choices):
    reject_old(name, raw)
    if not name.lower().endswith(".xlsx") or len(raw) > 5 * 1024 * 1024:
        raise ValueError("Chọn tệp Excel .xlsx tối đa 5 MB.")
    if not zipfile.is_zipfile(io.BytesIO(raw)):
        raise ValueError("Tệp không phải Excel .xlsx hợp lệ; vui lòng dùng mẫu xuất của danh mục.")
    with zipfile.ZipFile(io.BytesIO(raw)) as archive:
        if sum(x.file_size for x in archive.infolist()) > 20 * 1024 * 1024:
            raise ValueError("Tệp giải nén quá lớn.")
    wb = load_workbook(io.BytesIO(raw), read_only=True, data_only=False)
    if len(wb.worksheets) != 1:
        raise ValueError("Mẫu nhập có đúng một trang.")
    rows = iter(wb.active.values)
    header = next(rows, None)
    expected = [FIELDS[spec["table"]][n]["nhan_tieng_viet"] for n in spec["fields"]]
    if list(header or []) != expected:
        raise ValueError("Cột không đúng mẫu. Tải Excel danh mục để dùng tiêu đề chuẩn.")
    result = []
    Form = form_class(spec, choices)
    for index, row in enumerate(rows, 2):
        if index > 502:
            raise ValueError("Mỗi lần nhập tối đa 500 dòng để đối chiếu.")
        if not any(x is not None for x in row):
            continue
        data = {n: ("" if v is None else str(v)) for n, v in zip(spec["fields"], row)}
        if any(v.startswith(("=", "+", "@")) for v in data.values()):
            raise ValueError(f"Dòng {index}: không nhận công thức hoặc tham chiếu ngoài.")
        if data.get("ma_nghiep_vu") == "OTHER-001":
            raise ValueError("OTHER-001 thiếu hồ sơ nguồn.")
        for n in data:
            if FIELDS[spec["table"]][n]["kieu_du_lieu"] == "Có/không":
                data[n] = data[n].lower() in ("true", "có", "1")
        f = Form(data)
        if not f.is_valid():
            raise ValueError(f"Dòng {index}: " + "; ".join(str(x) for x in f.errors.values()))
        result.append(data)
    if not result:
        raise ValueError("Tệp không có dòng dữ liệu.")
    return result
