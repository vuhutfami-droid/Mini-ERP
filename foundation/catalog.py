"""Explicit D01 forms, not an arbitrary table editor."""

import csv, json
from pathlib import Path
from decimal import Decimal, InvalidOperation
from datetime import date, datetime
import uuid
from django import forms
from foundation.labels import label

ROOT = Path(__file__).resolve().parents[1]
FIELDS = {}
for r in csv.DictReader((ROOT / "docs/database/fields.csv").open()):
    FIELDS.setdefault(r["ten_bang"], {})[r["ten_truong"]] = r
# slug, title, table, user-editable fields, required fields
SPECS = [
    (
        "san-pham",
        "Sản phẩm và vật tư",
        "danh_muc.mat_hang",
        "ma_nghiep_vu ten loai_mat_hang nhom_san_pham loai ma_mau ma_quy_cach chieu_rong_mi_li_met chieu_dai_mi_li_met so_vien_tren_met_vuong_theo_quy_cach ma_nhom_mau ma_don_vi_co_so ma_phien_ban_quy_cach dang_su_dung bat_buoc_duyet_mau_rieng",
        "ma_nghiep_vu ten loai_mat_hang",
    ),
    (
        "doi-tac",
        "Đối tác",
        "dung_chung.doi_tac",
        "ma_nghiep_vu ten cac_vai_tro nhom_khach_hang dang_su_dung",
        "ma_nghiep_vu ten cac_vai_tro",
    ),
    (
        "lien-he",
        "Liên hệ đối tác",
        "dung_chung.lien_he_doi_tac",
        "ten kenh_lien_he dia_chi ma_doi_tac dang_su_dung",
        "ten ma_doi_tac",
    ),
    (
        "don-vi",
        "Đơn vị tính",
        "dung_chung.don_vi_tinh",
        "ma_nghiep_vu dai_luong so_chu_so_thap_phan_duoc_phep",
        "ma_nghiep_vu dai_luong so_chu_so_thap_phan_duoc_phep",
    ),
    (
        "bo-phan",
        "Bộ phận",
        "dung_chung.bo_phan",
        "ma_nghiep_vu ten ma_doanh_nghiep dang_su_dung",
        "ma_nghiep_vu ten ma_doanh_nghiep",
    ),
    (
        "vi-tri",
        "Vị trí giữ hàng",
        "dung_chung.vi_tri_giu_hang",
        "ma_nghiep_vu loai ma_kho_vat_ly ma_doanh_nghiep dang_su_dung",
        "ma_nghiep_vu loai ma_doanh_nghiep",
    ),
    (
        "ma-goi-khac",
        "Mã gọi khác",
        "danh_muc.ma_goi_khac",
        "ma_goi_khac ma_mat_hang chung_cu thoi_diem_bat_dau_hieu_luc",
        "ma_goi_khac ma_mat_hang chung_cu",
    ),
    (
        "quy-doi",
        "Quy đổi đơn vị",
        "danh_muc.quy_doi_don_vi",
        "ma_mat_hang ma_don_vi_quy_doi_nguon ma_don_vi_quy_doi_dich he_so so_phien_ban thoi_diem_bat_dau_hieu_luc thoi_diem_ket_thuc_hieu_luc",
        "ma_mat_hang ma_don_vi_quy_doi_nguon ma_don_vi_quy_doi_dich he_so so_phien_ban thoi_diem_bat_dau_hieu_luc",
    ),
    (
        "nhan-su",
        "Hồ sơ nhân sự cơ bản",
        "nhan_su.nhan_vien",
        "ma_nghiep_vu ten ngay_vao_lam ngay_nghi_viec ma_nguoi_that",
        "ma_nghiep_vu ten ma_nguoi_that",
    ),
    (
        "ho-so-lam-viec",
        "Hồ sơ làm việc theo hiệu lực",
        "nhan_su.ho_so_lam_viec_theo_hieu_luc",
        "ma_nhan_vien ma_bo_phan ma_nhan_vien_quan_ly thoi_diem_bat_dau_hieu_luc thoi_diem_ket_thuc_hieu_luc vi_tri_cong_viec loai_ho_so_hop_dong tinh_trang_lam_viec",
        "ma_nhan_vien ma_bo_phan thoi_diem_bat_dau_hieu_luc tinh_trang_lam_viec",
    ),
    (
        "ky-nang",
        "Kỹ năng và an toàn",
        "nhan_su.ho_so_ky_nang_va_an_toan",
        "loai ma_nghiep_vu ma_nhan_vien thoi_diem_bat_dau_hieu_luc thoi_diem_ket_thuc_hieu_luc ghi_chu_anh_huong_cong_viec",
        "loai ma_nghiep_vu ma_nhan_vien",
    ),
    (
        "ca-lam",
        "Ngày và ca dự kiến",
        "nhan_su.ngay_va_ca_lam_viec",
        "ngay_lam_viec loai_ngay_theo_lich ma_ca cac_khoang_lam_viec_trong_ca ma_phien_ban_chinh_sach",
        "ngay_lam_viec loai_ngay_theo_lich ma_ca cac_khoang_lam_viec_trong_ca",
    ),
    (
        "nguon-luc",
        "Nguồn lực xưởng",
        "san_xuat.nguon_luc_san_xuat",
        "ma_nghiep_vu loai ma_vi_tri suc_chua_theo_luong nang_luc_thoi_gian_tinh_theo_phut ky_nang_bat_buoc ma_phien_ban_chinh_sach",
        "ma_nghiep_vu loai",
    ),
    (
        "lich",
        "Phân công dự kiến",
        "san_xuat.lich_nguoi_va_nguon_luc",
        "doi_tuong_lich ma_nguon_luc ma_nhan_vien ma_ngay_va_ca_lam_viec thoi_diem_bat_dau_khoang thoi_diem_ket_thuc_khoang muc_dich so_luong_chiem_cho ma_phien_ban_chung_tu",
        "doi_tuong_lich thoi_diem_bat_dau_khoang thoi_diem_ket_thuc_khoang muc_dich",
    ),
    (
        "quy",
        "Quỹ và tài khoản tiền",
        "tai_chinh.quy_va_tai_khoan_tien",
        "ma_nghiep_vu loai tien_te dang_su_dung",
        "ma_nghiep_vu loai tien_te",
    ),
    (
        "chinh-sach",
        "Chính sách có căn cứ",
        "dung_chung.phien_ban_chinh_sach",
        "ma_nghiep_vu loai so_phien_ban thoi_diem_bat_dau_hieu_luc thoi_diem_ket_thuc_hieu_luc tham_so ma_chung_tu_can_cu_khai_bao ma_nguoi_khai_bao_du_lieu",
        "ma_nghiep_vu loai so_phien_ban tham_so ma_chung_tu_can_cu_khai_bao ma_nguoi_khai_bao_du_lieu",
    ),
    (
        "dai-dien",
        "Căn cứ đại diện đối tác",
        "dung_chung.can_cu_dai_dien",
        "hanh_dong ma_doi_tac ma_lien_he ma_doi_tac_dai_dien ma_chung_tu_lam_can_cu ma_chung_tu_xac_dinh_pham_vi thoi_diem_bat_dau_hieu_luc thoi_diem_ket_thuc_hieu_luc",
        "hanh_dong ma_doi_tac ma_lien_he ma_chung_tu_lam_can_cu",
    ),
]
# Validate form declarations against the source, fail early on typos.
REGISTRY = {}
for slug, title, table, fields, required in SPECS:
    actual = FIELDS[table]
    fields = fields.split()
    assert set(fields) <= set(actual), (slug, set(fields) - set(actual))
    REGISTRY[slug] = {
        "slug": slug,
        "title": title,
        "table": table,
        "fields": fields,
        "required": set(required.split()) & set(fields),
    }


