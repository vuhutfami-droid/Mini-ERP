-- Guards for D01; business rules of later domains are added with their releases.
CREATE FUNCTION nen_tang.co_quyen(bo uuid, bang text, viec text) RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER SET search_path=pg_catalog AS $$
 SELECT EXISTS (
 SELECT 1 FROM truy_cap.cap_vai_tro g
 JOIN truy_cap.tai_khoan_dang_nhap a ON a.ma_dinh_danh=g.ma_tai_khoan
 JOIN truy_cap.dinh_danh_nguoi n ON n.ma_dinh_danh=a.ma_nguoi_that
 JOIN truy_cap.quyen_thao_tac q ON q.ma_vai_tro=g.ma_vai_tro
 WHERE g.ma_bo_du_lieu=bo AND a.ma_dinh_danh::text=current_setting('erp.tai_khoan',true)
 AND a.trang_thai_xu_ly='dang_su_dung' AND n.trang_thai_xu_ly='dang_su_dung'
 AND g.thoi_diem_thu_hoi_quyen IS NULL AND g.thoi_diem_bat_dau_hieu_luc<=now()
 AND (g.thoi_diem_ket_thuc_hieu_luc IS NULL OR g.thoi_diem_ket_thuc_hieu_luc>now())
 AND q.loai_doi_tuong_phan_quyen=bang AND q.hanh_dong=viec AND q.pham_vi='doanh_nghiep')
$$;
REVOKE ALL ON FUNCTION nen_tang.co_quyen(uuid,text,text) FROM PUBLIC;
CREATE FUNCTION nen_tang.bao_toan_nguon() RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE o jsonb; n jsonb; k text; old_parent uuid; frozen boolean;
BEGIN
 o=to_jsonb(OLD); n=CASE WHEN TG_OP='DELETE' THEN '{}'::jsonb ELSE to_jsonb(NEW) END;
 IF TG_TABLE_SCHEMA='dung_chung' AND TG_TABLE_NAME='nhat_ky_thao_tac' OR TG_TABLE_SCHEMA='truy_cap' AND TG_TABLE_NAME='bien_nhan_xac_nhan_giao_dich' THEN RAISE EXCEPTION 'Lịch sử/biên nhận chỉ thêm' USING ERRCODE='23514'; END IF;
 frozen = o->>'trang_thai_ghi_so'='da_ghi_so' OR o->>'trang_thai_phe_duyet'='da_duyet' OR o->>'tinh_trang_xac_nhan_ket_luan'='da_xac_nhan';
 FOR k IN SELECT key FROM jsonb_each(o) WHERE key IN ('ma_phieu_van_dong_hang','ma_phien_ban_chung_tu') LOOP
  old_parent=(o->>k)::uuid;
  IF EXISTS(SELECT 1 FROM dung_chung.chung_tu WHERE ma_dinh_danh=old_parent AND (trang_thai_ghi_so='da_ghi_so' OR trang_thai_phe_duyet='da_duyet')) THEN frozen=true; END IF;
 END LOOP;
 IF frozen AND o IS DISTINCT FROM n THEN RAISE EXCEPTION 'Nguồn đã xác nhận không được sửa/xóa đè' USING ERRCODE='23514'; END IF;
 -- Changing a discriminator could invalidate an existing type-constrained child FK.
 FOR k IN SELECT key FROM jsonb_each(o) WHERE key IN ('loai','loai_mat_hang','loai_dong_giao','loai_ban_ghi_nghia_vu','giai_doan_dong','doi_tuong_lich','loai_van_dong_kho') LOOP
  IF TG_OP='UPDATE' AND o->k IS DISTINCT FROM n->k THEN RAISE EXCEPTION 'Đổi loại cần tạo nguồn mới' USING ERRCODE='23514'; END IF;
 END LOOP;
 RETURN CASE WHEN TG_OP='DELETE' THEN OLD ELSE NEW END;
END $$;
CREATE FUNCTION nen_tang.json_dung_khoa(v jsonb, keys text[]) RETURNS boolean LANGUAGE sql IMMUTABLE AS $$
 SELECT jsonb_typeof(v)='object' AND NOT EXISTS(SELECT 1 FROM jsonb_object_keys(CASE WHEN jsonb_typeof(v)='object' THEN v ELSE '{}'::jsonb END) k WHERE NOT k=ANY(keys))
