CREATE FUNCTION nen_tang.bao_toan_mat_hang() RETURNS trigger
LANGUAGE plpgsql SECURITY DEFINER SET search_path=pg_catalog AS $$
BEGIN
 IF EXISTS(SELECT 1 FROM kho.lo_hang WHERE ma_mat_hang=OLD.ma_dinh_danh AND ma_bo_du_lieu=OLD.ma_bo_du_lieu)
 OR EXISTS(SELECT 1 FROM dung_chung.chung_tu WHERE ma_bo_du_lieu=OLD.ma_bo_du_lieu AND loai='quyet_dinh_danh_muc' AND pham_vi='mat_hang:'||OLD.ma_dinh_danh::text AND trang_thai_phe_duyet='da_duyet') THEN
  IF (to_jsonb(OLD)-ARRAY['dang_su_dung','so_phien_ban_ghi_dong_thoi','ma_tai_khoan_thuc_hien']) IS DISTINCT FROM (to_jsonb(NEW)-ARRAY['dang_su_dung','so_phien_ban_ghi_dong_thoi','ma_tai_khoan_thuc_hien']) THEN
   RAISE EXCEPTION 'Mặt hàng đã dùng/duyệt: chỉ ngừng hoặc dùng lại, thay quy cách cần bản mới' USING ERRCODE='23514';
  END IF;
 END IF;
 RETURN NEW;
END $$;
REVOKE ALL ON FUNCTION nen_tang.bao_toan_mat_hang() FROM PUBLIC;
CREATE TRIGGER mat_hang_da_dung BEFORE UPDATE ON danh_muc.mat_hang FOR EACH ROW EXECUTE FUNCTION nen_tang.bao_toan_mat_hang();