def form_class(spec, choices=None):
    fields = {}
    choices = choices or {}
    for name in spec["fields"]:
        meta = FIELDS[spec["table"]][name]
        kind = meta["kieu_du_lieu"]
        kw = {
            "label": meta["nhan_tieng_viet"],
            "required": name in spec["required"],
            "help_text": meta["mo_ta"],
        }
        if name in choices:
            field = forms.TypedChoiceField(
                choices=[("", "— Chọn —")] + choices[name], coerce=uuid.UUID, empty_value=None, **kw
            )
        elif kind == "Mã UUID":
            field = forms.UUIDField(**kw)
        elif meta["gia_tri_cho_phep"]:
            field = forms.ChoiceField(
                choices=[("", "— Chọn —")]
                + [(s.strip(), label(s.strip())) for s in meta["gia_tri_cho_phep"].split(";")],
                **kw,
            )
        elif kind == "Có/không":
            field = forms.BooleanField(label=kw["label"], required=False, help_text=kw["help_text"])
        elif kind in ("Số nguyên", "Số nguyên nhỏ"):
            field = forms.IntegerField(min_value=0, **kw)
        elif kind.startswith(("Số lượng", "Số tiền", "Số thập phân", "Tỷ lệ")):
            field = forms.DecimalField(
                max_digits=24,
                decimal_places=0 if kind == "Số tiền VND nguyên đồng" else 6,
                min_value=0,
                **kw,
            )
        elif kind == "Ngày địa phương":
            field = forms.DateField(
                widget=forms.DateInput(format="%Y-%m-%d", attrs={"type": "date"}), **kw
            )
        elif kind == "Thời điểm có múi giờ":
            field = forms.DateTimeField(
                widget=forms.DateTimeInput(
                    format="%Y-%m-%dT%H:%M", attrs={"type": "datetime-local"}
                ),
                **kw,
            )
        elif kind == "Nội dung có cấu trúc đóng":
            field = forms.JSONField(widget=forms.Textarea(attrs={"rows": 4}), **kw)
        else:
            field = forms.CharField(max_length=500, **kw)
        fields[name] = field
    return type("SourceForm", (forms.Form,), fields)


