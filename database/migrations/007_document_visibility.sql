CREATE FUNCTION nen_tang.co_quyen_loai_ho_so(bo uuid,loai_ho_so text) RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER SET search_path=pg_catalog AS $$
 SELECT CASE loai_ho_so
  WHEN 'ho_so_lam_viec' THEN nen_tang.co_quyen(bo,'nhan_su.ho_so_lam_viec_theo_hieu_luc','xem')
  WHEN 'ky_nang' THEN nen_tang.co_quyen(bo,'nhan_su.ho_so_ky_nang_va_an_toan','xem')
  WHEN 'tien_dau' THEN nen_tang.co_quyen(bo,'tai_chinh.bien_dong_tien_thuc','xem')
  WHEN 'kiem_chat_luong' THEN nen_tang.co_quyen(bo,'chat_luong.phieu_kiem_tra_chat_luong','xem')
  WHEN 'ton_dau' THEN nen_tang.co_quyen(bo,'kho.dong_van_dong_hang','xem')
  WHEN 'van_dong_hang' THEN nen_tang.co_quyen(bo,'kho.dong_van_dong_hang','xem')
  WHEN 'quyet_dinh_cap_quyen' THEN nen_tang.co_quyen(bo,'truy_cap.cap_vai_tro','xem')
  WHEN 'quyet_dinh_danh_muc' THEN nen_tang.co_quyen(bo,'danh_muc.mat_hang','xem')
  WHEN 'quyet_dinh_chinh_sach' THEN nen_tang.co_quyen(bo,'dung_chung.phien_ban_chinh_sach','xem')
  WHEN 'phan_cong' THEN nen_tang.co_quyen(bo,'dung_chung.trao_doi_va_ban_giao','xem')
  ELSE false END
$$;
REVOKE ALL ON FUNCTION nen_tang.co_quyen_loai_ho_so(uuid,text) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION nen_tang.co_quyen_loai_ho_so(uuid,text) TO mini_erp_app;
CREATE FUNCTION nen_tang.co_quyen_ho_so(bo uuid,ho_so uuid) RETURNS boolean
LANGUAGE sql STABLE SECURITY DEFINER SET search_path=pg_catalog AS $$
 SELECT coalesce((SELECT nen_tang.co_quyen_loai_ho_so(bo,h.loai) FROM dung_chung.chung_tu h WHERE h.ma_dinh_danh=ho_so AND h.ma_bo_du_lieu=bo),false)
$$;
REVOKE ALL ON FUNCTION nen_tang.co_quyen_ho_so(uuid,uuid) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION nen_tang.co_quyen_ho_so(uuid,uuid) TO mini_erp_app;
