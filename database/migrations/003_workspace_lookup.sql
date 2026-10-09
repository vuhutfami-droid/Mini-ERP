CREATE FUNCTION nen_tang.cac_bo_duoc_cap() RETURNS TABLE(ma_dinh_danh uuid,ma_nghiep_vu text,che_do text)
LANGUAGE sql STABLE SECURITY DEFINER SET search_path=pg_catalog AS $$
 SELECT DISTINCT b.ma_dinh_danh,b.ma_nghiep_vu,b.che_do FROM dung_chung.bo_du_lieu_mo_phong b
 JOIN truy_cap.cap_vai_tro g ON g.ma_bo_du_lieu=b.ma_dinh_danh
 JOIN truy_cap.tai_khoan_dang_nhap a ON a.ma_dinh_danh=g.ma_tai_khoan
 WHERE a.ma_dinh_danh::text=current_setting('erp.tai_khoan',true) AND a.trang_thai_xu_ly='dang_su_dung'
 AND g.thoi_diem_thu_hoi_quyen IS NULL AND g.thoi_diem_bat_dau_hieu_luc<=now()
 AND (g.thoi_diem_ket_thuc_hieu_luc IS NULL OR g.thoi_diem_ket_thuc_hieu_luc>now())
 ORDER BY b.ma_nghiep_vu
$$;
REVOKE ALL ON FUNCTION nen_tang.cac_bo_duoc_cap() FROM PUBLIC;
GRANT EXECUTE ON FUNCTION nen_tang.cac_bo_duoc_cap() TO mini_erp_app;
