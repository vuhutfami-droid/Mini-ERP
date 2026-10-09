CREATE OR REPLACE FUNCTION nen_tang.co_quyen(bo uuid,bang text,viec text) RETURNS boolean
LANGUAGE plpgsql STABLE SECURITY DEFINER SET search_path=pg_catalog AS $$
 BEGIN
 IF nen_tang.co_quyen_vai_tro(bo,bang,viec) THEN RETURN true; END IF;
 IF bang LIKE 'truy_cap.%' OR NOT EXISTS(SELECT 1 FROM truy_cap.uy_quyen WHERE ma_bo_du_lieu=bo AND loai_doi_tuong_phan_quyen=bang AND hanh_dong=viec AND thoi_diem_thu_hoi_quyen IS NULL AND thoi_diem_ket_thuc_hieu_luc>now()) THEN RETURN false; END IF;
 RETURN EXISTS(
 SELECT 1 FROM truy_cap.uy_quyen u
 JOIN nhan_su.nhan_vien e ON e.ma_dinh_danh=u.ma_nhan_vien_nhan_uy_quyen AND e.ma_bo_du_lieu=bo
 JOIN truy_cap.tai_khoan_dang_nhap a ON a.ma_nguoi_that=e.ma_nguoi_that
 JOIN truy_cap.dinh_danh_nguoi n ON n.ma_dinh_danh=a.ma_nguoi_that
 JOIN nhan_su.nhan_vien giver ON giver.ma_dinh_danh=u.ma_nhan_vien_giao_uy_quyen AND giver.ma_bo_du_lieu=bo
 JOIN truy_cap.tai_khoan_dang_nhap ga ON ga.ma_nguoi_that=giver.ma_nguoi_that
 JOIN truy_cap.cap_vai_tro g ON g.ma_tai_khoan=ga.ma_dinh_danh AND g.ma_bo_du_lieu=bo
 JOIN truy_cap.quyen_thao_tac q ON q.ma_vai_tro=g.ma_vai_tro
 JOIN dung_chung.chung_tu h ON h.ma_dinh_danh=u.ma_phien_ban_chung_tu AND h.ma_bo_du_lieu=bo
 WHERE u.ma_bo_du_lieu=bo AND a.ma_dinh_danh::text=current_setting('erp.tai_khoan',true)
 AND a.trang_thai_xu_ly='dang_su_dung' AND n.trang_thai_xu_ly='dang_su_dung' AND ga.trang_thai_xu_ly='dang_su_dung'
 AND u.thoi_diem_thu_hoi_quyen IS NULL AND u.thoi_diem_bat_dau_hieu_luc<=now() AND u.thoi_diem_ket_thuc_hieu_luc>now()
 AND u.loai_doi_tuong_phan_quyen=bang AND u.hanh_dong=viec AND bang NOT LIKE 'truy_cap.%'
 AND u.ma_phe_duyet IS NOT NULL AND h.trang_thai_phe_duyet='da_duyet' AND h.loai='quyet_dinh_cap_quyen'
 AND u.gioi_han_so_luong_duoc_duyet IS NULL AND u.gioi_han_so_tien_duoc_duyet IS NULL
 AND giver.ma_nguoi_that<>e.ma_nguoi_that AND giver.ngay_nghi_viec IS NULL AND e.ngay_nghi_viec IS NULL
 AND g.thoi_diem_thu_hoi_quyen IS NULL AND g.thoi_diem_bat_dau_hieu_luc<=now() AND (g.thoi_diem_ket_thuc_hieu_luc IS NULL OR g.thoi_diem_ket_thuc_hieu_luc>now())
 AND q.loai_doi_tuong_phan_quyen=bang AND q.hanh_dong=viec AND q.pham_vi='doanh_nghiep');
 END
$$;

CREATE INDEX quyen_theo_vai_tro_cong_viec ON truy_cap.quyen_thao_tac(ma_vai_tro,loai_doi_tuong_phan_quyen,hanh_dong,pham_vi);
CREATE INDEX vai_tro_theo_tai_khoan_bo ON truy_cap.cap_vai_tro(ma_tai_khoan,ma_bo_du_lieu) WHERE thoi_diem_thu_hoi_quyen IS NULL;
CREATE INDEX uy_quyen_theo_bo_cong_viec ON truy_cap.uy_quyen(ma_bo_du_lieu,loai_doi_tuong_phan_quyen,hanh_dong) WHERE thoi_diem_thu_hoi_quyen IS NULL;
