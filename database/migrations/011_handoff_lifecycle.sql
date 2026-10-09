CREATE OR REPLACE FUNCTION nen_tang.bao_toan_nguon() RETURNS trigger LANGUAGE plpgsql AS $$
DECLARE o jsonb; n jsonb; k text; old_parent uuid; frozen boolean;
BEGIN
 o=to_jsonb(OLD); n=CASE WHEN TG_OP='DELETE' THEN '{}'::jsonb ELSE to_jsonb(NEW) END;
 IF TG_TABLE_SCHEMA='dung_chung' AND TG_TABLE_NAME='nhat_ky_thao_tac' OR TG_TABLE_SCHEMA='truy_cap' AND TG_TABLE_NAME='bien_nhan_xac_nhan_giao_dich' THEN RAISE EXCEPTION 'Lịch sử/biên nhận chỉ thêm' USING ERRCODE='23514'; END IF;
 frozen = (TG_TABLE_SCHEMA='dung_chung' AND TG_TABLE_NAME='trao_doi_va_ban_giao' AND o->>'trang_thai_xu_ly'='da_chap_nhan') OR o->>'trang_thai_ghi_so'='da_ghi_so' OR o->>'trang_thai_phe_duyet'='da_duyet' OR o->>'tinh_trang_xac_nhan_ket_luan'='da_xac_nhan';
 FOR k IN SELECT key FROM jsonb_each(o) WHERE key IN ('ma_phieu_van_dong_hang','ma_phien_ban_chung_tu') LOOP
  old_parent=(o->>k)::uuid;
  IF NOT (TG_TABLE_SCHEMA='dung_chung' AND TG_TABLE_NAME='trao_doi_va_ban_giao' OR TG_TABLE_SCHEMA='truy_cap' AND TG_TABLE_NAME='uy_quyen') AND EXISTS(SELECT 1 FROM dung_chung.chung_tu WHERE ma_dinh_danh=old_parent AND (trang_thai_ghi_so='da_ghi_so' OR trang_thai_phe_duyet='da_duyet')) THEN frozen=true; END IF;
 END LOOP;
 IF frozen AND o IS DISTINCT FROM n THEN RAISE EXCEPTION 'Nguồn đã xác nhận không được sửa/xóa đè' USING ERRCODE='23514'; END IF;
 -- Changing a discriminator could invalidate an existing type-constrained child FK.
 FOR k IN SELECT key FROM jsonb_each(o) WHERE key IN ('loai','loai_mat_hang','loai_dong_giao','loai_ban_ghi_nghia_vu','giai_doan_dong','doi_tuong_lich','loai_van_dong_kho') LOOP
  IF TG_OP='UPDATE' AND o->k IS DISTINCT FROM n->k THEN RAISE EXCEPTION 'Đổi loại cần tạo nguồn mới' USING ERRCODE='23514'; END IF;
 END LOOP;
 RETURN CASE WHEN TG_OP='DELETE' THEN OLD ELSE NEW END;
END $$;