$$;
CREATE FUNCTION nen_tang.kiem_cau_truc(v jsonb, loai text) RETURNS boolean LANGUAGE plpgsql IMMUTABLE AS $$
DECLARE a jsonb; k text; keys text[];
BEGIN
 IF v IS NULL THEN RETURN true; END IF;
 IF loai='quy_cach' THEN RETURN nen_tang.json_dung_khoa(v,ARRAY['ma_mat_hang','mau','chieu_dai_mi_li_met','chieu_rong_mi_li_met','do_day_mi_li_met','ma_mau_khach_duyet','yeu_cau_rieng']); END IF;
 IF loai='lich' THEN
  IF jsonb_typeof(v)<>'array' THEN RETURN false; END IF;
  FOR a IN SELECT value FROM jsonb_array_elements(v) LOOP
   IF NOT nen_tang.json_dung_khoa(a,ARRAY['gio_bat_dau','gio_ket_thuc']) OR NOT (a->>'gio_bat_dau' ~ '^([01][0-9]|2[0-3]):[0-5][0-9]$') OR NOT (a->>'gio_ket_thuc' ~ '^([01][0-9]|2[0-3]):[0-5][0-9]$') OR a->>'gio_bat_dau'>=a->>'gio_ket_thuc' THEN RETURN false; END IF;
  END LOOP; RETURN true;
 END IF;
 IF loai='bien_nhan' THEN
  IF NOT nen_tang.json_dung_khoa(v,ARRAY['cac_ma_chung_tu','cac_ma_dong','cac_ma_su_kien']) THEN RETURN false; END IF;
  FOR k IN SELECT jsonb_object_keys(v) LOOP IF jsonb_typeof(v->k)<>'array' THEN RETURN false; END IF;
   FOR a IN SELECT value FROM jsonb_array_elements(v->k) LOOP IF NOT (a #>> '{}') ~ '^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$' THEN RETURN false; END IF; END LOOP;
  END LOOP; RETURN true;
 END IF;
 IF loai='nhat_ky' THEN
  IF NOT nen_tang.json_dung_khoa(v,ARRAY['cac_truong']) OR jsonb_typeof(v->'cac_truong')<>'array' THEN RETURN false; END IF;
  FOR a IN SELECT value FROM jsonb_array_elements(v->'cac_truong') LOOP IF NOT nen_tang.json_dung_khoa(a,ARRAY['ten_truong','gia_tri_cu_da_luoc','gia_tri_moi_da_luoc']) THEN RETURN false; END IF; END LOOP; RETURN true;
 END IF;
 IF loai='chinh_sach' THEN
  IF NOT nen_tang.json_dung_khoa(v,ARRAY['loai_chinh_sach','cac_tham_so']) OR jsonb_typeof(v->'cac_tham_so')<>'array' THEN RETURN false; END IF;
  keys=CASE v->>'loai_chinh_sach'
   WHEN 'gia_chiet_khau' THEN ARRAY['gia_tham_chieu','ty_le_chiet_khau_de_nghi']
   WHEN 'tu_van_so_vien' THEN ARRAY['so_vien_tren_met_vuong','ty_le_du_phong']
   WHEN 'ton_muc_tieu' THEN ARRAY['nguong_canh_bao','muc_ton_muc_tieu']
   WHEN 'chat_luong' THEN ARRAY['ma_tieu_chi','gioi_han_duoi','gioi_han_tren','phuong_phap_kiem','pham_vi_kiem']
   WHEN 'cong_thu_nhap' THEN ARRAY['phut_chuan','cach_tinh_luong_thoi_gian','cach_tinh_phu_cap','he_so_lam_them']
   WHEN 'phan_bo_chi_phi' THEN ARRAY['can_cu_phan_bo','quy_tac_lam_tron'] END;
  IF keys IS NULL THEN RETURN false; END IF;
  FOR a IN SELECT value FROM jsonb_array_elements(v->'cac_tham_so') LOOP
   IF NOT nen_tang.json_dung_khoa(a,ARRAY['ten_tham_so','kieu_gia_tri','don_vi','gia_tri','can_cu_khai_bao']) OR NOT a->>'ten_tham_so'=ANY(keys) OR nullif(a->>'can_cu_khai_bao','') IS NULL THEN RETURN false; END IF;
  END LOOP; RETURN true;
 END IF;
 IF loai='thu_nhap' THEN
  IF NOT nen_tang.json_dung_khoa(v,ARRAY['phien_ban_phep_tinh','cac_nguon']) OR jsonb_typeof(v->'cac_nguon')<>'array' THEN RETURN false; END IF;
  FOR a IN SELECT value FROM jsonb_array_elements(v->'cac_nguon') LOOP IF NOT nen_tang.json_dung_khoa(a,ARRAY['ma_ban_cong','ma_khoang_cong','ma_phien_ban_chinh_sach','ma_khoan_thu_nhap','so_phut_can_cu','don_gia_can_cu','quy_tac_lam_tron']) THEN RETURN false; END IF; END LOOP; RETURN true;
 END IF;
 RETURN false;
END $$;
ALTER TABLE dung_chung.nhat_ky_thao_tac ADD CHECK (nen_tang.kiem_cau_truc(noi_dung_thay_doi_da_luoc_du_lieu_nhay_cam,'nhat_ky'));
ALTER TABLE dung_chung.phien_ban_chinh_sach ADD CHECK (nen_tang.kiem_cau_truc(tham_so,'chinh_sach'));
ALTER TABLE truy_cap.bien_nhan_xac_nhan_giao_dich ADD CHECK (nen_tang.kiem_cau_truc(cac_ma_ket_qua_da_ghi_nhan,'bien_nhan'));
ALTER TABLE kho.phan_lo_hang ADD CHECK (nen_tang.kiem_cau_truc(quy_cach_ky_thuat_ban_luu_tai_thoi_diem,'quy_cach'));
ALTER TABLE kinh_doanh.dong_tu_van_bao_gia_va_don_hang ADD CHECK (nen_tang.kiem_cau_truc(quy_cach_ky_thuat_ban_luu_tai_thoi_diem,'quy_cach'));
ALTER TABLE nhan_su.ngay_va_ca_lam_viec ADD CHECK (nen_tang.kiem_cau_truc(cac_khoang_lam_viec_trong_ca,'lich'));
ALTER TABLE nhan_su.thu_nhap_nhan_vien ADD CHECK (nen_tang.kiem_cau_truc(phep_tinh_ban_luu_tai_thoi_diem,'thu_nhap'));