# Native controls collect declarations; JSON is a storage contract, never an input format.
_GENERIC_FORM_CLASS = form_class
PARAM_NAMES = [
    ("", "— Không dùng dòng này —"),
    ("ma_tieu_chi", "Mã tiêu chí kiểm"),
    ("phuong_phap_kiem", "Phương pháp kiểm"),
    ("pham_vi_kiem", "Phạm vi kiểm"),
    ("gioi_han_duoi", "Giới hạn dưới"),
    ("gioi_han_tren", "Giới hạn trên"),
    ("gia_tham_chieu", "Giá tham chiếu"),
    ("ty_le_chiet_khau_de_nghi", "Tỷ lệ chiết khấu"),
    ("so_vien_tren_met_vuong", "Số viên trên m²"),
    ("ty_le_du_phong", "Tỷ lệ dự phòng"),
    ("nguong_canh_bao", "Ngưỡng cảnh báo"),
    ("muc_ton_muc_tieu", "Mức tồn mục tiêu"),
    ("phut_chuan", "Số phút chuẩn"),
    ("cach_tinh_luong_thoi_gian", "Cách tính lương thời gian"),
    ("cach_tinh_phu_cap", "Cách tính phụ cấp"),
    ("he_so_lam_them", "Hệ số làm thêm"),
    ("can_cu_phan_bo", "Căn cứ phân bổ"),
    ("quy_tac_lam_tron", "Quy tắc làm tròn"),
]
POLICY_TYPES = {
    "kiem_chat_luong": "chat_luong",
    "xac_dinh_gia": "gia_chiet_khau",
    "san_xuat": "tu_van_so_vien",
    "canh_bao_ton": "ton_muc_tieu",
    "lich_lam": "cong_thu_nhap",
    "thu_nhap": "cong_thu_nhap",
    "nghi": "cong_thu_nhap",
    "dinh_gia": "phan_bo_chi_phi",
}


