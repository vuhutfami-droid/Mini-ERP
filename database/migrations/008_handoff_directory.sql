CREATE FUNCTION nen_tang.danh_sach_nguoi_ban_giao() RETURNS TABLE(ma_dinh_danh uuid,nhan text)
LANGUAGE sql STABLE SECURITY DEFINER SET search_path=pg_catalog AS $$
 SELECT e.ma_dinh_danh,e.ten FROM nhan_su.nhan_vien e WHERE e.ma_bo_du_lieu::text=current_setting('erp.bo',true)
 AND nen_tang.co_quyen(e.ma_bo_du_lieu,'dung_chung.trao_doi_va_ban_giao','tao') ORDER BY e.ten
$$;
REVOKE ALL ON FUNCTION nen_tang.danh_sach_nguoi_ban_giao() FROM PUBLIC;
GRANT EXECUTE ON FUNCTION nen_tang.danh_sach_nguoi_ban_giao() TO mini_erp_app;
