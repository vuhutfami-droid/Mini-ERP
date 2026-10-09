-- Fix an omission in B29: T053/T062 inherit T006 but the two line types were absent.
-- No new business table, amount, decision or synthetic source is introduced.
ALTER TABLE dung_chung.dong_chung_tu DROP CONSTRAINT dong_chung_tu_loai_check;
ALTER TABLE dung_chung.dong_chung_tu ADD CONSTRAINT dong_chung_tu_loai_check CHECK(loai IN ('dong_bao_gia_don_hang','dong_don_mua','dong_van_dong','dong_kiem_ke','dong_dinh_muc','dong_giao_hang','dong_ghi_ban','xac_nhan_khach_nhan','doi_chieu_mua','nguon_chi_phi','phan_bo_chi_phi','yeu_cau_hang_vat_tu','dong_thu_nhap','dong_tien_thuc','dong_gia_tri'));
COMMENT ON COLUMN dung_chung.dong_chung_tu.loai IS 'Loại dòng nghiệp vụ; bổ sung dòng tiền thực và dòng giá trị để các nguồn T053/T062 có đúng phần mở rộng, không dùng sai loại hoặc bỏ FK.';
CREATE FUNCTION nen_tang.kiem_loai_dong_ke_thua() RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE kind text;
BEGIN
 SELECT loai INTO kind FROM dung_chung.dong_chung_tu WHERE ma_dinh_danh=NEW.ma_dinh_danh AND ma_bo_du_lieu=NEW.ma_bo_du_lieu;
 IF kind IS DISTINCT FROM TG_ARGV[0] THEN RAISE EXCEPTION 'Không đúng loại dòng nguồn' USING ERRCODE='23514'; END IF;
 RETURN NEW;
END $$;
CREATE CONSTRAINT TRIGGER loai_dong_tien AFTER INSERT OR UPDATE ON tai_chinh.bien_dong_tien_thuc DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.kiem_loai_dong_ke_thua('dong_tien_thuc');
CREATE CONSTRAINT TRIGGER loai_dong_gia_tri AFTER INSERT OR UPDATE ON tai_chinh.bien_dong_gia_tri DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.kiem_loai_dong_ke_thua('dong_gia_tri');