def form_class(spec, choices=None):
    Base = _GENERIC_FORM_CLASS(spec, choices)
    if spec["slug"] not in ("ca-lam", "chinh-sach"):
        return Base

    class FriendlyForm(Base):
        def __init__(self, *args, **kwargs):
            initial = dict(kwargs.get("initial") or {})
            if spec["slug"] == "ca-lam":
                for i, a in enumerate(initial.get("cac_khoang_lam_viec_trong_ca") or []):
                    initial[f"bat_dau_{i}"] = a["gio_bat_dau"]
                    initial[f"ket_thuc_{i}"] = a["gio_ket_thuc"]
            else:
                for i, a in enumerate((initial.get("tham_so") or {}).get("cac_tham_so", [])):
                    for field, key in [
                        ("tham_so", "ten_tham_so"),
                        ("gia_tri", "gia_tri"),
                        ("don_vi", "don_vi"),
                        ("can_cu", "can_cu_khai_bao"),
                    ]:
                        initial[f"{field}_{i}"] = a[key]
            kwargs["initial"] = initial
            super().__init__(*args, **kwargs)
            if spec["slug"] == "ca-lam":
                self.fields.pop("cac_khoang_lam_viec_trong_ca")
                for i in range(4):
                    for prefix, label in [("bat_dau", "Bắt đầu"), ("ket_thuc", "Kết thúc")]:
                        self.fields[f"{prefix}_{i}"] = forms.TimeField(
                            label=f"{label} khoảng {i+1}",
                            required=i == 0,
                            widget=forms.TimeInput(attrs={"type": "time"}),
                        )
            else:
                self.fields.pop("tham_so")
                self.fields.pop("ma_nguoi_khai_bao_du_lieu", None)
                for i in range(12):
                    self.fields[f"tham_so_{i}"] = forms.ChoiceField(
                        label=f"Tham số {i+1}", choices=PARAM_NAMES, required=False
                    )
                    self.fields[f"gia_tri_{i}"] = forms.CharField(
                        label="Giá trị khai báo", required=False, max_length=200
                    )
                    self.fields[f"don_vi_{i}"] = forms.CharField(
                        label="Đơn vị của giá trị", required=False, max_length=40
                    )
                    self.fields[f"can_cu_{i}"] = forms.CharField(
                        label="Căn cứ của giá trị", required=False, max_length=300
                    )

        def clean(self):
            data = super().clean()
            if spec["slug"] == "ca-lam":
                intervals = []
                for i in range(4):
                    begin = data.pop(f"bat_dau_{i}", None)
                    end = data.pop(f"ket_thuc_{i}", None)
                    if bool(begin) != bool(end):
                        raise forms.ValidationError(
                            "Mỗi khoảng phải có cả giờ bắt đầu và kết thúc."
                        )
                    if begin:
                        if begin >= end:
                            raise forms.ValidationError("Giờ kết thúc phải sau giờ bắt đầu.")
                        intervals.append(
                            {
                                "gio_bat_dau": begin.strftime("%H:%M"),
                                "gio_ket_thuc": end.strftime("%H:%M"),
                            }
                        )
                data["cac_khoang_lam_viec_trong_ca"] = intervals
            else:
                params = []
                for i in range(12):
                    name = data.pop(f"tham_so_{i}", "")
                    value = data.pop(f"gia_tri_{i}", "")
                    unit = data.pop(f"don_vi_{i}", "")
                    source = data.pop(f"can_cu_{i}", "")
                    if not name:
                        if value or unit or source:
                            raise forms.ValidationError("Chọn tên tham số cho dòng đã nhập.")
                        continue
                    if not value or not source:
                        raise forms.ValidationError("Tham số cần giá trị và căn cứ, không tự điền.")
                    params.append(
                        {
                            "ten_tham_so": name,
                            "gia_tri": value,
                            "don_vi": unit,
                            "can_cu_khai_bao": source,
                            "kieu_gia_tri": "van_ban",
                        }
                    )
                if not params:
                    raise forms.ValidationError("Chính sách cần ít nhất một tham số có căn cứ.")
                data["tham_so"] = {
                    "loai_chinh_sach": POLICY_TYPES.get(data.get("loai")),
                    "cac_tham_so": params,
                }
            return data

    return FriendlyForm


def draft_fields(spec):
    return set(form_class(spec)().fields)
