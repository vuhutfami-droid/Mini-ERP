CREATE FUNCTION nen_tang.kiem_loai_ke_thua() RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE kind text;
BEGIN
 SELECT loai INTO kind FROM dung_chung.chung_tu WHERE ma_dinh_danh=NEW.ma_dinh_danh AND ma_bo_du_lieu=NEW.ma_bo_du_lieu;
 IF kind IS DISTINCT FROM TG_ARGV[0] THEN RAISE EXCEPTION 'Bản kế thừa không đúng loại hồ sơ nguồn' USING ERRCODE='23514'; END IF;
 RETURN NEW;
END $$;
CREATE CONSTRAINT TRIGGER loai_kiem_chat_luong AFTER INSERT OR UPDATE ON chat_luong.phieu_kiem_tra_chat_luong DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.kiem_loai_ke_thua('kiem_chat_luong');
CREATE CONSTRAINT TRIGGER loai_ho_so_lam_viec AFTER INSERT OR UPDATE ON nhan_su.ho_so_lam_viec_theo_hieu_luc DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.kiem_loai_ke_thua('ho_so_lam_viec');
CREATE CONSTRAINT TRIGGER loai_ky_nang AFTER INSERT OR UPDATE ON nhan_su.ho_so_ky_nang_va_an_toan DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.kiem_loai_ke_thua('ky_nang');
