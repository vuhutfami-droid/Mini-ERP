-- Only reveal the employee attached to the trusted actor and current workspace.
CREATE FUNCTION nen_tang.nhan_vien_hien_tai() RETURNS uuid
LANGUAGE sql STABLE SECURITY DEFINER SET search_path=pg_catalog AS $$
 SELECT e.ma_dinh_danh FROM nhan_su.nhan_vien e
 JOIN truy_cap.tai_khoan_dang_nhap a ON a.ma_nguoi_that=e.ma_nguoi_that
 WHERE a.ma_dinh_danh::text=current_setting('erp.tai_khoan',true)
 AND e.ma_bo_du_lieu::text=current_setting('erp.bo',true)
 AND a.trang_thai_xu_ly='dang_su_dung' LIMIT 1
$$;
REVOKE ALL ON FUNCTION nen_tang.nhan_vien_hien_tai() FROM PUBLIC;
GRANT EXECUTE ON FUNCTION nen_tang.nhan_vien_hien_tai() TO mini_erp_app;
-- Missing keys must fail; SQL NULL in a CHECK must never mean an accepted structure.
ALTER FUNCTION nen_tang.kiem_cau_truc(jsonb,text) RENAME TO kiem_cau_truc_khoa;
CREATE FUNCTION nen_tang.kiem_cau_truc(v jsonb,loai text) RETURNS boolean LANGUAGE plpgsql IMMUTABLE AS $$
DECLARE a jsonb;
BEGIN
 IF v IS NULL THEN RETURN true; END IF;
 IF NOT coalesce(nen_tang.kiem_cau_truc_khoa(v,loai),false) THEN RETURN false; END IF;
 IF loai='lich' THEN
  IF jsonb_array_length(v)=0 THEN RETURN false; END IF;
  FOR a IN SELECT value FROM jsonb_array_elements(v) LOOP
   IF NOT (a ?& ARRAY['gio_bat_dau','gio_ket_thuc']) OR jsonb_typeof(a->'gio_bat_dau')<>'string' OR jsonb_typeof(a->'gio_ket_thuc')<>'string' THEN RETURN false; END IF;
  END LOOP;
 ELSIF loai='chinh_sach' THEN
  IF NOT (v ?& ARRAY['loai_chinh_sach','cac_tham_so']) OR jsonb_array_length(v->'cac_tham_so')=0 THEN RETURN false; END IF;
  FOR a IN SELECT value FROM jsonb_array_elements(v->'cac_tham_so') LOOP
   IF NOT (a ?& ARRAY['ten_tham_so','kieu_gia_tri','don_vi','gia_tri','can_cu_khai_bao']) OR nullif(a->>'ten_tham_so','') IS NULL OR nullif(a->>'can_cu_khai_bao','') IS NULL OR jsonb_typeof(a->'gia_tri') NOT IN ('string','number','boolean') THEN RETURN false; END IF;
  END LOOP;
 ELSIF loai='bien_nhan' AND NOT (v ?& ARRAY['cac_ma_chung_tu','cac_ma_dong','cac_ma_su_kien']) THEN RETURN false;
 ELSIF loai='nhat_ky' AND NOT (v ? 'cac_truong') THEN RETURN false;
 END IF;
 RETURN true;
END $$;
-- Existing CHECKs bind to the old function OID; add strict checks explicitly.
ALTER TABLE nhan_su.ngay_va_ca_lam_viec ADD CONSTRAINT lich_day_du CHECK(nen_tang.kiem_cau_truc(cac_khoang_lam_viec_trong_ca,'lich'));
ALTER TABLE dung_chung.phien_ban_chinh_sach ADD CONSTRAINT chinh_sach_day_du CHECK(nen_tang.kiem_cau_truc(tham_so,'chinh_sach'));
ALTER TABLE truy_cap.bien_nhan_xac_nhan_giao_dich ADD CONSTRAINT bien_nhan_day_du CHECK(nen_tang.kiem_cau_truc(cac_ma_ket_qua_da_ghi_nhan,'bien_nhan'));
