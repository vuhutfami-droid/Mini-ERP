-- B29: 74 business tables / 931 columns. Future-domain tables stay empty in D01.
CREATE SCHEMA "chat_luong";
CREATE SCHEMA "danh_muc";
CREATE SCHEMA "dung_chung";
CREATE SCHEMA "giao_hang";
CREATE SCHEMA "kho";
CREATE SCHEMA "kinh_doanh";
CREATE SCHEMA "mua_hang";
CREATE SCHEMA "nhan_su";
CREATE SCHEMA "san_xuat";
CREATE SCHEMA "tai_chinh";
CREATE SCHEMA "truy_cap";
CREATE SCHEMA nen_tang;
CREATE TABLE "dung_chung"."doanh_nghiep" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_nghiep_vu" text,
  "ten" text,
  "mui_gio" text,
  "tien_te" text CHECK ("tien_te" IN ('VND')),
  "che_do" text CHECK ("che_do" IN ('mo_phong')),
  "ma_bo_du_lieu" uuid NOT NULL,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "dung_chung"."doanh_nghiep"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "dung_chung"."doanh_nghiep"."ma_nghiep_vu" IS 'Mã nghiệp vụ: Mã nghiệp vụ của doanh nghiệp, phục vụ một đơn vị doanh nghiệp; được ghi bởi dùng chung theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."doanh_nghiep"."ten" IS 'Tên: Tên của doanh nghiệp, phục vụ một đơn vị doanh nghiệp; được ghi bởi dùng chung theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."doanh_nghiep"."mui_gio" IS 'Múi giờ: Múi giờ của doanh nghiệp, phục vụ một đơn vị doanh nghiệp; được ghi bởi dùng chung theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."doanh_nghiep"."tien_te" IS 'Tiền tệ: Tiền tệ của doanh nghiệp, phục vụ một đơn vị doanh nghiệp; được ghi bởi dùng chung theo hồ sơ nguồn của bảng. Giá trị cho phép: VND.';
COMMENT ON COLUMN "dung_chung"."doanh_nghiep"."che_do" IS 'Chế độ: Chế độ của doanh nghiệp, phục vụ một đơn vị doanh nghiệp; được ghi bởi dùng chung theo hồ sơ nguồn của bảng. Giá trị cho phép: mo_phong.';
COMMENT ON COLUMN "dung_chung"."doanh_nghiep"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."doanh_nghiep"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "dung_chung"."doanh_nghiep"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."doanh_nghiep"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
CREATE UNIQUE INDEX ma_40d7f3f26aabb433cd ON "dung_chung"."doanh_nghiep" (ma_bo_du_lieu,ma_nghiep_vu);
COMMENT ON TABLE "dung_chung"."doanh_nghiep" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "dung_chung"."bo_phan" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_nghiep_vu" text,
  "ten" text,
  "dang_su_dung" boolean,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_doanh_nghiep" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "dung_chung"."bo_phan"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "dung_chung"."bo_phan"."ma_nghiep_vu" IS 'Mã nghiệp vụ: Mã nghiệp vụ của bộ phận, phục vụ nhóm công việc của 50 người; được ghi bởi nhân sự theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."bo_phan"."ten" IS 'Tên: Tên của bộ phận, phục vụ nhóm công việc của 50 người; được ghi bởi nhân sự theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."bo_phan"."dang_su_dung" IS 'Đang sử dụng: Đang sử dụng của bộ phận, phục vụ nhóm công việc của 50 người; được ghi bởi nhân sự theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."bo_phan"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."bo_phan"."ma_doanh_nghiep" IS 'Mã doanh nghiệp: Mã doanh nghiệp liên kết dung_chung.doanh_nghiep đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."bo_phan"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "dung_chung"."bo_phan"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."bo_phan"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
CREATE UNIQUE INDEX ma_eebd0e06f9385b36b2 ON "dung_chung"."bo_phan" (ma_bo_du_lieu,ma_nghiep_vu);
COMMENT ON TABLE "dung_chung"."bo_phan" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "dung_chung"."vi_tri_giu_hang" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_nghiep_vu" text,
  "loai" text CHECK ("loai" IN ('ben_ngoai','dang_giao','vung_trong_kho','xuong')),
  "ma_kho_vat_ly" text,
  "dang_su_dung" boolean,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_doanh_nghiep" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "dung_chung"."vi_tri_giu_hang"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "dung_chung"."vi_tri_giu_hang"."ma_nghiep_vu" IS 'Mã nghiệp vụ: Mã nghiệp vụ của vị trí giữ hàng, phục vụ nơi chịu trách nhiệm giữ hàng; được ghi bởi kho / sản xuất / giao hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."vi_tri_giu_hang"."loai" IS 'Loại: Loại của vị trí giữ hàng, phục vụ nơi chịu trách nhiệm giữ hàng; được ghi bởi kho / sản xuất / giao hàng theo hồ sơ nguồn của bảng. Giá trị cho phép: vung_trong_kho; xuong; dang_giao; ben_ngoai.';
COMMENT ON COLUMN "dung_chung"."vi_tri_giu_hang"."ma_kho_vat_ly" IS 'Mã kho vật lý: Mã kho vật lý của vị trí giữ hàng, phục vụ nơi chịu trách nhiệm giữ hàng; được ghi bởi kho / sản xuất / giao hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."vi_tri_giu_hang"."dang_su_dung" IS 'Đang sử dụng: Đang sử dụng của vị trí giữ hàng, phục vụ nơi chịu trách nhiệm giữ hàng; được ghi bởi kho / sản xuất / giao hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."vi_tri_giu_hang"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."vi_tri_giu_hang"."ma_doanh_nghiep" IS 'Mã doanh nghiệp: Mã doanh nghiệp liên kết dung_chung.doanh_nghiep đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."vi_tri_giu_hang"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "dung_chung"."vi_tri_giu_hang"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."vi_tri_giu_hang"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
CREATE UNIQUE INDEX ma_b9fc9606e0ee99dcdd ON "dung_chung"."vi_tri_giu_hang" (ma_bo_du_lieu,ma_nghiep_vu);
COMMENT ON TABLE "dung_chung"."vi_tri_giu_hang" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "dung_chung"."don_vi_tinh" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_nghiep_vu" text,
  "dai_luong" text CHECK ("dai_luong" IN ('hang_loat','the_tich','thoi_gian','vien')),
  "so_chu_so_thap_phan_duoc_phep" smallint,
  "ma_bo_du_lieu" uuid NOT NULL,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "dung_chung"."don_vi_tinh"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "dung_chung"."don_vi_tinh"."ma_nghiep_vu" IS 'Mã nghiệp vụ: Mã nghiệp vụ của đơn vị tính, phục vụ đơn vị và độ chính xác; được ghi bởi dùng chung theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."don_vi_tinh"."dai_luong" IS 'Đại lượng: Đại lượng của đơn vị tính, phục vụ đơn vị và độ chính xác; được ghi bởi dùng chung theo hồ sơ nguồn của bảng. Giá trị cho phép: vien; hang_loat; the_tich; thoi_gian.';
COMMENT ON COLUMN "dung_chung"."don_vi_tinh"."so_chu_so_thap_phan_duoc_phep" IS 'Số chữ số thập phân được phép: Số chữ số thập phân được phép của đơn vị tính, phục vụ đơn vị và độ chính xác; được ghi bởi dùng chung theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."don_vi_tinh"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."don_vi_tinh"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "dung_chung"."don_vi_tinh"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."don_vi_tinh"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
CREATE UNIQUE INDEX ma_0b2c951a6a0cdea174 ON "dung_chung"."don_vi_tinh" (ma_bo_du_lieu,ma_nghiep_vu);
COMMENT ON TABLE "dung_chung"."don_vi_tinh" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "dung_chung"."chung_tu" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_nghiep_vu" text,
  "loai" text CHECK ("loai" IN ('ban_giao_dung_cu','bao_gia','chot_gia_thanh','cong','cong_doan','de_nghi_chi','de_nghi_nhan_su','dieu_chinh_nghia_vu','dinh_muc','doi_chieu_mua','don_hang','don_mua','ghi_ban','giam_ban','giao_hang','ho_so_lam_viec','khach_nhan','kiem_chat_luong','kiem_ke','ky_nang','ky_thu_nhap','lenh_san_xuat','mau_khach','nghi','nguon_chi_phi','nhu_cau_khach','nhu_cau_vat_tu','phan_bo_chi_phi','phan_cong','quyet_dinh_cap_quyen','quyet_dinh_chinh_sach','quyet_dinh_chot_ky','quyet_dinh_chot_lenh','quyet_dinh_danh_muc','su_co','su_kien_phep','tang_ban','thay_doi_thuong_mai','tien_dau','tien_thuc','ton_dau','van_dong_hang','xu_ly_chat_luong')),
  "so_phien_ban_chung_tu" bigint,
  "trang_thai_phe_duyet" text CHECK ("trang_thai_phe_duyet" IN ('da_bi_thay_ban','da_duyet','da_rut','da_trinh','da_tu_choi','khong_yeu_cau','nhap')),
  "thoi_diem_co_hieu_luc" timestamptz,
  "thoi_diem_he_thong_ghi_nhan" timestamptz,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  "ly_do" text,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_chung_tu_goc" uuid,
  "ma_nhan_vien_phu_trach" uuid,
  "ma_tai_khoan_lap_chung_tu" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "loai_van_dong_kho" text CHECK ("loai_van_dong_kho" IN ('cap_phat','chia_phan_chat_luong','chuyen_noi_bo','dau_ky','dieu_chinh_kiem_ke','nhan_hang','thuc_dung','tieu_huy','tra_hang','xuat_giao')),
  "trang_thai_ghi_so" text CHECK ("trang_thai_ghi_so" IN ('da_ghi_so','nhap')),
  "thoi_diem_thuc_hien_nghiep_vu" timestamptz,
  "thu_tu_ghi_so" bigint,
  "ma_bien_nhan_xac_nhan_giao_dich" uuid,
  "thoi_diem_moc_doi_chieu" timestamptz,
  "pham_vi" text,
  "trang_thai_xu_ly" text CHECK ("trang_thai_xu_ly" IN ('da_duyet','da_ghi_so','da_ra_soat','dang_dem')),
  "thoi_diem_bat_dau_ngung_giao_dich_kiem_ke" timestamptz,
  "thoi_diem_ket_thuc_ngung_giao_dich_kiem_ke" timestamptz,
  "ma_nhan_vien_dem_thuc" uuid,
  "ma_nhan_vien_doi_chieu" uuid,
  "pham_vi_mo_phong_thue" text CHECK ("pham_vi_mo_phong_thue" IN ('chua_mo_phong')),
  "ma_chung_tu_don_hang" uuid,
  "ma_ho_so_xu_ly_thuong_mai" uuid,
  "ma_phe_duyet" uuid,
  "tinh_trang_chot_gia_thanh" text CHECK ("tinh_trang_chot_gia_thanh" IN ('da_xac_nhan','tam_tinh')),
  "ma_lo_san_xuat" uuid,
  "ma_phien_ban_chinh_sach_dinh_gia" uuid,
  "tinh_trang_xac_nhan_cong" text CHECK ("tinh_trang_xac_nhan_cong" IN ('cho_xu_ly','da_chot','da_xac_nhan','nhap')),
  "ma_nguon_nhap_du_lieu" text,
  "ma_nhan_vien" uuid,
  "ma_ngay_va_ca_lam_viec" uuid,
  "ma_ban_chung_tu_bi_thay" uuid,
  "ma_nhan_vien_xac_nhan" uuid,
  "ma_ky" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "dung_chung"."chung_tu"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."ma_nghiep_vu" IS 'Mã nghiệp vụ: Mã nghiệp vụ của chứng từ, phục vụ định danh một phiên bản chứng từ; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."loai" IS 'Loại: Loại của chứng từ, phục vụ định danh một phiên bản chứng từ; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng. Giá trị cho phép: nhu_cau_khach; bao_gia; don_hang; mau_khach; thay_doi_thuong_mai; don_mua; van_dong_hang; ton_dau; kiem_ke; dinh_muc; lenh_san_xuat; cong_doan; kiem_chat_luong; xu_ly_chat_luong; giao_hang; ghi_ban; giam_ban; tang_ban; de_nghi_chi; chot_gia_thanh; ho_so_lam_viec; ky_nang; su_co; ban_giao_dung_cu; phan_cong; cong; nghi; ky_thu_nhap; khach_nhan; doi_chieu_mua; tien_thuc; tien_dau; dieu_chinh_nghia_vu; nguon_chi_phi; phan_bo_chi_phi; su_kien_phep; nhu_cau_vat_tu; quyet_dinh_danh_muc; quyet_dinh_chinh_sach; quyet_dinh_cap_quyen; quyet_dinh_chot_ky; de_nghi_nhan_su; quyet_dinh_chot_lenh.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."so_phien_ban_chung_tu" IS 'Số phiên bản chứng từ: Số phiên bản chứng từ của chứng từ, phục vụ định danh một phiên bản chứng từ; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."trang_thai_phe_duyet" IS 'Trạng thái phê duyệt: Trạng thái phê duyệt của chứng từ, phục vụ định danh một phiên bản chứng từ; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng. Giá trị cho phép: nhap; da_trinh; da_tu_choi; da_duyet; da_rut; da_bi_thay_ban. Loại không cần phê duyệt theo B24 dùng khong_yeu_cau; vẫn phải xác nhận thực đúng quyền, không ghi da_duyet hoặc tạo quyết định giả.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."thoi_diem_co_hieu_luc" IS 'Thời điểm có hiệu lực: Thời điểm người có thẩm quyền quy định nội dung bắt đầu áp dụng, tách với thời điểm hệ thống ghi.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."thoi_diem_he_thong_ghi_nhan" IS 'Thời điểm hệ thống ghi nhận: Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."ly_do" IS 'Lý do: Lý do của chứng từ, phục vụ định danh một phiên bản chứng từ; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."ma_chung_tu_goc" IS 'Mã chứng từ gốc: Mã chứng từ gốc liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."ma_nhan_vien_phu_trach" IS 'Mã nhân viên phụ trách: Mã nhân viên phụ trách liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."ma_tai_khoan_lap_chung_tu" IS 'Mã tài khoản lập chứng từ: Mã tài khoản lập chứng từ liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."loai_van_dong_kho" IS 'Loại: Loại của phiếu vận động hàng, phục vụ phiếu và sự kiện thực vào/ra/chuyển; được ghi bởi kho / người xác nhận thực theo nguồn theo hồ sơ nguồn của bảng. Giá trị cho phép: dau_ky; nhan_hang; chuyen_noi_bo; chia_phan_chat_luong; cap_phat; tra_hang; thuc_dung; xuat_giao; tieu_huy; dieu_chinh_kiem_ke.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."trang_thai_ghi_so" IS 'Trạng thái xác nhận thực hiện: Trạng thái xác nhận thực hiện của phiếu vận động hàng, phục vụ phiếu và sự kiện thực vào/ra/chuyển; được ghi bởi kho / người xác nhận thực theo nguồn theo hồ sơ nguồn của bảng. Giá trị cho phép: nhap; da_ghi_so.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."thoi_diem_thuc_hien_nghiep_vu" IS 'Thời điểm thực hiện nghiệp vụ: Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."thu_tu_ghi_so" IS 'Thứ tự ghi sổ: Thứ tự ghi sổ của phiếu vận động hàng, phục vụ phiếu và sự kiện thực vào/ra/chuyển; được ghi bởi kho / người xác nhận thực theo nguồn theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."ma_bien_nhan_xac_nhan_giao_dich" IS 'Mã biên nhận xác nhận giao dịch: Mã biên nhận xác nhận giao dịch liên kết truy_cap.bien_nhan_xac_nhan_giao_dich đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."thoi_diem_moc_doi_chieu" IS 'Thời điểm mốc đối chiếu: Thời điểm mốc đối chiếu của biên bản kiểm kê, phục vụ mốc và phạm vi kiểm kê; được ghi bởi kho, người đếm/đối chiếu khác nhau theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."pham_vi" IS 'Phạm vi: Phạm vi của biên bản kiểm kê, phục vụ mốc và phạm vi kiểm kê; được ghi bởi kho, người đếm/đối chiếu khác nhau theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."trang_thai_xu_ly" IS 'Trạng thái xử lý: Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: dang_dem; da_ra_soat; da_duyet; da_ghi_so.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."thoi_diem_bat_dau_ngung_giao_dich_kiem_ke" IS 'Thời điểm bắt đầu ngừng giao dịch kiểm kê: Thời điểm bắt đầu ngừng giao dịch kiểm kê của biên bản kiểm kê, phục vụ mốc và phạm vi kiểm kê; được ghi bởi kho, người đếm/đối chiếu khác nhau theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."thoi_diem_ket_thuc_ngung_giao_dich_kiem_ke" IS 'Thời điểm kết thúc ngừng giao dịch kiểm kê: Thời điểm kết thúc ngừng giao dịch kiểm kê của biên bản kiểm kê, phục vụ mốc và phạm vi kiểm kê; được ghi bởi kho, người đếm/đối chiếu khác nhau theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."ma_nhan_vien_dem_thuc" IS 'Mã nhân viên đếm thực: Mã nhân viên đếm thực liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."ma_nhan_vien_doi_chieu" IS 'Mã nhân viên đối chiếu: Mã nhân viên đối chiếu liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."pham_vi_mo_phong_thue" IS 'Phạm vi mô phỏng thuế: Phạm vi mô phỏng thuế của chứng từ ghi nhận bán, phục vụ ghi nhận bán hoặc điều chỉnh thương mại; được ghi bởi kế toán theo hồ sơ nguồn của bảng. Giá trị cho phép: chua_mo_phong.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."ma_chung_tu_don_hang" IS 'Mã chứng từ đơn hàng: Mã chứng từ đơn hàng liên kết kinh_doanh.bao_gia_va_don_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."ma_ho_so_xu_ly_thuong_mai" IS 'Mã hồ sơ xử lý thương mại: Mã hồ sơ xử lý thương mại liên kết kinh_doanh.ho_so_xu_ly đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."ma_phe_duyet" IS 'Mã phê duyệt: Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."tinh_trang_chot_gia_thanh" IS 'Trạng thái xử lý: Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: tam_tinh; da_xac_nhan.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."ma_lo_san_xuat" IS 'Mã lô sản xuất: Mã lô sản xuất liên kết san_xuat.lo_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."ma_phien_ban_chinh_sach_dinh_gia" IS 'Mã phiên bản chính sách định giá: Mã phiên bản chính sách định giá liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."tinh_trang_xac_nhan_cong" IS 'Trạng thái xử lý: Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: nhap; cho_xu_ly; da_xac_nhan; da_chot.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."ma_nguon_nhap_du_lieu" IS 'Mã nguồn nhập dữ liệu: Mã nguồn nhập dữ liệu của bản công người ngày ca, phục vụ một bản công người/ngày/ca; được ghi bởi tổ trưởng ghi / quản lý xác nhận / hr chốt theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."ma_nhan_vien" IS 'Mã nhân viên: Mã nhân viên liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."ma_ngay_va_ca_lam_viec" IS 'Mã ngày và ca làm việc: Mã ngày và ca làm việc liên kết nhan_su.ngay_va_ca_lam_viec đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."ma_ban_chung_tu_bi_thay" IS 'Mã bản công bị thay: Mã bản công bị thay liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."ma_nhan_vien_xac_nhan" IS 'Mã nhân viên xác nhận: Mã nhân viên xác nhận liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."chung_tu"."ma_ky" IS 'Mã kỳ: Mã kỳ liên kết dung_chung.ky_nghiep_vu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "dung_chung"."chung_tu" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "dung_chung"."dong_chung_tu" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "so_thu_tu_dong" bigint,
  "loai" text CHECK ("loai" IN ('doi_chieu_mua','dong_bao_gia_don_hang','dong_dinh_muc','dong_don_mua','dong_ghi_ban','dong_giao_hang','dong_kiem_ke','dong_thu_nhap','dong_van_dong','nguon_chi_phi','phan_bo_chi_phi','xac_nhan_khach_nhan','yeu_cau_hang_vat_tu')),
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_phien_ban_chung_tu" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "dung_chung"."dong_chung_tu"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "dung_chung"."dong_chung_tu"."so_thu_tu_dong" IS 'Số thứ tự dòng: Số thứ tự dòng của dòng chứng từ, phục vụ mã dòng chung để liên kết và duyệt đúng phần; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."dong_chung_tu"."loai" IS 'Loại: Loại của dòng chứng từ, phục vụ mã dòng chung để liên kết và duyệt đúng phần; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng. Giá trị cho phép: dong_bao_gia_don_hang; dong_don_mua; dong_van_dong; dong_kiem_ke; dong_dinh_muc; dong_giao_hang; dong_ghi_ban; xac_nhan_khach_nhan; doi_chieu_mua; nguon_chi_phi; phan_bo_chi_phi; yeu_cau_hang_vat_tu; dong_thu_nhap.';
COMMENT ON COLUMN "dung_chung"."dong_chung_tu"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."dong_chung_tu"."ma_phien_ban_chung_tu" IS 'Mã phiên bản chứng từ: Mã phiên bản chứng từ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."dong_chung_tu"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "dung_chung"."dong_chung_tu"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."dong_chung_tu"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON TABLE "dung_chung"."dong_chung_tu" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "dung_chung"."lien_ket_chung_tu" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "quan_he" text CHECK ("quan_he" IN ('dao_nguon_goc','dieu_chinh_ban_goc','nguon_goc','phu_thuoc','thay_ban_truoc')),
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_chung_tu_nguon_lien_ket" uuid,
  "ma_chung_tu_dich_lien_ket" uuid,
  "thoi_diem_he_thong_ghi_nhan" timestamptz,
  "ma_tai_khoan_thuc_hien" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "dung_chung"."lien_ket_chung_tu"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "dung_chung"."lien_ket_chung_tu"."quan_he" IS 'Quan hệ: Quan hệ của liên kết chứng từ, phục vụ nguồn, thay đổi, đảo hoặc thay thế; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng. Giá trị cho phép: nguon_goc; dieu_chinh_ban_goc; dao_nguon_goc; thay_ban_truoc; phu_thuoc.';
COMMENT ON COLUMN "dung_chung"."lien_ket_chung_tu"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."lien_ket_chung_tu"."ma_chung_tu_nguon_lien_ket" IS 'Mã chứng từ nguồn liên kết: Mã chứng từ nguồn liên kết liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."lien_ket_chung_tu"."ma_chung_tu_dich_lien_ket" IS 'Mã chứng từ đích liên kết: Mã chứng từ đích liên kết liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."lien_ket_chung_tu"."thoi_diem_he_thong_ghi_nhan" IS 'Thời điểm hệ thống ghi nhận: Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc.';
COMMENT ON COLUMN "dung_chung"."lien_ket_chung_tu"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "dung_chung"."lien_ket_chung_tu" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "hanh_dong" text CHECK ("hanh_dong" IN ('chot_ky','chot_lenh','danh_gia_dap_ung','dieu_chinh','huy','khoi_phuc','kiem_tra','mo_lai_ky','nhan','phe_duyet','quyet_dinh_uu_tien','tao','xac_nhan','xem','xuat_du_lieu')),
  "trang_thai_xu_ly" text CHECK ("trang_thai_xu_ly" IN ('da_de_nghi','da_duyet','da_kiem_tra','da_thu_hoi_quyen','da_tu_choi')),
  "thoi_diem_de_nghi" timestamptz,
  "thoi_diem_quyet_dinh" timestamptz,
  "gioi_han_so_luong_duoc_duyet" numeric(24,6),
  "gioi_han_so_tien_duoc_duyet" numeric(24,0),
  "ly_do" text,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_phien_ban_chung_tu" uuid,
  "ma_dong_chung_tu" uuid,
  "ma_nhan_vien_de_nghi" uuid,
  "ma_nhan_vien_kiem_tra" uuid,
  "ma_nhan_vien_quyet_dinh" uuid,
  "ma_uy_quyen" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet"."hanh_dong" IS 'Hành động: Hành động của đề nghị và quyết định phê duyệt, phục vụ đề nghị, kiểm và quyết định đúng phiên bản; được ghi bởi theo bảng thẩm quyền b24 theo hồ sơ nguồn của bảng. Giá trị cho phép: xem; tao; kiem_tra; phe_duyet; xac_nhan; nhan; xuat_du_lieu; huy; dieu_chinh; khoi_phuc; chot_ky; mo_lai_ky; danh_gia_dap_ung; quyet_dinh_uu_tien; chot_lenh.';
COMMENT ON COLUMN "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet"."trang_thai_xu_ly" IS 'Trạng thái xử lý: Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: da_de_nghi; da_kiem_tra; da_duyet; da_tu_choi; da_thu_hoi_quyen.';
COMMENT ON COLUMN "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet"."thoi_diem_de_nghi" IS 'Thời điểm đề nghị: Thời điểm đề nghị của đề nghị và quyết định phê duyệt, phục vụ đề nghị, kiểm và quyết định đúng phiên bản; được ghi bởi theo bảng thẩm quyền b24 theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet"."thoi_diem_quyet_dinh" IS 'Thời điểm quyết định: Thời điểm quyết định của đề nghị và quyết định phê duyệt, phục vụ đề nghị, kiểm và quyết định đúng phiên bản; được ghi bởi theo bảng thẩm quyền b24 theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet"."gioi_han_so_luong_duoc_duyet" IS 'Giới hạn số lượng được duyệt: Giới hạn số lượng được duyệt của đề nghị và quyết định phê duyệt, phục vụ đề nghị, kiểm và quyết định đúng phiên bản; được ghi bởi theo bảng thẩm quyền b24 theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet"."gioi_han_so_tien_duoc_duyet" IS 'Giới hạn số tiền được duyệt: Giới hạn số tiền được duyệt của đề nghị và quyết định phê duyệt, phục vụ đề nghị, kiểm và quyết định đúng phiên bản; được ghi bởi theo bảng thẩm quyền b24 theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet"."ly_do" IS 'Lý do: Lý do của đề nghị và quyết định phê duyệt, phục vụ đề nghị, kiểm và quyết định đúng phiên bản; được ghi bởi theo bảng thẩm quyền b24 theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet"."ma_phien_ban_chung_tu" IS 'Mã phiên bản chứng từ: Mã phiên bản chứng từ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet"."ma_dong_chung_tu" IS 'Mã dòng chứng từ: Mã dòng chứng từ liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet"."ma_nhan_vien_de_nghi" IS 'Mã nhân viên đề nghị: Mã nhân viên đề nghị liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet"."ma_nhan_vien_kiem_tra" IS 'Mã nhân viên kiểm tra: Mã nhân viên kiểm tra liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet"."ma_nhan_vien_quyet_dinh" IS 'Mã nhân viên quyết định: Mã nhân viên quyết định liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet"."ma_uy_quyen" IS 'Mã ủy quyền: Mã ủy quyền liên kết truy_cap.uy_quyen đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON TABLE "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "dung_chung"."trao_doi_va_ban_giao" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "trang_thai_xu_ly" text CHECK ("trang_thai_xu_ly" IN ('can_bo_sung','da_chap_nhan','da_gui','da_huy')),
  "so_luong_de_nghi" numeric(24,6),
  "so_luong_duoc_chap_nhan" numeric(24,6),
  "thoi_diem_can_hoan_thanh" timestamptz,
  "thoi_diem_nhan" timestamptz,
  "ly_do_con_thieu" text,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_phien_ban_chung_tu" uuid,
  "ma_dong_chung_tu" uuid,
  "ma_nhan_vien_ban_giao" uuid,
  "ma_nhan_vien_nhan_ban_giao" uuid,
  "ma_don_vi" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  "kenh_tiep_nhan" text CHECK ("kenh_tiep_nhan" IN ('dien_thoai','gioi_thieu','lien_he_ca_nhan','thu_dien_tu','trang_mang')),
  "noi_dung_tiep_nhan" text,
  "ma_doi_chieu_ben_ngoai" text,
  "ma_tai_khoan_nhap_du_lieu" uuid,
  "loai_ban_giao_dung_cu" text CHECK ("loai_ban_giao_dung_cu" IN ('cap_phat','thay_the','tra_hang')),
  "thoi_diem_thuc_hien_nghiep_vu" timestamptz,
  "can_cu_tiep_nhan" text,
  "ma_nhan_vien" uuid,
  "ma_dong_van_dong_hang" uuid,
  "ma_ban_giao_goc" uuid,
  "loai_trao_doi" text CHECK ("loai_trao_doi" IN ('ban_giao_cong_viec','ban_giao_dung_cu','tiep_nhan_khach')),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."trang_thai_xu_ly" IS 'Trạng thái xử lý: Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: da_gui; da_chap_nhan; can_bo_sung; da_huy.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."so_luong_de_nghi" IS 'Số lượng đề nghị: Số lượng đề nghị của bàn giao công việc, phục vụ bàn giao từng phần, việc chờ và phản hồi; được ghi bởi người giao và người nhận theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."so_luong_duoc_chap_nhan" IS 'Số lượng được chấp nhận: Số lượng được chấp nhận của bàn giao công việc, phục vụ bàn giao từng phần, việc chờ và phản hồi; được ghi bởi người giao và người nhận theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."thoi_diem_can_hoan_thanh" IS 'Thời điểm cần hoàn thành: Thời điểm cần hoàn thành của bàn giao công việc, phục vụ bàn giao từng phần, việc chờ và phản hồi; được ghi bởi người giao và người nhận theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."thoi_diem_nhan" IS 'Thời điểm nhận: Thời điểm nhận của bàn giao công việc, phục vụ bàn giao từng phần, việc chờ và phản hồi; được ghi bởi người giao và người nhận theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."ly_do_con_thieu" IS 'Lý do còn thiếu: Lý do còn thiếu của bàn giao công việc, phục vụ bàn giao từng phần, việc chờ và phản hồi; được ghi bởi người giao và người nhận theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."ma_phien_ban_chung_tu" IS 'Mã phiên bản chứng từ: Mã phiên bản chứng từ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."ma_dong_chung_tu" IS 'Mã dòng chứng từ: Mã dòng chứng từ liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."ma_nhan_vien_ban_giao" IS 'Mã nhân viên bàn giao: Mã nhân viên bàn giao liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."ma_nhan_vien_nhan_ban_giao" IS 'Mã nhân viên nhận bàn giao: Mã nhân viên nhận bàn giao liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."ma_don_vi" IS 'Mã đơn vị: Mã đơn vị liên kết dung_chung.don_vi_tinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."kenh_tiep_nhan" IS 'Kênh tiếp nhận: Kênh tiếp nhận của lần tiếp nhận nhu cầu, phục vụ các kênh và lần tiếp nhận; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. Giá trị cho phép: dien_thoai; thu_dien_tu; trang_mang; lien_he_ca_nhan; gioi_thieu.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."noi_dung_tiep_nhan" IS 'Nội dung tiếp nhận: Nội dung tiếp nhận của lần tiếp nhận nhu cầu, phục vụ các kênh và lần tiếp nhận; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."ma_doi_chieu_ben_ngoai" IS 'Mã đối chiếu bên ngoài: Mã đối chiếu bên ngoài của lần tiếp nhận nhu cầu, phục vụ các kênh và lần tiếp nhận; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."ma_tai_khoan_nhap_du_lieu" IS 'Mã tài khoản nhập dữ liệu: Mã tài khoản nhập dữ liệu liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."loai_ban_giao_dung_cu" IS 'Loại: Loại của bàn giao bảo hộ dụng cụ, phục vụ cấp/trả đồ bảo hộ và dụng cụ; được ghi bởi nhân sự / kho theo hồ sơ nguồn của bảng. Giá trị cho phép: cap_phat; tra_hang; thay_the.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."thoi_diem_thuc_hien_nghiep_vu" IS 'Thời điểm thực hiện nghiệp vụ: Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."can_cu_tiep_nhan" IS 'Căn cứ tiếp nhận: Căn cứ tiếp nhận của bàn giao bảo hộ dụng cụ, phục vụ cấp/trả đồ bảo hộ và dụng cụ; được ghi bởi nhân sự / kho theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."ma_nhan_vien" IS 'Mã nhân viên: Mã nhân viên liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."ma_dong_van_dong_hang" IS 'Mã dòng vận động hàng: Mã dòng vận động hàng liên kết kho.dong_van_dong_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."ma_ban_giao_goc" IS 'Mã bàn giao dụng cụ gốc: Mã bàn giao dụng cụ gốc liên kết dung_chung.trao_doi_va_ban_giao đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."trao_doi_va_ban_giao"."loai_trao_doi" IS 'Loại trao đổi hoặc bàn giao: Phân biệt nội dung tiếp nhận khách, giao việc và bàn giao dụng cụ; quyền/điều kiện từng loại được kiểm riêng.';
COMMENT ON TABLE "dung_chung"."trao_doi_va_ban_giao" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "dung_chung"."chung_cu_dinh_kem" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "khoa_tep_trong_noi_luu" text,
  "ma_kiem_toan_ven" text,
  "loai_dinh_dang_tep" text,
  "dung_luong_tep_tinh_theo_byte" bigint,
  "muc_nhay_cam" text CHECK ("muc_nhay_cam" IN ('duoc_xem_trong_mo_phong','noi_bo','thu_nhap')),
  "gia_lap" boolean,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_phien_ban_chung_tu" uuid,
  "ma_dong_chung_tu" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "dung_chung"."chung_cu_dinh_kem"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "dung_chung"."chung_cu_dinh_kem"."khoa_tep_trong_noi_luu" IS 'Khóa tệp trong nơi lưu: Khóa tệp trong nơi lưu của chứng cứ đính kèm, phục vụ chỉ mục chứng cứ trong kho tệp; được ghi bởi bộ phận của nguồn theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."chung_cu_dinh_kem"."ma_kiem_toan_ven" IS 'Mã kiểm toàn vẹn: Mã kiểm toàn vẹn của chứng cứ đính kèm, phục vụ chỉ mục chứng cứ trong kho tệp; được ghi bởi bộ phận của nguồn theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."chung_cu_dinh_kem"."loai_dinh_dang_tep" IS 'Loại định dạng tệp: Loại định dạng tệp của chứng cứ đính kèm, phục vụ chỉ mục chứng cứ trong kho tệp; được ghi bởi bộ phận của nguồn theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."chung_cu_dinh_kem"."dung_luong_tep_tinh_theo_byte" IS 'Dung lượng tệp tính theo byte: Dung lượng tệp tính theo byte của chứng cứ đính kèm, phục vụ chỉ mục chứng cứ trong kho tệp; được ghi bởi bộ phận của nguồn theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."chung_cu_dinh_kem"."muc_nhay_cam" IS 'Mức nhạy cảm: Mức nhạy cảm của chứng cứ đính kèm, phục vụ chỉ mục chứng cứ trong kho tệp; được ghi bởi bộ phận của nguồn theo hồ sơ nguồn của bảng. Giá trị cho phép: duoc_xem_trong_mo_phong; noi_bo; thu_nhap.';
COMMENT ON COLUMN "dung_chung"."chung_cu_dinh_kem"."gia_lap" IS 'Giả lập: Giả lập của chứng cứ đính kèm, phục vụ chỉ mục chứng cứ trong kho tệp; được ghi bởi bộ phận của nguồn theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."chung_cu_dinh_kem"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."chung_cu_dinh_kem"."ma_phien_ban_chung_tu" IS 'Mã phiên bản chứng từ: Mã phiên bản chứng từ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."chung_cu_dinh_kem"."ma_dong_chung_tu" IS 'Mã dòng chứng từ: Mã dòng chứng từ liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."chung_cu_dinh_kem"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "dung_chung"."chung_cu_dinh_kem"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."chung_cu_dinh_kem"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON TABLE "dung_chung"."chung_cu_dinh_kem" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "dung_chung"."nhat_ky_thao_tac" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "hanh_dong" text,
  "thoi_diem_he_thong_ghi_nhan" timestamptz,
  "khoa_lien_ket_thao_tac" uuid,
  "noi_dung_thay_doi_da_luoc_du_lieu_nhay_cam" jsonb,
  "ly_do" text,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_phien_ban_chung_tu" uuid,
  "ma_tai_khoan_thuc_hien" uuid,
  "ma_nhan_vien_duoc_ghi_nhan_thay" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "dung_chung"."nhat_ky_thao_tac"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "dung_chung"."nhat_ky_thao_tac"."hanh_dong" IS 'Hành động: Hành động của nhật ký thao tác, phục vụ dấu vết thao tác và thay đổi; được ghi bởi hệ thống, giới hạn theo nguồn theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."nhat_ky_thao_tac"."thoi_diem_he_thong_ghi_nhan" IS 'Thời điểm hệ thống ghi nhận: Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc.';
COMMENT ON COLUMN "dung_chung"."nhat_ky_thao_tac"."khoa_lien_ket_thao_tac" IS 'Khóa liên kết thao tác: Khóa liên kết thao tác của nhật ký thao tác, phục vụ dấu vết thao tác và thay đổi; được ghi bởi hệ thống, giới hạn theo nguồn theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."nhat_ky_thao_tac"."noi_dung_thay_doi_da_luoc_du_lieu_nhay_cam" IS 'Nội dung thay đổi đã lược dữ liệu nhạy cảm: Nội dung thay đổi đã lược dữ liệu nhạy cảm của nhật ký thao tác, phục vụ dấu vết thao tác và thay đổi; được ghi bởi hệ thống, giới hạn theo nguồn theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."nhat_ky_thao_tac"."ly_do" IS 'Lý do: Lý do của nhật ký thao tác, phục vụ dấu vết thao tác và thay đổi; được ghi bởi hệ thống, giới hạn theo nguồn theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."nhat_ky_thao_tac"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."nhat_ky_thao_tac"."ma_phien_ban_chung_tu" IS 'Mã phiên bản chứng từ: Mã phiên bản chứng từ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."nhat_ky_thao_tac"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."nhat_ky_thao_tac"."ma_nhan_vien_duoc_ghi_nhan_thay" IS 'Mã nhân viên được ghi nhận thay: Mã nhân viên được ghi nhận thay liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "dung_chung"."nhat_ky_thao_tac" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "dung_chung"."ky_nghiep_vu" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "loai_ky" text CHECK ("loai_ky" IN ('cong','kho','tai_chinh','thu_nhap')),
  "ngay_bat_dau" date,
  "ngay_ket_thuc" date,
  "trang_thai_xu_ly" text CHECK ("trang_thai_xu_ly" IN ('da_chot','dang_mo')),
  "thoi_diem_chot" timestamptz,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_chung_tu_quyet_dinh_chot_ky" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  "so_phien_ban_chung_tu" bigint,
  "gioi_han_mo_phong" text CHECK ("gioi_han_mo_phong" IN ('chua_mo_phong_khoan_bat_buoc')),
  "ma_chung_tu_ky_thu_nhap" uuid,
  "ma_ky_goc" uuid,
  "ma_chung_tu_chot_cong" uuid,
  "ma_phien_ban_chinh_sach" uuid,
  "ma_ban_ky_bi_thay" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "dung_chung"."ky_nghiep_vu"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "dung_chung"."ky_nghiep_vu"."loai_ky" IS 'Loại kỳ: Kỳ kho/công/thu nhập/tài chính độc lập; bản tính thu nhập là loại kỳ thu nhập có nguồn công/chính sách cố định.';
COMMENT ON COLUMN "dung_chung"."ky_nghiep_vu"."ngay_bat_dau" IS 'Ngày bắt đầu: Ngày bắt đầu của kỳ nghiệp vụ, phục vụ chốt và mở lại kỳ; được ghi bởi nhân sự / tài chính / kho theo loại kỳ theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."ky_nghiep_vu"."ngay_ket_thuc" IS 'Ngày kết thúc: Ngày kết thúc của kỳ nghiệp vụ, phục vụ chốt và mở lại kỳ; được ghi bởi nhân sự / tài chính / kho theo loại kỳ theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."ky_nghiep_vu"."trang_thai_xu_ly" IS 'Trạng thái xử lý: Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: dang_mo; da_chot.';
COMMENT ON COLUMN "dung_chung"."ky_nghiep_vu"."thoi_diem_chot" IS 'Thời điểm chốt: Thời điểm chốt của kỳ nghiệp vụ, phục vụ chốt và mở lại kỳ; được ghi bởi nhân sự / tài chính / kho theo loại kỳ theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."ky_nghiep_vu"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."ky_nghiep_vu"."ma_chung_tu_quyet_dinh_chot_ky" IS 'Mã chứng từ quyết định chốt kỳ: Mã chứng từ quyết định chốt kỳ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."ky_nghiep_vu"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "dung_chung"."ky_nghiep_vu"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."ky_nghiep_vu"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON COLUMN "dung_chung"."ky_nghiep_vu"."so_phien_ban_chung_tu" IS 'Số phiên bản chứng từ: Số phiên bản chứng từ của kỳ tính thu nhập, phục vụ kỳ và phiên bản bảng thu nhập; được ghi bởi nhân sự lập / tài chính kiểm theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."ky_nghiep_vu"."gioi_han_mo_phong" IS 'Giới hạn mô phỏng: Giới hạn mô phỏng của kỳ tính thu nhập, phục vụ kỳ và phiên bản bảng thu nhập; được ghi bởi nhân sự lập / tài chính kiểm theo hồ sơ nguồn của bảng. Giá trị cho phép: chua_mo_phong_khoan_bat_buoc.';
COMMENT ON COLUMN "dung_chung"."ky_nghiep_vu"."ma_chung_tu_ky_thu_nhap" IS 'Mã phiên bản chứng từ: Mã phiên bản chứng từ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."ky_nghiep_vu"."ma_ky_goc" IS 'Mã kỳ: Mã kỳ liên kết dung_chung.ky_nghiep_vu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."ky_nghiep_vu"."ma_chung_tu_chot_cong" IS 'Mã chứng từ chốt công: Mã chứng từ chốt công liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."ky_nghiep_vu"."ma_phien_ban_chinh_sach" IS 'Mã phiên bản chính sách: Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."ky_nghiep_vu"."ma_ban_ky_bi_thay" IS 'Mã kỳ tính thu nhập bị thay: Mã kỳ tính thu nhập bị thay liên kết dung_chung.ky_nghiep_vu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "dung_chung"."ky_nghiep_vu" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "dung_chung"."phien_ban_chinh_sach" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "loai" text CHECK ("loai" IN ('canh_bao_ton','dinh_gia','kiem_chat_luong','lich_lam','nghi','san_xuat','thu_nhap','xac_dinh_gia')),
  "ma_nghiep_vu" text,
  "so_phien_ban" bigint,
  "thoi_diem_bat_dau_hieu_luc" timestamptz,
  "thoi_diem_ket_thuc_hieu_luc" timestamptz,
  "tham_so" jsonb,
  "gia_lap" boolean,
  "thoi_diem_khai_bao" timestamptz,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_phe_duyet" uuid,
  "ma_chung_tu_can_cu_khai_bao" uuid,
  "ma_nguoi_khai_bao_du_lieu" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "dung_chung"."phien_ban_chinh_sach"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "dung_chung"."phien_ban_chinh_sach"."loai" IS 'Loại: Loại của phiên bản chính sách, phục vụ tham số có hiệu lực và căn cứ; được ghi bởi bộ phận phụ trách chính sách theo hồ sơ nguồn của bảng. Giá trị cho phép: lich_lam; xac_dinh_gia; kiem_chat_luong; san_xuat; thu_nhap; nghi; dinh_gia; canh_bao_ton.';
COMMENT ON COLUMN "dung_chung"."phien_ban_chinh_sach"."ma_nghiep_vu" IS 'Mã nghiệp vụ: Mã nghiệp vụ của phiên bản chính sách, phục vụ tham số có hiệu lực và căn cứ; được ghi bởi bộ phận phụ trách chính sách theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."phien_ban_chinh_sach"."so_phien_ban" IS 'Số phiên bản: Số phiên bản của phiên bản chính sách, phục vụ tham số có hiệu lực và căn cứ; được ghi bởi bộ phận phụ trách chính sách theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."phien_ban_chinh_sach"."thoi_diem_bat_dau_hieu_luc" IS 'Thời điểm bắt đầu hiệu lực: Thời điểm bắt đầu hiệu lực của phiên bản chính sách, phục vụ tham số có hiệu lực và căn cứ; được ghi bởi bộ phận phụ trách chính sách theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."phien_ban_chinh_sach"."thoi_diem_ket_thuc_hieu_luc" IS 'Thời điểm kết thúc hiệu lực: Thời điểm kết thúc hiệu lực của phiên bản chính sách, phục vụ tham số có hiệu lực và căn cứ; được ghi bởi bộ phận phụ trách chính sách theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."phien_ban_chinh_sach"."tham_so" IS 'Tham số: Các tham số khai báo có cấu trúc và đơn vị, gắn chứng từ căn cứ/người khai báo/hiệu lực/duyệt; thiếu căn cứ để chờ, không nạp mặc định rồi coi chính sách doanh nghiệp.';
COMMENT ON COLUMN "dung_chung"."phien_ban_chinh_sach"."gia_lap" IS 'Giả lập: Giả lập của phiên bản chính sách, phục vụ tham số có hiệu lực và căn cứ; được ghi bởi bộ phận phụ trách chính sách theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."phien_ban_chinh_sach"."thoi_diem_khai_bao" IS 'Thời điểm khai báo: Thời điểm khai báo của phiên bản chính sách, phục vụ tham số có hiệu lực và căn cứ; được ghi bởi bộ phận phụ trách chính sách theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."phien_ban_chinh_sach"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."phien_ban_chinh_sach"."ma_phe_duyet" IS 'Mã phê duyệt: Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."phien_ban_chinh_sach"."ma_chung_tu_can_cu_khai_bao" IS 'Mã chứng từ căn cứ khai báo: Mã chứng từ căn cứ khai báo liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."phien_ban_chinh_sach"."ma_nguoi_khai_bao_du_lieu" IS 'Mã người khai báo dữ liệu: Mã người khai báo dữ liệu liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."phien_ban_chinh_sach"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "dung_chung"."phien_ban_chinh_sach"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."phien_ban_chinh_sach"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON TABLE "dung_chung"."phien_ban_chinh_sach" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "dung_chung"."bo_du_lieu_mo_phong" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_nghiep_vu" text,
  "phien_ban_bo_mo_phong" text,
  "che_do" text CHECK ("che_do" IN ('anh_chup_da_hoan_thanh','dau_ky','nhanh_thu')),
  "ma_kich_ban_kiem_tra" text,
  "thoi_diem_moc_goc" timestamptz,
  "trang_thai_xu_ly" text CHECK ("trang_thai_xu_ly" IN ('chuan_bi_vao_lam','du_dieu_kien_bat_dau','luu_tru')),
  "ma_kiem_toan_ven_bo_nap" text,
  "ma_bo_du_lieu_cha" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0)
);
COMMENT ON COLUMN "dung_chung"."bo_du_lieu_mo_phong"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "dung_chung"."bo_du_lieu_mo_phong"."ma_nghiep_vu" IS 'Mã nghiệp vụ: Mã nghiệp vụ của bộ dữ liệu mô phỏng, phục vụ cách ly cơ sở, mốc và nhánh; được ghi bởi quản trị bộ mô phỏng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."bo_du_lieu_mo_phong"."phien_ban_bo_mo_phong" IS 'Phiên bản bộ mô phỏng: Phiên bản bộ mô phỏng của bộ dữ liệu mô phỏng, phục vụ cách ly cơ sở, mốc và nhánh; được ghi bởi quản trị bộ mô phỏng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."bo_du_lieu_mo_phong"."che_do" IS 'Chế độ: Chế độ của bộ dữ liệu mô phỏng, phục vụ cách ly cơ sở, mốc và nhánh; được ghi bởi quản trị bộ mô phỏng theo hồ sơ nguồn của bảng. Giá trị cho phép: dau_ky; anh_chup_da_hoan_thanh; nhanh_thu.';
COMMENT ON COLUMN "dung_chung"."bo_du_lieu_mo_phong"."ma_kich_ban_kiem_tra" IS 'Mã kịch bản kiểm tra: Mã kịch bản kiểm tra của bộ dữ liệu mô phỏng, phục vụ cách ly cơ sở, mốc và nhánh; được ghi bởi quản trị bộ mô phỏng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."bo_du_lieu_mo_phong"."thoi_diem_moc_goc" IS 'Thời điểm mốc gốc: Thời điểm mốc gốc của bộ dữ liệu mô phỏng, phục vụ cách ly cơ sở, mốc và nhánh; được ghi bởi quản trị bộ mô phỏng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."bo_du_lieu_mo_phong"."trang_thai_xu_ly" IS 'Trạng thái xử lý: Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: chuan_bi_vao_lam; du_dieu_kien_bat_dau; luu_tru.';
COMMENT ON COLUMN "dung_chung"."bo_du_lieu_mo_phong"."ma_kiem_toan_ven_bo_nap" IS 'Mã kiểm toàn vẹn bộ nạp: Mã kiểm toàn vẹn bộ nạp của bộ dữ liệu mô phỏng, phục vụ cách ly cơ sở, mốc và nhánh; được ghi bởi quản trị bộ mô phỏng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."bo_du_lieu_mo_phong"."ma_bo_du_lieu_cha" IS 'Mã bộ dữ liệu cha: Mã bộ dữ liệu cha liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."bo_du_lieu_mo_phong"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "dung_chung"."bo_du_lieu_mo_phong"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."bo_du_lieu_mo_phong"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON TABLE "dung_chung"."bo_du_lieu_mo_phong" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "truy_cap"."tai_khoan_dang_nhap" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ten_dang_nhap" text,
  "ban_bam_thong_tin_xac_thuc" text,
  "trang_thai_xu_ly" text CHECK ("trang_thai_xu_ly" IN ('dang_su_dung','ngung_su_dung')),
  "so_phien_ban_quyen_xac_thuc" bigint,
  "ma_nguoi_that" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0)
);
COMMENT ON COLUMN "truy_cap"."tai_khoan_dang_nhap"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "truy_cap"."tai_khoan_dang_nhap"."ten_dang_nhap" IS 'Tên đăng nhập: Tên đăng nhập của tài khoản đăng nhập, phục vụ tài khoản của người thật; được ghi bởi quản trị truy cập theo quyết định theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."tai_khoan_dang_nhap"."ban_bam_thong_tin_xac_thuc" IS 'Bản băm thông tin xác thực: Bản băm thông tin xác thực của tài khoản đăng nhập, phục vụ tài khoản của người thật; được ghi bởi quản trị truy cập theo quyết định theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."tai_khoan_dang_nhap"."trang_thai_xu_ly" IS 'Trạng thái xử lý: Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: dang_su_dung; ngung_su_dung.';
COMMENT ON COLUMN "truy_cap"."tai_khoan_dang_nhap"."so_phien_ban_quyen_xac_thuc" IS 'Số phiên bản quyền xác thực: Số phiên bản quyền xác thực của tài khoản đăng nhập, phục vụ tài khoản của người thật; được ghi bởi quản trị truy cập theo quyết định theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."tai_khoan_dang_nhap"."ma_nguoi_that" IS 'Mã người thật: Mã người thật liên kết truy_cap.dinh_danh_nguoi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."tai_khoan_dang_nhap"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "truy_cap"."tai_khoan_dang_nhap"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."tai_khoan_dang_nhap"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON TABLE "truy_cap"."tai_khoan_dang_nhap" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "truy_cap"."vai_tro_cong_viec" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_nghiep_vu" text,
  "ten" text,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0)
);
COMMENT ON COLUMN "truy_cap"."vai_tro_cong_viec"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "truy_cap"."vai_tro_cong_viec"."ma_nghiep_vu" IS 'Mã nghiệp vụ: Mã nghiệp vụ của vai trò công việc, phục vụ nhóm quyền công việc; được ghi bởi quản trị truy cập theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."vai_tro_cong_viec"."ten" IS 'Tên: Tên của vai trò công việc, phục vụ nhóm quyền công việc; được ghi bởi quản trị truy cập theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."vai_tro_cong_viec"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "truy_cap"."vai_tro_cong_viec"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."vai_tro_cong_viec"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
CREATE UNIQUE INDEX ma_1b8db65991e21d5308 ON "truy_cap"."vai_tro_cong_viec" (ma_nghiep_vu);
COMMENT ON TABLE "truy_cap"."vai_tro_cong_viec" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "truy_cap"."quyen_thao_tac" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "loai_doi_tuong_phan_quyen" text CHECK ("loai_doi_tuong_phan_quyen" IN ('chat_luong.ket_qua_tung_tieu_chi_kiem_tra','chat_luong.phieu_kiem_tra_chat_luong','danh_muc.ma_goi_khac','danh_muc.mat_hang','danh_muc.quy_doi_don_vi','dung_chung.bo_du_lieu_mo_phong','dung_chung.bo_phan','dung_chung.can_cu_dai_dien','dung_chung.chung_cu_dinh_kem','dung_chung.chung_tu','dung_chung.de_nghi_va_quyet_dinh_phe_duyet','dung_chung.doanh_nghiep','dung_chung.doi_tac','dung_chung.don_vi_tinh','dung_chung.dong_chung_tu','dung_chung.ky_nghiep_vu','dung_chung.lien_he_doi_tac','dung_chung.lien_ket_chung_tu','dung_chung.nhat_ky_thao_tac','dung_chung.phien_ban_chinh_sach','dung_chung.trao_doi_va_ban_giao','dung_chung.vi_tri_giu_hang','giao_hang.dong_giao_va_nhan_hang','giao_hang.dot_giao_hang','kho.dong_kiem_ke','kho.dong_van_dong_hang','kho.lo_hang','kho.phan_lo_hang','kho.su_kien_giu_khoa_va_dang_ve','kho.yeu_cau_hang_va_vat_tu','kinh_doanh.bao_gia_va_don_hang','kinh_doanh.dong_tu_van_bao_gia_va_don_hang','kinh_doanh.ho_so_xu_ly','kinh_doanh.mau_khach_duyet','kinh_doanh.nhu_cau_khach_hang','mua_hang.don_mua_hang','mua_hang.dong_don_mua_hang','nhan_su.de_nghi_nghi','nhan_su.ho_so_ky_nang_va_an_toan','nhan_su.ho_so_lam_viec_theo_hieu_luc','nhan_su.khoan_thu_nhap_co_can_cu','nhan_su.khoang_cong_thuc_te','nhan_su.ngay_va_ca_lam_viec','nhan_su.nhan_vien','nhan_su.su_kien_phep','nhan_su.thu_nhap_nhan_vien','san_xuat.cong_doan_san_xuat','san_xuat.dong_dinh_muc_vat_tu','san_xuat.lenh_san_xuat','san_xuat.lich_nguoi_va_nguon_luc','san_xuat.lo_san_xuat','san_xuat.nguon_luc_san_xuat','san_xuat.phien_ban_dinh_muc_san_xuat','tai_chinh.bien_dong_gia_tri','tai_chinh.bien_dong_tien_thuc','tai_chinh.can_cu_phan_bo_chi_phi','tai_chinh.de_nghi_chi_tien','tai_chinh.doi_chieu_nghia_vu_mua','tai_chinh.dong_doi_chieu_quy_ngan_hang','tai_chinh.dong_ghi_nhan_ban','tai_chinh.nghia_vu_va_dieu_chinh','tai_chinh.nguon_chi_phi','tai_chinh.nguon_cua_ban_chot_gia_thanh','tai_chinh.phan_bo_chi_phi','tai_chinh.quy_va_tai_khoan_tien','tai_chinh.su_kien_su_dung_nguon_tien','truy_cap.bien_nhan_xac_nhan_giao_dich','truy_cap.cap_vai_tro','truy_cap.dinh_danh_nguoi','truy_cap.phien_dang_nhap','truy_cap.quyen_thao_tac','truy_cap.tai_khoan_dang_nhap','truy_cap.uy_quyen','truy_cap.vai_tro_cong_viec')),
  "hanh_dong" text CHECK ("hanh_dong" IN ('dieu_chinh','kiem_tra','phe_duyet','tao','xac_nhan','xem','xuat_khau')),
  "pham_vi" text CHECK ("pham_vi" IN ('bo_phan','da_phan_cong','doanh_nghiep','tu_than')),
  "cac_nhom_du_lieu_nhay_cam" text CHECK ("cac_nhom_du_lieu_nhay_cam" IN ('chung_cu_han_che','cong_ca_nhan','ho_so_ca_nhan','luong_ca_nhan','nguon_chi_phi_ca_nhan','thong_tin_xac_thuc')),
  "ma_vai_tro" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0)
);
COMMENT ON COLUMN "truy_cap"."quyen_thao_tac"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "truy_cap"."quyen_thao_tac"."loai_doi_tuong_phan_quyen" IS 'Loại đối tượng phân quyền: Loại đối tượng phân quyền của quyền thao tác, phục vụ quyền của từng vai trò; được ghi bởi quản trị truy cập theo hồ sơ nguồn của bảng. Giá trị cho phép: dung_chung.doanh_nghiep; dung_chung.bo_phan; dung_chung.vi_tri_giu_hang; dung_chung.don_vi_tinh; dung_chung.chung_tu; dung_chung.dong_chung_tu; dung_chung.lien_ket_chung_tu; dung_chung.de_nghi_va_quyet_dinh_phe_duyet; dung_chung.trao_doi_va_ban_giao; dung_chung.chung_cu_dinh_kem; dung_chung.nhat_ky_thao_tac; dung_chung.ky_nghiep_vu; dung_chung.phien_ban_chinh_sach; dung_chung.bo_du_lieu_mo_phong; truy_cap.tai_khoan_dang_nhap; truy_cap.vai_tro_cong_viec; truy_cap.quyen_thao_tac; truy_cap.cap_vai_tro; truy_cap.uy_quyen; truy_cap.bien_nhan_xac_nhan_giao_dich; danh_muc.mat_hang; danh_muc.mat_hang; danh_muc.ma_goi_khac; danh_muc.quy_doi_don_vi; dung_chung.doi_tac; dung_chung.lien_he_doi_tac; dung_chung.can_cu_dai_dien; kinh_doanh.nhu_cau_khach_hang; dung_chung.trao_doi_va_ban_giao; kinh_doanh.dong_tu_van_bao_gia_va_don_hang; kinh_doanh.bao_gia_va_don_hang; kinh_doanh.dong_tu_van_bao_gia_va_don_hang; kinh_doanh.mau_khach_duyet; kinh_doanh.ho_so_xu_ly; mua_hang.don_mua_hang; mua_hang.dong_don_mua_hang; kho.su_kien_giu_khoa_va_dang_ve; kho.lo_hang; kho.phan_lo_hang; dung_chung.chung_tu; kho.dong_van_dong_hang; kho.yeu_cau_hang_va_vat_tu; kho.su_kien_giu_khoa_va_dang_ve; dung_chung.chung_tu; kho.dong_kiem_ke; san_xuat.phien_ban_dinh_muc_san_xuat; san_xuat.dong_dinh_muc_vat_tu; san_xuat.nguon_luc_san_xuat; san_xuat.lenh_san_xuat; san_xuat.lo_san_xuat; san_xuat.cong_doan_san_xuat; san_xuat.lich_nguoi_va_nguon_luc; kho.dong_van_dong_hang; chat_luong.phieu_kiem_tra_chat_luong; chat_luong.ket_qua_tung_tieu_chi_kiem_tra; kho.su_kien_giu_khoa_va_dang_ve; kinh_doanh.ho_so_xu_ly; giao_hang.dot_giao_hang; giao_hang.dong_giao_va_nhan_hang; giao_hang.dong_giao_va_nhan_hang; tai_chinh.quy_va_tai_khoan_tien; tai_chinh.de_nghi_chi_tien; tai_chinh.bien_dong_tien_thuc; tai_chinh.nghia_vu_va_dieu_chinh; tai_chinh.nghia_vu_va_dieu_chinh; tai_chinh.su_kien_su_dung_nguon_tien; dung_chung.chung_tu; tai_chinh.dong_ghi_nhan_ban; tai_chinh.doi_chieu_nghia_vu_mua; tai_chinh.dong_doi_chieu_quy_ngan_hang; tai_chinh.nguon_chi_phi; tai_chinh.phan_bo_chi_phi; tai_chinh.can_cu_phan_bo_chi_phi; dung_chung.chung_tu; tai_chinh.bien_dong_gia_tri; nhan_su.nhan_vien; nhan_su.ho_so_lam_viec_theo_hieu_luc; nhan_su.ho_so_ky_nang_va_an_toan; dung_chung.trao_doi_va_ban_giao; nhan_su.ngay_va_ca_lam_viec; san_xuat.lich_nguoi_va_nguon_luc; dung_chung.chung_tu; nhan_su.khoang_cong_thuc_te; nhan_su.de_nghi_nghi; nhan_su.su_kien_phep; dung_chung.ky_nghiep_vu; nhan_su.thu_nhap_nhan_vien; nhan_su.khoan_thu_nhap_co_can_cu; truy_cap.phien_dang_nhap; tai_chinh.nguon_cua_ban_chot_gia_thanh; truy_cap.dinh_danh_nguoi.';
COMMENT ON COLUMN "truy_cap"."quyen_thao_tac"."hanh_dong" IS 'Hành động: Hành động của quyền thao tác, phục vụ quyền của từng vai trò; được ghi bởi quản trị truy cập theo hồ sơ nguồn của bảng. Giá trị cho phép: xem; tao; kiem_tra; phe_duyet; xac_nhan; dieu_chinh; xuat_khau.';
COMMENT ON COLUMN "truy_cap"."quyen_thao_tac"."pham_vi" IS 'Phạm vi: Phạm vi của quyền thao tác, phục vụ quyền của từng vai trò; được ghi bởi quản trị truy cập theo hồ sơ nguồn của bảng. Giá trị cho phép: tu_than; da_phan_cong; bo_phan; doanh_nghiep.';
COMMENT ON COLUMN "truy_cap"."quyen_thao_tac"."cac_nhom_du_lieu_nhay_cam" IS 'Các nhóm dữ liệu nhạy cảm: Các nhóm dữ liệu nhạy cảm của quyền thao tác, phục vụ quyền của từng vai trò; được ghi bởi quản trị truy cập theo hồ sơ nguồn của bảng. Giá trị cho phép: luong_ca_nhan; ho_so_ca_nhan; cong_ca_nhan; chung_cu_han_che; nguon_chi_phi_ca_nhan; thong_tin_xac_thuc.';
COMMENT ON COLUMN "truy_cap"."quyen_thao_tac"."ma_vai_tro" IS 'Mã vai trò: Mã vai trò liên kết truy_cap.vai_tro_cong_viec đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."quyen_thao_tac"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "truy_cap"."quyen_thao_tac"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."quyen_thao_tac"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON TABLE "truy_cap"."quyen_thao_tac" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "truy_cap"."cap_vai_tro" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "thoi_diem_bat_dau_hieu_luc" timestamptz,
  "thoi_diem_ket_thuc_hieu_luc" timestamptz,
  "thoi_diem_thu_hoi_quyen" timestamptz,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_tai_khoan" uuid,
  "ma_vai_tro" uuid,
  "ma_phe_duyet" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "truy_cap"."cap_vai_tro"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "truy_cap"."cap_vai_tro"."thoi_diem_bat_dau_hieu_luc" IS 'Thời điểm bắt đầu hiệu lực: Thời điểm bắt đầu hiệu lực của cấp vai trò, phục vụ cấp vai trò có hiệu lực; được ghi bởi quản trị truy cập theo quyết định theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."cap_vai_tro"."thoi_diem_ket_thuc_hieu_luc" IS 'Thời điểm kết thúc hiệu lực: Thời điểm kết thúc hiệu lực của cấp vai trò, phục vụ cấp vai trò có hiệu lực; được ghi bởi quản trị truy cập theo quyết định theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."cap_vai_tro"."thoi_diem_thu_hoi_quyen" IS 'Thời điểm thu hồi quyền: Thời điểm thu hồi quyền của cấp vai trò, phục vụ cấp vai trò có hiệu lực; được ghi bởi quản trị truy cập theo quyết định theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."cap_vai_tro"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."cap_vai_tro"."ma_tai_khoan" IS 'Mã tài khoản: Mã tài khoản liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."cap_vai_tro"."ma_vai_tro" IS 'Mã vai trò: Mã vai trò liên kết truy_cap.vai_tro_cong_viec đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."cap_vai_tro"."ma_phe_duyet" IS 'Mã phê duyệt: Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."cap_vai_tro"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "truy_cap"."cap_vai_tro"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."cap_vai_tro"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON TABLE "truy_cap"."cap_vai_tro" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "truy_cap"."uy_quyen" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "hanh_dong" text CHECK ("hanh_dong" IN ('chot_ky','chot_lenh','danh_gia_dap_ung','dieu_chinh','huy','khoi_phuc','kiem_tra','mo_lai_ky','nhan','phe_duyet','quyet_dinh_uu_tien','tao','xac_nhan','xem','xuat_du_lieu')),
  "loai_doi_tuong_phan_quyen" text CHECK ("loai_doi_tuong_phan_quyen" IN ('chat_luong.ket_qua_tung_tieu_chi_kiem_tra','chat_luong.phieu_kiem_tra_chat_luong','danh_muc.ma_goi_khac','danh_muc.mat_hang','danh_muc.quy_doi_don_vi','dung_chung.bo_du_lieu_mo_phong','dung_chung.bo_phan','dung_chung.can_cu_dai_dien','dung_chung.chung_cu_dinh_kem','dung_chung.chung_tu','dung_chung.de_nghi_va_quyet_dinh_phe_duyet','dung_chung.doanh_nghiep','dung_chung.doi_tac','dung_chung.don_vi_tinh','dung_chung.dong_chung_tu','dung_chung.ky_nghiep_vu','dung_chung.lien_he_doi_tac','dung_chung.lien_ket_chung_tu','dung_chung.nhat_ky_thao_tac','dung_chung.phien_ban_chinh_sach','dung_chung.trao_doi_va_ban_giao','dung_chung.vi_tri_giu_hang','giao_hang.dong_giao_va_nhan_hang','giao_hang.dot_giao_hang','kho.dong_kiem_ke','kho.dong_van_dong_hang','kho.lo_hang','kho.phan_lo_hang','kho.su_kien_giu_khoa_va_dang_ve','kho.yeu_cau_hang_va_vat_tu','kinh_doanh.bao_gia_va_don_hang','kinh_doanh.dong_tu_van_bao_gia_va_don_hang','kinh_doanh.ho_so_xu_ly','kinh_doanh.mau_khach_duyet','kinh_doanh.nhu_cau_khach_hang','mua_hang.don_mua_hang','mua_hang.dong_don_mua_hang','nhan_su.de_nghi_nghi','nhan_su.ho_so_ky_nang_va_an_toan','nhan_su.ho_so_lam_viec_theo_hieu_luc','nhan_su.khoan_thu_nhap_co_can_cu','nhan_su.khoang_cong_thuc_te','nhan_su.ngay_va_ca_lam_viec','nhan_su.nhan_vien','nhan_su.su_kien_phep','nhan_su.thu_nhap_nhan_vien','san_xuat.cong_doan_san_xuat','san_xuat.dong_dinh_muc_vat_tu','san_xuat.lenh_san_xuat','san_xuat.lich_nguoi_va_nguon_luc','san_xuat.lo_san_xuat','san_xuat.nguon_luc_san_xuat','san_xuat.phien_ban_dinh_muc_san_xuat','tai_chinh.bien_dong_gia_tri','tai_chinh.bien_dong_tien_thuc','tai_chinh.can_cu_phan_bo_chi_phi','tai_chinh.de_nghi_chi_tien','tai_chinh.doi_chieu_nghia_vu_mua','tai_chinh.dong_doi_chieu_quy_ngan_hang','tai_chinh.dong_ghi_nhan_ban','tai_chinh.nghia_vu_va_dieu_chinh','tai_chinh.nguon_chi_phi','tai_chinh.nguon_cua_ban_chot_gia_thanh','tai_chinh.phan_bo_chi_phi','tai_chinh.quy_va_tai_khoan_tien','tai_chinh.su_kien_su_dung_nguon_tien','truy_cap.bien_nhan_xac_nhan_giao_dich','truy_cap.cap_vai_tro','truy_cap.dinh_danh_nguoi','truy_cap.phien_dang_nhap','truy_cap.quyen_thao_tac','truy_cap.tai_khoan_dang_nhap','truy_cap.uy_quyen','truy_cap.vai_tro_cong_viec')),
  "thoi_diem_bat_dau_hieu_luc" timestamptz,
  "thoi_diem_ket_thuc_hieu_luc" timestamptz,
  "gioi_han_so_luong_duoc_duyet" numeric(24,6),
  "gioi_han_so_tien_duoc_duyet" numeric(24,0),
  "thoi_diem_thu_hoi_quyen" timestamptz,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_nhan_vien_giao_uy_quyen" uuid,
  "ma_nhan_vien_nhan_uy_quyen" uuid,
  "ma_phien_ban_chung_tu" uuid,
  "ma_phe_duyet" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "truy_cap"."uy_quyen"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "truy_cap"."uy_quyen"."hanh_dong" IS 'Hành động: Hành động của ủy quyền, phục vụ ủy quyền giới hạn; được ghi bởi giám đốc / người có thẩm quyền theo hồ sơ nguồn của bảng. Giá trị cho phép: xem; tao; kiem_tra; phe_duyet; xac_nhan; nhan; xuat_du_lieu; huy; dieu_chinh; khoi_phuc; chot_ky; mo_lai_ky; danh_gia_dap_ung; quyet_dinh_uu_tien; chot_lenh.';
COMMENT ON COLUMN "truy_cap"."uy_quyen"."loai_doi_tuong_phan_quyen" IS 'Loại đối tượng phân quyền: Loại đối tượng phân quyền của ủy quyền, phục vụ ủy quyền giới hạn; được ghi bởi giám đốc / người có thẩm quyền theo hồ sơ nguồn của bảng. Giá trị cho phép: dung_chung.doanh_nghiep; dung_chung.bo_phan; dung_chung.vi_tri_giu_hang; dung_chung.don_vi_tinh; dung_chung.chung_tu; dung_chung.dong_chung_tu; dung_chung.lien_ket_chung_tu; dung_chung.de_nghi_va_quyet_dinh_phe_duyet; dung_chung.trao_doi_va_ban_giao; dung_chung.chung_cu_dinh_kem; dung_chung.nhat_ky_thao_tac; dung_chung.ky_nghiep_vu; dung_chung.phien_ban_chinh_sach; dung_chung.bo_du_lieu_mo_phong; truy_cap.tai_khoan_dang_nhap; truy_cap.vai_tro_cong_viec; truy_cap.quyen_thao_tac; truy_cap.cap_vai_tro; truy_cap.uy_quyen; truy_cap.bien_nhan_xac_nhan_giao_dich; danh_muc.mat_hang; danh_muc.mat_hang; danh_muc.ma_goi_khac; danh_muc.quy_doi_don_vi; dung_chung.doi_tac; dung_chung.lien_he_doi_tac; dung_chung.can_cu_dai_dien; kinh_doanh.nhu_cau_khach_hang; dung_chung.trao_doi_va_ban_giao; kinh_doanh.dong_tu_van_bao_gia_va_don_hang; kinh_doanh.bao_gia_va_don_hang; kinh_doanh.dong_tu_van_bao_gia_va_don_hang; kinh_doanh.mau_khach_duyet; kinh_doanh.ho_so_xu_ly; mua_hang.don_mua_hang; mua_hang.dong_don_mua_hang; kho.su_kien_giu_khoa_va_dang_ve; kho.lo_hang; kho.phan_lo_hang; dung_chung.chung_tu; kho.dong_van_dong_hang; kho.yeu_cau_hang_va_vat_tu; kho.su_kien_giu_khoa_va_dang_ve; dung_chung.chung_tu; kho.dong_kiem_ke; san_xuat.phien_ban_dinh_muc_san_xuat; san_xuat.dong_dinh_muc_vat_tu; san_xuat.nguon_luc_san_xuat; san_xuat.lenh_san_xuat; san_xuat.lo_san_xuat; san_xuat.cong_doan_san_xuat; san_xuat.lich_nguoi_va_nguon_luc; kho.dong_van_dong_hang; chat_luong.phieu_kiem_tra_chat_luong; chat_luong.ket_qua_tung_tieu_chi_kiem_tra; kho.su_kien_giu_khoa_va_dang_ve; kinh_doanh.ho_so_xu_ly; giao_hang.dot_giao_hang; giao_hang.dong_giao_va_nhan_hang; giao_hang.dong_giao_va_nhan_hang; tai_chinh.quy_va_tai_khoan_tien; tai_chinh.de_nghi_chi_tien; tai_chinh.bien_dong_tien_thuc; tai_chinh.nghia_vu_va_dieu_chinh; tai_chinh.nghia_vu_va_dieu_chinh; tai_chinh.su_kien_su_dung_nguon_tien; dung_chung.chung_tu; tai_chinh.dong_ghi_nhan_ban; tai_chinh.doi_chieu_nghia_vu_mua; tai_chinh.dong_doi_chieu_quy_ngan_hang; tai_chinh.nguon_chi_phi; tai_chinh.phan_bo_chi_phi; tai_chinh.can_cu_phan_bo_chi_phi; dung_chung.chung_tu; tai_chinh.bien_dong_gia_tri; nhan_su.nhan_vien; nhan_su.ho_so_lam_viec_theo_hieu_luc; nhan_su.ho_so_ky_nang_va_an_toan; dung_chung.trao_doi_va_ban_giao; nhan_su.ngay_va_ca_lam_viec; san_xuat.lich_nguoi_va_nguon_luc; dung_chung.chung_tu; nhan_su.khoang_cong_thuc_te; nhan_su.de_nghi_nghi; nhan_su.su_kien_phep; dung_chung.ky_nghiep_vu; nhan_su.thu_nhap_nhan_vien; nhan_su.khoan_thu_nhap_co_can_cu; truy_cap.phien_dang_nhap; tai_chinh.nguon_cua_ban_chot_gia_thanh; truy_cap.dinh_danh_nguoi.';
COMMENT ON COLUMN "truy_cap"."uy_quyen"."thoi_diem_bat_dau_hieu_luc" IS 'Thời điểm bắt đầu hiệu lực: Thời điểm bắt đầu hiệu lực của ủy quyền, phục vụ ủy quyền giới hạn; được ghi bởi giám đốc / người có thẩm quyền theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."uy_quyen"."thoi_diem_ket_thuc_hieu_luc" IS 'Thời điểm kết thúc hiệu lực: Thời điểm kết thúc hiệu lực của ủy quyền, phục vụ ủy quyền giới hạn; được ghi bởi giám đốc / người có thẩm quyền theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."uy_quyen"."gioi_han_so_luong_duoc_duyet" IS 'Giới hạn số lượng được duyệt: Giới hạn số lượng được duyệt của ủy quyền, phục vụ ủy quyền giới hạn; được ghi bởi giám đốc / người có thẩm quyền theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."uy_quyen"."gioi_han_so_tien_duoc_duyet" IS 'Giới hạn số tiền được duyệt: Giới hạn số tiền được duyệt của ủy quyền, phục vụ ủy quyền giới hạn; được ghi bởi giám đốc / người có thẩm quyền theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."uy_quyen"."thoi_diem_thu_hoi_quyen" IS 'Thời điểm thu hồi quyền: Thời điểm thu hồi quyền của ủy quyền, phục vụ ủy quyền giới hạn; được ghi bởi giám đốc / người có thẩm quyền theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."uy_quyen"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."uy_quyen"."ma_nhan_vien_giao_uy_quyen" IS 'Mã nhân viên giao ủy quyền: Mã nhân viên giao ủy quyền liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."uy_quyen"."ma_nhan_vien_nhan_uy_quyen" IS 'Mã nhân viên nhận ủy quyền: Mã nhân viên nhận ủy quyền liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."uy_quyen"."ma_phien_ban_chung_tu" IS 'Mã phiên bản chứng từ: Mã phiên bản chứng từ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."uy_quyen"."ma_phe_duyet" IS 'Mã phê duyệt: Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."uy_quyen"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "truy_cap"."uy_quyen"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."uy_quyen"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON TABLE "truy_cap"."uy_quyen" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "truy_cap"."bien_nhan_xac_nhan_giao_dich" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "khoa_chong_xac_nhan_lap" text,
  "hanh_dong" text CHECK ("hanh_dong" IN ('chot_ky','chot_lenh','danh_gia_dap_ung','dieu_chinh','huy','khoi_phuc','kiem_tra','mo_lai_ky','nhan','phe_duyet','quyet_dinh_uu_tien','tao','xac_nhan','xem','xuat_du_lieu')),
  "ban_bam_noi_dung_yeu_cau" text,
  "trang_thai_xu_ly" text CHECK ("trang_thai_xu_ly" IN ('da_ghi_toan_phan')),
  "thoi_diem_ghi_nhan_toan_phan" timestamptz,
  "cac_ma_ket_qua_da_ghi_nhan" jsonb,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_tai_khoan" uuid,
  "ma_phien_ban_chung_tu" uuid,
  "thoi_diem_he_thong_ghi_nhan" timestamptz,
  "ma_tai_khoan_thuc_hien" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "truy_cap"."bien_nhan_xac_nhan_giao_dich"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "truy_cap"."bien_nhan_xac_nhan_giao_dich"."khoa_chong_xac_nhan_lap" IS 'Khóa chống xác nhận lặp: Khóa chống xác nhận lặp của biên nhận xác nhận giao dịch, phục vụ chống ghi trùng và đối chiếu mất phản hồi; được ghi bởi hệ thống theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."bien_nhan_xac_nhan_giao_dich"."hanh_dong" IS 'Hành động: Hành động của biên nhận xác nhận giao dịch, phục vụ chống ghi trùng và đối chiếu mất phản hồi; được ghi bởi hệ thống theo hồ sơ nguồn của bảng. Giá trị cho phép: xem; tao; kiem_tra; phe_duyet; xac_nhan; nhan; xuat_du_lieu; huy; dieu_chinh; khoi_phuc; chot_ky; mo_lai_ky; danh_gia_dap_ung; quyet_dinh_uu_tien; chot_lenh.';
COMMENT ON COLUMN "truy_cap"."bien_nhan_xac_nhan_giao_dich"."ban_bam_noi_dung_yeu_cau" IS 'Bản băm nội dung yêu cầu: Bản băm nội dung yêu cầu của biên nhận xác nhận giao dịch, phục vụ chống ghi trùng và đối chiếu mất phản hồi; được ghi bởi hệ thống theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."bien_nhan_xac_nhan_giao_dich"."trang_thai_xu_ly" IS 'Trạng thái xử lý: Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: da_ghi_toan_phan.';
COMMENT ON COLUMN "truy_cap"."bien_nhan_xac_nhan_giao_dich"."thoi_diem_ghi_nhan_toan_phan" IS 'Thời điểm ghi nhận toàn phần: Thời điểm ghi nhận toàn phần của biên nhận xác nhận giao dịch, phục vụ chống ghi trùng và đối chiếu mất phản hồi; được ghi bởi hệ thống theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."bien_nhan_xac_nhan_giao_dich"."cac_ma_ket_qua_da_ghi_nhan" IS 'Các mã kết quả đã ghi nhận: Các mã kết quả đã ghi nhận của biên nhận xác nhận giao dịch, phục vụ chống ghi trùng và đối chiếu mất phản hồi; được ghi bởi hệ thống theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."bien_nhan_xac_nhan_giao_dich"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."bien_nhan_xac_nhan_giao_dich"."ma_tai_khoan" IS 'Mã tài khoản: Mã tài khoản liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."bien_nhan_xac_nhan_giao_dich"."ma_phien_ban_chung_tu" IS 'Mã phiên bản chứng từ: Mã phiên bản chứng từ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."bien_nhan_xac_nhan_giao_dich"."thoi_diem_he_thong_ghi_nhan" IS 'Thời điểm hệ thống ghi nhận: Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc.';
COMMENT ON COLUMN "truy_cap"."bien_nhan_xac_nhan_giao_dich"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "truy_cap"."bien_nhan_xac_nhan_giao_dich" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "danh_muc"."mat_hang" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_nghiep_vu" text,
  "ten" text,
  "nhom_san_pham" text CHECK ("nhom_san_pham" IN ('gach_terrazzo','ngoi','phu_kien')),
  "dang_su_dung" boolean,
  "ma_bo_du_lieu" uuid NOT NULL,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  "loai" text CHECK ("loai" IN ('bao_ho','thanh_pham','vat_tu')),
  "ma_mau" text,
  "ma_quy_cach" text,
  "chieu_rong_mi_li_met" numeric(24,8),
  "chieu_dai_mi_li_met" numeric(24,8),
  "so_vien_tren_met_vuong_theo_quy_cach" numeric(24,8),
  "bat_buoc_duyet_mau_rieng" boolean,
  "ma_nhom_mau" uuid,
  "ma_don_vi_co_so" uuid,
  "ma_phien_ban_quy_cach" uuid,
  "loai_mat_hang" text CHECK ("loai_mat_hang" IN ('bao_ho','bien_the','nhom_mau','vat_tu')),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "danh_muc"."mat_hang"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "danh_muc"."mat_hang"."ma_nghiep_vu" IS 'Mã nghiệp vụ: Mã nghiệp vụ của sản phẩm, phục vụ nhóm mẫu ngói/gạch terrazzo; được ghi bởi kinh doanh / sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "danh_muc"."mat_hang"."ten" IS 'Tên: Tên của sản phẩm, phục vụ nhóm mẫu ngói/gạch terrazzo; được ghi bởi kinh doanh / sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "danh_muc"."mat_hang"."nhom_san_pham" IS 'Nhóm sản phẩm: Nhóm sản phẩm của sản phẩm, phục vụ nhóm mẫu ngói/gạch terrazzo; được ghi bởi kinh doanh / sản xuất theo hồ sơ nguồn của bảng. Giá trị cho phép: ngoi; gach_terrazzo; phu_kien.';
COMMENT ON COLUMN "danh_muc"."mat_hang"."dang_su_dung" IS 'Đang sử dụng: Đang sử dụng của sản phẩm, phục vụ nhóm mẫu ngói/gạch terrazzo; được ghi bởi kinh doanh / sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "danh_muc"."mat_hang"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "danh_muc"."mat_hang"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "danh_muc"."mat_hang"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "danh_muc"."mat_hang"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON COLUMN "danh_muc"."mat_hang"."loai" IS 'Loại: Loại của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng. Giá trị cho phép: vat_tu; thanh_pham; bao_ho.';
COMMENT ON COLUMN "danh_muc"."mat_hang"."ma_mau" IS 'Mã màu: Mã màu của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "danh_muc"."mat_hang"."ma_quy_cach" IS 'Mã quy cách: Mã quy cách của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "danh_muc"."mat_hang"."chieu_rong_mi_li_met" IS 'Chiều rộng mi li mét: Chiều rộng mi li mét của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "danh_muc"."mat_hang"."chieu_dai_mi_li_met" IS 'Chiều dài mi li mét: Chiều dài mi li mét của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "danh_muc"."mat_hang"."so_vien_tren_met_vuong_theo_quy_cach" IS 'Số viên trên mét vuông theo quy cách: Số viên trên mét vuông theo quy cách của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "danh_muc"."mat_hang"."bat_buoc_duyet_mau_rieng" IS 'Bắt buộc duyệt mẫu riêng: Bắt buộc duyệt mẫu riêng của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "danh_muc"."mat_hang"."ma_nhom_mau" IS 'Mã sản phẩm: Mã sản phẩm liên kết danh_muc.mat_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "danh_muc"."mat_hang"."ma_don_vi_co_so" IS 'Mã đơn vị cơ sở: Mã đơn vị cơ sở liên kết dung_chung.don_vi_tinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "danh_muc"."mat_hang"."ma_phien_ban_quy_cach" IS 'Mã phiên bản quy cách: Mã phiên bản quy cách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "danh_muc"."mat_hang"."loai_mat_hang" IS 'Loại mặt hàng: Nhóm mẫu là dòng danh mục cha; vật tư/biến thể/bảo hộ mới là đối tượng giao dịch kho.';
CREATE UNIQUE INDEX ma_fa00137f651c8f4cea ON "danh_muc"."mat_hang" (ma_bo_du_lieu,ma_nghiep_vu);
COMMENT ON TABLE "danh_muc"."mat_hang" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "danh_muc"."ma_goi_khac" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_goi_khac" text,
  "chung_cu" text,
  "thoi_diem_bat_dau_hieu_luc" date,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_mat_hang" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "danh_muc"."ma_goi_khac"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "danh_muc"."ma_goi_khac"."ma_goi_khac" IS 'Mã gọi khác: Mã gọi khác của mã gọi khác, phục vụ mã trang mạng/cũ trỏ mã chuẩn; được ghi bởi kinh doanh / kho theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "danh_muc"."ma_goi_khac"."chung_cu" IS 'Chứng cứ: Chứng cứ của mã gọi khác, phục vụ mã trang mạng/cũ trỏ mã chuẩn; được ghi bởi kinh doanh / kho theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "danh_muc"."ma_goi_khac"."thoi_diem_bat_dau_hieu_luc" IS 'Thời điểm bắt đầu hiệu lực: Thời điểm bắt đầu hiệu lực của mã gọi khác, phục vụ mã trang mạng/cũ trỏ mã chuẩn; được ghi bởi kinh doanh / kho theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "danh_muc"."ma_goi_khac"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "danh_muc"."ma_goi_khac"."ma_mat_hang" IS 'Mã sản phẩm: Mã sản phẩm liên kết danh_muc.mat_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "danh_muc"."ma_goi_khac"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "danh_muc"."ma_goi_khac"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "danh_muc"."ma_goi_khac"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON TABLE "danh_muc"."ma_goi_khac" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "danh_muc"."quy_doi_don_vi" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "so_phien_ban" bigint,
  "he_so" numeric(24,8),
  "thoi_diem_bat_dau_hieu_luc" date,
  "thoi_diem_ket_thuc_hieu_luc" date,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_mat_hang" uuid,
  "ma_don_vi_quy_doi_nguon" uuid,
  "ma_don_vi_quy_doi_dich" uuid,
  "ma_phe_duyet" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "danh_muc"."quy_doi_don_vi"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "danh_muc"."quy_doi_don_vi"."so_phien_ban" IS 'Số phiên bản: Số phiên bản của quy đổi đơn vị, phục vụ quy đổi đóng gói theo hàng, có bản; được ghi bởi kho / mua hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "danh_muc"."quy_doi_don_vi"."he_so" IS 'Hệ số: Hệ số của quy đổi đơn vị, phục vụ quy đổi đóng gói theo hàng, có bản; được ghi bởi kho / mua hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "danh_muc"."quy_doi_don_vi"."thoi_diem_bat_dau_hieu_luc" IS 'Thời điểm bắt đầu hiệu lực: Thời điểm bắt đầu hiệu lực của quy đổi đơn vị, phục vụ quy đổi đóng gói theo hàng, có bản; được ghi bởi kho / mua hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "danh_muc"."quy_doi_don_vi"."thoi_diem_ket_thuc_hieu_luc" IS 'Thời điểm kết thúc hiệu lực: Thời điểm kết thúc hiệu lực của quy đổi đơn vị, phục vụ quy đổi đóng gói theo hàng, có bản; được ghi bởi kho / mua hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "danh_muc"."quy_doi_don_vi"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "danh_muc"."quy_doi_don_vi"."ma_mat_hang" IS 'Mã mặt hàng: Mã mặt hàng liên kết danh_muc.mat_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "danh_muc"."quy_doi_don_vi"."ma_don_vi_quy_doi_nguon" IS 'Mã đơn vị quy đổi nguồn: Mã đơn vị quy đổi nguồn liên kết dung_chung.don_vi_tinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "danh_muc"."quy_doi_don_vi"."ma_don_vi_quy_doi_dich" IS 'Mã đơn vị quy đổi đích: Mã đơn vị quy đổi đích liên kết dung_chung.don_vi_tinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "danh_muc"."quy_doi_don_vi"."ma_phe_duyet" IS 'Mã phê duyệt: Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "danh_muc"."quy_doi_don_vi"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "danh_muc"."quy_doi_don_vi"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "danh_muc"."quy_doi_don_vi"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON TABLE "danh_muc"."quy_doi_don_vi" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "dung_chung"."doi_tac" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_nghiep_vu" text,
  "ten" text,
  "cac_vai_tro" text CHECK ("cac_vai_tro" IN ('ben_nhan_hang','ben_tra_tien','ben_van_chuyen','khach_hang','nha_cung_cap')),
  "nhom_khach_hang" text CHECK ("nhom_khach_hang" IN ('chu_cong_trinh','dai_ly','khach_le','nha_thau','xuat_khau')),
  "dang_su_dung" boolean,
  "ma_bo_du_lieu" uuid NOT NULL,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "dung_chung"."doi_tac"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "dung_chung"."doi_tac"."ma_nghiep_vu" IS 'Mã nghiệp vụ: Mã nghiệp vụ của đối tác, phục vụ một đối tác dùng chung mua/bán/trả/nhận; được ghi bởi kinh doanh / mua hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."doi_tac"."ten" IS 'Tên: Tên của đối tác, phục vụ một đối tác dùng chung mua/bán/trả/nhận; được ghi bởi kinh doanh / mua hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."doi_tac"."cac_vai_tro" IS 'Các vai trò: Các vai trò của đối tác, phục vụ một đối tác dùng chung mua/bán/trả/nhận; được ghi bởi kinh doanh / mua hàng theo hồ sơ nguồn của bảng. Giá trị cho phép: khach_hang; nha_cung_cap; ben_tra_tien; ben_nhan_hang; ben_van_chuyen.';
COMMENT ON COLUMN "dung_chung"."doi_tac"."nhom_khach_hang" IS 'Nhóm khách hàng: Nhóm khách hàng của đối tác, phục vụ một đối tác dùng chung mua/bán/trả/nhận; được ghi bởi kinh doanh / mua hàng theo hồ sơ nguồn của bảng. Giá trị cho phép: dai_ly; nha_thau; chu_cong_trinh; khach_le; xuat_khau.';
COMMENT ON COLUMN "dung_chung"."doi_tac"."dang_su_dung" IS 'Đang sử dụng: Đang sử dụng của đối tác, phục vụ một đối tác dùng chung mua/bán/trả/nhận; được ghi bởi kinh doanh / mua hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."doi_tac"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."doi_tac"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "dung_chung"."doi_tac"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."doi_tac"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
CREATE UNIQUE INDEX ma_6fff0ce4fb9859f122 ON "dung_chung"."doi_tac" (ma_bo_du_lieu,ma_nghiep_vu);
COMMENT ON TABLE "dung_chung"."doi_tac" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "dung_chung"."lien_he_doi_tac" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ten" text,
  "kenh_lien_he" text,
  "dia_chi" text,
  "dang_su_dung" boolean,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_doi_tac" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "dung_chung"."lien_he_doi_tac"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "dung_chung"."lien_he_doi_tac"."ten" IS 'Tên: Tên của liên hệ đối tác, phục vụ người liên hệ và địa điểm; được ghi bởi bộ phận phụ trách đối tác theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."lien_he_doi_tac"."kenh_lien_he" IS 'Kênh liên hệ: Kênh liên hệ của liên hệ đối tác, phục vụ người liên hệ và địa điểm; được ghi bởi bộ phận phụ trách đối tác theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."lien_he_doi_tac"."dia_chi" IS 'Địa chỉ: Địa chỉ của liên hệ đối tác, phục vụ người liên hệ và địa điểm; được ghi bởi bộ phận phụ trách đối tác theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."lien_he_doi_tac"."dang_su_dung" IS 'Đang sử dụng: Đang sử dụng của liên hệ đối tác, phục vụ người liên hệ và địa điểm; được ghi bởi bộ phận phụ trách đối tác theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."lien_he_doi_tac"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."lien_he_doi_tac"."ma_doi_tac" IS 'Mã đối tác: Mã đối tác liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."lien_he_doi_tac"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "dung_chung"."lien_he_doi_tac"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."lien_he_doi_tac"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON TABLE "dung_chung"."lien_he_doi_tac" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "dung_chung"."can_cu_dai_dien" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "hanh_dong" text CHECK ("hanh_dong" IN ('doi_don','duyet_mau','nhan','tra_thay','xac_nhan_don')),
  "thoi_diem_bat_dau_hieu_luc" timestamptz,
  "thoi_diem_ket_thuc_hieu_luc" timestamptz,
  "ma_chung_tu_lam_can_cu" uuid,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_doi_tac" uuid,
  "ma_lien_he" uuid,
  "ma_chung_tu_xac_dinh_pham_vi" uuid,
  "ma_doi_tac_dai_dien" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "dung_chung"."can_cu_dai_dien"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "dung_chung"."can_cu_dai_dien"."hanh_dong" IS 'Hành động: Hành động của căn cứ đại diện, phục vụ căn cứ đại diện hoặc trả thay; được ghi bởi kinh doanh / tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: xac_nhan_don; duyet_mau; doi_don; tra_thay; nhan.';
COMMENT ON COLUMN "dung_chung"."can_cu_dai_dien"."thoi_diem_bat_dau_hieu_luc" IS 'Thời điểm bắt đầu hiệu lực: Thời điểm bắt đầu hiệu lực của căn cứ đại diện, phục vụ căn cứ đại diện hoặc trả thay; được ghi bởi kinh doanh / tài chính theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."can_cu_dai_dien"."thoi_diem_ket_thuc_hieu_luc" IS 'Thời điểm kết thúc hiệu lực: Thời điểm kết thúc hiệu lực của căn cứ đại diện, phục vụ căn cứ đại diện hoặc trả thay; được ghi bởi kinh doanh / tài chính theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "dung_chung"."can_cu_dai_dien"."ma_chung_tu_lam_can_cu" IS 'Mã chứng từ làm căn cứ: Mã chứng từ làm căn cứ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."can_cu_dai_dien"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."can_cu_dai_dien"."ma_doi_tac" IS 'Mã đối tác: Mã đối tác liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."can_cu_dai_dien"."ma_lien_he" IS 'Mã liên hệ: Mã liên hệ liên kết dung_chung.lien_he_doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."can_cu_dai_dien"."ma_chung_tu_xac_dinh_pham_vi" IS 'Mã chứng từ xác định phạm vi: Mã chứng từ xác định phạm vi liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."can_cu_dai_dien"."ma_doi_tac_dai_dien" IS 'Mã đối tác đại diện: Mã đối tác đại diện liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."can_cu_dai_dien"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "dung_chung"."can_cu_dai_dien"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "dung_chung"."can_cu_dai_dien"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON TABLE "dung_chung"."can_cu_dai_dien" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "kinh_doanh"."nhu_cau_khach_hang" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "trang_thai_thuc_hien" text CHECK ("trang_thai_thuc_hien" IN ('da_bao_gia','da_chot','da_chuyen_thanh_don','dang_lam_ro','dang_mo')),
  "ghi_chu_cong_trinh" text,
  "tinh_trang_dieu_kien_xuat_khau" text CHECK ("tinh_trang_dieu_kien_xuat_khau" IN ('cho_xu_ly','da_xac_dinh','khong_ap_dung')),
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_khach_hang" uuid,
  "ma_lien_he" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "kinh_doanh"."nhu_cau_khach_hang"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."nhu_cau_khach_hang"."trang_thai_thuc_hien" IS 'Trạng thái thực hiện: Trạng thái của sự kiện do người phụ trách xác nhận; không tự nạp đã hoàn tất. Trạng thái tổng hợp từ nhiều sự kiện chỉ tính khi xem. Giá trị cho phép: dang_mo; dang_lam_ro; da_bao_gia; da_chuyen_thanh_don; da_chot.';
COMMENT ON COLUMN "kinh_doanh"."nhu_cau_khach_hang"."ghi_chu_cong_trinh" IS 'Ghi chú công trình: Ghi chú công trình của nhu cầu khách hàng, phục vụ một nhu cầu, nhiều lần liên hệ; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."nhu_cau_khach_hang"."tinh_trang_dieu_kien_xuat_khau" IS 'Tình trạng điều kiện xuất khẩu: Tình trạng điều kiện xuất khẩu của nhu cầu khách hàng, phục vụ một nhu cầu, nhiều lần liên hệ; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. Giá trị cho phép: khong_ap_dung; cho_xu_ly; da_xac_dinh.';
COMMENT ON COLUMN "kinh_doanh"."nhu_cau_khach_hang"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."nhu_cau_khach_hang"."ma_khach_hang" IS 'Mã khách hàng: Mã khách hàng liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."nhu_cau_khach_hang"."ma_lien_he" IS 'Mã liên hệ: Mã liên hệ liên kết dung_chung.lien_he_doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "kinh_doanh"."nhu_cau_khach_hang" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "kinh_doanh"."bao_gia_va_don_hang" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "loai" text CHECK ("loai" IN ('bao_gia','don_hang')),
  "thoi_diem_het_hieu_luc" timestamptz,
  "thoi_diem_xac_nhan" timestamptz,
  "so_tien_dat_coc_yeu_cau" numeric(24,0),
  "dieu_kien_thanh_toan" text,
  "dieu_kien_giao_hang" text,
  "pham_vi_mo_phong_thue" text CHECK ("pham_vi_mo_phong_thue" IN ('chua_mo_phong')),
  "can_cu_khach_xac_nhan" text,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_chung_tu_nhu_cau_khach" uuid,
  "ma_ben_mua" uuid,
  "ma_ben_tra_tien" uuid,
  "ma_ben_nhan" uuid,
  "ma_can_cu_dai_dien" uuid,
  "ma_phien_ban_chinh_sach_gia" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "kinh_doanh"."bao_gia_va_don_hang"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."bao_gia_va_don_hang"."loai" IS 'Loại: Loại của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. Giá trị cho phép: bao_gia; don_hang.';
COMMENT ON COLUMN "kinh_doanh"."bao_gia_va_don_hang"."thoi_diem_het_hieu_luc" IS 'Thời điểm hết hiệu lực: Thời điểm hết hiệu lực của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."bao_gia_va_don_hang"."thoi_diem_xac_nhan" IS 'Thời điểm xác nhận: Thời điểm xác nhận của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."bao_gia_va_don_hang"."so_tien_dat_coc_yeu_cau" IS 'Số tiền đặt cọc yêu cầu: Số tiền đặt cọc yêu cầu của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."bao_gia_va_don_hang"."dieu_kien_thanh_toan" IS 'Điều kiện thanh toán: Điều kiện thanh toán của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."bao_gia_va_don_hang"."dieu_kien_giao_hang" IS 'Điều kiện giao hàng: Điều kiện giao hàng của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."bao_gia_va_don_hang"."pham_vi_mo_phong_thue" IS 'Phạm vi mô phỏng thuế: Phạm vi mô phỏng thuế của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. Giá trị cho phép: chua_mo_phong.';
COMMENT ON COLUMN "kinh_doanh"."bao_gia_va_don_hang"."can_cu_khach_xac_nhan" IS 'Căn cứ khách xác nhận: Căn cứ khách xác nhận của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."bao_gia_va_don_hang"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."bao_gia_va_don_hang"."ma_chung_tu_nhu_cau_khach" IS 'Mã chứng từ nhu cầu khách: Mã chứng từ nhu cầu khách liên kết kinh_doanh.nhu_cau_khach_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."bao_gia_va_don_hang"."ma_ben_mua" IS 'Mã bên mua: Mã bên mua liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."bao_gia_va_don_hang"."ma_ben_tra_tien" IS 'Mã bên trả tiền: Mã bên trả tiền liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."bao_gia_va_don_hang"."ma_ben_nhan" IS 'Mã bên nhận: Mã bên nhận liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."bao_gia_va_don_hang"."ma_can_cu_dai_dien" IS 'Mã căn cứ đại diện: Mã căn cứ đại diện liên kết dung_chung.can_cu_dai_dien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."bao_gia_va_don_hang"."ma_phien_ban_chinh_sach_gia" IS 'Mã phiên bản chính sách giá: Mã phiên bản chính sách giá liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "kinh_doanh"."bao_gia_va_don_hang" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "dien_tich_met_vuong" numeric(24,8),
  "so_vien_tren_met_vuong_theo_quy_cach" numeric(24,8),
  "ty_le_du_phong_tu_van" numeric(12,10) CHECK ("ty_le_du_phong_tu_van" BETWEEN 0 AND 1),
  "tinh_trang_khach_chot_luong" text CHECK ("tinh_trang_khach_chot_luong" IN ('khach_da_xac_nhan','uoc_tinh')),
  "can_cu_khach_xac_nhan" text,
  "so_vien_khach_xac_nhan" numeric(24,6),
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_chung_tu_nhu_cau_khach" uuid,
  "ma_mat_hang" uuid,
  "ma_phien_ban_chinh_sach" uuid,
  "so_vien_thoa_thuan" numeric(24,6),
  "don_gia_niem_yet_tham_chieu" numeric(24,8),
  "loai_chiet_khau" text CHECK ("loai_chiet_khau" IN ('khong_ap_dung','so_tien','ty_le')),
  "gia_tri_chiet_khau" numeric(24,8),
  "don_gia_thoa_thuan" numeric(24,8),
  "so_tien_thoa_thuan" numeric(24,0),
  "ngay_giao_khach_yeu_cau" date,
  "muc_dich_dong_hang" text CHECK ("muc_dich_dong_hang" IN ('ghi_ban','giao_bu')),
  "quy_cach_ky_thuat_ban_luu_tai_thoi_diem" jsonb,
  "ma_chung_tu_don_hang" uuid,
  "ma_chung_tu_mau_khach_da_duyet" uuid,
  "ma_ho_so_giao_bu" uuid,
  "giai_doan_dong" text CHECK ("giai_doan_dong" IN ('bao_gia','don_hang','tu_van')),
  "ma_dong_tu_van_goc" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."dien_tich_met_vuong" IS 'Diện tích mét vuông: Diện tích mét vuông của thông số tư vấn, phục vụ tư vấn số viên từ diện tích; được ghi bởi kinh doanh / sản xuất kiểm theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."so_vien_tren_met_vuong_theo_quy_cach" IS 'Số viên trên mét vuông theo quy cách: Số viên trên mét vuông theo quy cách của thông số tư vấn, phục vụ tư vấn số viên từ diện tích; được ghi bởi kinh doanh / sản xuất kiểm theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."ty_le_du_phong_tu_van" IS 'Tỷ lệ dự phòng tư vấn: Tỷ lệ dự phòng tư vấn của thông số tư vấn, phục vụ tư vấn số viên từ diện tích; được ghi bởi kinh doanh / sản xuất kiểm theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."tinh_trang_khach_chot_luong" IS 'Trạng thái xử lý: Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: uoc_tinh; khach_da_xac_nhan.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."can_cu_khach_xac_nhan" IS 'Căn cứ khách xác nhận: Căn cứ khách xác nhận của thông số tư vấn, phục vụ tư vấn số viên từ diện tích; được ghi bởi kinh doanh / sản xuất kiểm theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."so_vien_khach_xac_nhan" IS 'Số viên khách xác nhận: Số viên được khách xác nhận trong căn cứ riêng; nếu chưa xác nhận để trống, số viên ước tính chỉ là kết quả tính khi xem.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."ma_chung_tu_nhu_cau_khach" IS 'Mã chứng từ nhu cầu khách: Mã chứng từ nhu cầu khách liên kết kinh_doanh.nhu_cau_khach_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."ma_mat_hang" IS 'Mã mặt hàng: Mã mặt hàng liên kết danh_muc.mat_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."ma_phien_ban_chinh_sach" IS 'Mã phiên bản chính sách: Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."so_vien_thoa_thuan" IS 'Số viên thỏa thuận: Số viên thỏa thuận của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."don_gia_niem_yet_tham_chieu" IS 'Đơn giá niêm yết tham chiếu: Đơn giá niêm yết tham chiếu của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."loai_chiet_khau" IS 'Loại chiết khấu: Loại chiết khấu của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. Giá trị cho phép: khong_ap_dung; ty_le; so_tien.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."gia_tri_chiet_khau" IS 'Giá trị chiết khấu: Giá trị chiết khấu của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."don_gia_thoa_thuan" IS 'Đơn giá thỏa thuận: Đơn giá thỏa thuận của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."so_tien_thoa_thuan" IS 'Số tiền thỏa thuận: Số tiền thỏa thuận của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."ngay_giao_khach_yeu_cau" IS 'Ngày giao khách yêu cầu: Ngày giao khách yêu cầu của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."muc_dich_dong_hang" IS 'Mục đích dòng hàng: Mục đích dòng hàng của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. Giá trị cho phép: ghi_ban; giao_bu.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."quy_cach_ky_thuat_ban_luu_tai_thoi_diem" IS 'Quy cách kỹ thuật bản lưu tại thời điểm: Quy cách kỹ thuật bản lưu tại thời điểm của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."ma_chung_tu_don_hang" IS 'Mã chứng từ đơn hàng: Mã chứng từ đơn hàng liên kết kinh_doanh.bao_gia_va_don_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."ma_chung_tu_mau_khach_da_duyet" IS 'Mã chứng từ mẫu khách đã duyệt: Mã chứng từ mẫu khách đã duyệt liên kết kinh_doanh.mau_khach_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."ma_ho_so_giao_bu" IS 'Mã hồ sơ giao bù: Mã hồ sơ giao bù liên kết kinh_doanh.ho_so_xu_ly đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."giai_doan_dong" IS 'Giai đoạn dòng thương mại: Dòng tư vấn thuộc nhu cầu; dòng báo giá/đơn thuộc chứng từ tương ứng. Chuyển bước tạo bản/dòng mới liên kết gốc, không sửa lịch sử.';
COMMENT ON COLUMN "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang"."ma_dong_tu_van_goc" IS 'Mã dòng tư vấn gốc: Mã dòng tư vấn gốc liên kết kinh_doanh.dong_tu_van_bao_gia_va_don_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "kinh_doanh"."mau_khach_duyet" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "so_luong_mau_rieng" numeric(24,6),
  "quyet_dinh_cua_khach" text CHECK ("quyet_dinh_cua_khach" IN ('cho_xu_ly','da_duyet','da_tu_choi')),
  "thoi_diem_quyet_dinh" timestamptz,
  "chung_cu" text,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_dong_don_hang" uuid,
  "ma_lenh_san_xuat_mau" uuid,
  "ma_phieu_kiem_chat_luong" uuid,
  "ma_can_cu_dai_dien_khach" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "kinh_doanh"."mau_khach_duyet"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."mau_khach_duyet"."so_luong_mau_rieng" IS 'Số lượng mẫu riêng: Số lượng mẫu riêng của mẫu khách duyệt, phục vụ mẫu riêng và khách duyệt đúng bản; được ghi bởi kinh doanh cùng sản xuất/kiểm chất lượng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."mau_khach_duyet"."quyet_dinh_cua_khach" IS 'Quyết định của khách: Quyết định của khách của mẫu khách duyệt, phục vụ mẫu riêng và khách duyệt đúng bản; được ghi bởi kinh doanh cùng sản xuất/kiểm chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: cho_xu_ly; da_duyet; da_tu_choi.';
COMMENT ON COLUMN "kinh_doanh"."mau_khach_duyet"."thoi_diem_quyet_dinh" IS 'Thời điểm quyết định: Thời điểm quyết định của mẫu khách duyệt, phục vụ mẫu riêng và khách duyệt đúng bản; được ghi bởi kinh doanh cùng sản xuất/kiểm chất lượng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."mau_khach_duyet"."chung_cu" IS 'Chứng cứ: Chứng cứ của mẫu khách duyệt, phục vụ mẫu riêng và khách duyệt đúng bản; được ghi bởi kinh doanh cùng sản xuất/kiểm chất lượng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."mau_khach_duyet"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."mau_khach_duyet"."ma_dong_don_hang" IS 'Mã dòng đơn hàng: Mã dòng đơn hàng liên kết kinh_doanh.dong_tu_van_bao_gia_va_don_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."mau_khach_duyet"."ma_lenh_san_xuat_mau" IS 'Mã lệnh sản xuất mẫu: Mã lệnh sản xuất mẫu liên kết san_xuat.lenh_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."mau_khach_duyet"."ma_phieu_kiem_chat_luong" IS 'Mã phiếu kiểm chất lượng: Mã phiếu kiểm chất lượng liên kết chat_luong.phieu_kiem_tra_chat_luong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."mau_khach_duyet"."ma_can_cu_dai_dien_khach" IS 'Mã căn cứ đại diện khách: Mã căn cứ đại diện khách liên kết dung_chung.can_cu_dai_dien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "kinh_doanh"."mau_khach_duyet" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "kinh_doanh"."ho_so_xu_ly" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "loai" text CHECK ("loai" IN ('huy','khieu_nai','thay_doi','thu_hoi','tra_hang')),
  "so_luong_bi_anh_huong" numeric(24,6),
  "phuong_an_xu_ly" text CHECK ("phuong_an_xu_ly" IN ('cho_xu_ly','giam_ban','giao_bu','hoan_tien','huy','loi','tai_xu_ly')),
  "so_luong_da_bat_dau_tai_luc_danh_gia" numeric(24,6),
  "can_cu_khach_xac_nhan" text,
  "ghi_chu_giai_quyet_thuong_mai" text,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_dong_don_hang_goc" uuid,
  "ma_dong_don_hang_moi" uuid,
  "ma_dong_ghi_ban_goc" uuid,
  "ma_phe_duyet" uuid,
  "hanh_dong_xu_ly_chat_luong" text CHECK ("hanh_dong_xu_ly_chat_luong" IN ('ha_loai','tai_xu_ly','thu_hoi','tieu_huy','tra_nha_cung_cap')),
  "so_luong_duoc_duyet_xu_ly" numeric(24,6),
  "ghi_chu_phuong_an_xu_ly" text,
  "ma_phieu_kiem_chat_luong" uuid,
  "ma_phan_lo_xu_ly" uuid,
  "ma_ho_so_lien_quan" uuid,
  "loai_ho_so_xu_ly" text CHECK ("loai_ho_so_xu_ly" IN ('chat_luong','thuong_mai')),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "kinh_doanh"."ho_so_xu_ly"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."ho_so_xu_ly"."loai" IS 'Loại: Loại của hồ sơ thay đổi và xử lý thương mại, phục vụ đổi/hủy, phản ánh, trả/thu hồi và phương án thương mại; được ghi bởi kinh doanh giữ việc theo hồ sơ nguồn của bảng. Giá trị cho phép: thay_doi; huy; tra_hang; khieu_nai; thu_hoi.';
COMMENT ON COLUMN "kinh_doanh"."ho_so_xu_ly"."so_luong_bi_anh_huong" IS 'Số lượng bị ảnh hưởng: Số lượng bị ảnh hưởng của hồ sơ thay đổi và xử lý thương mại, phục vụ đổi/hủy, phản ánh, trả/thu hồi và phương án thương mại; được ghi bởi kinh doanh giữ việc theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."ho_so_xu_ly"."phuong_an_xu_ly" IS 'Phương án xử lý: Phương án xử lý của hồ sơ thay đổi và xử lý thương mại, phục vụ đổi/hủy, phản ánh, trả/thu hồi và phương án thương mại; được ghi bởi kinh doanh giữ việc theo hồ sơ nguồn của bảng. Giá trị cho phép: cho_xu_ly; giam_ban; hoan_tien; giao_bu; tai_xu_ly; huy; loi.';
COMMENT ON COLUMN "kinh_doanh"."ho_so_xu_ly"."so_luong_da_bat_dau_tai_luc_danh_gia" IS 'Số lượng đã bắt đầu tại lúc đánh giá: Số lượng đã bắt đầu tại lúc đánh giá của hồ sơ thay đổi và xử lý thương mại, phục vụ đổi/hủy, phản ánh, trả/thu hồi và phương án thương mại; được ghi bởi kinh doanh giữ việc theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."ho_so_xu_ly"."can_cu_khach_xac_nhan" IS 'Căn cứ khách xác nhận: Căn cứ khách xác nhận của hồ sơ thay đổi và xử lý thương mại, phục vụ đổi/hủy, phản ánh, trả/thu hồi và phương án thương mại; được ghi bởi kinh doanh giữ việc theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."ho_so_xu_ly"."ghi_chu_giai_quyet_thuong_mai" IS 'Ghi chú giải quyết thương mại: Ghi chú giải quyết thương mại của hồ sơ thay đổi và xử lý thương mại, phục vụ đổi/hủy, phản ánh, trả/thu hồi và phương án thương mại; được ghi bởi kinh doanh giữ việc theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."ho_so_xu_ly"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."ho_so_xu_ly"."ma_dong_don_hang_goc" IS 'Mã dòng đơn hàng gốc: Mã dòng đơn hàng gốc liên kết kinh_doanh.dong_tu_van_bao_gia_va_don_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."ho_so_xu_ly"."ma_dong_don_hang_moi" IS 'Mã dòng đơn hàng mới: Mã dòng đơn hàng mới liên kết kinh_doanh.dong_tu_van_bao_gia_va_don_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."ho_so_xu_ly"."ma_dong_ghi_ban_goc" IS 'Mã dòng ghi bán gốc: Mã dòng ghi bán gốc liên kết tai_chinh.dong_ghi_nhan_ban đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."ho_so_xu_ly"."ma_phe_duyet" IS 'Mã phê duyệt: Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."ho_so_xu_ly"."hanh_dong_xu_ly_chat_luong" IS 'Hành động: Hành động của phương án xử lý chất lượng, phục vụ phương án lỗi, làm lại, loại bỏ, thu hồi; được ghi bởi quản lý đề nghị / giám đốc duyệt / thực hiện theo hồ sơ nguồn của bảng. Giá trị cho phép: tai_xu_ly; tieu_huy; tra_nha_cung_cap; thu_hoi; ha_loai.';
COMMENT ON COLUMN "kinh_doanh"."ho_so_xu_ly"."so_luong_duoc_duyet_xu_ly" IS 'Số lượng được duyệt xử lý: Số lượng được duyệt xử lý của phương án xử lý chất lượng, phục vụ phương án lỗi, làm lại, loại bỏ, thu hồi; được ghi bởi quản lý đề nghị / giám đốc duyệt / thực hiện theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."ho_so_xu_ly"."ghi_chu_phuong_an_xu_ly" IS 'Ghi chú phương án xử lý: Ghi chú phương án xử lý của phương án xử lý chất lượng, phục vụ phương án lỗi, làm lại, loại bỏ, thu hồi; được ghi bởi quản lý đề nghị / giám đốc duyệt / thực hiện theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kinh_doanh"."ho_so_xu_ly"."ma_phieu_kiem_chat_luong" IS 'Mã phiếu kiểm chất lượng: Mã phiếu kiểm chất lượng liên kết chat_luong.phieu_kiem_tra_chat_luong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."ho_so_xu_ly"."ma_phan_lo_xu_ly" IS 'Mã phần lô: Mã phần lô liên kết kho.phan_lo_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."ho_so_xu_ly"."ma_ho_so_lien_quan" IS 'Mã hồ sơ xử lý thương mại: Mã hồ sơ xử lý thương mại liên kết kinh_doanh.ho_so_xu_ly đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kinh_doanh"."ho_so_xu_ly"."loai_ho_so_xu_ly" IS 'Loại hồ sơ xử lý: Phân biệt phương án chất lượng nội bộ với thương mại; một vụ việc có thể có hai hồ sơ liên kết, không dùng duyệt QC thay duyệt tiền.';
COMMENT ON TABLE "kinh_doanh"."ho_so_xu_ly" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "mua_hang"."don_mua_hang" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_chung_tu_nha_cung_cap" text,
  "ngay_cam_ket" date,
  "dieu_kien_thanh_toan" text,
  "ghi_chu_doi_chieu_nguon_cung" text,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_nha_cung_cap" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "mua_hang"."don_mua_hang"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "mua_hang"."don_mua_hang"."ma_chung_tu_nha_cung_cap" IS 'Mã chứng từ nhà cung cấp: Mã chứng từ nhà cung cấp của đơn mua hàng, phục vụ đặt mua theo nhu cầu đã duyệt; được ghi bởi mua hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "mua_hang"."don_mua_hang"."ngay_cam_ket" IS 'Ngày cam kết: Ngày cam kết của đơn mua hàng, phục vụ đặt mua theo nhu cầu đã duyệt; được ghi bởi mua hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "mua_hang"."don_mua_hang"."dieu_kien_thanh_toan" IS 'Điều kiện thanh toán: Điều kiện thanh toán của đơn mua hàng, phục vụ đặt mua theo nhu cầu đã duyệt; được ghi bởi mua hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "mua_hang"."don_mua_hang"."ghi_chu_doi_chieu_nguon_cung" IS 'Ghi chú đối chiếu nguồn cung: Ghi chú đối chiếu nguồn cung của đơn mua hàng, phục vụ đặt mua theo nhu cầu đã duyệt; được ghi bởi mua hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "mua_hang"."don_mua_hang"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "mua_hang"."don_mua_hang"."ma_nha_cung_cap" IS 'Mã nhà cung cấp: Mã nhà cung cấp liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "mua_hang"."don_mua_hang" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "mua_hang"."dong_don_mua_hang" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "so_luong_theo_don_vi_nhap" numeric(24,6),
  "don_gia_mua" numeric(24,8),
  "so_tien_thoa_thuan" numeric(24,0),
  "ngay_cam_ket" date,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_chung_tu_don_hang" uuid,
  "ma_mat_hang" uuid,
  "ma_don_vi_nhap" uuid,
  "ma_quy_doi" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "mua_hang"."dong_don_mua_hang"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "mua_hang"."dong_don_mua_hang"."so_luong_theo_don_vi_nhap" IS 'Số lượng theo đơn vị nhập: Số lượng theo đơn vị nhập của dòng đơn mua hàng, phục vụ lượng đặt, giá và đơn vị mua; được ghi bởi mua hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "mua_hang"."dong_don_mua_hang"."don_gia_mua" IS 'Đơn giá mua: Đơn giá mua của dòng đơn mua hàng, phục vụ lượng đặt, giá và đơn vị mua; được ghi bởi mua hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "mua_hang"."dong_don_mua_hang"."so_tien_thoa_thuan" IS 'Số tiền thỏa thuận: Số tiền thỏa thuận của dòng đơn mua hàng, phục vụ lượng đặt, giá và đơn vị mua; được ghi bởi mua hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "mua_hang"."dong_don_mua_hang"."ngay_cam_ket" IS 'Ngày cam kết: Ngày cam kết của dòng đơn mua hàng, phục vụ lượng đặt, giá và đơn vị mua; được ghi bởi mua hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "mua_hang"."dong_don_mua_hang"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "mua_hang"."dong_don_mua_hang"."ma_chung_tu_don_hang" IS 'Mã chứng từ đơn hàng: Mã chứng từ đơn hàng liên kết mua_hang.don_mua_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "mua_hang"."dong_don_mua_hang"."ma_mat_hang" IS 'Mã mặt hàng: Mã mặt hàng liên kết danh_muc.mat_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "mua_hang"."dong_don_mua_hang"."ma_don_vi_nhap" IS 'Mã đơn vị nhập: Mã đơn vị nhập liên kết dung_chung.don_vi_tinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "mua_hang"."dong_don_mua_hang"."ma_quy_doi" IS 'Mã quy đổi: Mã quy đổi liên kết danh_muc.quy_doi_don_vi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "mua_hang"."dong_don_mua_hang" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "kho"."lo_hang" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_nghiep_vu" text,
  "ma_lo_nha_cung_cap" text,
  "ngay_san_xuat" date,
  "ngay_het_han" date,
  "loai_nguon_hinh_thanh_lo" text CHECK ("loai_nguon_hinh_thanh_lo" IN ('chua_ro','dau_ky','mua_hang','san_xuat')),
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_mat_hang" uuid,
  "ma_chung_tu_hinh_thanh_lo" uuid,
  "ma_lo_san_xuat_nguon" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "kho"."lo_hang"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "kho"."lo_hang"."ma_nghiep_vu" IS 'Mã nghiệp vụ: Mã nghiệp vụ của lô hàng, phục vụ nhận dạng nguồn vật tư/thành phẩm; được ghi bởi kho / sản xuất nguồn tạo theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kho"."lo_hang"."ma_lo_nha_cung_cap" IS 'Mã lô nhà cung cấp: Mã lô nhà cung cấp của lô hàng, phục vụ nhận dạng nguồn vật tư/thành phẩm; được ghi bởi kho / sản xuất nguồn tạo theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kho"."lo_hang"."ngay_san_xuat" IS 'Ngày sản xuất: Ngày sản xuất của lô hàng, phục vụ nhận dạng nguồn vật tư/thành phẩm; được ghi bởi kho / sản xuất nguồn tạo theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kho"."lo_hang"."ngay_het_han" IS 'Ngày hết hạn: Ngày hết hạn của lô hàng, phục vụ nhận dạng nguồn vật tư/thành phẩm; được ghi bởi kho / sản xuất nguồn tạo theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kho"."lo_hang"."loai_nguon_hinh_thanh_lo" IS 'Loại nguồn hình thành lô: Loại nguồn hình thành lô của lô hàng, phục vụ nhận dạng nguồn vật tư/thành phẩm; được ghi bởi kho / sản xuất nguồn tạo theo hồ sơ nguồn của bảng. Giá trị cho phép: dau_ky; mua_hang; san_xuat; chua_ro.';
COMMENT ON COLUMN "kho"."lo_hang"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."lo_hang"."ma_mat_hang" IS 'Mã mặt hàng: Mã mặt hàng liên kết danh_muc.mat_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."lo_hang"."ma_chung_tu_hinh_thanh_lo" IS 'Mã chứng từ hình thành lô: Mã chứng từ hình thành lô liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."lo_hang"."ma_lo_san_xuat_nguon" IS 'Mã lô sản xuất nguồn: Mã lô sản xuất nguồn liên kết san_xuat.lo_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."lo_hang"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "kho"."lo_hang"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."lo_hang"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
CREATE UNIQUE INDEX ma_6474d0a5f78331dffb ON "kho"."lo_hang" (ma_bo_du_lieu,ma_nghiep_vu);
COMMENT ON TABLE "kho"."lo_hang" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "kho"."phan_lo_hang" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "tinh_trang_chat_luong" text CHECK ("tinh_trang_chat_luong" IN ('cho_xu_ly','dat','loi')),
  "quyen_so_huu" text CHECK ("quyen_so_huu" IN ('ben_khac','chua_ro','doanh_nghiep')),
  "quy_cach_ky_thuat_ban_luu_tai_thoi_diem" jsonb,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_lo_hang" uuid,
  "ma_phan_lo_cha" uuid,
  "ma_phieu_ket_luan_chat_luong" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "kho"."phan_lo_hang"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "kho"."phan_lo_hang"."tinh_trang_chat_luong" IS 'Tình trạng chất lượng: Tình trạng chất lượng của phần lô hàng, phục vụ phần đồng nhất chất lượng/quyền sở hữu của một lô; được ghi bởi kho, kiểm chất lượng giữ chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: cho_xu_ly; dat; loi.';
COMMENT ON COLUMN "kho"."phan_lo_hang"."quyen_so_huu" IS 'Quyền sở hữu: Quyền sở hữu của phần lô hàng, phục vụ phần đồng nhất chất lượng/quyền sở hữu của một lô; được ghi bởi kho, kiểm chất lượng giữ chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: doanh_nghiep; ben_khac; chua_ro.';
COMMENT ON COLUMN "kho"."phan_lo_hang"."quy_cach_ky_thuat_ban_luu_tai_thoi_diem" IS 'Quy cách kỹ thuật bản lưu tại thời điểm: Quy cách kỹ thuật bản lưu tại thời điểm của phần lô hàng, phục vụ phần đồng nhất chất lượng/quyền sở hữu của một lô; được ghi bởi kho, kiểm chất lượng giữ chất lượng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kho"."phan_lo_hang"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."phan_lo_hang"."ma_lo_hang" IS 'Mã lô hàng: Mã lô hàng liên kết kho.lo_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."phan_lo_hang"."ma_phan_lo_cha" IS 'Mã phần lô cha: Mã phần lô cha liên kết kho.phan_lo_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."phan_lo_hang"."ma_phieu_ket_luan_chat_luong" IS 'Mã phiếu kết luận chất lượng: Mã phiếu kết luận chất lượng liên kết chat_luong.phieu_kiem_tra_chat_luong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."phan_lo_hang"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "kho"."phan_lo_hang"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."phan_lo_hang"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON TABLE "kho"."phan_lo_hang" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "kho"."dong_van_dong_hang" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "so_luong_theo_don_vi_nhap" numeric(24,6),
  "so_luong_do_theo_don_vi_co_so" numeric(24,6),
  "he_so_quy_doi_tai_lan_ghi_nhan" numeric(24,8),
  "ly_do" text,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_phieu_van_dong_hang" uuid,
  "ma_phan_lo_nguon" uuid,
  "ma_phan_lo_dich" uuid,
  "ma_vi_tri_nguon" uuid,
  "ma_vi_tri_dich" uuid,
  "ma_don_vi_nhap" uuid,
  "ma_quy_doi" uuid,
  "ma_dong_nghiep_vu_goc" uuid,
  "ma_yeu_cau_hang" uuid,
  "ma_chung_tu_phuong_an_xu_ly" uuid,
  "loai_thuc_dung_vat_tu" text CHECK ("loai_thuc_dung_vat_tu" IN ('hao_hut_san_xuat','thuc_dung')),
  "ma_chung_tu_cong_doan" uuid,
  "ma_dong_cap_vat_tu_nguon" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "kho"."dong_van_dong_hang"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."dong_van_dong_hang"."so_luong_theo_don_vi_nhap" IS 'Số lượng theo đơn vị nhập: Số lượng theo đơn vị nhập của dòng vận động hàng, phục vụ sổ lượng qua hai đầu trách nhiệm; được ghi bởi kho / xác nhận sản xuất đúng phạm vi theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kho"."dong_van_dong_hang"."so_luong_do_theo_don_vi_co_so" IS 'Số lượng đo theo đơn vị cơ sở: Số đo thực của hàng bằng đơn vị cơ sở trên dòng xác nhận; nếu được quy đổi từ đơn vị nhập phải dẫn đúng bản quy đổi và phép tính, không tự làm tròn mất hàng.';
COMMENT ON COLUMN "kho"."dong_van_dong_hang"."he_so_quy_doi_tai_lan_ghi_nhan" IS 'Hệ số quy đổi tại lần ghi nhận: Hệ số quy đổi tại lần ghi nhận của dòng vận động hàng, phục vụ sổ lượng qua hai đầu trách nhiệm; được ghi bởi kho / xác nhận sản xuất đúng phạm vi theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kho"."dong_van_dong_hang"."ly_do" IS 'Lý do: Lý do của dòng vận động hàng, phục vụ sổ lượng qua hai đầu trách nhiệm; được ghi bởi kho / xác nhận sản xuất đúng phạm vi theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kho"."dong_van_dong_hang"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."dong_van_dong_hang"."ma_phieu_van_dong_hang" IS 'Mã phiếu vận động hàng: Mã phiếu vận động hàng liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."dong_van_dong_hang"."ma_phan_lo_nguon" IS 'Mã phần lô nguồn: Mã phần lô nguồn liên kết kho.phan_lo_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."dong_van_dong_hang"."ma_phan_lo_dich" IS 'Mã phần lô đích: Mã phần lô đích liên kết kho.phan_lo_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."dong_van_dong_hang"."ma_vi_tri_nguon" IS 'Mã vị trí nguồn: Mã vị trí nguồn liên kết dung_chung.vi_tri_giu_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."dong_van_dong_hang"."ma_vi_tri_dich" IS 'Mã vị trí đích: Mã vị trí đích liên kết dung_chung.vi_tri_giu_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."dong_van_dong_hang"."ma_don_vi_nhap" IS 'Mã đơn vị nhập: Mã đơn vị nhập liên kết dung_chung.don_vi_tinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."dong_van_dong_hang"."ma_quy_doi" IS 'Mã quy đổi: Mã quy đổi liên kết danh_muc.quy_doi_don_vi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."dong_van_dong_hang"."ma_dong_nghiep_vu_goc" IS 'Mã dòng nghiệp vụ gốc: Mã dòng nghiệp vụ gốc liên kết kho.dong_van_dong_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."dong_van_dong_hang"."ma_yeu_cau_hang" IS 'Mã yêu cầu hàng: Mã yêu cầu hàng liên kết kho.yeu_cau_hang_va_vat_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."dong_van_dong_hang"."ma_chung_tu_phuong_an_xu_ly" IS 'Mã chứng từ phương án xử lý: Mã chứng từ phương án xử lý liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."dong_van_dong_hang"."loai_thuc_dung_vat_tu" IS 'Loại: Loại của vật tư thực dùng, phục vụ thực dùng/hao hụt theo lô và nguồn cấp; được ghi bởi sản xuất xác nhận theo hồ sơ nguồn của bảng. Giá trị cho phép: thuc_dung; hao_hut_san_xuat.';
COMMENT ON COLUMN "kho"."dong_van_dong_hang"."ma_chung_tu_cong_doan" IS 'Mã chứng từ công đoạn: Mã chứng từ công đoạn liên kết san_xuat.cong_doan_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."dong_van_dong_hang"."ma_dong_cap_vat_tu_nguon" IS 'Mã dòng cấp vật tư nguồn: Mã dòng cấp vật tư nguồn liên kết kho.dong_van_dong_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "kho"."dong_van_dong_hang" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "kho"."yeu_cau_hang_va_vat_tu" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "muc_dich" text CHECK ("muc_dich" IN ('ghi_ban','giao_bu','nhu_cau_tuong_lai_da_duyet','san_xuat')),
  "so_luong_can_theo_yeu_cau" numeric(24,6),
  "ngay_can_dap_ung" date,
  "trang_thai_xu_ly" text CHECK ("trang_thai_xu_ly" IN ('da_chot','da_huy','dang_mo')),
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_dong_nguon_nghiep_vu" uuid,
  "ma_mat_hang" uuid,
  "ma_don_vi" uuid,
  "ma_yeu_cau_hang_bi_thay" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "kho"."yeu_cau_hang_va_vat_tu"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."yeu_cau_hang_va_vat_tu"."muc_dich" IS 'Mục đích: Mục đích của yêu cầu hàng và vật tư, phục vụ nhu cầu hàng/vật tư không tự mất khi khóa lô; được ghi bởi kinh doanh / sản xuất lập; kho đối chiếu theo hồ sơ nguồn của bảng. Giá trị cho phép: ghi_ban; san_xuat; nhu_cau_tuong_lai_da_duyet; giao_bu.';
COMMENT ON COLUMN "kho"."yeu_cau_hang_va_vat_tu"."so_luong_can_theo_yeu_cau" IS 'Số lượng cần theo yêu cầu: Lượng được người giữ nguồn yêu cầu, có dòng đơn/lệnh hoặc nhu cầu tương lai đã duyệt; không cài một nguồn giả chỉ để làm phép tính thiếu.';
COMMENT ON COLUMN "kho"."yeu_cau_hang_va_vat_tu"."ngay_can_dap_ung" IS 'Ngày cần đáp ứng: Ngày cần đáp ứng của yêu cầu hàng và vật tư, phục vụ nhu cầu hàng/vật tư không tự mất khi khóa lô; được ghi bởi kinh doanh / sản xuất lập; kho đối chiếu theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kho"."yeu_cau_hang_va_vat_tu"."trang_thai_xu_ly" IS 'Trạng thái xử lý: Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: dang_mo; da_chot; da_huy.';
COMMENT ON COLUMN "kho"."yeu_cau_hang_va_vat_tu"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."yeu_cau_hang_va_vat_tu"."ma_dong_nguon_nghiep_vu" IS 'Mã dòng nguồn nghiệp vụ: Mã dòng nguồn nghiệp vụ liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."yeu_cau_hang_va_vat_tu"."ma_mat_hang" IS 'Mã mặt hàng: Mã mặt hàng liên kết danh_muc.mat_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."yeu_cau_hang_va_vat_tu"."ma_don_vi" IS 'Mã đơn vị: Mã đơn vị liên kết dung_chung.don_vi_tinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."yeu_cau_hang_va_vat_tu"."ma_yeu_cau_hang_bi_thay" IS 'Mã yêu cầu hàng bị thay: Mã yêu cầu hàng bị thay liên kết kho.yeu_cau_hang_va_vat_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "kho"."yeu_cau_hang_va_vat_tu" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "kho"."su_kien_giu_khoa_va_dang_ve" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "so_luong_do_theo_don_vi_co_so" numeric(24,6),
  "thoi_diem_co_hieu_luc" timestamptz,
  "thoi_diem_ket_thuc_hieu_luc" timestamptz,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_dong_don_mua" uuid,
  "ma_yeu_cau_hang" uuid,
  "ma_su_kien_dang_ve_bi_thay" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  "loai" text CHECK ("loai" IN ('dung_giu','giai_phong_dang_ve','giai_phong_giu','giai_phong_khoa','giu_dang_ve','giu_ton','khoa_chat_luong','mat_hieu_luc_giu')),
  "thoi_diem_thuc_hien_nghiep_vu" timestamptz,
  "ly_do" text,
  "ma_phan_lo" uuid,
  "ma_vi_tri" uuid,
  "ma_su_kien_goc" uuid,
  "ma_dong_van_dong_hang" uuid,
  "ma_phe_duyet" uuid,
  "thoi_diem_he_thong_ghi_nhan" timestamptz,
  "ma_phieu_kiem_chat_luong" uuid,
  "ma_chung_tu_phuong_an_xu_ly" uuid,
  "ma_nhan_vien_thuc_hien" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."so_luong_do_theo_don_vi_co_so" IS 'Số lượng đo theo đơn vị cơ sở: Số đo thực của hàng bằng đơn vị cơ sở trên dòng xác nhận; nếu được quy đổi từ đơn vị nhập phải dẫn đúng bản quy đổi và phép tính, không tự làm tròn mất hàng.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."thoi_diem_co_hieu_luc" IS 'Thời điểm có hiệu lực: Thời điểm người có thẩm quyền quy định nội dung bắt đầu áp dụng, tách với thời điểm hệ thống ghi.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."thoi_diem_ket_thuc_hieu_luc" IS 'Thời điểm kết thúc hiệu lực: Thời điểm kết thúc hiệu lực của phân bổ hàng đang về, phục vụ dành phần đang về cho đúng nhu cầu; được ghi bởi mua hàng / kho theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."ma_dong_don_mua" IS 'Mã dòng đơn mua: Mã dòng đơn mua liên kết mua_hang.dong_don_mua_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."ma_yeu_cau_hang" IS 'Mã yêu cầu hàng: Mã yêu cầu hàng liên kết kho.yeu_cau_hang_va_vat_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."ma_su_kien_dang_ve_bi_thay" IS 'Mã bản phân bổ hàng về bị thay: Mã bản phân bổ hàng về bị thay liên kết kho.su_kien_giu_khoa_va_dang_ve đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."loai" IS 'Loại sự kiện hàng: Sự kiện giữ/khóa nguồn hàng có phạm vi và người có quyền; đang về tách hoàn toàn khỏi tồn/khả dụng.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."thoi_diem_thuc_hien_nghiep_vu" IS 'Thời điểm thực hiện nghiệp vụ: Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."ly_do" IS 'Lý do: Lý do của sự kiện giữ hàng, phục vụ lịch sử giữ, dùng, giải phóng và mất hiệu lực; được ghi bởi kho theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."ma_phan_lo" IS 'Mã phần lô: Mã phần lô liên kết kho.phan_lo_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."ma_vi_tri" IS 'Mã vị trí: Mã vị trí liên kết dung_chung.vi_tri_giu_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."ma_su_kien_goc" IS 'Mã sự kiện giữ gốc: Mã sự kiện giữ gốc liên kết kho.su_kien_giu_khoa_va_dang_ve đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."ma_dong_van_dong_hang" IS 'Mã dòng vận động hàng: Mã dòng vận động hàng liên kết kho.dong_van_dong_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."ma_phe_duyet" IS 'Mã phê duyệt: Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."thoi_diem_he_thong_ghi_nhan" IS 'Thời điểm hệ thống ghi nhận: Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."ma_phieu_kiem_chat_luong" IS 'Mã phiếu kiểm chất lượng: Mã phiếu kiểm chất lượng liên kết chat_luong.phieu_kiem_tra_chat_luong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."ma_chung_tu_phuong_an_xu_ly" IS 'Mã chứng từ phương án xử lý: Mã chứng từ phương án xử lý liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."su_kien_giu_khoa_va_dang_ve"."ma_nhan_vien_thuc_hien" IS 'Mã nhân viên thực hiện: Mã nhân viên thực hiện liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "kho"."su_kien_giu_khoa_va_dang_ve" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "kho"."dong_kiem_ke" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "so_luong_dem_thuc" numeric(24,6),
  "so_luong_so_tai_moc_kiem_ke" numeric(24,6),
  "ly_do" text,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_bien_ban_kiem_ke" uuid,
  "ma_phan_lo" uuid,
  "ma_vi_tri" uuid,
  "ma_dong_dieu_chinh" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "kho"."dong_kiem_ke"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."dong_kiem_ke"."so_luong_dem_thuc" IS 'Số lượng đếm thực: Số lượng đếm thực của dòng kiểm kê, phục vụ đếm thực theo lô/vị trí/điều kiện; được ghi bởi kho theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kho"."dong_kiem_ke"."so_luong_so_tai_moc_kiem_ke" IS 'Số lượng sổ tại mốc kiểm kê: Ảnh chụp số sổ dựng từ các vận động đã xác nhận tới mốc/thu_tu kiểm kê; chỉ đối chiếu với đếm thực, không là đầu vào mới cho tồn.';
COMMENT ON COLUMN "kho"."dong_kiem_ke"."ly_do" IS 'Lý do: Lý do của dòng kiểm kê, phục vụ đếm thực theo lô/vị trí/điều kiện; được ghi bởi kho theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "kho"."dong_kiem_ke"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."dong_kiem_ke"."ma_bien_ban_kiem_ke" IS 'Mã biên bản kiểm kê: Mã biên bản kiểm kê liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."dong_kiem_ke"."ma_phan_lo" IS 'Mã phần lô: Mã phần lô liên kết kho.phan_lo_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."dong_kiem_ke"."ma_vi_tri" IS 'Mã vị trí: Mã vị trí liên kết dung_chung.vi_tri_giu_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "kho"."dong_kiem_ke"."ma_dong_dieu_chinh" IS 'Mã dòng điều chỉnh: Mã dòng điều chỉnh liên kết kho.dong_van_dong_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "kho"."dong_kiem_ke" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "san_xuat"."phien_ban_dinh_muc_san_xuat" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_nghiep_vu" text,
  "so_phien_ban" bigint,
  "so_luong_chuan_lam_can_cu_dinh_muc" numeric(24,6),
  "ty_le_dat_du_kien" numeric(12,10) CHECK ("ty_le_dat_du_kien" BETWEEN 0 AND 1),
  "thoi_diem_bat_dau_hieu_luc" date,
  "thoi_diem_ket_thuc_hieu_luc" date,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_mat_hang_dau_ra" uuid,
  "ma_phien_ban_chinh_sach" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "san_xuat"."phien_ban_dinh_muc_san_xuat"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."phien_ban_dinh_muc_san_xuat"."ma_nghiep_vu" IS 'Mã nghiệp vụ: Mã nghiệp vụ của phiên bản định mức sản xuất, phục vụ một phiên bản định mức/công đoạn; được ghi bởi sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."phien_ban_dinh_muc_san_xuat"."so_phien_ban" IS 'Số phiên bản: Số phiên bản của phiên bản định mức sản xuất, phục vụ một phiên bản định mức/công đoạn; được ghi bởi sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."phien_ban_dinh_muc_san_xuat"."so_luong_chuan_lam_can_cu_dinh_muc" IS 'Số lượng chuẩn làm căn cứ định mức: Số lượng chuẩn làm căn cứ định mức của phiên bản định mức sản xuất, phục vụ một phiên bản định mức/công đoạn; được ghi bởi sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."phien_ban_dinh_muc_san_xuat"."ty_le_dat_du_kien" IS 'Tỷ lệ đạt dự kiến: Tỷ lệ dự kiến do sản xuất khai báo trong bản định mức được duyệt; dùng lập kế hoạch, tuyệt đối không sinh kết quả kiểm chất lượng thực tế.';
COMMENT ON COLUMN "san_xuat"."phien_ban_dinh_muc_san_xuat"."thoi_diem_bat_dau_hieu_luc" IS 'Thời điểm bắt đầu hiệu lực: Thời điểm bắt đầu hiệu lực của phiên bản định mức sản xuất, phục vụ một phiên bản định mức/công đoạn; được ghi bởi sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."phien_ban_dinh_muc_san_xuat"."thoi_diem_ket_thuc_hieu_luc" IS 'Thời điểm kết thúc hiệu lực: Thời điểm kết thúc hiệu lực của phiên bản định mức sản xuất, phục vụ một phiên bản định mức/công đoạn; được ghi bởi sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."phien_ban_dinh_muc_san_xuat"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."phien_ban_dinh_muc_san_xuat"."ma_mat_hang_dau_ra" IS 'Mã mặt hàng đầu ra: Mã mặt hàng đầu ra liên kết danh_muc.mat_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."phien_ban_dinh_muc_san_xuat"."ma_phien_ban_chinh_sach" IS 'Mã phiên bản chính sách: Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
CREATE UNIQUE INDEX ma_28f6333f3fe7bb2a9c ON "san_xuat"."phien_ban_dinh_muc_san_xuat" (ma_bo_du_lieu,ma_nghiep_vu);
COMMENT ON TABLE "san_xuat"."phien_ban_dinh_muc_san_xuat" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "san_xuat"."dong_dinh_muc_vat_tu" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "luong_vat_tu_theo_dinh_muc" numeric(24,6),
  "ma_cong_doan" text,
  "thu_tu" bigint,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_chung_tu_dinh_muc" uuid,
  "ma_mat_hang" uuid,
  "ma_don_vi" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "san_xuat"."dong_dinh_muc_vat_tu"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."dong_dinh_muc_vat_tu"."luong_vat_tu_theo_dinh_muc" IS 'Lượng vật tư theo định mức: Lượng vật tư theo định mức của dòng định mức vật tư, phục vụ vật tư và công đoạn tiêu dùng theo bom; được ghi bởi sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."dong_dinh_muc_vat_tu"."ma_cong_doan" IS 'Mã công đoạn: Mã công đoạn của dòng định mức vật tư, phục vụ vật tư và công đoạn tiêu dùng theo bom; được ghi bởi sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."dong_dinh_muc_vat_tu"."thu_tu" IS 'Thứ tự: Thứ tự của dòng định mức vật tư, phục vụ vật tư và công đoạn tiêu dùng theo bom; được ghi bởi sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."dong_dinh_muc_vat_tu"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."dong_dinh_muc_vat_tu"."ma_chung_tu_dinh_muc" IS 'Mã chứng từ định mức: Mã chứng từ định mức liên kết san_xuat.phien_ban_dinh_muc_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."dong_dinh_muc_vat_tu"."ma_mat_hang" IS 'Mã mặt hàng: Mã mặt hàng liên kết danh_muc.mat_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."dong_dinh_muc_vat_tu"."ma_don_vi" IS 'Mã đơn vị: Mã đơn vị liên kết dung_chung.don_vi_tinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "san_xuat"."dong_dinh_muc_vat_tu" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "san_xuat"."nguon_luc_san_xuat" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_nghiep_vu" text,
  "loai" text CHECK ("loai" IN ('cho_duong_ho','may','vi_tri_thao_tac')),
  "suc_chua_theo_luong" numeric(24,6),
  "nang_luc_thoi_gian_tinh_theo_phut" bigint,
  "ky_nang_bat_buoc" text,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_vi_tri" uuid,
  "ma_phien_ban_chinh_sach" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "san_xuat"."nguon_luc_san_xuat"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "san_xuat"."nguon_luc_san_xuat"."ma_nghiep_vu" IS 'Mã nghiệp vụ: Mã nghiệp vụ của nguồn lực sản xuất, phục vụ nguồn tạo hình/hoàn thiện/chỗ dưỡng hộ; được ghi bởi sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."nguon_luc_san_xuat"."loai" IS 'Loại: Loại của nguồn lực sản xuất, phục vụ nguồn tạo hình/hoàn thiện/chỗ dưỡng hộ; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. Giá trị cho phép: may; vi_tri_thao_tac; cho_duong_ho.';
COMMENT ON COLUMN "san_xuat"."nguon_luc_san_xuat"."suc_chua_theo_luong" IS 'Sức chứa theo lượng: Sức chứa theo lượng của nguồn lực sản xuất, phục vụ nguồn tạo hình/hoàn thiện/chỗ dưỡng hộ; được ghi bởi sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."nguon_luc_san_xuat"."nang_luc_thoi_gian_tinh_theo_phut" IS 'Năng lực thời gian tính theo phút: Năng lực thời gian tính theo phút của nguồn lực sản xuất, phục vụ nguồn tạo hình/hoàn thiện/chỗ dưỡng hộ; được ghi bởi sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."nguon_luc_san_xuat"."ky_nang_bat_buoc" IS 'Kỹ năng bắt buộc: Kỹ năng bắt buộc của nguồn lực sản xuất, phục vụ nguồn tạo hình/hoàn thiện/chỗ dưỡng hộ; được ghi bởi sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."nguon_luc_san_xuat"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."nguon_luc_san_xuat"."ma_vi_tri" IS 'Mã vị trí: Mã vị trí liên kết dung_chung.vi_tri_giu_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."nguon_luc_san_xuat"."ma_phien_ban_chinh_sach" IS 'Mã phiên bản chính sách: Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."nguon_luc_san_xuat"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "san_xuat"."nguon_luc_san_xuat"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."nguon_luc_san_xuat"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
CREATE UNIQUE INDEX ma_a76201bb279aa24bcf ON "san_xuat"."nguon_luc_san_xuat" (ma_bo_du_lieu,ma_nghiep_vu);
COMMENT ON TABLE "san_xuat"."nguon_luc_san_xuat" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "san_xuat"."lenh_san_xuat" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "muc_dich" text CHECK ("muc_dich" IN ('lam_san','mau','tai_xu_ly','theo_don_khach')),
  "so_luong_dat_can_dap_ung" numeric(24,6),
  "so_luong_bat_dau_du_kien" numeric(24,6),
  "ngay_cam_ket" date,
  "uu_tien" bigint,
  "ly_do_quyet_dinh_uu_tien" text,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_chung_tu_dinh_muc" uuid,
  "ma_dong_don_hang_nguon" uuid,
  "ma_ho_so_xu_ly_nguon" uuid,
  "ma_phien_ban_chinh_sach" uuid,
  "ma_chung_tu_quyet_dinh_chot_lenh" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "san_xuat"."lenh_san_xuat"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."lenh_san_xuat"."muc_dich" IS 'Mục đích: Mục đích của lệnh sản xuất, phục vụ lệnh theo đơn/làm sẵn/mẫu/làm lại; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng. Giá trị cho phép: theo_don_khach; lam_san; mau; tai_xu_ly.';
COMMENT ON COLUMN "san_xuat"."lenh_san_xuat"."so_luong_dat_can_dap_ung" IS 'Số lượng đạt cần đáp ứng: Lượng đạt người đề nghị muốn đáp ứng; lưu ý nhu cầu khai báo khác phần thiếu được tính từ tồn và giữ tại mốc.';
COMMENT ON COLUMN "san_xuat"."lenh_san_xuat"."so_luong_bat_dau_du_kien" IS 'Số lượng bắt đầu dự kiến: Số lượng bắt đầu do người lập kế hoạch đề nghị trong bản lệnh/lô; có căn cứ đơn hoặc quyết định làm sẵn, không tự lấy ngưỡng tồn ép thành lệnh.';
COMMENT ON COLUMN "san_xuat"."lenh_san_xuat"."ngay_cam_ket" IS 'Ngày cam kết: Ngày cam kết của lệnh sản xuất, phục vụ lệnh theo đơn/làm sẵn/mẫu/làm lại; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."lenh_san_xuat"."uu_tien" IS 'Ưu tiên: Mức ưu tiên được quản lý và giám đốc quyết định có lý do/căn cứ; thứ tự tính từ ngày giao chỉ là đề xuất hiển thị, không tự ghi quyết định.';
COMMENT ON COLUMN "san_xuat"."lenh_san_xuat"."ly_do_quyet_dinh_uu_tien" IS 'Lý do quyết định ưu tiên: Lý do quyết định ưu tiên của lệnh sản xuất, phục vụ lệnh theo đơn/làm sẵn/mẫu/làm lại; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."lenh_san_xuat"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."lenh_san_xuat"."ma_chung_tu_dinh_muc" IS 'Mã chứng từ định mức: Mã chứng từ định mức liên kết san_xuat.phien_ban_dinh_muc_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."lenh_san_xuat"."ma_dong_don_hang_nguon" IS 'Mã dòng đơn hàng nguồn: Mã dòng đơn hàng nguồn liên kết kinh_doanh.dong_tu_van_bao_gia_va_don_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."lenh_san_xuat"."ma_ho_so_xu_ly_nguon" IS 'Mã hồ sơ xử lý nguồn: Mã hồ sơ xử lý nguồn liên kết kinh_doanh.ho_so_xu_ly đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."lenh_san_xuat"."ma_phien_ban_chinh_sach" IS 'Mã phiên bản chính sách: Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."lenh_san_xuat"."ma_chung_tu_quyet_dinh_chot_lenh" IS 'Mã chứng từ quyết định chốt lệnh: Mã chứng từ quyết định chốt lệnh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "san_xuat"."lenh_san_xuat" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "san_xuat"."lo_san_xuat" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_nghiep_vu" text,
  "so_luong_bat_dau_du_kien" numeric(24,6),
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_lenh_san_xuat" uuid,
  "ma_lo_thanh_pham_dau_ra" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "san_xuat"."lo_san_xuat"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "san_xuat"."lo_san_xuat"."ma_nghiep_vu" IS 'Mã nghiệp vụ: Mã nghiệp vụ của lô sản xuất, phục vụ một lô thực hiện của lệnh; được ghi bởi sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."lo_san_xuat"."so_luong_bat_dau_du_kien" IS 'Số lượng bắt đầu dự kiến: Số lượng bắt đầu do người lập kế hoạch đề nghị trong bản lệnh/lô; có căn cứ đơn hoặc quyết định làm sẵn, không tự lấy ngưỡng tồn ép thành lệnh.';
COMMENT ON COLUMN "san_xuat"."lo_san_xuat"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."lo_san_xuat"."ma_lenh_san_xuat" IS 'Mã lệnh sản xuất: Mã lệnh sản xuất liên kết san_xuat.lenh_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."lo_san_xuat"."ma_lo_thanh_pham_dau_ra" IS 'Mã lô thành phẩm đầu ra: Mã lô thành phẩm đầu ra liên kết kho.lo_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."lo_san_xuat"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "san_xuat"."lo_san_xuat"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."lo_san_xuat"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
CREATE UNIQUE INDEX ma_04f6917abb179d7a92 ON "san_xuat"."lo_san_xuat" (ma_bo_du_lieu,ma_nghiep_vu);
COMMENT ON TABLE "san_xuat"."lo_san_xuat" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "san_xuat"."cong_doan_san_xuat" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_nghiep_vu" text,
  "thu_tu" bigint,
  "thoi_diem_bat_dau_du_kien" timestamptz,
  "thoi_diem_ket_thuc_du_kien" timestamptz,
  "thoi_diem_bat_dau_thuc_te" timestamptz,
  "thoi_diem_ket_thuc_thuc_te" timestamptz,
  "so_luong_thuc_bat_dau" numeric(24,6),
  "so_luong_thuc_hoan_thanh" numeric(24,6),
  "trang_thai_thuc_hien" text CHECK ("trang_thai_thuc_hien" IN ('dang_cho','dang_thuc_hien','du_kien','hoan_thanh')),
  "ly_do" text,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_lo_san_xuat" uuid,
  "ma_phien_ban_chinh_sach" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "san_xuat"."cong_doan_san_xuat"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."cong_doan_san_xuat"."ma_nghiep_vu" IS 'Mã nghiệp vụ: Mã nghiệp vụ của công đoạn sản xuất, phục vụ công đoạn, thời điểm và sản lượng thực; được ghi bởi sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."cong_doan_san_xuat"."thu_tu" IS 'Thứ tự: Thứ tự của công đoạn sản xuất, phục vụ công đoạn, thời điểm và sản lượng thực; được ghi bởi sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."cong_doan_san_xuat"."thoi_diem_bat_dau_du_kien" IS 'Thời điểm bắt đầu dự kiến: Thời điểm bắt đầu dự kiến của công đoạn sản xuất, phục vụ công đoạn, thời điểm và sản lượng thực; được ghi bởi sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."cong_doan_san_xuat"."thoi_diem_ket_thuc_du_kien" IS 'Thời điểm kết thúc dự kiến: Thời điểm kết thúc dự kiến của công đoạn sản xuất, phục vụ công đoạn, thời điểm và sản lượng thực; được ghi bởi sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."cong_doan_san_xuat"."thoi_diem_bat_dau_thuc_te" IS 'Thời điểm bắt đầu thực tế: Thời điểm bắt đầu thực tế của công đoạn sản xuất, phục vụ công đoạn, thời điểm và sản lượng thực; được ghi bởi sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."cong_doan_san_xuat"."thoi_diem_ket_thuc_thuc_te" IS 'Thời điểm kết thúc thực tế: Thời điểm kết thúc thực tế của công đoạn sản xuất, phục vụ công đoạn, thời điểm và sản lượng thực; được ghi bởi sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."cong_doan_san_xuat"."so_luong_thuc_bat_dau" IS 'Số lượng thực bắt đầu: Lượng thực đã bắt đầu công đoạn, có thời điểm và xác nhận nguồn.';
COMMENT ON COLUMN "san_xuat"."cong_doan_san_xuat"."so_luong_thuc_hoan_thanh" IS 'Số lượng thực hoàn thành: Lượng hoàn thành thực được tổ trưởng ghi và người quản lý xác nhận; không lấy lượng kế hoạch làm thực tế.';
COMMENT ON COLUMN "san_xuat"."cong_doan_san_xuat"."trang_thai_thuc_hien" IS 'Trạng thái thực hiện: Trạng thái của sự kiện do người phụ trách xác nhận; không tự nạp đã hoàn tất. Trạng thái tổng hợp từ nhiều sự kiện chỉ tính khi xem. Giá trị cho phép: du_kien; dang_thuc_hien; dang_cho; hoan_thanh.';
COMMENT ON COLUMN "san_xuat"."cong_doan_san_xuat"."ly_do" IS 'Lý do: Lý do của công đoạn sản xuất, phục vụ công đoạn, thời điểm và sản lượng thực; được ghi bởi sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."cong_doan_san_xuat"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."cong_doan_san_xuat"."ma_lo_san_xuat" IS 'Mã lô sản xuất: Mã lô sản xuất liên kết san_xuat.lo_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."cong_doan_san_xuat"."ma_phien_ban_chinh_sach" IS 'Mã phiên bản chính sách: Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
CREATE UNIQUE INDEX ma_958a24f29d0b1bdb02 ON "san_xuat"."cong_doan_san_xuat" (ma_bo_du_lieu,ma_nghiep_vu);
COMMENT ON TABLE "san_xuat"."cong_doan_san_xuat" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "san_xuat"."lich_nguoi_va_nguon_luc" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "loai" text CHECK ("loai" IN ('du_kien','thuc_te')),
  "thoi_diem_bat_dau_khoang" timestamptz,
  "thoi_diem_ket_thuc_khoang" timestamptz,
  "so_luong_chiem_cho" numeric(24,6),
  "trang_thai_xu_ly" text CHECK ("trang_thai_xu_ly" IN ('da_huy','dang_su_dung','du_kien')),
  "muc_dich" text CHECK ("muc_dich" IN ('bao_tri','chuan_bi_may','dao_tao','duong_ho','hoan_thien','khac_co_ly_do','lam_viec','tao_hinh')),
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_nguon_luc" uuid,
  "ma_chung_tu_cong_doan" uuid,
  "ma_lich_bi_thay" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  "ma_phien_ban_chung_tu" uuid,
  "ma_nhan_vien" uuid,
  "ma_ngay_va_ca_lam_viec" uuid,
  "doi_tuong_lich" text CHECK ("doi_tuong_lich" IN ('nguon_luc','nhan_vien')),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "san_xuat"."lich_nguoi_va_nguon_luc"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "san_xuat"."lich_nguoi_va_nguon_luc"."loai" IS 'Loại: Loại của lịch và sử dụng nguồn lực, phục vụ lịch nguồn lực và giờ máy thực; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng. Giá trị cho phép: du_kien; thuc_te.';
COMMENT ON COLUMN "san_xuat"."lich_nguoi_va_nguon_luc"."thoi_diem_bat_dau_khoang" IS 'Thời điểm bắt đầu khoảng: Thời điểm bắt đầu khoảng của lịch và sử dụng nguồn lực, phục vụ lịch nguồn lực và giờ máy thực; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."lich_nguoi_va_nguon_luc"."thoi_diem_ket_thuc_khoang" IS 'Thời điểm kết thúc khoảng: Thời điểm kết thúc khoảng của lịch và sử dụng nguồn lực, phục vụ lịch nguồn lực và giờ máy thực; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."lich_nguoi_va_nguon_luc"."so_luong_chiem_cho" IS 'Số lượng chiếm chỗ: Số lượng chiếm chỗ của lịch và sử dụng nguồn lực, phục vụ lịch nguồn lực và giờ máy thực; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "san_xuat"."lich_nguoi_va_nguon_luc"."trang_thai_xu_ly" IS 'Trạng thái xử lý: Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: dang_su_dung; da_huy.';
COMMENT ON COLUMN "san_xuat"."lich_nguoi_va_nguon_luc"."muc_dich" IS 'Mục đích: Mục đích của lịch và sử dụng nguồn lực, phục vụ lịch nguồn lực và giờ máy thực; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng. Giá trị cho phép: tao_hinh; hoan_thien; duong_ho; chuan_bi_may; bao_tri.';
COMMENT ON COLUMN "san_xuat"."lich_nguoi_va_nguon_luc"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."lich_nguoi_va_nguon_luc"."ma_nguon_luc" IS 'Mã nguồn lực: Mã nguồn lực liên kết san_xuat.nguon_luc_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."lich_nguoi_va_nguon_luc"."ma_chung_tu_cong_doan" IS 'Mã chứng từ công đoạn: Mã chứng từ công đoạn liên kết san_xuat.cong_doan_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."lich_nguoi_va_nguon_luc"."ma_lich_bi_thay" IS 'Mã lịch nguồn lực bị thay: Mã lịch nguồn lực bị thay liên kết san_xuat.lich_nguoi_va_nguon_luc đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."lich_nguoi_va_nguon_luc"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "san_xuat"."lich_nguoi_va_nguon_luc"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."lich_nguoi_va_nguon_luc"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON COLUMN "san_xuat"."lich_nguoi_va_nguon_luc"."ma_phien_ban_chung_tu" IS 'Mã phiên bản chứng từ: Mã phiên bản chứng từ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."lich_nguoi_va_nguon_luc"."ma_nhan_vien" IS 'Mã nhân viên: Mã nhân viên liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."lich_nguoi_va_nguon_luc"."ma_ngay_va_ca_lam_viec" IS 'Mã ngày và ca làm việc: Mã ngày và ca làm việc liên kết nhan_su.ngay_va_ca_lam_viec đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "san_xuat"."lich_nguoi_va_nguon_luc"."doi_tuong_lich" IS 'Đối tượng lịch: Một dòng lịch thuộc máy/chỗ giữ hoặc người; thực công của người lưu ở khoảng công, không sao giờ thành công.';
COMMENT ON TABLE "san_xuat"."lich_nguoi_va_nguon_luc" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "chat_luong"."phieu_kiem_tra_chat_luong" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "loai_kiem_tra_chat_luong" text CHECK ("loai_kiem_tra_chat_luong" IN ('dau_vao','mau','thanh_pham','tra_hang','trong_san_xuat','xuat_giao')),
  "so_luong_thuc_kiem" numeric(24,6),
  "so_luong_ket_luan_dat" numeric(24,6),
  "so_luong_ket_luan_loi" numeric(24,6),
  "so_luong_cho_ket_luan" numeric(24,6),
  "pham_vi_kiem" text CHECK ("pham_vi_kiem" IN ('mau','toan_bo')),
  "tinh_trang_xac_nhan_ket_luan" text CHECK ("tinh_trang_xac_nhan_ket_luan" IN ('cho_xu_ly','da_xac_nhan')),
  "thoi_diem_xac_nhan_ket_luan" timestamptz,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_dong_nguon_nghiep_vu" uuid,
  "ma_lo_hang" uuid,
  "ma_phien_ban_bo_tieu_chi" uuid,
  "ma_chung_tu_mau" uuid,
  "ma_nhan_vien_kiem_chat_luong" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "chat_luong"."phieu_kiem_tra_chat_luong"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "chat_luong"."phieu_kiem_tra_chat_luong"."loai_kiem_tra_chat_luong" IS 'Loại kiểm tra chất lượng: Loại kiểm tra chất lượng của phiếu kiểm tra chất lượng, phục vụ hồ sơ kiểm tra đúng nguồn/phạm vi; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: dau_vao; trong_san_xuat; thanh_pham; mau; tra_hang; xuat_giao.';
COMMENT ON COLUMN "chat_luong"."phieu_kiem_tra_chat_luong"."so_luong_thuc_kiem" IS 'Số lượng thực kiểm: Lượng đã được thực kiểm hoặc đối chiếu theo phạm vi và phương pháp trong hồ sơ kiểm chất lượng.';
COMMENT ON COLUMN "chat_luong"."phieu_kiem_tra_chat_luong"."so_luong_ket_luan_dat" IS 'Số lượng kết luận đạt: Lượng người kiểm tra kết luận đạt trong phạm vi kiểm có căn cứ; không sinh từ tỷ lệ lỗi dự kiến.';
COMMENT ON COLUMN "chat_luong"."phieu_kiem_tra_chat_luong"."so_luong_ket_luan_loi" IS 'Số lượng kết luận lỗi: Lượng được người kiểm tra xác nhận lỗi; nguyên nhân lỗi có thể chồng loại, không cộng các loại lỗi thành lượng mới.';
COMMENT ON COLUMN "chat_luong"."phieu_kiem_tra_chat_luong"."so_luong_cho_ket_luan" IS 'Số lượng chờ kết luận: Lượng người kiểm tra chưa đủ căn cứ kết luận trong phạm vi kiểm; không suy từ kế hoạch thành một kết quả kiểm.';
COMMENT ON COLUMN "chat_luong"."phieu_kiem_tra_chat_luong"."pham_vi_kiem" IS 'Phạm vi kiểm: Phạm vi kiểm của phiếu kiểm tra chất lượng, phục vụ hồ sơ kiểm tra đúng nguồn/phạm vi; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: toan_bo; mau.';
COMMENT ON COLUMN "chat_luong"."phieu_kiem_tra_chat_luong"."tinh_trang_xac_nhan_ket_luan" IS 'Tình trạng xác nhận kết luận: Tình trạng xác nhận kết luận của phiếu kiểm tra chất lượng, phục vụ hồ sơ kiểm tra đúng nguồn/phạm vi; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: cho_xu_ly; da_xac_nhan.';
COMMENT ON COLUMN "chat_luong"."phieu_kiem_tra_chat_luong"."thoi_diem_xac_nhan_ket_luan" IS 'Thời điểm xác nhận kết luận: Thời điểm xác nhận kết luận của phiếu kiểm tra chất lượng, phục vụ hồ sơ kiểm tra đúng nguồn/phạm vi; được ghi bởi chất lượng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "chat_luong"."phieu_kiem_tra_chat_luong"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "chat_luong"."phieu_kiem_tra_chat_luong"."ma_dong_nguon_nghiep_vu" IS 'Mã dòng nguồn nghiệp vụ: Mã dòng nguồn nghiệp vụ liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "chat_luong"."phieu_kiem_tra_chat_luong"."ma_lo_hang" IS 'Mã lô hàng: Mã lô hàng liên kết kho.lo_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "chat_luong"."phieu_kiem_tra_chat_luong"."ma_phien_ban_bo_tieu_chi" IS 'Mã phiên bản bộ tiêu chí: Mã phiên bản bộ tiêu chí liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "chat_luong"."phieu_kiem_tra_chat_luong"."ma_chung_tu_mau" IS 'Mã chứng từ mẫu: Mã chứng từ mẫu liên kết kinh_doanh.mau_khach_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "chat_luong"."phieu_kiem_tra_chat_luong"."ma_nhan_vien_kiem_chat_luong" IS 'Mã nhân viên kiểm chất lượng: Mã nhân viên kiểm chất lượng liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "chat_luong"."phieu_kiem_tra_chat_luong" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "chat_luong"."ket_qua_tung_tieu_chi_kiem_tra" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_tieu_chi_kiem" text,
  "gia_tri_do_thuc" numeric(24,8),
  "ma_don_vi_do" text,
  "noi_dung_quan_sat_thuc" text,
  "ket_qua" text CHECK ("ket_qua" IN ('cho_xu_ly','dat','khong_dat')),
  "so_luong_bi_anh_huong" numeric(24,6),
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_phieu_kiem_chat_luong" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "chat_luong"."ket_qua_tung_tieu_chi_kiem_tra"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "chat_luong"."ket_qua_tung_tieu_chi_kiem_tra"."ma_tieu_chi_kiem" IS 'Mã tiêu chí kiểm: Mã tiêu chí kiểm của kết quả từng tiêu chí kiểm tra, phục vụ số đo/ngoại quan và lỗi theo tiêu chí; được ghi bởi chất lượng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "chat_luong"."ket_qua_tung_tieu_chi_kiem_tra"."gia_tri_do_thuc" IS 'Giá trị đo thực: Giá trị đo thực của kết quả từng tiêu chí kiểm tra, phục vụ số đo/ngoại quan và lỗi theo tiêu chí; được ghi bởi chất lượng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "chat_luong"."ket_qua_tung_tieu_chi_kiem_tra"."ma_don_vi_do" IS 'Mã đơn vị đo: Mã đơn vị đo của kết quả từng tiêu chí kiểm tra, phục vụ số đo/ngoại quan và lỗi theo tiêu chí; được ghi bởi chất lượng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "chat_luong"."ket_qua_tung_tieu_chi_kiem_tra"."noi_dung_quan_sat_thuc" IS 'Nội dung quan sát thực: Nội dung quan sát thực của kết quả từng tiêu chí kiểm tra, phục vụ số đo/ngoại quan và lỗi theo tiêu chí; được ghi bởi chất lượng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "chat_luong"."ket_qua_tung_tieu_chi_kiem_tra"."ket_qua" IS 'Kết quả: Kết quả của kết quả từng tiêu chí kiểm tra, phục vụ số đo/ngoại quan và lỗi theo tiêu chí; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: dat; khong_dat; cho_xu_ly.';
COMMENT ON COLUMN "chat_luong"."ket_qua_tung_tieu_chi_kiem_tra"."so_luong_bi_anh_huong" IS 'Số lượng bị ảnh hưởng: Số lượng bị ảnh hưởng của kết quả từng tiêu chí kiểm tra, phục vụ số đo/ngoại quan và lỗi theo tiêu chí; được ghi bởi chất lượng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "chat_luong"."ket_qua_tung_tieu_chi_kiem_tra"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "chat_luong"."ket_qua_tung_tieu_chi_kiem_tra"."ma_phieu_kiem_chat_luong" IS 'Mã phiếu kiểm chất lượng: Mã phiếu kiểm chất lượng liên kết chat_luong.phieu_kiem_tra_chat_luong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "chat_luong"."ket_qua_tung_tieu_chi_kiem_tra"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "chat_luong"."ket_qua_tung_tieu_chi_kiem_tra"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "chat_luong"."ket_qua_tung_tieu_chi_kiem_tra"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON TABLE "chat_luong"."ket_qua_tung_tieu_chi_kiem_tra" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "giao_hang"."dot_giao_hang" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "dia_chi_nhan_tai_luc_giao" text,
  "ghi_chu_van_chuyen" text,
  "thoi_diem_roi_kho" timestamptz,
  "thoi_diem_nhan" timestamptz,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_chung_tu_don_hang" uuid,
  "ma_ben_nhan" uuid,
  "ma_ben_van_chuyen" uuid,
  "ma_can_cu_dai_dien_nhan_hang" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "giao_hang"."dot_giao_hang"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "giao_hang"."dot_giao_hang"."dia_chi_nhan_tai_luc_giao" IS 'Địa chỉ nhận tại lúc giao: Địa chỉ nhận tại lúc giao của đợt giao hàng, phục vụ một đợt soạn/rời/nhận; được ghi bởi giao hàng phối hợp kinh doanh theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "giao_hang"."dot_giao_hang"."ghi_chu_van_chuyen" IS 'Ghi chú vận chuyển: Ghi chú vận chuyển của đợt giao hàng, phục vụ một đợt soạn/rời/nhận; được ghi bởi giao hàng phối hợp kinh doanh theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "giao_hang"."dot_giao_hang"."thoi_diem_roi_kho" IS 'Thời điểm rời kho: Thời điểm rời kho của đợt giao hàng, phục vụ một đợt soạn/rời/nhận; được ghi bởi giao hàng phối hợp kinh doanh theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "giao_hang"."dot_giao_hang"."thoi_diem_nhan" IS 'Thời điểm nhận: Thời điểm nhận của đợt giao hàng, phục vụ một đợt soạn/rời/nhận; được ghi bởi giao hàng phối hợp kinh doanh theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "giao_hang"."dot_giao_hang"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "giao_hang"."dot_giao_hang"."ma_chung_tu_don_hang" IS 'Mã chứng từ đơn hàng: Mã chứng từ đơn hàng liên kết kinh_doanh.bao_gia_va_don_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "giao_hang"."dot_giao_hang"."ma_ben_nhan" IS 'Mã bên nhận: Mã bên nhận liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "giao_hang"."dot_giao_hang"."ma_ben_van_chuyen" IS 'Mã bên vận chuyển: Mã bên vận chuyển liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "giao_hang"."dot_giao_hang"."ma_can_cu_dai_dien_nhan_hang" IS 'Mã căn cứ đại diện nhận hàng: Mã căn cứ đại diện nhận hàng liên kết dung_chung.can_cu_dai_dien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "giao_hang"."dot_giao_hang" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "giao_hang"."dong_giao_va_nhan_hang" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "so_luong_giao_du_kien" numeric(24,6),
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_chung_tu_dot_giao" uuid,
  "ma_dong_don_hang" uuid,
  "ma_dong_thuc_xuat_giao_hang" uuid,
  "so_luong_khach_thuc_nhan" numeric(24,6),
  "so_luong_duoc_chap_nhan" numeric(24,6),
  "so_luong_khach_tu_choi" numeric(24,6),
  "so_luong_hu_hong_duoc_ghi_nhan" numeric(24,6),
  "thoi_diem_thuc_hien_nghiep_vu" timestamptz,
  "chung_cu" text,
  "ma_dong_giao_du_kien" uuid,
  "ma_lien_he_nguoi_nhan_hang" uuid,
  "thoi_diem_he_thong_ghi_nhan" timestamptz,
  "loai_dong_giao" text CHECK ("loai_dong_giao" IN ('giao_du_kien','nhan_thuc')),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "giao_hang"."dong_giao_va_nhan_hang"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "giao_hang"."dong_giao_va_nhan_hang"."so_luong_giao_du_kien" IS 'Số lượng giao dự kiến: Số lượng giao dự kiến của dòng giao hàng, phục vụ biến thể/lô của đợt giao; được ghi bởi giao hàng / kho ghi thực xuất theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "giao_hang"."dong_giao_va_nhan_hang"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "giao_hang"."dong_giao_va_nhan_hang"."ma_chung_tu_dot_giao" IS 'Mã chứng từ đợt giao: Mã chứng từ đợt giao liên kết giao_hang.dot_giao_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "giao_hang"."dong_giao_va_nhan_hang"."ma_dong_don_hang" IS 'Mã dòng đơn hàng: Mã dòng đơn hàng liên kết kinh_doanh.dong_tu_van_bao_gia_va_don_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "giao_hang"."dong_giao_va_nhan_hang"."ma_dong_thuc_xuat_giao_hang" IS 'Mã dòng thực xuất giao hàng: Mã dòng thực xuất giao hàng liên kết kho.dong_van_dong_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "giao_hang"."dong_giao_va_nhan_hang"."so_luong_khach_thuc_nhan" IS 'Số lượng khách thực nhận: Số lượng khách thực nhận của xác nhận khách nhận hàng, phục vụ kết quả khách nhận từng phần; được ghi bởi giao hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "giao_hang"."dong_giao_va_nhan_hang"."so_luong_duoc_chap_nhan" IS 'Số lượng được chấp nhận: Số lượng được chấp nhận của xác nhận khách nhận hàng, phục vụ kết quả khách nhận từng phần; được ghi bởi giao hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "giao_hang"."dong_giao_va_nhan_hang"."so_luong_khach_tu_choi" IS 'Số lượng khách từ chối: Số lượng khách từ chối của xác nhận khách nhận hàng, phục vụ kết quả khách nhận từng phần; được ghi bởi giao hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "giao_hang"."dong_giao_va_nhan_hang"."so_luong_hu_hong_duoc_ghi_nhan" IS 'Số lượng hư hỏng được ghi nhận: Số lượng hư hỏng được ghi nhận của xác nhận khách nhận hàng, phục vụ kết quả khách nhận từng phần; được ghi bởi giao hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "giao_hang"."dong_giao_va_nhan_hang"."thoi_diem_thuc_hien_nghiep_vu" IS 'Thời điểm thực hiện nghiệp vụ: Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện.';
COMMENT ON COLUMN "giao_hang"."dong_giao_va_nhan_hang"."chung_cu" IS 'Chứng cứ: Chứng cứ của xác nhận khách nhận hàng, phục vụ kết quả khách nhận từng phần; được ghi bởi giao hàng theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "giao_hang"."dong_giao_va_nhan_hang"."ma_dong_giao_du_kien" IS 'Mã dòng giao hàng: Mã dòng giao hàng liên kết giao_hang.dong_giao_va_nhan_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "giao_hang"."dong_giao_va_nhan_hang"."ma_lien_he_nguoi_nhan_hang" IS 'Mã liên hệ người nhận hàng: Mã liên hệ người nhận hàng liên kết dung_chung.lien_he_doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "giao_hang"."dong_giao_va_nhan_hang"."thoi_diem_he_thong_ghi_nhan" IS 'Thời điểm hệ thống ghi nhận: Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc.';
COMMENT ON COLUMN "giao_hang"."dong_giao_va_nhan_hang"."loai_dong_giao" IS 'Loại dòng giao hoặc nhận: Dòng giao dự kiến có phiếu xuất; từng lần nhận thực là dòng con, giữ nhiều lần/nhận một phần mà không xuất lại.';
COMMENT ON TABLE "giao_hang"."dong_giao_va_nhan_hang" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "tai_chinh"."quy_va_tai_khoan_tien" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_nghiep_vu" text,
  "loai" text CHECK ("loai" IN ('ngan_hang','tien_mat')),
  "tien_te" text CHECK ("tien_te" IN ('VND')),
  "dang_su_dung" boolean,
  "ma_bo_du_lieu" uuid NOT NULL,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "tai_chinh"."quy_va_tai_khoan_tien"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "tai_chinh"."quy_va_tai_khoan_tien"."ma_nghiep_vu" IS 'Mã nghiệp vụ: Mã nghiệp vụ của quỹ và tài khoản tiền, phục vụ quỹ/tài khoản và số dư tính từ sổ; được ghi bởi tài chính theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."quy_va_tai_khoan_tien"."loai" IS 'Loại: Loại của quỹ và tài khoản tiền, phục vụ quỹ/tài khoản và số dư tính từ sổ; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: tien_mat; ngan_hang.';
COMMENT ON COLUMN "tai_chinh"."quy_va_tai_khoan_tien"."tien_te" IS 'Tiền tệ: Tiền tệ của quỹ và tài khoản tiền, phục vụ quỹ/tài khoản và số dư tính từ sổ; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: VND.';
COMMENT ON COLUMN "tai_chinh"."quy_va_tai_khoan_tien"."dang_su_dung" IS 'Đang sử dụng: Đang sử dụng của quỹ và tài khoản tiền, phục vụ quỹ/tài khoản và số dư tính từ sổ; được ghi bởi tài chính theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."quy_va_tai_khoan_tien"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."quy_va_tai_khoan_tien"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "tai_chinh"."quy_va_tai_khoan_tien"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."quy_va_tai_khoan_tien"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
CREATE UNIQUE INDEX ma_c85ae9a434e45c626a ON "tai_chinh"."quy_va_tai_khoan_tien" (ma_bo_du_lieu,ma_nghiep_vu);
COMMENT ON TABLE "tai_chinh"."quy_va_tai_khoan_tien" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "tai_chinh"."de_nghi_chi_tien" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "so_tien_de_nghi" numeric(24,0),
  "muc_dich" text CHECK ("muc_dich" IN ('chi_phi_ky','chuyen_noi_bo','hoan_tien','nha_cung_cap','thu_nhap','ung_truoc')),
  "ten_nguoi_huong_tai_luc_de_nghi" text,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_doi_tac_huong_tien" uuid,
  "ma_nhan_vien_huong_tien" uuid,
  "ma_nghia_vu_thanh_toan" uuid,
  "ma_phe_duyet" uuid,
  "ma_quy_hoac_tai_khoan_dich" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "tai_chinh"."de_nghi_chi_tien"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."de_nghi_chi_tien"."so_tien_de_nghi" IS 'Số tiền đề nghị: Số tiền đề nghị của đề nghị chi tiền, phục vụ được phép chi theo nguồn; được ghi bởi kế toán / hr lập; giám đốc duyệt theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."de_nghi_chi_tien"."muc_dich" IS 'Mục đích: Mục đích của đề nghị chi tiền, phục vụ được phép chi theo nguồn; được ghi bởi kế toán / hr lập; giám đốc duyệt theo hồ sơ nguồn của bảng. Giá trị cho phép: nha_cung_cap; ung_truoc; thu_nhap; hoan_tien; chi_phi_ky; chuyen_noi_bo.';
COMMENT ON COLUMN "tai_chinh"."de_nghi_chi_tien"."ten_nguoi_huong_tai_luc_de_nghi" IS 'Tên người hưởng tại lúc đề nghị: Tên người hưởng tại lúc đề nghị của đề nghị chi tiền, phục vụ được phép chi theo nguồn; được ghi bởi kế toán / hr lập; giám đốc duyệt theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."de_nghi_chi_tien"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."de_nghi_chi_tien"."ma_doi_tac_huong_tien" IS 'Mã đối tác hưởng tiền: Mã đối tác hưởng tiền liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."de_nghi_chi_tien"."ma_nhan_vien_huong_tien" IS 'Mã nhân viên hưởng tiền: Mã nhân viên hưởng tiền liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."de_nghi_chi_tien"."ma_nghia_vu_thanh_toan" IS 'Mã nghĩa vụ thanh toán: Mã nghĩa vụ thanh toán liên kết tai_chinh.nghia_vu_va_dieu_chinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."de_nghi_chi_tien"."ma_phe_duyet" IS 'Mã phê duyệt: Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."de_nghi_chi_tien"."ma_quy_hoac_tai_khoan_dich" IS 'Mã quỹ hoặc tài khoản đích: Mã quỹ hoặc tài khoản đích liên kết tai_chinh.quy_va_tai_khoan_tien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "tai_chinh"."de_nghi_chi_tien" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "tai_chinh"."bien_dong_tien_thuc" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "chieu_tang_giam" text CHECK ("chieu_tang_giam" IN ('chi_ra','dau_ky','thu_vao')),
  "so_tien" numeric(24,0),
  "thoi_diem_thuc_hien_nghiep_vu" timestamptz,
  "ma_doi_chieu_ben_ngoai" text,
  "khoa_chuyen_quy_noi_bo" uuid,
  "pham_vi_xac_dinh_chu_nguon_tien" text CHECK ("pham_vi_xac_dinh_chu_nguon_tien" IN ('chua_xac_dinh_chu_the','khach_hang','nha_cung_cap','nhan_vien','noi_bo')),
  "trang_thai_ghi_so" text CHECK ("trang_thai_ghi_so" IN ('da_ghi_so','nhap')),
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_quy_hoac_tai_khoan_tien" uuid,
  "ma_chung_tu_de_nghi_chi" uuid,
  "ma_doi_tac" uuid,
  "ma_nhan_vien" uuid,
  "ma_can_cu_dai_dien" uuid,
  "ma_bien_nhan_xac_nhan_giao_dich" uuid,
  "thoi_diem_he_thong_ghi_nhan" timestamptz,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "tai_chinh"."bien_dong_tien_thuc"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_tien_thuc"."chieu_tang_giam" IS 'Chiều tăng giảm: Chiều tăng giảm của biến động tiền thực, phục vụ một biến động tiền thực hoặc số đầu; được ghi bởi người thu/chi xác nhận theo hồ sơ nguồn của bảng. Giá trị cho phép: thu_vao; chi_ra; dau_ky.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_tien_thuc"."so_tien" IS 'Số tiền: Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_tien_thuc"."thoi_diem_thuc_hien_nghiep_vu" IS 'Thời điểm thực hiện nghiệp vụ: Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_tien_thuc"."ma_doi_chieu_ben_ngoai" IS 'Mã đối chiếu bên ngoài: Mã đối chiếu bên ngoài của biến động tiền thực, phục vụ một biến động tiền thực hoặc số đầu; được ghi bởi người thu/chi xác nhận theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_tien_thuc"."khoa_chuyen_quy_noi_bo" IS 'Khóa chuyển quỹ nội bộ: Khóa chuyển quỹ nội bộ của biến động tiền thực, phục vụ một biến động tiền thực hoặc số đầu; được ghi bởi người thu/chi xác nhận theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_tien_thuc"."pham_vi_xac_dinh_chu_nguon_tien" IS 'Phạm vi xác định chủ nguồn tiền: Phạm vi xác định chủ nguồn tiền của biến động tiền thực, phục vụ một biến động tiền thực hoặc số đầu; được ghi bởi người thu/chi xác nhận theo hồ sơ nguồn của bảng. Giá trị cho phép: chua_xac_dinh_chu_the; khach_hang; nha_cung_cap; nhan_vien; noi_bo.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_tien_thuc"."trang_thai_ghi_so" IS 'Trạng thái ghi sổ: Trạng thái ghi sổ của biến động tiền thực, phục vụ một biến động tiền thực hoặc số đầu; được ghi bởi người thu/chi xác nhận theo hồ sơ nguồn của bảng. Giá trị cho phép: nhap; da_ghi_so.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_tien_thuc"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_tien_thuc"."ma_quy_hoac_tai_khoan_tien" IS 'Mã quỹ hoặc tài khoản tiền: Mã quỹ hoặc tài khoản tiền liên kết tai_chinh.quy_va_tai_khoan_tien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_tien_thuc"."ma_chung_tu_de_nghi_chi" IS 'Mã chứng từ đề nghị chi: Mã chứng từ đề nghị chi liên kết tai_chinh.de_nghi_chi_tien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_tien_thuc"."ma_doi_tac" IS 'Mã đối tác: Mã đối tác liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_tien_thuc"."ma_nhan_vien" IS 'Mã nhân viên: Mã nhân viên liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_tien_thuc"."ma_can_cu_dai_dien" IS 'Mã căn cứ đại diện: Mã căn cứ đại diện liên kết dung_chung.can_cu_dai_dien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_tien_thuc"."ma_bien_nhan_xac_nhan_giao_dich" IS 'Mã biên nhận xác nhận giao dịch: Mã biên nhận xác nhận giao dịch liên kết truy_cap.bien_nhan_xac_nhan_giao_dich đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_tien_thuc"."thoi_diem_he_thong_ghi_nhan" IS 'Thời điểm hệ thống ghi nhận: Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc.';
COMMENT ON TABLE "tai_chinh"."bien_dong_tien_thuc" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "tai_chinh"."nghia_vu_va_dieu_chinh" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "loai" text CHECK ("loai" IN ('phai_hoan_tien','phai_thu','phai_tra','thu_hoi_ung')),
  "so_tien_nghia_vu_goc" numeric(24,0),
  "ngay_den_han_thanh_toan" date,
  "ten_nguoi_huong_tai_luc_de_nghi" text,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_dong_nguon_nghiep_vu" uuid,
  "ma_doi_tac" uuid,
  "ma_nhan_vien" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  "loai_ban_ghi_nghia_vu" text CHECK ("loai_ban_ghi_nghia_vu" IN ('dieu_chinh_tien','doi_han','xac_lap')),
  "chieu_tang_giam" text CHECK ("chieu_tang_giam" IN ('giam','tang')),
  "so_tien" numeric(24,0),
  "thoi_diem_thuc_hien_nghiep_vu" timestamptz,
  "ly_do" text,
  "ngay_den_han_moi" date,
  "ma_nghia_vu_goc" uuid,
  "ma_su_kien_dieu_chinh_goc" uuid,
  "ma_phe_duyet" uuid,
  "thoi_diem_he_thong_ghi_nhan" timestamptz,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."loai" IS 'Loại: Loại của nghĩa vụ thanh toán, phục vụ khoản phải thu/trả/hoàn theo nguồn; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: phai_thu; phai_tra; phai_hoan_tien; thu_hoi_ung.';
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."so_tien_nghia_vu_goc" IS 'Số tiền nghĩa vụ gốc: Khoản nghĩa vụ được xác lập theo chứng từ gốc đã đối chiếu, không phải số nợ cuối mong muốn.';
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."ngay_den_han_thanh_toan" IS 'Ngày đến hạn thanh toán: Ngày đến hạn thanh toán của nghĩa vụ thanh toán, phục vụ khoản phải thu/trả/hoàn theo nguồn; được ghi bởi tài chính theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."ten_nguoi_huong_tai_luc_de_nghi" IS 'Tên người hưởng tại lúc đề nghị: Tên người hưởng tại lúc đề nghị của nghĩa vụ thanh toán, phục vụ khoản phải thu/trả/hoàn theo nguồn; được ghi bởi tài chính theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."ma_dong_nguon_nghiep_vu" IS 'Mã dòng nguồn nghiệp vụ: Mã dòng nguồn nghiệp vụ liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."ma_doi_tac" IS 'Mã đối tác: Mã đối tác liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."ma_nhan_vien" IS 'Mã nhân viên: Mã nhân viên liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."loai_ban_ghi_nghia_vu" IS 'Loại bản ghi nghĩa vụ: Bản gốc xác lập nghĩa vụ; điều chỉnh thêm dòng riêng nối gốc. Tổng nợ không cộng số gốc ở dòng điều chỉnh.';
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."chieu_tang_giam" IS 'Chiều tăng giảm: Chiều tăng giảm của điều chỉnh nghĩa vụ, phục vụ điều chỉnh nghĩa vụ không sửa gốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: tang; giam.';
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."so_tien" IS 'Số tiền: Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối.';
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."thoi_diem_thuc_hien_nghiep_vu" IS 'Thời điểm thực hiện nghiệp vụ: Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện.';
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."ly_do" IS 'Lý do: Lý do của điều chỉnh nghĩa vụ, phục vụ điều chỉnh nghĩa vụ không sửa gốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."ngay_den_han_moi" IS 'Ngày đến hạn mới: Ngày đến hạn mới của điều chỉnh nghĩa vụ, phục vụ điều chỉnh nghĩa vụ không sửa gốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."ma_nghia_vu_goc" IS 'Mã nghĩa vụ thanh toán: Mã nghĩa vụ thanh toán liên kết tai_chinh.nghia_vu_va_dieu_chinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."ma_su_kien_dieu_chinh_goc" IS 'Mã sự kiện gốc: Mã sự kiện gốc liên kết tai_chinh.nghia_vu_va_dieu_chinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."ma_phe_duyet" IS 'Mã phê duyệt: Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."nghia_vu_va_dieu_chinh"."thoi_diem_he_thong_ghi_nhan" IS 'Thời điểm hệ thống ghi nhận: Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc.';
COMMENT ON TABLE "tai_chinh"."nghia_vu_va_dieu_chinh" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "tai_chinh"."su_kien_su_dung_nguon_tien" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "loai" text CHECK ("loai" IN ('dao_su_dung_tien','giai_phong_nguon_hoan','giu_nguon_hoan','su_dung_tien_thanh_toan','thuc_dung_nguon_hoan')),
  "so_tien" numeric(24,0),
  "thoi_diem_thuc_hien_nghiep_vu" timestamptz,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_bien_dong_tien_thuc" uuid,
  "ma_nghia_vu_thanh_toan" uuid,
  "ma_su_kien_su_dung_tien_goc" uuid,
  "ma_bien_dong_tien_thuc_hoan" uuid,
  "ma_can_cu_dai_dien" uuid,
  "thoi_diem_he_thong_ghi_nhan" timestamptz,
  "ma_tai_khoan_thuc_hien" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "tai_chinh"."su_kien_su_dung_nguon_tien"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "tai_chinh"."su_kien_su_dung_nguon_tien"."loai" IS 'Loại: Loại của sự kiện sử dụng nguồn tiền, phục vụ dùng tiền cho nghĩa vụ hoặc giữ nguồn hoàn; được ghi bởi kế toán theo hồ sơ nguồn của bảng. Giá trị cho phép: su_dung_tien_thanh_toan; dao_su_dung_tien; giu_nguon_hoan; giai_phong_nguon_hoan; thuc_dung_nguon_hoan.';
COMMENT ON COLUMN "tai_chinh"."su_kien_su_dung_nguon_tien"."so_tien" IS 'Số tiền: Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối.';
COMMENT ON COLUMN "tai_chinh"."su_kien_su_dung_nguon_tien"."thoi_diem_thuc_hien_nghiep_vu" IS 'Thời điểm thực hiện nghiệp vụ: Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện.';
COMMENT ON COLUMN "tai_chinh"."su_kien_su_dung_nguon_tien"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."su_kien_su_dung_nguon_tien"."ma_bien_dong_tien_thuc" IS 'Mã biến động tiền thực: Mã biến động tiền thực liên kết tai_chinh.bien_dong_tien_thuc đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."su_kien_su_dung_nguon_tien"."ma_nghia_vu_thanh_toan" IS 'Mã nghĩa vụ thanh toán: Mã nghĩa vụ thanh toán liên kết tai_chinh.nghia_vu_va_dieu_chinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."su_kien_su_dung_nguon_tien"."ma_su_kien_su_dung_tien_goc" IS 'Mã sự kiện sử dụng tiền gốc: Mã sự kiện sử dụng tiền gốc liên kết tai_chinh.su_kien_su_dung_nguon_tien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."su_kien_su_dung_nguon_tien"."ma_bien_dong_tien_thuc_hoan" IS 'Mã biến động tiền thực hoàn: Mã biến động tiền thực hoàn liên kết tai_chinh.bien_dong_tien_thuc đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."su_kien_su_dung_nguon_tien"."ma_can_cu_dai_dien" IS 'Mã căn cứ đại diện: Mã căn cứ đại diện liên kết dung_chung.can_cu_dai_dien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."su_kien_su_dung_nguon_tien"."thoi_diem_he_thong_ghi_nhan" IS 'Thời điểm hệ thống ghi nhận: Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc.';
COMMENT ON COLUMN "tai_chinh"."su_kien_su_dung_nguon_tien"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "tai_chinh"."su_kien_su_dung_nguon_tien" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "tai_chinh"."dong_ghi_nhan_ban" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "so_vien_thoa_thuan" numeric(24,6),
  "don_gia_tai_lan_ghi_nhan" numeric(24,8),
  "so_tien" numeric(24,0),
  "tinh_trang_ghi_nhan_gia_von" text CHECK ("tinh_trang_ghi_nhan_gia_von" IN ('da_xac_nhan','tam_tinh')),
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_chung_tu_ghi_ban" uuid,
  "ma_dong_xac_nhan_khach_nhan" uuid,
  "ma_dong_ghi_ban_goc" uuid,
  "ma_dong_don_hang" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "tai_chinh"."dong_ghi_nhan_ban"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."dong_ghi_nhan_ban"."so_vien_thoa_thuan" IS 'Số viên thỏa thuận: Số viên thỏa thuận của dòng ghi nhận bán, phục vụ doanh thu theo lượng/giá đã chấp nhận; được ghi bởi kế toán theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."dong_ghi_nhan_ban"."don_gia_tai_lan_ghi_nhan" IS 'Đơn giá tại lần ghi nhận: Đơn giá tại lần ghi nhận của dòng ghi nhận bán, phục vụ doanh thu theo lượng/giá đã chấp nhận; được ghi bởi kế toán theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."dong_ghi_nhan_ban"."so_tien" IS 'Số tiền: Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối.';
COMMENT ON COLUMN "tai_chinh"."dong_ghi_nhan_ban"."tinh_trang_ghi_nhan_gia_von" IS 'Tình trạng ghi nhận giá vốn: Tình trạng ghi nhận giá vốn của dòng ghi nhận bán, phục vụ doanh thu theo lượng/giá đã chấp nhận; được ghi bởi kế toán theo hồ sơ nguồn của bảng. Giá trị cho phép: tam_tinh; da_xac_nhan.';
COMMENT ON COLUMN "tai_chinh"."dong_ghi_nhan_ban"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."dong_ghi_nhan_ban"."ma_chung_tu_ghi_ban" IS 'Mã chứng từ ghi bán: Mã chứng từ ghi bán liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."dong_ghi_nhan_ban"."ma_dong_xac_nhan_khach_nhan" IS 'Mã dòng xác nhận khách nhận: Mã dòng xác nhận khách nhận liên kết giao_hang.dong_giao_va_nhan_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."dong_ghi_nhan_ban"."ma_dong_ghi_ban_goc" IS 'Mã dòng ghi bán gốc: Mã dòng ghi bán gốc liên kết tai_chinh.dong_ghi_nhan_ban đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."dong_ghi_nhan_ban"."ma_dong_don_hang" IS 'Mã dòng đơn hàng: Mã dòng đơn hàng liên kết kinh_doanh.dong_tu_van_bao_gia_va_don_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "tai_chinh"."dong_ghi_nhan_ban" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "tai_chinh"."doi_chieu_nghia_vu_mua" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "so_luong_duoc_chap_nhan" numeric(24,6),
  "so_tien_doi_chieu_chap_nhan_mua" numeric(24,0),
  "ma_chung_tu_nha_cung_cap" text,
  "ngay_den_han_thanh_toan" date,
  "trang_thai_thuc_hien" text CHECK ("trang_thai_thuc_hien" IN ('cho_xu_ly','da_xac_nhan','tranh_chap')),
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_dong_don_mua" uuid,
  "ma_dong_nhan_hang_mua" uuid,
  "ma_phieu_kiem_chat_luong" uuid,
  "ma_nha_cung_cap" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "tai_chinh"."doi_chieu_nghia_vu_mua"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."doi_chieu_nghia_vu_mua"."so_luong_duoc_chap_nhan" IS 'Số lượng được chấp nhận: Số lượng được chấp nhận của đối chiếu nghĩa vụ mua, phục vụ chứng từ nghĩa vụ và giá trị mua được chấp nhận; được ghi bởi mua hàng / kế toán đối chiếu theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."doi_chieu_nghia_vu_mua"."so_tien_doi_chieu_chap_nhan_mua" IS 'Số tiền đối chiếu chấp nhận mua: Số tiền đối chiếu chấp nhận mua của đối chiếu nghĩa vụ mua, phục vụ chứng từ nghĩa vụ và giá trị mua được chấp nhận; được ghi bởi mua hàng / kế toán đối chiếu theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."doi_chieu_nghia_vu_mua"."ma_chung_tu_nha_cung_cap" IS 'Mã chứng từ nhà cung cấp: Mã chứng từ nhà cung cấp của đối chiếu nghĩa vụ mua, phục vụ chứng từ nghĩa vụ và giá trị mua được chấp nhận; được ghi bởi mua hàng / kế toán đối chiếu theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."doi_chieu_nghia_vu_mua"."ngay_den_han_thanh_toan" IS 'Ngày đến hạn thanh toán: Ngày đến hạn thanh toán của đối chiếu nghĩa vụ mua, phục vụ chứng từ nghĩa vụ và giá trị mua được chấp nhận; được ghi bởi mua hàng / kế toán đối chiếu theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."doi_chieu_nghia_vu_mua"."trang_thai_thuc_hien" IS 'Trạng thái thực hiện: Trạng thái của sự kiện do người phụ trách xác nhận; không tự nạp đã hoàn tất. Trạng thái tổng hợp từ nhiều sự kiện chỉ tính khi xem. Giá trị cho phép: cho_xu_ly; da_xac_nhan; tranh_chap.';
COMMENT ON COLUMN "tai_chinh"."doi_chieu_nghia_vu_mua"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."doi_chieu_nghia_vu_mua"."ma_dong_don_mua" IS 'Mã dòng đơn mua: Mã dòng đơn mua liên kết mua_hang.dong_don_mua_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."doi_chieu_nghia_vu_mua"."ma_dong_nhan_hang_mua" IS 'Mã dòng nhận hàng mua: Mã dòng nhận hàng mua liên kết kho.dong_van_dong_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."doi_chieu_nghia_vu_mua"."ma_phieu_kiem_chat_luong" IS 'Mã phiếu kiểm chất lượng: Mã phiếu kiểm chất lượng liên kết chat_luong.phieu_kiem_tra_chat_luong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."doi_chieu_nghia_vu_mua"."ma_nha_cung_cap" IS 'Mã nhà cung cấp: Mã nhà cung cấp liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "tai_chinh"."doi_chieu_nghia_vu_mua" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "tai_chinh"."dong_doi_chieu_quy_ngan_hang" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_doi_chieu_ben_ngoai" text,
  "so_tien_thuc_tren_nguon_doi_chieu" numeric(24,0),
  "chieu_tang_giam" text CHECK ("chieu_tang_giam" IN ('chi_ra','thu_vao')),
  "thoi_diem_quan_sat_nguon_doi_chieu" timestamptz,
  "trang_thai_xu_ly" text CHECK ("trang_thai_xu_ly" IN ('chua_doi_chieu','da_doi_chieu','tranh_chap')),
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_quy_hoac_tai_khoan_tien" uuid,
  "ma_bien_dong_tien_thuc" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "tai_chinh"."dong_doi_chieu_quy_ngan_hang"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."dong_doi_chieu_quy_ngan_hang"."ma_doi_chieu_ben_ngoai" IS 'Mã đối chiếu bên ngoài: Mã đối chiếu bên ngoài của dòng đối chiếu quỹ ngân hàng, phục vụ đối chiếu quỹ/ngân hàng giả lập theo mốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."dong_doi_chieu_quy_ngan_hang"."so_tien_thuc_tren_nguon_doi_chieu" IS 'Số tiền thực trên nguồn đối chiếu: Số tiền thực trên nguồn đối chiếu của dòng đối chiếu quỹ ngân hàng, phục vụ đối chiếu quỹ/ngân hàng giả lập theo mốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."dong_doi_chieu_quy_ngan_hang"."chieu_tang_giam" IS 'Chiều tăng giảm: Chiều tăng giảm của dòng đối chiếu quỹ ngân hàng, phục vụ đối chiếu quỹ/ngân hàng giả lập theo mốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: thu_vao; chi_ra.';
COMMENT ON COLUMN "tai_chinh"."dong_doi_chieu_quy_ngan_hang"."thoi_diem_quan_sat_nguon_doi_chieu" IS 'Thời điểm quan sát nguồn đối chiếu: Thời điểm quan sát nguồn đối chiếu của dòng đối chiếu quỹ ngân hàng, phục vụ đối chiếu quỹ/ngân hàng giả lập theo mốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."dong_doi_chieu_quy_ngan_hang"."trang_thai_xu_ly" IS 'Trạng thái xử lý: Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: chua_doi_chieu; da_doi_chieu; tranh_chap.';
COMMENT ON COLUMN "tai_chinh"."dong_doi_chieu_quy_ngan_hang"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."dong_doi_chieu_quy_ngan_hang"."ma_quy_hoac_tai_khoan_tien" IS 'Mã quỹ hoặc tài khoản tiền: Mã quỹ hoặc tài khoản tiền liên kết tai_chinh.quy_va_tai_khoan_tien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."dong_doi_chieu_quy_ngan_hang"."ma_bien_dong_tien_thuc" IS 'Mã biến động tiền thực: Mã biến động tiền thực liên kết tai_chinh.bien_dong_tien_thuc đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "tai_chinh"."dong_doi_chieu_quy_ngan_hang" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "tai_chinh"."nguon_chi_phi" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "loai" text CHECK ("loai" IN ('bo_sung','chi_phi_chung','co_the_thu_hoi','nhan_cong','vat_tu')),
  "so_tien" numeric(24,0),
  "trang_thai_xu_ly" text CHECK ("trang_thai_xu_ly" IN ('da_xac_nhan','tam_tinh')),
  "ghi_chu_can_cu_chi_phi" text,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_dong_nguon_nghiep_vu" uuid,
  "ma_dong_thu_nhap_nhan_vien" uuid,
  "ma_dong_vat_tu_thuc_dung" uuid,
  "ma_phien_ban_chinh_sach" uuid,
  "ma_nguon_chi_phi_bi_thay" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "tai_chinh"."nguon_chi_phi"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."nguon_chi_phi"."loai" IS 'Loại: Loại của nguồn chi phí, phục vụ một nguồn chi phí được đối chiếu; được ghi bởi tài chính; hr cung cấp phần lương theo hồ sơ nguồn của bảng. Giá trị cho phép: vat_tu; nhan_cong; chi_phi_chung; bo_sung; co_the_thu_hoi.';
COMMENT ON COLUMN "tai_chinh"."nguon_chi_phi"."so_tien" IS 'Số tiền: Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối.';
COMMENT ON COLUMN "tai_chinh"."nguon_chi_phi"."trang_thai_xu_ly" IS 'Trạng thái xử lý: Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: tam_tinh; da_xac_nhan.';
COMMENT ON COLUMN "tai_chinh"."nguon_chi_phi"."ghi_chu_can_cu_chi_phi" IS 'Ghi chú căn cứ chi phí: Ghi chú căn cứ chi phí của nguồn chi phí, phục vụ một nguồn chi phí được đối chiếu; được ghi bởi tài chính; hr cung cấp phần lương theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."nguon_chi_phi"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."nguon_chi_phi"."ma_dong_nguon_nghiep_vu" IS 'Mã dòng nguồn nghiệp vụ: Mã dòng nguồn nghiệp vụ liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."nguon_chi_phi"."ma_dong_thu_nhap_nhan_vien" IS 'Mã dòng thu nhập nhân viên: Mã dòng thu nhập nhân viên liên kết nhan_su.thu_nhap_nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."nguon_chi_phi"."ma_dong_vat_tu_thuc_dung" IS 'Mã dòng vật tư thực dùng: Mã dòng vật tư thực dùng liên kết kho.dong_van_dong_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."nguon_chi_phi"."ma_phien_ban_chinh_sach" IS 'Mã phiên bản chính sách: Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."nguon_chi_phi"."ma_nguon_chi_phi_bi_thay" IS 'Mã nguồn chi phí bị thay: Mã nguồn chi phí bị thay liên kết tai_chinh.nguon_chi_phi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "tai_chinh"."nguon_chi_phi" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "tai_chinh"."phan_bo_chi_phi" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "so_tien" numeric(24,0),
  "doi_tuong_chiu_chi_phi" text CHECK ("doi_tuong_chiu_chi_phi" IN ('lo_san_xuat','ngoai_san_xuat','thu_hoi_gia_tri','viec_khac_tai_xuong')),
  "so_luong_can_cu_phan_bo" numeric(24,8),
  "trang_thai_xu_ly" text CHECK ("trang_thai_xu_ly" IN ('da_xac_nhan','tam_tinh')),
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_nguon_chi_phi" uuid,
  "ma_lo_san_xuat" uuid,
  "ma_phien_ban_chinh_sach" uuid,
  "ma_ban_phan_bo_chi_phi_bi_thay" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "tai_chinh"."phan_bo_chi_phi"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."phan_bo_chi_phi"."so_tien" IS 'Số tiền: Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối.';
COMMENT ON COLUMN "tai_chinh"."phan_bo_chi_phi"."doi_tuong_chiu_chi_phi" IS 'Đối tượng chịu chi phí: Đối tượng chịu chi phí của phân bổ chi phí, phục vụ phân bổ nguồn đến lô hoặc chi phí khác; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: lo_san_xuat; viec_khac_tai_xuong; ngoai_san_xuat; thu_hoi_gia_tri.';
COMMENT ON COLUMN "tai_chinh"."phan_bo_chi_phi"."so_luong_can_cu_phan_bo" IS 'Số lượng căn cứ phân bổ: Số lượng căn cứ phân bổ của phân bổ chi phí, phục vụ phân bổ nguồn đến lô hoặc chi phí khác; được ghi bởi tài chính theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."phan_bo_chi_phi"."trang_thai_xu_ly" IS 'Trạng thái xử lý: Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: tam_tinh; da_xac_nhan.';
COMMENT ON COLUMN "tai_chinh"."phan_bo_chi_phi"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."phan_bo_chi_phi"."ma_nguon_chi_phi" IS 'Mã nguồn chi phí: Mã nguồn chi phí liên kết tai_chinh.nguon_chi_phi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."phan_bo_chi_phi"."ma_lo_san_xuat" IS 'Mã lô sản xuất: Mã lô sản xuất liên kết san_xuat.lo_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."phan_bo_chi_phi"."ma_phien_ban_chinh_sach" IS 'Mã phiên bản chính sách: Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."phan_bo_chi_phi"."ma_ban_phan_bo_chi_phi_bi_thay" IS 'Mã bản phân bổ chi phí bị thay: Mã bản phân bổ chi phí bị thay liên kết tai_chinh.phan_bo_chi_phi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "tai_chinh"."phan_bo_chi_phi" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "tai_chinh"."can_cu_phan_bo_chi_phi" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "loai_can_cu_phan_bo" text CHECK ("loai_can_cu_phan_bo" IN ('luong_vat_tu','phut_cong','phut_may')),
  "so_luong_can_cu_phan_bo" numeric(24,8),
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_dong_phan_bo_chi_phi" uuid,
  "ma_khoang_cong_thuc_te" uuid,
  "ma_lich_nguon_luc" uuid,
  "ma_dong_vat_tu_thuc_dung" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "tai_chinh"."can_cu_phan_bo_chi_phi"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "tai_chinh"."can_cu_phan_bo_chi_phi"."loai_can_cu_phan_bo" IS 'Loại căn cứ phân bổ: Loại căn cứ phân bổ của căn cứ phân bổ chi phí, phục vụ các dòng thực làm/giờ máy/vật tư cho phân bổ; được ghi bởi tài chính; sản xuất/hr xác nhận nguồn giờ theo hồ sơ nguồn của bảng. Giá trị cho phép: phut_cong; phut_may; luong_vat_tu.';
COMMENT ON COLUMN "tai_chinh"."can_cu_phan_bo_chi_phi"."so_luong_can_cu_phan_bo" IS 'Số lượng căn cứ phân bổ: Số lượng căn cứ phân bổ của căn cứ phân bổ chi phí, phục vụ các dòng thực làm/giờ máy/vật tư cho phân bổ; được ghi bởi tài chính; sản xuất/hr xác nhận nguồn giờ theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."can_cu_phan_bo_chi_phi"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."can_cu_phan_bo_chi_phi"."ma_dong_phan_bo_chi_phi" IS 'Mã dòng phân bổ chi phí: Mã dòng phân bổ chi phí liên kết tai_chinh.phan_bo_chi_phi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."can_cu_phan_bo_chi_phi"."ma_khoang_cong_thuc_te" IS 'Mã khoảng công thực tế: Mã khoảng công thực tế liên kết nhan_su.khoang_cong_thuc_te đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."can_cu_phan_bo_chi_phi"."ma_lich_nguon_luc" IS 'Mã lịch nguồn lực: Mã lịch nguồn lực liên kết san_xuat.lich_nguoi_va_nguon_luc đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."can_cu_phan_bo_chi_phi"."ma_dong_vat_tu_thuc_dung" IS 'Mã dòng vật tư thực dùng: Mã dòng vật tư thực dùng liên kết kho.dong_van_dong_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."can_cu_phan_bo_chi_phi"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "tai_chinh"."can_cu_phan_bo_chi_phi"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."can_cu_phan_bo_chi_phi"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON TABLE "tai_chinh"."can_cu_phan_bo_chi_phi" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "tai_chinh"."bien_dong_gia_tri" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "nhom_gia_tri_nguon" text CHECK ("nhom_gia_tri_nguon" IN ('chi_phi_ky','dang_giao','do_dang','gia_von','nguon_dau_vao','thu_hoi_gia_tri','ton_hang')),
  "nhom_gia_tri_dich" text CHECK ("nhom_gia_tri_dich" IN ('chi_phi_ky','dang_giao','do_dang','gia_von','nguon_dau_vao','thu_hoi_gia_tri','ton_hang')),
  "so_tien" numeric(24,0),
  "thoi_diem_thuc_hien_nghiep_vu" timestamptz,
  "tinh_trang_xac_nhan_dinh_gia" text CHECK ("tinh_trang_xac_nhan_dinh_gia" IN ('da_xac_nhan','tam_tinh')),
  "quy_tac_lam_tron_da_ap_dung" text,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_mat_hang" uuid,
  "ma_dong_van_dong_hang" uuid,
  "ma_chung_tu_ban_chot_gia_thanh" uuid,
  "ma_dong_ghi_ban" uuid,
  "ma_bien_dong_gia_tri_goc" uuid,
  "thoi_diem_he_thong_ghi_nhan" timestamptz,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "tai_chinh"."bien_dong_gia_tri"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_gia_tri"."nhom_gia_tri_nguon" IS 'Nhóm giá trị nguồn: Nhóm giá trị nguồn của biến động giá trị, phục vụ sổ giá trị kho/xưởng/đang giao/giá vốn; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: nguon_dau_vao; ton_hang; do_dang; dang_giao; gia_von; chi_phi_ky; thu_hoi_gia_tri.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_gia_tri"."nhom_gia_tri_dich" IS 'Nhóm giá trị đích: Nhóm giá trị đích của biến động giá trị, phục vụ sổ giá trị kho/xưởng/đang giao/giá vốn; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: nguon_dau_vao; ton_hang; do_dang; dang_giao; gia_von; chi_phi_ky; thu_hoi_gia_tri.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_gia_tri"."so_tien" IS 'Số tiền: Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_gia_tri"."thoi_diem_thuc_hien_nghiep_vu" IS 'Thời điểm thực hiện nghiệp vụ: Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_gia_tri"."tinh_trang_xac_nhan_dinh_gia" IS 'Tình trạng xác nhận định giá: Tình trạng xác nhận định giá của biến động giá trị, phục vụ sổ giá trị kho/xưởng/đang giao/giá vốn; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: tam_tinh; da_xac_nhan.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_gia_tri"."quy_tac_lam_tron_da_ap_dung" IS 'Quy tắc làm tròn đã áp dụng: Quy tắc làm tròn đã áp dụng của biến động giá trị, phục vụ sổ giá trị kho/xưởng/đang giao/giá vốn; được ghi bởi tài chính theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_gia_tri"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_gia_tri"."ma_mat_hang" IS 'Mã mặt hàng: Mã mặt hàng liên kết danh_muc.mat_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_gia_tri"."ma_dong_van_dong_hang" IS 'Mã dòng vận động hàng: Mã dòng vận động hàng liên kết kho.dong_van_dong_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_gia_tri"."ma_chung_tu_ban_chot_gia_thanh" IS 'Mã chứng từ bản chốt giá thành: Mã chứng từ bản chốt giá thành liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_gia_tri"."ma_dong_ghi_ban" IS 'Mã dòng ghi bán: Mã dòng ghi bán liên kết tai_chinh.dong_ghi_nhan_ban đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_gia_tri"."ma_bien_dong_gia_tri_goc" IS 'Mã biến động giá trị gốc: Mã biến động giá trị gốc liên kết tai_chinh.bien_dong_gia_tri đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."bien_dong_gia_tri"."thoi_diem_he_thong_ghi_nhan" IS 'Thời điểm hệ thống ghi nhận: Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc.';
COMMENT ON TABLE "tai_chinh"."bien_dong_gia_tri" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "nhan_su"."nhan_vien" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_nghiep_vu" text,
  "ma_nguoi_that" uuid,
  "ten" text,
  "ngay_vao_lam" date,
  "ngay_nghi_viec" date,
  "ma_bo_du_lieu" uuid NOT NULL,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "nhan_su"."nhan_vien"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "nhan_su"."nhan_vien"."ma_nghiep_vu" IS 'Mã nghiệp vụ: Mã nghiệp vụ của nhân viên, phục vụ một hồ sơ người, không bắt có tài khoản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."nhan_vien"."ma_nguoi_that" IS 'Mã người thật: Mã người thật liên kết truy_cap.dinh_danh_nguoi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."nhan_vien"."ten" IS 'Tên: Tên của nhân viên, phục vụ một hồ sơ người, không bắt có tài khoản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."nhan_vien"."ngay_vao_lam" IS 'Ngày vào làm: Ngày vào làm của nhân viên, phục vụ một hồ sơ người, không bắt có tài khoản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."nhan_vien"."ngay_nghi_viec" IS 'Ngày nghỉ việc: Ngày nghỉ việc của nhân viên, phục vụ một hồ sơ người, không bắt có tài khoản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."nhan_vien"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."nhan_vien"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "nhan_su"."nhan_vien"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."nhan_vien"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
CREATE UNIQUE INDEX ma_aade14366f0f5738bb ON "nhan_su"."nhan_vien" (ma_bo_du_lieu,ma_nghiep_vu);
COMMENT ON TABLE "nhan_su"."nhan_vien" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "nhan_su"."ho_so_lam_viec_theo_hieu_luc" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "thoi_diem_bat_dau_hieu_luc" date,
  "thoi_diem_ket_thuc_hieu_luc" date,
  "loai_ho_so_hop_dong" text,
  "ngay_ket_thuc_hop_dong" date,
  "vi_tri_cong_viec" text,
  "luong_co_ban" numeric(24,0),
  "phu_cap_co_dinh" numeric(24,0),
  "ghi_chu_thu_viec" text,
  "tinh_trang_lam_viec" text CHECK ("tinh_trang_lam_viec" IN ('chuan_bi_vao_lam','da_nghi_viec','dang_su_dung','tam_ngung_lam','thu_viec')),
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_nhan_vien" uuid,
  "ma_bo_phan" uuid,
  "ma_nhan_vien_quan_ly" uuid,
  "ma_phien_ban_chinh_sach_thu_nhap" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "nhan_su"."ho_so_lam_viec_theo_hieu_luc"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."ho_so_lam_viec_theo_hieu_luc"."thoi_diem_bat_dau_hieu_luc" IS 'Thời điểm bắt đầu hiệu lực: Thời điểm bắt đầu hiệu lực của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."ho_so_lam_viec_theo_hieu_luc"."thoi_diem_ket_thuc_hieu_luc" IS 'Thời điểm kết thúc hiệu lực: Thời điểm kết thúc hiệu lực của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."ho_so_lam_viec_theo_hieu_luc"."loai_ho_so_hop_dong" IS 'Loại hồ sơ hợp đồng: Loại hồ sơ hợp đồng của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."ho_so_lam_viec_theo_hieu_luc"."ngay_ket_thuc_hop_dong" IS 'Ngày kết thúc hợp đồng: Ngày kết thúc hợp đồng của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."ho_so_lam_viec_theo_hieu_luc"."vi_tri_cong_viec" IS 'Vị trí công việc: Vị trí công việc của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."ho_so_lam_viec_theo_hieu_luc"."luong_co_ban" IS 'Lương cơ bản: Lương cơ bản của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."ho_so_lam_viec_theo_hieu_luc"."phu_cap_co_dinh" IS 'Phụ cấp cố định: Phụ cấp cố định của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."ho_so_lam_viec_theo_hieu_luc"."ghi_chu_thu_viec" IS 'Ghi chú thử việc: Ghi chú thử việc của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."ho_so_lam_viec_theo_hieu_luc"."tinh_trang_lam_viec" IS 'Tình trạng làm việc: Tình trạng làm việc của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng. Giá trị cho phép: chuan_bi_vao_lam; thu_viec; dang_su_dung; tam_ngung_lam; da_nghi_viec.';
COMMENT ON COLUMN "nhan_su"."ho_so_lam_viec_theo_hieu_luc"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."ho_so_lam_viec_theo_hieu_luc"."ma_nhan_vien" IS 'Mã nhân viên: Mã nhân viên liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."ho_so_lam_viec_theo_hieu_luc"."ma_bo_phan" IS 'Mã bộ phận: Mã bộ phận liên kết dung_chung.bo_phan đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."ho_so_lam_viec_theo_hieu_luc"."ma_nhan_vien_quan_ly" IS 'Mã nhân viên quản lý: Mã nhân viên quản lý liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."ho_so_lam_viec_theo_hieu_luc"."ma_phien_ban_chinh_sach_thu_nhap" IS 'Mã phiên bản chính sách thu nhập: Mã phiên bản chính sách thu nhập liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "nhan_su"."ho_so_lam_viec_theo_hieu_luc" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "nhan_su"."ho_so_ky_nang_va_an_toan" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "loai" text CHECK ("loai" IN ('huan_luyen_an_toan','ky_nang','su_co')),
  "ma_nghiep_vu" text,
  "thoi_diem_bat_dau_hieu_luc" date,
  "thoi_diem_ket_thuc_hieu_luc" date,
  "trang_thai_xu_ly" text CHECK ("trang_thai_xu_ly" IN ('cho_xu_ly','da_chot','du_dieu_kien','het_hieu_luc')),
  "ghi_chu_anh_huong_cong_viec" text,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_nhan_vien" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "nhan_su"."ho_so_ky_nang_va_an_toan"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."ho_so_ky_nang_va_an_toan"."loai" IS 'Loại: Loại của hồ sơ kỹ năng và an toàn, phục vụ kỹ năng, hướng dẫn an toàn và sự cố cơ sở; được ghi bởi nhân sự / quản lý xác nhận theo hồ sơ nguồn của bảng. Giá trị cho phép: ky_nang; huan_luyen_an_toan; su_co.';
COMMENT ON COLUMN "nhan_su"."ho_so_ky_nang_va_an_toan"."ma_nghiep_vu" IS 'Mã nghiệp vụ: Mã nghiệp vụ của hồ sơ kỹ năng và an toàn, phục vụ kỹ năng, hướng dẫn an toàn và sự cố cơ sở; được ghi bởi nhân sự / quản lý xác nhận theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."ho_so_ky_nang_va_an_toan"."thoi_diem_bat_dau_hieu_luc" IS 'Thời điểm bắt đầu hiệu lực: Thời điểm bắt đầu hiệu lực của hồ sơ kỹ năng và an toàn, phục vụ kỹ năng, hướng dẫn an toàn và sự cố cơ sở; được ghi bởi nhân sự / quản lý xác nhận theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."ho_so_ky_nang_va_an_toan"."thoi_diem_ket_thuc_hieu_luc" IS 'Thời điểm kết thúc hiệu lực: Thời điểm kết thúc hiệu lực của hồ sơ kỹ năng và an toàn, phục vụ kỹ năng, hướng dẫn an toàn và sự cố cơ sở; được ghi bởi nhân sự / quản lý xác nhận theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."ho_so_ky_nang_va_an_toan"."trang_thai_xu_ly" IS 'Trạng thái xử lý: Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: cho_xu_ly; du_dieu_kien; het_hieu_luc; da_chot.';
COMMENT ON COLUMN "nhan_su"."ho_so_ky_nang_va_an_toan"."ghi_chu_anh_huong_cong_viec" IS 'Ghi chú ảnh hưởng công việc: Ghi chú ảnh hưởng công việc của hồ sơ kỹ năng và an toàn, phục vụ kỹ năng, hướng dẫn an toàn và sự cố cơ sở; được ghi bởi nhân sự / quản lý xác nhận theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."ho_so_ky_nang_va_an_toan"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."ho_so_ky_nang_va_an_toan"."ma_nhan_vien" IS 'Mã nhân viên: Mã nhân viên liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
CREATE UNIQUE INDEX ma_8d3dba2134ebd2d945 ON "nhan_su"."ho_so_ky_nang_va_an_toan" (ma_bo_du_lieu,ma_nghiep_vu);
COMMENT ON TABLE "nhan_su"."ho_so_ky_nang_va_an_toan" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "nhan_su"."ngay_va_ca_lam_viec" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ngay_lam_viec" date,
  "loai_ngay_theo_lich" text CHECK ("loai_ngay_theo_lich" IN ('lam_viec','ngay_le','nghi_tuan','ngoai_le')),
  "ma_ca" text,
  "cac_khoang_lam_viec_trong_ca" jsonb,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_phien_ban_chinh_sach" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "nhan_su"."ngay_va_ca_lam_viec"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "nhan_su"."ngay_va_ca_lam_viec"."ngay_lam_viec" IS 'Ngày làm việc: Ngày làm việc của ngày và ca làm việc, phục vụ ngày làm và các khoảng ca có phiên bản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."ngay_va_ca_lam_viec"."loai_ngay_theo_lich" IS 'Loại ngày theo lịch: Loại ngày theo lịch của ngày và ca làm việc, phục vụ ngày làm và các khoảng ca có phiên bản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. Giá trị cho phép: lam_viec; nghi_tuan; ngay_le; ngoai_le.';
COMMENT ON COLUMN "nhan_su"."ngay_va_ca_lam_viec"."ma_ca" IS 'Mã ca: Mã ca của ngày và ca làm việc, phục vụ ngày làm và các khoảng ca có phiên bản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."ngay_va_ca_lam_viec"."cac_khoang_lam_viec_trong_ca" IS 'Các khoảng làm việc trong ca: Các khoảng làm việc trong ca của ngày và ca làm việc, phục vụ ngày làm và các khoảng ca có phiên bản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."ngay_va_ca_lam_viec"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."ngay_va_ca_lam_viec"."ma_phien_ban_chinh_sach" IS 'Mã phiên bản chính sách: Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."ngay_va_ca_lam_viec"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "nhan_su"."ngay_va_ca_lam_viec"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."ngay_va_ca_lam_viec"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON TABLE "nhan_su"."ngay_va_ca_lam_viec" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "nhan_su"."khoang_cong_thuc_te" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "thoi_diem_bat_dau_khoang" timestamptz,
  "thoi_diem_ket_thuc_khoang" timestamptz,
  "loai" text CHECK ("loai" IN ('chua_xac_minh','cong_tac','dang_cho','dao_tao','ho_tro','lam_them','nghi_huong_luong','nghi_khong_luong','truc_tiep')),
  "can_cu_huong_luong" text CHECK ("can_cu_huong_luong" IN ('cho_chinh_sach','huong_luong','khong_huong_luong')),
  "trang_thai_xu_ly" text CHECK ("trang_thai_xu_ly" IN ('cho_xu_ly','da_xac_nhan')),
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_chung_tu_ban_cong" uuid,
  "ma_chung_tu_cong_doan" uuid,
  "ma_chung_tu_de_nghi_nghi" uuid,
  "ma_quyet_dinh_duyet_lam_them" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "nhan_su"."khoang_cong_thuc_te"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "nhan_su"."khoang_cong_thuc_te"."thoi_diem_bat_dau_khoang" IS 'Thời điểm bắt đầu khoảng: Thời điểm bắt đầu khoảng của khoảng công thực tế, phục vụ khoảng thực làm/nghỉ/chờ và trực tiếp theo người; được ghi bởi tổ trưởng / quản lý xác nhận theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."khoang_cong_thuc_te"."thoi_diem_ket_thuc_khoang" IS 'Thời điểm kết thúc khoảng: Thời điểm kết thúc khoảng của khoảng công thực tế, phục vụ khoảng thực làm/nghỉ/chờ và trực tiếp theo người; được ghi bởi tổ trưởng / quản lý xác nhận theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."khoang_cong_thuc_te"."loai" IS 'Loại: Loại của khoảng công thực tế, phục vụ khoảng thực làm/nghỉ/chờ và trực tiếp theo người; được ghi bởi tổ trưởng / quản lý xác nhận theo hồ sơ nguồn của bảng. Giá trị cho phép: truc_tiep; ho_tro; dang_cho; dao_tao; cong_tac; nghi_huong_luong; nghi_khong_luong; chua_xac_minh; lam_them.';
COMMENT ON COLUMN "nhan_su"."khoang_cong_thuc_te"."can_cu_huong_luong" IS 'Căn cứ hưởng lương: Căn cứ hưởng lương của khoảng công thực tế, phục vụ khoảng thực làm/nghỉ/chờ và trực tiếp theo người; được ghi bởi tổ trưởng / quản lý xác nhận theo hồ sơ nguồn của bảng. Giá trị cho phép: huong_luong; khong_huong_luong; cho_chinh_sach.';
COMMENT ON COLUMN "nhan_su"."khoang_cong_thuc_te"."trang_thai_xu_ly" IS 'Trạng thái xử lý: Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: cho_xu_ly; da_xac_nhan.';
COMMENT ON COLUMN "nhan_su"."khoang_cong_thuc_te"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."khoang_cong_thuc_te"."ma_chung_tu_ban_cong" IS 'Mã chứng từ bản công: Mã chứng từ bản công liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."khoang_cong_thuc_te"."ma_chung_tu_cong_doan" IS 'Mã chứng từ công đoạn: Mã chứng từ công đoạn liên kết san_xuat.cong_doan_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."khoang_cong_thuc_te"."ma_chung_tu_de_nghi_nghi" IS 'Mã chứng từ đề nghị nghỉ: Mã chứng từ đề nghị nghỉ liên kết nhan_su.de_nghi_nghi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."khoang_cong_thuc_te"."ma_quyet_dinh_duyet_lam_them" IS 'Mã quyết định duyệt làm thêm: Mã quyết định duyệt làm thêm liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."khoang_cong_thuc_te"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "nhan_su"."khoang_cong_thuc_te"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."khoang_cong_thuc_te"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON TABLE "nhan_su"."khoang_cong_thuc_te" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "nhan_su"."de_nghi_nghi" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "loai_nghi" text CHECK ("loai_nghi" IN ('khac_co_ly_do','khong_huong_luong','nghi_om','phep_nam_huong_luong')),
  "thoi_diem_bat_dau_khoang" timestamptz,
  "thoi_diem_ket_thuc_khoang" timestamptz,
  "trang_thai_xu_ly" text CHECK ("trang_thai_xu_ly" IN ('da_de_nghi','da_dung','da_duyet','da_huy')),
  "ly_do" text,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_nhan_vien" uuid,
  "ma_nhan_vien_lam_thay" uuid,
  "ma_phien_ban_chinh_sach" uuid,
  "ma_phe_duyet" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "nhan_su"."de_nghi_nghi"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."de_nghi_nghi"."loai_nghi" IS 'Loại nghỉ: Loại nghỉ của đề nghị nghỉ, phục vụ đề nghị nghỉ và bàn giao; được ghi bởi quản lý duyệt / hr kiểm theo hồ sơ nguồn của bảng. Giá trị cho phép: phep_nam_huong_luong; khong_huong_luong; nghi_om; khac_co_ly_do.';
COMMENT ON COLUMN "nhan_su"."de_nghi_nghi"."thoi_diem_bat_dau_khoang" IS 'Thời điểm bắt đầu khoảng: Thời điểm bắt đầu khoảng của đề nghị nghỉ, phục vụ đề nghị nghỉ và bàn giao; được ghi bởi quản lý duyệt / hr kiểm theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."de_nghi_nghi"."thoi_diem_ket_thuc_khoang" IS 'Thời điểm kết thúc khoảng: Thời điểm kết thúc khoảng của đề nghị nghỉ, phục vụ đề nghị nghỉ và bàn giao; được ghi bởi quản lý duyệt / hr kiểm theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."de_nghi_nghi"."trang_thai_xu_ly" IS 'Trạng thái xử lý: Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: da_de_nghi; da_duyet; da_huy; da_dung.';
COMMENT ON COLUMN "nhan_su"."de_nghi_nghi"."ly_do" IS 'Lý do: Lý do của đề nghị nghỉ, phục vụ đề nghị nghỉ và bàn giao; được ghi bởi quản lý duyệt / hr kiểm theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."de_nghi_nghi"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."de_nghi_nghi"."ma_nhan_vien" IS 'Mã nhân viên: Mã nhân viên liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."de_nghi_nghi"."ma_nhan_vien_lam_thay" IS 'Mã nhân viên làm thay: Mã nhân viên làm thay liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."de_nghi_nghi"."ma_phien_ban_chinh_sach" IS 'Mã phiên bản chính sách: Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."de_nghi_nghi"."ma_phe_duyet" IS 'Mã phê duyệt: Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "nhan_su"."de_nghi_nghi" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "nhan_su"."su_kien_phep" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "loai" text CHECK ("loai" IN ('dau_ky','dieu_chinh_giam','dieu_chinh_tang','dung_phep','giai_phong','giu_nguon','phat_sinh_phep')),
  "so_phut_phat_sinh" bigint,
  "thoi_diem_thuc_hien_nghiep_vu" timestamptz,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_nhan_vien" uuid,
  "ma_chung_tu_de_nghi_nghi" uuid,
  "ma_su_kien_giu_goc" uuid,
  "ma_phe_duyet" uuid,
  "thoi_diem_he_thong_ghi_nhan" timestamptz,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "nhan_su"."su_kien_phep"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."su_kien_phep"."loai" IS 'Loại: Loại của sự kiện phép, phục vụ sổ phép đầu/phát sinh/giữ/dùng/điều chỉnh; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. Giá trị cho phép: dau_ky; phat_sinh_phep; giu_nguon; giai_phong; dung_phep; dieu_chinh_tang; dieu_chinh_giam.';
COMMENT ON COLUMN "nhan_su"."su_kien_phep"."so_phut_phat_sinh" IS 'Số phút phát sinh: Số phút phát sinh của sự kiện phép, phục vụ sổ phép đầu/phát sinh/giữ/dùng/điều chỉnh; được ghi bởi nhân sự theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."su_kien_phep"."thoi_diem_thuc_hien_nghiep_vu" IS 'Thời điểm thực hiện nghiệp vụ: Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện.';
COMMENT ON COLUMN "nhan_su"."su_kien_phep"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."su_kien_phep"."ma_nhan_vien" IS 'Mã nhân viên: Mã nhân viên liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."su_kien_phep"."ma_chung_tu_de_nghi_nghi" IS 'Mã chứng từ đề nghị nghỉ: Mã chứng từ đề nghị nghỉ liên kết nhan_su.de_nghi_nghi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."su_kien_phep"."ma_su_kien_giu_goc" IS 'Mã sự kiện giữ gốc: Mã sự kiện giữ gốc liên kết nhan_su.su_kien_phep đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."su_kien_phep"."ma_phe_duyet" IS 'Mã phê duyệt: Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."su_kien_phep"."thoi_diem_he_thong_ghi_nhan" IS 'Thời điểm hệ thống ghi nhận: Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc.';
COMMENT ON TABLE "nhan_su"."su_kien_phep" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "nhan_su"."thu_nhap_nhan_vien" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "trang_thai_xu_ly" text CHECK ("trang_thai_xu_ly" IN ('cho_kiem_tra_doc_lap','da_duyet','da_kiem_tra','tam_tinh')),
  "pham_vi_mo_phong_khoan_bat_buoc" text CHECK ("pham_vi_mo_phong_khoan_bat_buoc" IN ('chua_mo_phong')),
  "phep_tinh_ban_luu_tai_thoi_diem" jsonb,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_chung_tu_ky_tinh_thu_nhap" uuid,
  "ma_nhan_vien" uuid,
  "ma_ho_so_lam_viec_theo_hieu_luc" uuid,
  "ma_phe_duyet" uuid,
  "ma_dong_thu_nhap_goc" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "nhan_su"."thu_nhap_nhan_vien"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."thu_nhap_nhan_vien"."trang_thai_xu_ly" IS 'Trạng thái xử lý: Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: tam_tinh; da_kiem_tra; cho_kiem_tra_doc_lap; da_duyet.';
COMMENT ON COLUMN "nhan_su"."thu_nhap_nhan_vien"."pham_vi_mo_phong_khoan_bat_buoc" IS 'Phạm vi mô phỏng khoản bắt buộc: Phạm vi mô phỏng khoản bắt buộc của dòng thu nhập nhân viên, phục vụ thu nhập một người, duyệt từng dòng; được ghi bởi nhân sự / tài chính kiểm tra / người duyệt đủ quyền theo hồ sơ nguồn của bảng. Giá trị cho phép: chua_mo_phong.';
COMMENT ON COLUMN "nhan_su"."thu_nhap_nhan_vien"."phep_tinh_ban_luu_tai_thoi_diem" IS 'Phép tính bản lưu tại thời điểm: Phép tính bản lưu tại thời điểm của dòng thu nhập nhân viên, phục vụ thu nhập một người, duyệt từng dòng; được ghi bởi nhân sự / tài chính kiểm tra / người duyệt đủ quyền theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."thu_nhap_nhan_vien"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."thu_nhap_nhan_vien"."ma_chung_tu_ky_tinh_thu_nhap" IS 'Mã chứng từ kỳ tính thu nhập: Mã chứng từ kỳ tính thu nhập liên kết dung_chung.ky_nghiep_vu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."thu_nhap_nhan_vien"."ma_nhan_vien" IS 'Mã nhân viên: Mã nhân viên liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."thu_nhap_nhan_vien"."ma_ho_so_lam_viec_theo_hieu_luc" IS 'Mã hồ sơ làm việc theo hiệu lực: Mã hồ sơ làm việc theo hiệu lực liên kết nhan_su.ho_so_lam_viec_theo_hieu_luc đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."thu_nhap_nhan_vien"."ma_phe_duyet" IS 'Mã phê duyệt: Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."thu_nhap_nhan_vien"."ma_dong_thu_nhap_goc" IS 'Mã dòng thu nhập gốc: Mã dòng thu nhập gốc liên kết nhan_su.thu_nhap_nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "nhan_su"."thu_nhap_nhan_vien" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "nhan_su"."khoan_thu_nhap_co_can_cu" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "loai" text CHECK ("loai" IN ('dieu_chinh','lam_them','luong_thoi_gian','phu_cap_co_dinh','thuong_da_duyet')),
  "chieu_tang_giam" text CHECK ("chieu_tang_giam" IN ('giam','tang')),
  "so_tien" numeric(24,0),
  "so_phut_duoc_lay_lam_can_cu" bigint,
  "don_gia_tinh_tai_lan_xac_nhan" numeric(24,8),
  "ly_do" text,
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_dong_thu_nhap_nhan_vien" uuid,
  "ma_phien_ban_chinh_sach" uuid,
  "ma_phe_duyet" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0),
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "nhan_su"."khoan_thu_nhap_co_can_cu"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "nhan_su"."khoan_thu_nhap_co_can_cu"."loai" IS 'Loại: Loại của khoản thu nhập có căn cứ, phục vụ từng khoản lương/phụ cấp/chênh có căn cứ; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. Giá trị cho phép: luong_thoi_gian; phu_cap_co_dinh; thuong_da_duyet; lam_them; dieu_chinh.';
COMMENT ON COLUMN "nhan_su"."khoan_thu_nhap_co_can_cu"."chieu_tang_giam" IS 'Chiều tăng giảm: Chiều tăng giảm của khoản thu nhập có căn cứ, phục vụ từng khoản lương/phụ cấp/chênh có căn cứ; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. Giá trị cho phép: tang; giam.';
COMMENT ON COLUMN "nhan_su"."khoan_thu_nhap_co_can_cu"."so_tien" IS 'Số tiền: Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối.';
COMMENT ON COLUMN "nhan_su"."khoan_thu_nhap_co_can_cu"."so_phut_duoc_lay_lam_can_cu" IS 'Số phút được lấy làm căn cứ: Số phút được lấy làm căn cứ của khoản thu nhập có căn cứ, phục vụ từng khoản lương/phụ cấp/chênh có căn cứ; được ghi bởi nhân sự theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."khoan_thu_nhap_co_can_cu"."don_gia_tinh_tai_lan_xac_nhan" IS 'Đơn giá tính tại lần xác nhận: Đơn giá tính tại lần xác nhận của khoản thu nhập có căn cứ, phục vụ từng khoản lương/phụ cấp/chênh có căn cứ; được ghi bởi nhân sự theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."khoan_thu_nhap_co_can_cu"."ly_do" IS 'Lý do: Lý do của khoản thu nhập có căn cứ, phục vụ từng khoản lương/phụ cấp/chênh có căn cứ; được ghi bởi nhân sự theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "nhan_su"."khoan_thu_nhap_co_can_cu"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."khoan_thu_nhap_co_can_cu"."ma_dong_thu_nhap_nhan_vien" IS 'Mã dòng thu nhập nhân viên: Mã dòng thu nhập nhân viên liên kết nhan_su.thu_nhap_nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."khoan_thu_nhap_co_can_cu"."ma_phien_ban_chinh_sach" IS 'Mã phiên bản chính sách: Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."khoan_thu_nhap_co_can_cu"."ma_phe_duyet" IS 'Mã phê duyệt: Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."khoan_thu_nhap_co_can_cu"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "nhan_su"."khoan_thu_nhap_co_can_cu"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "nhan_su"."khoan_thu_nhap_co_can_cu"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON TABLE "nhan_su"."khoan_thu_nhap_co_can_cu" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "truy_cap"."phien_dang_nhap" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ban_bam_ma_phien_dang_nhap" text,
  "thoi_diem_cap_phien" timestamptz,
  "thoi_diem_het_hieu_luc" timestamptz,
  "thoi_diem_thu_hoi_quyen" timestamptz,
  "so_phien_ban_quyen_khi_cap_phien" bigint,
  "ma_tai_khoan" uuid,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0)
);
COMMENT ON COLUMN "truy_cap"."phien_dang_nhap"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "truy_cap"."phien_dang_nhap"."ban_bam_ma_phien_dang_nhap" IS 'Bản băm mã phiên đăng nhập: Bản băm mã phiên đăng nhập của phiên đăng nhập, phục vụ phiên đăng nhập có hạn và thu hồi; được ghi bởi hệ thống xác thực theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."phien_dang_nhap"."thoi_diem_cap_phien" IS 'Thời điểm cấp phiên: Thời điểm cấp phiên của phiên đăng nhập, phục vụ phiên đăng nhập có hạn và thu hồi; được ghi bởi hệ thống xác thực theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."phien_dang_nhap"."thoi_diem_het_hieu_luc" IS 'Thời điểm hết hiệu lực: Thời điểm hết hiệu lực của phiên đăng nhập, phục vụ phiên đăng nhập có hạn và thu hồi; được ghi bởi hệ thống xác thực theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."phien_dang_nhap"."thoi_diem_thu_hoi_quyen" IS 'Thời điểm thu hồi quyền: Thời điểm thu hồi quyền của phiên đăng nhập, phục vụ phiên đăng nhập có hạn và thu hồi; được ghi bởi hệ thống xác thực theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."phien_dang_nhap"."so_phien_ban_quyen_khi_cap_phien" IS 'Số phiên bản quyền khi cấp phiên: Số phiên bản quyền khi cấp phiên của phiên đăng nhập, phục vụ phiên đăng nhập có hạn và thu hồi; được ghi bởi hệ thống xác thực theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."phien_dang_nhap"."ma_tai_khoan" IS 'Mã tài khoản: Mã tài khoản liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."phien_dang_nhap"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "truy_cap"."phien_dang_nhap"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."phien_dang_nhap"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON TABLE "truy_cap"."phien_dang_nhap" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "tai_chinh"."nguon_cua_ban_chot_gia_thanh" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_bo_du_lieu" uuid NOT NULL,
  "ma_chung_tu_ban_chot_gia_thanh" uuid,
  "ma_dong_phan_bo_chi_phi" uuid,
  UNIQUE (ma_dinh_danh,ma_bo_du_lieu)
);
COMMENT ON COLUMN "tai_chinh"."nguon_cua_ban_chot_gia_thanh"."ma_dinh_danh" IS 'Mã định danh: Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."nguon_cua_ban_chot_gia_thanh"."ma_bo_du_lieu" IS 'Mã bộ dữ liệu: Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."nguon_cua_ban_chot_gia_thanh"."ma_chung_tu_ban_chot_gia_thanh" IS 'Mã chứng từ bản chốt giá thành: Mã chứng từ bản chốt giá thành liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "tai_chinh"."nguon_cua_ban_chot_gia_thanh"."ma_dong_phan_bo_chi_phi" IS 'Mã dòng phân bổ chi phí: Mã dòng phân bổ chi phí liên kết tai_chinh.phan_bo_chi_phi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON TABLE "tai_chinh"."nguon_cua_ban_chot_gia_thanh" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
CREATE TABLE "truy_cap"."dinh_danh_nguoi" (
  "ma_dinh_danh" uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  "ma_dinh_danh_nguoi" text,
  "ten_hien_thi" text,
  "trang_thai_xu_ly" text CHECK ("trang_thai_xu_ly" IN ('dang_su_dung','ngung_su_dung')),
  "gia_lap" boolean,
  "thoi_diem_tao" timestamptz NOT NULL DEFAULT now(),
  "ma_tai_khoan_thuc_hien" uuid,
  "so_phien_ban_ghi_dong_thoi" bigint NOT NULL DEFAULT 1 CHECK ("so_phien_ban_ghi_dong_thoi">0)
);
COMMENT ON COLUMN "truy_cap"."dinh_danh_nguoi"."ma_dinh_danh" IS 'Mã định danh: Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng.';
COMMENT ON COLUMN "truy_cap"."dinh_danh_nguoi"."ma_dinh_danh_nguoi" IS 'Mã định danh người: Mã định danh người của định danh người, phục vụ người thật ổn định qua tài khoản và các bộ mô phỏng; được ghi bởi quản trị định danh phối hợp hr theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."dinh_danh_nguoi"."ten_hien_thi" IS 'Tên hiển thị: Tên hiển thị của định danh người, phục vụ người thật ổn định qua tài khoản và các bộ mô phỏng; được ghi bởi quản trị định danh phối hợp hr theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."dinh_danh_nguoi"."trang_thai_xu_ly" IS 'Trạng thái xử lý: Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: dang_su_dung; ngung_su_dung.';
COMMENT ON COLUMN "truy_cap"."dinh_danh_nguoi"."gia_lap" IS 'Giả lập: Giả lập của định danh người, phục vụ người thật ổn định qua tài khoản và các bộ mô phỏng; được ghi bởi quản trị định danh phối hợp hr theo hồ sơ nguồn của bảng.';
COMMENT ON COLUMN "truy_cap"."dinh_danh_nguoi"."thoi_diem_tao" IS 'Thời điểm tạo: Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực.';
COMMENT ON COLUMN "truy_cap"."dinh_danh_nguoi"."ma_tai_khoan_thuc_hien" IS 'Mã tài khoản thực hiện: Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc.';
COMMENT ON COLUMN "truy_cap"."dinh_danh_nguoi"."so_phien_ban_ghi_dong_thoi" IS 'Số phiên bản ghi đồng thời: Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ.';
COMMENT ON TABLE "truy_cap"."dinh_danh_nguoi" IS 'Thiết kế B29; không tạo dữ liệu để hoàn tất kịch bản.';
ALTER TABLE "dung_chung"."doanh_nghiep" ADD CONSTRAINT fk_d917d97f51a5003513 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_d917d97f51a5003513 ON "dung_chung"."doanh_nghiep" ("ma_bo_du_lieu");
ALTER TABLE "dung_chung"."doanh_nghiep" ADD CONSTRAINT fk_43359d8cc98d5549cd FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_43359d8cc98d5549cd ON "dung_chung"."doanh_nghiep" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "dung_chung"."bo_phan" ADD CONSTRAINT fk_d579d5f10be8d9be3e FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_d579d5f10be8d9be3e ON "dung_chung"."bo_phan" ("ma_bo_du_lieu");
ALTER TABLE "dung_chung"."bo_phan" ADD CONSTRAINT fk_f400cb6475480b04bd FOREIGN KEY ("ma_doanh_nghiep",ma_bo_du_lieu) REFERENCES "dung_chung"."doanh_nghiep" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_f400cb6475480b04bd ON "dung_chung"."bo_phan" ("ma_doanh_nghiep");
ALTER TABLE "dung_chung"."bo_phan" ADD CONSTRAINT fk_000e76b70c53af95cf FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_000e76b70c53af95cf ON "dung_chung"."bo_phan" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "dung_chung"."vi_tri_giu_hang" ADD CONSTRAINT fk_d8e403a495dd4309a0 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_d8e403a495dd4309a0 ON "dung_chung"."vi_tri_giu_hang" ("ma_bo_du_lieu");
ALTER TABLE "dung_chung"."vi_tri_giu_hang" ADD CONSTRAINT fk_d513a98dfcd973dc64 FOREIGN KEY ("ma_doanh_nghiep",ma_bo_du_lieu) REFERENCES "dung_chung"."doanh_nghiep" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_d513a98dfcd973dc64 ON "dung_chung"."vi_tri_giu_hang" ("ma_doanh_nghiep");
ALTER TABLE "dung_chung"."vi_tri_giu_hang" ADD CONSTRAINT fk_6eb56766c2e0c39496 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_6eb56766c2e0c39496 ON "dung_chung"."vi_tri_giu_hang" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "dung_chung"."don_vi_tinh" ADD CONSTRAINT fk_dc57a5374777ac3cfb FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_dc57a5374777ac3cfb ON "dung_chung"."don_vi_tinh" ("ma_bo_du_lieu");
ALTER TABLE "dung_chung"."don_vi_tinh" ADD CONSTRAINT fk_54dd7ba0f9b857950f FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_54dd7ba0f9b857950f ON "dung_chung"."don_vi_tinh" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "dung_chung"."chung_tu" ADD CONSTRAINT fk_c220893be0f4232909 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_c220893be0f4232909 ON "dung_chung"."chung_tu" ("ma_bo_du_lieu");
ALTER TABLE "dung_chung"."chung_tu" ADD CONSTRAINT fk_e57c89eb7382489d4f FOREIGN KEY ("ma_chung_tu_goc",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_e57c89eb7382489d4f ON "dung_chung"."chung_tu" ("ma_chung_tu_goc");
ALTER TABLE "dung_chung"."chung_tu" ADD CONSTRAINT fk_7f0407df6d5652df81 FOREIGN KEY ("ma_nhan_vien_phu_trach",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_7f0407df6d5652df81 ON "dung_chung"."chung_tu" ("ma_nhan_vien_phu_trach");
ALTER TABLE "dung_chung"."chung_tu" ADD CONSTRAINT fk_05c813415e305edf5b FOREIGN KEY ("ma_tai_khoan_lap_chung_tu") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_05c813415e305edf5b ON "dung_chung"."chung_tu" ("ma_tai_khoan_lap_chung_tu");
ALTER TABLE "dung_chung"."chung_tu" ADD CONSTRAINT fk_01e2551a9b6436f61f FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_01e2551a9b6436f61f ON "dung_chung"."chung_tu" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "dung_chung"."chung_tu" ADD CONSTRAINT fk_2e80bc2a358857ff66 FOREIGN KEY ("ma_bien_nhan_xac_nhan_giao_dich",ma_bo_du_lieu) REFERENCES "truy_cap"."bien_nhan_xac_nhan_giao_dich" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_2e80bc2a358857ff66 ON "dung_chung"."chung_tu" ("ma_bien_nhan_xac_nhan_giao_dich");
ALTER TABLE "dung_chung"."chung_tu" ADD CONSTRAINT fk_cc830d1d27927b51a8 FOREIGN KEY ("ma_nhan_vien_dem_thuc",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_cc830d1d27927b51a8 ON "dung_chung"."chung_tu" ("ma_nhan_vien_dem_thuc");
ALTER TABLE "dung_chung"."chung_tu" ADD CONSTRAINT fk_02c4cf139cc139eda3 FOREIGN KEY ("ma_nhan_vien_doi_chieu",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_02c4cf139cc139eda3 ON "dung_chung"."chung_tu" ("ma_nhan_vien_doi_chieu");
ALTER TABLE "dung_chung"."chung_tu" ADD CONSTRAINT fk_65329bd85882e8cbc9 FOREIGN KEY ("ma_chung_tu_don_hang",ma_bo_du_lieu) REFERENCES "kinh_doanh"."bao_gia_va_don_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_65329bd85882e8cbc9 ON "dung_chung"."chung_tu" ("ma_chung_tu_don_hang");
ALTER TABLE "dung_chung"."chung_tu" ADD CONSTRAINT fk_3680ae2a65e92ae7c7 FOREIGN KEY ("ma_ho_so_xu_ly_thuong_mai",ma_bo_du_lieu) REFERENCES "kinh_doanh"."ho_so_xu_ly" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_3680ae2a65e92ae7c7 ON "dung_chung"."chung_tu" ("ma_ho_so_xu_ly_thuong_mai");
ALTER TABLE "dung_chung"."chung_tu" ADD CONSTRAINT fk_b7782814865d6f43fc FOREIGN KEY ("ma_phe_duyet",ma_bo_du_lieu) REFERENCES "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_b7782814865d6f43fc ON "dung_chung"."chung_tu" ("ma_phe_duyet");
ALTER TABLE "dung_chung"."chung_tu" ADD CONSTRAINT fk_b2c451b45c4834dcc3 FOREIGN KEY ("ma_lo_san_xuat",ma_bo_du_lieu) REFERENCES "san_xuat"."lo_san_xuat" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_b2c451b45c4834dcc3 ON "dung_chung"."chung_tu" ("ma_lo_san_xuat");
ALTER TABLE "dung_chung"."chung_tu" ADD CONSTRAINT fk_a8ed9058191ac6a103 FOREIGN KEY ("ma_phien_ban_chinh_sach_dinh_gia",ma_bo_du_lieu) REFERENCES "dung_chung"."phien_ban_chinh_sach" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_a8ed9058191ac6a103 ON "dung_chung"."chung_tu" ("ma_phien_ban_chinh_sach_dinh_gia");
ALTER TABLE "dung_chung"."chung_tu" ADD CONSTRAINT fk_f283a6463e71b681a1 FOREIGN KEY ("ma_nhan_vien",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_f283a6463e71b681a1 ON "dung_chung"."chung_tu" ("ma_nhan_vien");
ALTER TABLE "dung_chung"."chung_tu" ADD CONSTRAINT fk_2ca566af4d6efc09a6 FOREIGN KEY ("ma_ngay_va_ca_lam_viec",ma_bo_du_lieu) REFERENCES "nhan_su"."ngay_va_ca_lam_viec" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_2ca566af4d6efc09a6 ON "dung_chung"."chung_tu" ("ma_ngay_va_ca_lam_viec");
ALTER TABLE "dung_chung"."chung_tu" ADD CONSTRAINT fk_153314cd0294fee0c6 FOREIGN KEY ("ma_ban_chung_tu_bi_thay",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_153314cd0294fee0c6 ON "dung_chung"."chung_tu" ("ma_ban_chung_tu_bi_thay");
ALTER TABLE "dung_chung"."chung_tu" ADD CONSTRAINT fk_eeefcabf90cac74dd7 FOREIGN KEY ("ma_nhan_vien_xac_nhan",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_eeefcabf90cac74dd7 ON "dung_chung"."chung_tu" ("ma_nhan_vien_xac_nhan");
ALTER TABLE "dung_chung"."chung_tu" ADD CONSTRAINT fk_eb68234c24f5b076d3 FOREIGN KEY ("ma_ky",ma_bo_du_lieu) REFERENCES "dung_chung"."ky_nghiep_vu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_eb68234c24f5b076d3 ON "dung_chung"."chung_tu" ("ma_ky");
ALTER TABLE "dung_chung"."dong_chung_tu" ADD CONSTRAINT fk_4927a4562e8a3bfe1f FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_4927a4562e8a3bfe1f ON "dung_chung"."dong_chung_tu" ("ma_bo_du_lieu");
ALTER TABLE "dung_chung"."dong_chung_tu" ADD CONSTRAINT fk_35d9e88784fc021a5b FOREIGN KEY ("ma_phien_ban_chung_tu",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_35d9e88784fc021a5b ON "dung_chung"."dong_chung_tu" ("ma_phien_ban_chung_tu");
ALTER TABLE "dung_chung"."dong_chung_tu" ADD CONSTRAINT fk_4bc0933d9854e9ac9a FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_4bc0933d9854e9ac9a ON "dung_chung"."dong_chung_tu" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "dung_chung"."lien_ket_chung_tu" ADD CONSTRAINT fk_3451d90f2116560ac9 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_3451d90f2116560ac9 ON "dung_chung"."lien_ket_chung_tu" ("ma_bo_du_lieu");
ALTER TABLE "dung_chung"."lien_ket_chung_tu" ADD CONSTRAINT fk_a33325c8d76d5d0082 FOREIGN KEY ("ma_chung_tu_nguon_lien_ket",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_a33325c8d76d5d0082 ON "dung_chung"."lien_ket_chung_tu" ("ma_chung_tu_nguon_lien_ket");
ALTER TABLE "dung_chung"."lien_ket_chung_tu" ADD CONSTRAINT fk_f5f16f3353d950ce9f FOREIGN KEY ("ma_chung_tu_dich_lien_ket",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_f5f16f3353d950ce9f ON "dung_chung"."lien_ket_chung_tu" ("ma_chung_tu_dich_lien_ket");
ALTER TABLE "dung_chung"."lien_ket_chung_tu" ADD CONSTRAINT fk_e5405265e8f165ea7b FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_e5405265e8f165ea7b ON "dung_chung"."lien_ket_chung_tu" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ADD CONSTRAINT fk_48f2669cd6b072e182 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_48f2669cd6b072e182 ON "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_bo_du_lieu");
ALTER TABLE "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ADD CONSTRAINT fk_aec1c10b51c65a272c FOREIGN KEY ("ma_phien_ban_chung_tu",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_aec1c10b51c65a272c ON "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_phien_ban_chung_tu");
ALTER TABLE "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ADD CONSTRAINT fk_f6b1a41ade210526f3 FOREIGN KEY ("ma_dong_chung_tu",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_f6b1a41ade210526f3 ON "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_dong_chung_tu");
ALTER TABLE "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ADD CONSTRAINT fk_cc2a870c182703e81c FOREIGN KEY ("ma_nhan_vien_de_nghi",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_cc2a870c182703e81c ON "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_nhan_vien_de_nghi");
ALTER TABLE "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ADD CONSTRAINT fk_121953dadac53e91a4 FOREIGN KEY ("ma_nhan_vien_kiem_tra",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_121953dadac53e91a4 ON "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_nhan_vien_kiem_tra");
ALTER TABLE "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ADD CONSTRAINT fk_d3c5671a328887cc6a FOREIGN KEY ("ma_nhan_vien_quyet_dinh",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_d3c5671a328887cc6a ON "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_nhan_vien_quyet_dinh");
ALTER TABLE "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ADD CONSTRAINT fk_8e98231c480a31b33c FOREIGN KEY ("ma_uy_quyen",ma_bo_du_lieu) REFERENCES "truy_cap"."uy_quyen" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_8e98231c480a31b33c ON "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_uy_quyen");
ALTER TABLE "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ADD CONSTRAINT fk_e18f9f7f878d71ac1d FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_e18f9f7f878d71ac1d ON "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "dung_chung"."trao_doi_va_ban_giao" ADD CONSTRAINT fk_13c6711a61ec547b37 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_13c6711a61ec547b37 ON "dung_chung"."trao_doi_va_ban_giao" ("ma_bo_du_lieu");
ALTER TABLE "dung_chung"."trao_doi_va_ban_giao" ADD CONSTRAINT fk_9b635ace3ed87b02f2 FOREIGN KEY ("ma_phien_ban_chung_tu",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_9b635ace3ed87b02f2 ON "dung_chung"."trao_doi_va_ban_giao" ("ma_phien_ban_chung_tu");
ALTER TABLE "dung_chung"."trao_doi_va_ban_giao" ADD CONSTRAINT fk_6534cd699939ff11c5 FOREIGN KEY ("ma_dong_chung_tu",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_6534cd699939ff11c5 ON "dung_chung"."trao_doi_va_ban_giao" ("ma_dong_chung_tu");
ALTER TABLE "dung_chung"."trao_doi_va_ban_giao" ADD CONSTRAINT fk_37c23b9297b14b6912 FOREIGN KEY ("ma_nhan_vien_ban_giao",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_37c23b9297b14b6912 ON "dung_chung"."trao_doi_va_ban_giao" ("ma_nhan_vien_ban_giao");
ALTER TABLE "dung_chung"."trao_doi_va_ban_giao" ADD CONSTRAINT fk_4e355d0c8dd02c6a72 FOREIGN KEY ("ma_nhan_vien_nhan_ban_giao",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_4e355d0c8dd02c6a72 ON "dung_chung"."trao_doi_va_ban_giao" ("ma_nhan_vien_nhan_ban_giao");
ALTER TABLE "dung_chung"."trao_doi_va_ban_giao" ADD CONSTRAINT fk_a90cb6163429b741b6 FOREIGN KEY ("ma_don_vi",ma_bo_du_lieu) REFERENCES "dung_chung"."don_vi_tinh" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_a90cb6163429b741b6 ON "dung_chung"."trao_doi_va_ban_giao" ("ma_don_vi");
ALTER TABLE "dung_chung"."trao_doi_va_ban_giao" ADD CONSTRAINT fk_a2b542be9d6cd23820 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_a2b542be9d6cd23820 ON "dung_chung"."trao_doi_va_ban_giao" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "dung_chung"."trao_doi_va_ban_giao" ADD CONSTRAINT fk_d0a4b8c122ab80efc3 FOREIGN KEY ("ma_tai_khoan_nhap_du_lieu") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_d0a4b8c122ab80efc3 ON "dung_chung"."trao_doi_va_ban_giao" ("ma_tai_khoan_nhap_du_lieu");
ALTER TABLE "dung_chung"."trao_doi_va_ban_giao" ADD CONSTRAINT fk_a84892df434fc913a0 FOREIGN KEY ("ma_nhan_vien",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_a84892df434fc913a0 ON "dung_chung"."trao_doi_va_ban_giao" ("ma_nhan_vien");
ALTER TABLE "dung_chung"."trao_doi_va_ban_giao" ADD CONSTRAINT fk_8fd3f2bca57ce980dd FOREIGN KEY ("ma_dong_van_dong_hang",ma_bo_du_lieu) REFERENCES "kho"."dong_van_dong_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_8fd3f2bca57ce980dd ON "dung_chung"."trao_doi_va_ban_giao" ("ma_dong_van_dong_hang");
ALTER TABLE "dung_chung"."trao_doi_va_ban_giao" ADD CONSTRAINT fk_4220731cc3feb3e794 FOREIGN KEY ("ma_ban_giao_goc",ma_bo_du_lieu) REFERENCES "dung_chung"."trao_doi_va_ban_giao" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_4220731cc3feb3e794 ON "dung_chung"."trao_doi_va_ban_giao" ("ma_ban_giao_goc");
ALTER TABLE "dung_chung"."chung_cu_dinh_kem" ADD CONSTRAINT fk_3234968ce0e2b4ab0f FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_3234968ce0e2b4ab0f ON "dung_chung"."chung_cu_dinh_kem" ("ma_bo_du_lieu");
ALTER TABLE "dung_chung"."chung_cu_dinh_kem" ADD CONSTRAINT fk_8adc3283581ca0328b FOREIGN KEY ("ma_phien_ban_chung_tu",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_8adc3283581ca0328b ON "dung_chung"."chung_cu_dinh_kem" ("ma_phien_ban_chung_tu");
ALTER TABLE "dung_chung"."chung_cu_dinh_kem" ADD CONSTRAINT fk_bdffcbd3aee6108410 FOREIGN KEY ("ma_dong_chung_tu",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_bdffcbd3aee6108410 ON "dung_chung"."chung_cu_dinh_kem" ("ma_dong_chung_tu");
ALTER TABLE "dung_chung"."chung_cu_dinh_kem" ADD CONSTRAINT fk_12e818f11035b26f79 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_12e818f11035b26f79 ON "dung_chung"."chung_cu_dinh_kem" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "dung_chung"."nhat_ky_thao_tac" ADD CONSTRAINT fk_54c5cc1ebd6b60c9ff FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_54c5cc1ebd6b60c9ff ON "dung_chung"."nhat_ky_thao_tac" ("ma_bo_du_lieu");
ALTER TABLE "dung_chung"."nhat_ky_thao_tac" ADD CONSTRAINT fk_c229e9fecdf60f4384 FOREIGN KEY ("ma_phien_ban_chung_tu",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_c229e9fecdf60f4384 ON "dung_chung"."nhat_ky_thao_tac" ("ma_phien_ban_chung_tu");
ALTER TABLE "dung_chung"."nhat_ky_thao_tac" ADD CONSTRAINT fk_956dae4fe379c7b023 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_956dae4fe379c7b023 ON "dung_chung"."nhat_ky_thao_tac" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "dung_chung"."nhat_ky_thao_tac" ADD CONSTRAINT fk_86a7e7d562594540d3 FOREIGN KEY ("ma_nhan_vien_duoc_ghi_nhan_thay",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_86a7e7d562594540d3 ON "dung_chung"."nhat_ky_thao_tac" ("ma_nhan_vien_duoc_ghi_nhan_thay");
ALTER TABLE "dung_chung"."ky_nghiep_vu" ADD CONSTRAINT fk_9c16ecfa0e0c85589a FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_9c16ecfa0e0c85589a ON "dung_chung"."ky_nghiep_vu" ("ma_bo_du_lieu");
ALTER TABLE "dung_chung"."ky_nghiep_vu" ADD CONSTRAINT fk_05b8f7140ca4652687 FOREIGN KEY ("ma_chung_tu_quyet_dinh_chot_ky",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_05b8f7140ca4652687 ON "dung_chung"."ky_nghiep_vu" ("ma_chung_tu_quyet_dinh_chot_ky");
ALTER TABLE "dung_chung"."ky_nghiep_vu" ADD CONSTRAINT fk_3598c884a1d928baa9 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_3598c884a1d928baa9 ON "dung_chung"."ky_nghiep_vu" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "dung_chung"."ky_nghiep_vu" ADD CONSTRAINT fk_59b47218b7ca305376 FOREIGN KEY ("ma_chung_tu_ky_thu_nhap",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_59b47218b7ca305376 ON "dung_chung"."ky_nghiep_vu" ("ma_chung_tu_ky_thu_nhap");
ALTER TABLE "dung_chung"."ky_nghiep_vu" ADD CONSTRAINT fk_61d7fbb309949a9fcf FOREIGN KEY ("ma_ky_goc",ma_bo_du_lieu) REFERENCES "dung_chung"."ky_nghiep_vu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_61d7fbb309949a9fcf ON "dung_chung"."ky_nghiep_vu" ("ma_ky_goc");
ALTER TABLE "dung_chung"."ky_nghiep_vu" ADD CONSTRAINT fk_8bbbfea469c67bfd21 FOREIGN KEY ("ma_chung_tu_chot_cong",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_8bbbfea469c67bfd21 ON "dung_chung"."ky_nghiep_vu" ("ma_chung_tu_chot_cong");
ALTER TABLE "dung_chung"."ky_nghiep_vu" ADD CONSTRAINT fk_1bd1d7f7ff05d1d138 FOREIGN KEY ("ma_phien_ban_chinh_sach",ma_bo_du_lieu) REFERENCES "dung_chung"."phien_ban_chinh_sach" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_1bd1d7f7ff05d1d138 ON "dung_chung"."ky_nghiep_vu" ("ma_phien_ban_chinh_sach");
ALTER TABLE "dung_chung"."ky_nghiep_vu" ADD CONSTRAINT fk_3472a4c8ac5723eaf9 FOREIGN KEY ("ma_ban_ky_bi_thay",ma_bo_du_lieu) REFERENCES "dung_chung"."ky_nghiep_vu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_3472a4c8ac5723eaf9 ON "dung_chung"."ky_nghiep_vu" ("ma_ban_ky_bi_thay");
ALTER TABLE "dung_chung"."phien_ban_chinh_sach" ADD CONSTRAINT fk_31781120e3261d0e24 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_31781120e3261d0e24 ON "dung_chung"."phien_ban_chinh_sach" ("ma_bo_du_lieu");
ALTER TABLE "dung_chung"."phien_ban_chinh_sach" ADD CONSTRAINT fk_3925b230fb1ea082c6 FOREIGN KEY ("ma_phe_duyet",ma_bo_du_lieu) REFERENCES "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_3925b230fb1ea082c6 ON "dung_chung"."phien_ban_chinh_sach" ("ma_phe_duyet");
ALTER TABLE "dung_chung"."phien_ban_chinh_sach" ADD CONSTRAINT fk_6cc15de097694e35f9 FOREIGN KEY ("ma_chung_tu_can_cu_khai_bao",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_6cc15de097694e35f9 ON "dung_chung"."phien_ban_chinh_sach" ("ma_chung_tu_can_cu_khai_bao");
ALTER TABLE "dung_chung"."phien_ban_chinh_sach" ADD CONSTRAINT fk_07fed592a63be19167 FOREIGN KEY ("ma_nguoi_khai_bao_du_lieu",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_07fed592a63be19167 ON "dung_chung"."phien_ban_chinh_sach" ("ma_nguoi_khai_bao_du_lieu");
ALTER TABLE "dung_chung"."phien_ban_chinh_sach" ADD CONSTRAINT fk_4214da834701ebb2af FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_4214da834701ebb2af ON "dung_chung"."phien_ban_chinh_sach" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "dung_chung"."bo_du_lieu_mo_phong" ADD CONSTRAINT fk_b95227ec8eac50a1a3 FOREIGN KEY ("ma_bo_du_lieu_cha") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_b95227ec8eac50a1a3 ON "dung_chung"."bo_du_lieu_mo_phong" ("ma_bo_du_lieu_cha");
ALTER TABLE "dung_chung"."bo_du_lieu_mo_phong" ADD CONSTRAINT fk_8e66635f21ab1f5c2c FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_8e66635f21ab1f5c2c ON "dung_chung"."bo_du_lieu_mo_phong" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "truy_cap"."tai_khoan_dang_nhap" ADD CONSTRAINT fk_eff8de73dfe872c6fb FOREIGN KEY ("ma_nguoi_that") REFERENCES "truy_cap"."dinh_danh_nguoi" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_eff8de73dfe872c6fb ON "truy_cap"."tai_khoan_dang_nhap" ("ma_nguoi_that");
ALTER TABLE "truy_cap"."tai_khoan_dang_nhap" ADD CONSTRAINT fk_afa6c0599851e17a67 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_afa6c0599851e17a67 ON "truy_cap"."tai_khoan_dang_nhap" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "truy_cap"."vai_tro_cong_viec" ADD CONSTRAINT fk_102007793587642d06 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_102007793587642d06 ON "truy_cap"."vai_tro_cong_viec" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "truy_cap"."quyen_thao_tac" ADD CONSTRAINT fk_5dfc43cbbf2140da48 FOREIGN KEY ("ma_vai_tro") REFERENCES "truy_cap"."vai_tro_cong_viec" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_5dfc43cbbf2140da48 ON "truy_cap"."quyen_thao_tac" ("ma_vai_tro");
ALTER TABLE "truy_cap"."quyen_thao_tac" ADD CONSTRAINT fk_af48517e160af00ae7 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_af48517e160af00ae7 ON "truy_cap"."quyen_thao_tac" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "truy_cap"."cap_vai_tro" ADD CONSTRAINT fk_01cd13dcd919e50b51 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_01cd13dcd919e50b51 ON "truy_cap"."cap_vai_tro" ("ma_bo_du_lieu");
ALTER TABLE "truy_cap"."cap_vai_tro" ADD CONSTRAINT fk_730af37d4b060dfbec FOREIGN KEY ("ma_tai_khoan") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_730af37d4b060dfbec ON "truy_cap"."cap_vai_tro" ("ma_tai_khoan");
ALTER TABLE "truy_cap"."cap_vai_tro" ADD CONSTRAINT fk_0e050880be8d2536ee FOREIGN KEY ("ma_vai_tro") REFERENCES "truy_cap"."vai_tro_cong_viec" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_0e050880be8d2536ee ON "truy_cap"."cap_vai_tro" ("ma_vai_tro");
ALTER TABLE "truy_cap"."cap_vai_tro" ADD CONSTRAINT fk_9bd645ea4203e8aabf FOREIGN KEY ("ma_phe_duyet",ma_bo_du_lieu) REFERENCES "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_9bd645ea4203e8aabf ON "truy_cap"."cap_vai_tro" ("ma_phe_duyet");
ALTER TABLE "truy_cap"."cap_vai_tro" ADD CONSTRAINT fk_876e700545dbbf1640 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_876e700545dbbf1640 ON "truy_cap"."cap_vai_tro" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "truy_cap"."uy_quyen" ADD CONSTRAINT fk_7c2ca211ea0e2a564f FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_7c2ca211ea0e2a564f ON "truy_cap"."uy_quyen" ("ma_bo_du_lieu");
ALTER TABLE "truy_cap"."uy_quyen" ADD CONSTRAINT fk_d8bfa1ed9a670c1c77 FOREIGN KEY ("ma_nhan_vien_giao_uy_quyen",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_d8bfa1ed9a670c1c77 ON "truy_cap"."uy_quyen" ("ma_nhan_vien_giao_uy_quyen");
ALTER TABLE "truy_cap"."uy_quyen" ADD CONSTRAINT fk_b24975f76cb4f37830 FOREIGN KEY ("ma_nhan_vien_nhan_uy_quyen",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_b24975f76cb4f37830 ON "truy_cap"."uy_quyen" ("ma_nhan_vien_nhan_uy_quyen");
ALTER TABLE "truy_cap"."uy_quyen" ADD CONSTRAINT fk_0ee22172cfdd2505d6 FOREIGN KEY ("ma_phien_ban_chung_tu",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_0ee22172cfdd2505d6 ON "truy_cap"."uy_quyen" ("ma_phien_ban_chung_tu");
ALTER TABLE "truy_cap"."uy_quyen" ADD CONSTRAINT fk_8d225a4669d7f7cedc FOREIGN KEY ("ma_phe_duyet",ma_bo_du_lieu) REFERENCES "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_8d225a4669d7f7cedc ON "truy_cap"."uy_quyen" ("ma_phe_duyet");
ALTER TABLE "truy_cap"."uy_quyen" ADD CONSTRAINT fk_ee48fe5d3ab3796b55 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_ee48fe5d3ab3796b55 ON "truy_cap"."uy_quyen" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "truy_cap"."bien_nhan_xac_nhan_giao_dich" ADD CONSTRAINT fk_4299f53680d4f64b8d FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_4299f53680d4f64b8d ON "truy_cap"."bien_nhan_xac_nhan_giao_dich" ("ma_bo_du_lieu");
ALTER TABLE "truy_cap"."bien_nhan_xac_nhan_giao_dich" ADD CONSTRAINT fk_d806d289fe2c962697 FOREIGN KEY ("ma_tai_khoan") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_d806d289fe2c962697 ON "truy_cap"."bien_nhan_xac_nhan_giao_dich" ("ma_tai_khoan");
ALTER TABLE "truy_cap"."bien_nhan_xac_nhan_giao_dich" ADD CONSTRAINT fk_dabea92ef0d3fbf209 FOREIGN KEY ("ma_phien_ban_chung_tu",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_dabea92ef0d3fbf209 ON "truy_cap"."bien_nhan_xac_nhan_giao_dich" ("ma_phien_ban_chung_tu");
ALTER TABLE "truy_cap"."bien_nhan_xac_nhan_giao_dich" ADD CONSTRAINT fk_381db12330b6f7b022 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_381db12330b6f7b022 ON "truy_cap"."bien_nhan_xac_nhan_giao_dich" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "danh_muc"."mat_hang" ADD CONSTRAINT fk_adeec12978f443b3df FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_adeec12978f443b3df ON "danh_muc"."mat_hang" ("ma_bo_du_lieu");
ALTER TABLE "danh_muc"."mat_hang" ADD CONSTRAINT fk_5bd41e77a58f6a9b2d FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_5bd41e77a58f6a9b2d ON "danh_muc"."mat_hang" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "danh_muc"."mat_hang" ADD CONSTRAINT fk_787cc8581a23bbab3e FOREIGN KEY ("ma_nhom_mau",ma_bo_du_lieu) REFERENCES "danh_muc"."mat_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_787cc8581a23bbab3e ON "danh_muc"."mat_hang" ("ma_nhom_mau");
ALTER TABLE "danh_muc"."mat_hang" ADD CONSTRAINT fk_eb4981749ba1b72fcb FOREIGN KEY ("ma_don_vi_co_so",ma_bo_du_lieu) REFERENCES "dung_chung"."don_vi_tinh" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_eb4981749ba1b72fcb ON "danh_muc"."mat_hang" ("ma_don_vi_co_so");
ALTER TABLE "danh_muc"."mat_hang" ADD CONSTRAINT fk_8fc0cde53cec0f1bd2 FOREIGN KEY ("ma_phien_ban_quy_cach",ma_bo_du_lieu) REFERENCES "dung_chung"."phien_ban_chinh_sach" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_8fc0cde53cec0f1bd2 ON "danh_muc"."mat_hang" ("ma_phien_ban_quy_cach");
ALTER TABLE "danh_muc"."ma_goi_khac" ADD CONSTRAINT fk_180ba39173136329db FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_180ba39173136329db ON "danh_muc"."ma_goi_khac" ("ma_bo_du_lieu");
ALTER TABLE "danh_muc"."ma_goi_khac" ADD CONSTRAINT fk_419e7c8cd0d8032ce9 FOREIGN KEY ("ma_mat_hang",ma_bo_du_lieu) REFERENCES "danh_muc"."mat_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_419e7c8cd0d8032ce9 ON "danh_muc"."ma_goi_khac" ("ma_mat_hang");
ALTER TABLE "danh_muc"."ma_goi_khac" ADD CONSTRAINT fk_45fa6395c4ef00cfe1 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_45fa6395c4ef00cfe1 ON "danh_muc"."ma_goi_khac" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "danh_muc"."quy_doi_don_vi" ADD CONSTRAINT fk_d0fc3c1a74b6a9cd66 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_d0fc3c1a74b6a9cd66 ON "danh_muc"."quy_doi_don_vi" ("ma_bo_du_lieu");
ALTER TABLE "danh_muc"."quy_doi_don_vi" ADD CONSTRAINT fk_601933c3b708ecab05 FOREIGN KEY ("ma_mat_hang",ma_bo_du_lieu) REFERENCES "danh_muc"."mat_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_601933c3b708ecab05 ON "danh_muc"."quy_doi_don_vi" ("ma_mat_hang");
ALTER TABLE "danh_muc"."quy_doi_don_vi" ADD CONSTRAINT fk_e043175e2880c94ad2 FOREIGN KEY ("ma_don_vi_quy_doi_nguon",ma_bo_du_lieu) REFERENCES "dung_chung"."don_vi_tinh" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_e043175e2880c94ad2 ON "danh_muc"."quy_doi_don_vi" ("ma_don_vi_quy_doi_nguon");
ALTER TABLE "danh_muc"."quy_doi_don_vi" ADD CONSTRAINT fk_8872d1b018470a57b5 FOREIGN KEY ("ma_don_vi_quy_doi_dich",ma_bo_du_lieu) REFERENCES "dung_chung"."don_vi_tinh" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_8872d1b018470a57b5 ON "danh_muc"."quy_doi_don_vi" ("ma_don_vi_quy_doi_dich");
ALTER TABLE "danh_muc"."quy_doi_don_vi" ADD CONSTRAINT fk_e152bd56153267905f FOREIGN KEY ("ma_phe_duyet",ma_bo_du_lieu) REFERENCES "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_e152bd56153267905f ON "danh_muc"."quy_doi_don_vi" ("ma_phe_duyet");
ALTER TABLE "danh_muc"."quy_doi_don_vi" ADD CONSTRAINT fk_46293cdfb793e2880b FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_46293cdfb793e2880b ON "danh_muc"."quy_doi_don_vi" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "dung_chung"."doi_tac" ADD CONSTRAINT fk_28054e51eb514c6163 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_28054e51eb514c6163 ON "dung_chung"."doi_tac" ("ma_bo_du_lieu");
ALTER TABLE "dung_chung"."doi_tac" ADD CONSTRAINT fk_befcf488487a1af43a FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_befcf488487a1af43a ON "dung_chung"."doi_tac" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "dung_chung"."lien_he_doi_tac" ADD CONSTRAINT fk_c02f4d1d4884450671 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_c02f4d1d4884450671 ON "dung_chung"."lien_he_doi_tac" ("ma_bo_du_lieu");
ALTER TABLE "dung_chung"."lien_he_doi_tac" ADD CONSTRAINT fk_666a5de9eba7207295 FOREIGN KEY ("ma_doi_tac",ma_bo_du_lieu) REFERENCES "dung_chung"."doi_tac" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_666a5de9eba7207295 ON "dung_chung"."lien_he_doi_tac" ("ma_doi_tac");
ALTER TABLE "dung_chung"."lien_he_doi_tac" ADD CONSTRAINT fk_cf22285a35e653e9d1 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_cf22285a35e653e9d1 ON "dung_chung"."lien_he_doi_tac" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "dung_chung"."can_cu_dai_dien" ADD CONSTRAINT fk_87916ce4d57bcfa5f3 FOREIGN KEY ("ma_chung_tu_lam_can_cu",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_87916ce4d57bcfa5f3 ON "dung_chung"."can_cu_dai_dien" ("ma_chung_tu_lam_can_cu");
ALTER TABLE "dung_chung"."can_cu_dai_dien" ADD CONSTRAINT fk_da98a0e64cbf9ee358 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_da98a0e64cbf9ee358 ON "dung_chung"."can_cu_dai_dien" ("ma_bo_du_lieu");
ALTER TABLE "dung_chung"."can_cu_dai_dien" ADD CONSTRAINT fk_77c0da28ac2fb02a14 FOREIGN KEY ("ma_doi_tac",ma_bo_du_lieu) REFERENCES "dung_chung"."doi_tac" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_77c0da28ac2fb02a14 ON "dung_chung"."can_cu_dai_dien" ("ma_doi_tac");
ALTER TABLE "dung_chung"."can_cu_dai_dien" ADD CONSTRAINT fk_5cdbaedaa7eed6cacc FOREIGN KEY ("ma_lien_he",ma_bo_du_lieu) REFERENCES "dung_chung"."lien_he_doi_tac" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_5cdbaedaa7eed6cacc ON "dung_chung"."can_cu_dai_dien" ("ma_lien_he");
ALTER TABLE "dung_chung"."can_cu_dai_dien" ADD CONSTRAINT fk_69ba8088c29c01cb2a FOREIGN KEY ("ma_chung_tu_xac_dinh_pham_vi",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_69ba8088c29c01cb2a ON "dung_chung"."can_cu_dai_dien" ("ma_chung_tu_xac_dinh_pham_vi");
ALTER TABLE "dung_chung"."can_cu_dai_dien" ADD CONSTRAINT fk_c67b555127d0f9d218 FOREIGN KEY ("ma_doi_tac_dai_dien",ma_bo_du_lieu) REFERENCES "dung_chung"."doi_tac" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_c67b555127d0f9d218 ON "dung_chung"."can_cu_dai_dien" ("ma_doi_tac_dai_dien");
ALTER TABLE "dung_chung"."can_cu_dai_dien" ADD CONSTRAINT fk_624d5813efa5bc84ce FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_624d5813efa5bc84ce ON "dung_chung"."can_cu_dai_dien" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "kinh_doanh"."nhu_cau_khach_hang" ADD CONSTRAINT fk_f83ea9bd45ed8f6c37 FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_f83ea9bd45ed8f6c37 ON "kinh_doanh"."nhu_cau_khach_hang" ("ma_dinh_danh");
ALTER TABLE "kinh_doanh"."nhu_cau_khach_hang" ADD CONSTRAINT fk_1ed0c119be96ef6519 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_1ed0c119be96ef6519 ON "kinh_doanh"."nhu_cau_khach_hang" ("ma_bo_du_lieu");
ALTER TABLE "kinh_doanh"."nhu_cau_khach_hang" ADD CONSTRAINT fk_70a9e903ed289a9062 FOREIGN KEY ("ma_khach_hang",ma_bo_du_lieu) REFERENCES "dung_chung"."doi_tac" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_70a9e903ed289a9062 ON "kinh_doanh"."nhu_cau_khach_hang" ("ma_khach_hang");
ALTER TABLE "kinh_doanh"."nhu_cau_khach_hang" ADD CONSTRAINT fk_52e254a7e4d8f9cddc FOREIGN KEY ("ma_lien_he",ma_bo_du_lieu) REFERENCES "dung_chung"."lien_he_doi_tac" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_52e254a7e4d8f9cddc ON "kinh_doanh"."nhu_cau_khach_hang" ("ma_lien_he");
ALTER TABLE "kinh_doanh"."bao_gia_va_don_hang" ADD CONSTRAINT fk_107b87a42899142b1f FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_107b87a42899142b1f ON "kinh_doanh"."bao_gia_va_don_hang" ("ma_dinh_danh");
ALTER TABLE "kinh_doanh"."bao_gia_va_don_hang" ADD CONSTRAINT fk_bb5b64e1f6489ac45d FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_bb5b64e1f6489ac45d ON "kinh_doanh"."bao_gia_va_don_hang" ("ma_bo_du_lieu");
ALTER TABLE "kinh_doanh"."bao_gia_va_don_hang" ADD CONSTRAINT fk_03772051386f452173 FOREIGN KEY ("ma_chung_tu_nhu_cau_khach",ma_bo_du_lieu) REFERENCES "kinh_doanh"."nhu_cau_khach_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_03772051386f452173 ON "kinh_doanh"."bao_gia_va_don_hang" ("ma_chung_tu_nhu_cau_khach");
ALTER TABLE "kinh_doanh"."bao_gia_va_don_hang" ADD CONSTRAINT fk_99cf1849f4c80e2125 FOREIGN KEY ("ma_ben_mua",ma_bo_du_lieu) REFERENCES "dung_chung"."doi_tac" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_99cf1849f4c80e2125 ON "kinh_doanh"."bao_gia_va_don_hang" ("ma_ben_mua");
ALTER TABLE "kinh_doanh"."bao_gia_va_don_hang" ADD CONSTRAINT fk_f7f6e98da5310bf991 FOREIGN KEY ("ma_ben_tra_tien",ma_bo_du_lieu) REFERENCES "dung_chung"."doi_tac" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_f7f6e98da5310bf991 ON "kinh_doanh"."bao_gia_va_don_hang" ("ma_ben_tra_tien");
ALTER TABLE "kinh_doanh"."bao_gia_va_don_hang" ADD CONSTRAINT fk_d5fcbe28da27ea596a FOREIGN KEY ("ma_ben_nhan",ma_bo_du_lieu) REFERENCES "dung_chung"."doi_tac" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_d5fcbe28da27ea596a ON "kinh_doanh"."bao_gia_va_don_hang" ("ma_ben_nhan");
ALTER TABLE "kinh_doanh"."bao_gia_va_don_hang" ADD CONSTRAINT fk_e58b97307b35da632e FOREIGN KEY ("ma_can_cu_dai_dien",ma_bo_du_lieu) REFERENCES "dung_chung"."can_cu_dai_dien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_e58b97307b35da632e ON "kinh_doanh"."bao_gia_va_don_hang" ("ma_can_cu_dai_dien");
ALTER TABLE "kinh_doanh"."bao_gia_va_don_hang" ADD CONSTRAINT fk_1b17af117f1fb8ecfd FOREIGN KEY ("ma_phien_ban_chinh_sach_gia",ma_bo_du_lieu) REFERENCES "dung_chung"."phien_ban_chinh_sach" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_1b17af117f1fb8ecfd ON "kinh_doanh"."bao_gia_va_don_hang" ("ma_phien_ban_chinh_sach_gia");
ALTER TABLE "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ADD CONSTRAINT fk_13093a0e4d244beeb0 FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_13093a0e4d244beeb0 ON "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ("ma_dinh_danh");
ALTER TABLE "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ADD CONSTRAINT fk_ca822060f3f05a164b FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_ca822060f3f05a164b ON "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ("ma_bo_du_lieu");
ALTER TABLE "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ADD CONSTRAINT fk_ae105684cf2cf1508e FOREIGN KEY ("ma_chung_tu_nhu_cau_khach",ma_bo_du_lieu) REFERENCES "kinh_doanh"."nhu_cau_khach_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_ae105684cf2cf1508e ON "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ("ma_chung_tu_nhu_cau_khach");
ALTER TABLE "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ADD CONSTRAINT fk_4da588a809307da670 FOREIGN KEY ("ma_mat_hang",ma_bo_du_lieu) REFERENCES "danh_muc"."mat_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_4da588a809307da670 ON "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ("ma_mat_hang");
ALTER TABLE "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ADD CONSTRAINT fk_5ba872998e5ce99c38 FOREIGN KEY ("ma_phien_ban_chinh_sach",ma_bo_du_lieu) REFERENCES "dung_chung"."phien_ban_chinh_sach" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_5ba872998e5ce99c38 ON "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ("ma_phien_ban_chinh_sach");
ALTER TABLE "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ADD CONSTRAINT fk_80cc63f1e9f6555edc FOREIGN KEY ("ma_chung_tu_don_hang",ma_bo_du_lieu) REFERENCES "kinh_doanh"."bao_gia_va_don_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_80cc63f1e9f6555edc ON "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ("ma_chung_tu_don_hang");
ALTER TABLE "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ADD CONSTRAINT fk_0ff52edc239d6eab15 FOREIGN KEY ("ma_chung_tu_mau_khach_da_duyet",ma_bo_du_lieu) REFERENCES "kinh_doanh"."mau_khach_duyet" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_0ff52edc239d6eab15 ON "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ("ma_chung_tu_mau_khach_da_duyet");
ALTER TABLE "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ADD CONSTRAINT fk_f7d8cb80026ae748f8 FOREIGN KEY ("ma_ho_so_giao_bu",ma_bo_du_lieu) REFERENCES "kinh_doanh"."ho_so_xu_ly" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_f7d8cb80026ae748f8 ON "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ("ma_ho_so_giao_bu");
ALTER TABLE "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ADD CONSTRAINT fk_6df51dfd62e685a3ac FOREIGN KEY ("ma_dong_tu_van_goc",ma_bo_du_lieu) REFERENCES "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_6df51dfd62e685a3ac ON "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ("ma_dong_tu_van_goc");
ALTER TABLE "kinh_doanh"."mau_khach_duyet" ADD CONSTRAINT fk_56873dc9a644fad655 FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_56873dc9a644fad655 ON "kinh_doanh"."mau_khach_duyet" ("ma_dinh_danh");
ALTER TABLE "kinh_doanh"."mau_khach_duyet" ADD CONSTRAINT fk_4ccdbc8f14dae41d15 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_4ccdbc8f14dae41d15 ON "kinh_doanh"."mau_khach_duyet" ("ma_bo_du_lieu");
ALTER TABLE "kinh_doanh"."mau_khach_duyet" ADD CONSTRAINT fk_623632c49c122da706 FOREIGN KEY ("ma_dong_don_hang",ma_bo_du_lieu) REFERENCES "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_623632c49c122da706 ON "kinh_doanh"."mau_khach_duyet" ("ma_dong_don_hang");
ALTER TABLE "kinh_doanh"."mau_khach_duyet" ADD CONSTRAINT fk_4e008d5c457f8592a7 FOREIGN KEY ("ma_lenh_san_xuat_mau",ma_bo_du_lieu) REFERENCES "san_xuat"."lenh_san_xuat" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_4e008d5c457f8592a7 ON "kinh_doanh"."mau_khach_duyet" ("ma_lenh_san_xuat_mau");
ALTER TABLE "kinh_doanh"."mau_khach_duyet" ADD CONSTRAINT fk_1ae85943627033e788 FOREIGN KEY ("ma_phieu_kiem_chat_luong",ma_bo_du_lieu) REFERENCES "chat_luong"."phieu_kiem_tra_chat_luong" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_1ae85943627033e788 ON "kinh_doanh"."mau_khach_duyet" ("ma_phieu_kiem_chat_luong");
ALTER TABLE "kinh_doanh"."mau_khach_duyet" ADD CONSTRAINT fk_9de22fec91af4e316b FOREIGN KEY ("ma_can_cu_dai_dien_khach",ma_bo_du_lieu) REFERENCES "dung_chung"."can_cu_dai_dien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_9de22fec91af4e316b ON "kinh_doanh"."mau_khach_duyet" ("ma_can_cu_dai_dien_khach");
ALTER TABLE "kinh_doanh"."ho_so_xu_ly" ADD CONSTRAINT fk_331cc91b3672d77bae FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_331cc91b3672d77bae ON "kinh_doanh"."ho_so_xu_ly" ("ma_dinh_danh");
ALTER TABLE "kinh_doanh"."ho_so_xu_ly" ADD CONSTRAINT fk_4900eff8ab0c625ac6 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_4900eff8ab0c625ac6 ON "kinh_doanh"."ho_so_xu_ly" ("ma_bo_du_lieu");
ALTER TABLE "kinh_doanh"."ho_so_xu_ly" ADD CONSTRAINT fk_7ff4fd33df1ac6fb6b FOREIGN KEY ("ma_dong_don_hang_goc",ma_bo_du_lieu) REFERENCES "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_7ff4fd33df1ac6fb6b ON "kinh_doanh"."ho_so_xu_ly" ("ma_dong_don_hang_goc");
ALTER TABLE "kinh_doanh"."ho_so_xu_ly" ADD CONSTRAINT fk_9b40b9666afc060b68 FOREIGN KEY ("ma_dong_don_hang_moi",ma_bo_du_lieu) REFERENCES "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_9b40b9666afc060b68 ON "kinh_doanh"."ho_so_xu_ly" ("ma_dong_don_hang_moi");
ALTER TABLE "kinh_doanh"."ho_so_xu_ly" ADD CONSTRAINT fk_a815c0883542c402d1 FOREIGN KEY ("ma_dong_ghi_ban_goc",ma_bo_du_lieu) REFERENCES "tai_chinh"."dong_ghi_nhan_ban" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_a815c0883542c402d1 ON "kinh_doanh"."ho_so_xu_ly" ("ma_dong_ghi_ban_goc");
ALTER TABLE "kinh_doanh"."ho_so_xu_ly" ADD CONSTRAINT fk_9f3d9b7595a7581bbb FOREIGN KEY ("ma_phe_duyet",ma_bo_du_lieu) REFERENCES "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_9f3d9b7595a7581bbb ON "kinh_doanh"."ho_so_xu_ly" ("ma_phe_duyet");
ALTER TABLE "kinh_doanh"."ho_so_xu_ly" ADD CONSTRAINT fk_1d84b75775acbc02b4 FOREIGN KEY ("ma_phieu_kiem_chat_luong",ma_bo_du_lieu) REFERENCES "chat_luong"."phieu_kiem_tra_chat_luong" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_1d84b75775acbc02b4 ON "kinh_doanh"."ho_so_xu_ly" ("ma_phieu_kiem_chat_luong");
ALTER TABLE "kinh_doanh"."ho_so_xu_ly" ADD CONSTRAINT fk_6adac952f46250384b FOREIGN KEY ("ma_phan_lo_xu_ly",ma_bo_du_lieu) REFERENCES "kho"."phan_lo_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_6adac952f46250384b ON "kinh_doanh"."ho_so_xu_ly" ("ma_phan_lo_xu_ly");
ALTER TABLE "kinh_doanh"."ho_so_xu_ly" ADD CONSTRAINT fk_3e16ebcf60f5424d44 FOREIGN KEY ("ma_ho_so_lien_quan",ma_bo_du_lieu) REFERENCES "kinh_doanh"."ho_so_xu_ly" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_3e16ebcf60f5424d44 ON "kinh_doanh"."ho_so_xu_ly" ("ma_ho_so_lien_quan");
ALTER TABLE "mua_hang"."don_mua_hang" ADD CONSTRAINT fk_6e665d5d770a205e7b FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_6e665d5d770a205e7b ON "mua_hang"."don_mua_hang" ("ma_dinh_danh");
ALTER TABLE "mua_hang"."don_mua_hang" ADD CONSTRAINT fk_12d44d942c64b9e83a FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_12d44d942c64b9e83a ON "mua_hang"."don_mua_hang" ("ma_bo_du_lieu");
ALTER TABLE "mua_hang"."don_mua_hang" ADD CONSTRAINT fk_12a80296de6a166e01 FOREIGN KEY ("ma_nha_cung_cap",ma_bo_du_lieu) REFERENCES "dung_chung"."doi_tac" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_12a80296de6a166e01 ON "mua_hang"."don_mua_hang" ("ma_nha_cung_cap");
ALTER TABLE "mua_hang"."dong_don_mua_hang" ADD CONSTRAINT fk_e917ea033f80707d6f FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_e917ea033f80707d6f ON "mua_hang"."dong_don_mua_hang" ("ma_dinh_danh");
ALTER TABLE "mua_hang"."dong_don_mua_hang" ADD CONSTRAINT fk_294ebd6bf435323e6d FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_294ebd6bf435323e6d ON "mua_hang"."dong_don_mua_hang" ("ma_bo_du_lieu");
ALTER TABLE "mua_hang"."dong_don_mua_hang" ADD CONSTRAINT fk_5a5d7a6b8b20d5bd8d FOREIGN KEY ("ma_chung_tu_don_hang",ma_bo_du_lieu) REFERENCES "mua_hang"."don_mua_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_5a5d7a6b8b20d5bd8d ON "mua_hang"."dong_don_mua_hang" ("ma_chung_tu_don_hang");
ALTER TABLE "mua_hang"."dong_don_mua_hang" ADD CONSTRAINT fk_a4d2c508039e3759e6 FOREIGN KEY ("ma_mat_hang",ma_bo_du_lieu) REFERENCES "danh_muc"."mat_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_a4d2c508039e3759e6 ON "mua_hang"."dong_don_mua_hang" ("ma_mat_hang");
ALTER TABLE "mua_hang"."dong_don_mua_hang" ADD CONSTRAINT fk_1632b34a15761e38e5 FOREIGN KEY ("ma_don_vi_nhap",ma_bo_du_lieu) REFERENCES "dung_chung"."don_vi_tinh" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_1632b34a15761e38e5 ON "mua_hang"."dong_don_mua_hang" ("ma_don_vi_nhap");
ALTER TABLE "mua_hang"."dong_don_mua_hang" ADD CONSTRAINT fk_227d477da6ee3d2406 FOREIGN KEY ("ma_quy_doi",ma_bo_du_lieu) REFERENCES "danh_muc"."quy_doi_don_vi" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_227d477da6ee3d2406 ON "mua_hang"."dong_don_mua_hang" ("ma_quy_doi");
ALTER TABLE "kho"."lo_hang" ADD CONSTRAINT fk_2c5b1339b9f6a37bb0 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_2c5b1339b9f6a37bb0 ON "kho"."lo_hang" ("ma_bo_du_lieu");
ALTER TABLE "kho"."lo_hang" ADD CONSTRAINT fk_229da6c8f0361e192f FOREIGN KEY ("ma_mat_hang",ma_bo_du_lieu) REFERENCES "danh_muc"."mat_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_229da6c8f0361e192f ON "kho"."lo_hang" ("ma_mat_hang");
ALTER TABLE "kho"."lo_hang" ADD CONSTRAINT fk_549cc48d49e80f5b81 FOREIGN KEY ("ma_chung_tu_hinh_thanh_lo",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_549cc48d49e80f5b81 ON "kho"."lo_hang" ("ma_chung_tu_hinh_thanh_lo");
ALTER TABLE "kho"."lo_hang" ADD CONSTRAINT fk_3ebc92265ee02695b8 FOREIGN KEY ("ma_lo_san_xuat_nguon",ma_bo_du_lieu) REFERENCES "san_xuat"."lo_san_xuat" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_3ebc92265ee02695b8 ON "kho"."lo_hang" ("ma_lo_san_xuat_nguon");
ALTER TABLE "kho"."lo_hang" ADD CONSTRAINT fk_ed07cb90f2b88dc7df FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_ed07cb90f2b88dc7df ON "kho"."lo_hang" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "kho"."phan_lo_hang" ADD CONSTRAINT fk_14b72380132a37721b FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_14b72380132a37721b ON "kho"."phan_lo_hang" ("ma_bo_du_lieu");
ALTER TABLE "kho"."phan_lo_hang" ADD CONSTRAINT fk_98af676e37c30ae6fe FOREIGN KEY ("ma_lo_hang",ma_bo_du_lieu) REFERENCES "kho"."lo_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_98af676e37c30ae6fe ON "kho"."phan_lo_hang" ("ma_lo_hang");
ALTER TABLE "kho"."phan_lo_hang" ADD CONSTRAINT fk_db4dcee7ea827653c5 FOREIGN KEY ("ma_phan_lo_cha",ma_bo_du_lieu) REFERENCES "kho"."phan_lo_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_db4dcee7ea827653c5 ON "kho"."phan_lo_hang" ("ma_phan_lo_cha");
ALTER TABLE "kho"."phan_lo_hang" ADD CONSTRAINT fk_fa421acbf01e8cb696 FOREIGN KEY ("ma_phieu_ket_luan_chat_luong",ma_bo_du_lieu) REFERENCES "chat_luong"."phieu_kiem_tra_chat_luong" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_fa421acbf01e8cb696 ON "kho"."phan_lo_hang" ("ma_phieu_ket_luan_chat_luong");
ALTER TABLE "kho"."phan_lo_hang" ADD CONSTRAINT fk_7c92a12bd19eac687b FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_7c92a12bd19eac687b ON "kho"."phan_lo_hang" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "kho"."dong_van_dong_hang" ADD CONSTRAINT fk_ad2ca8b7842daf684f FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_ad2ca8b7842daf684f ON "kho"."dong_van_dong_hang" ("ma_dinh_danh");
ALTER TABLE "kho"."dong_van_dong_hang" ADD CONSTRAINT fk_f6f30f0600220a755e FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_f6f30f0600220a755e ON "kho"."dong_van_dong_hang" ("ma_bo_du_lieu");
ALTER TABLE "kho"."dong_van_dong_hang" ADD CONSTRAINT fk_2accbdfdf305fc8c6b FOREIGN KEY ("ma_phieu_van_dong_hang",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_2accbdfdf305fc8c6b ON "kho"."dong_van_dong_hang" ("ma_phieu_van_dong_hang");
ALTER TABLE "kho"."dong_van_dong_hang" ADD CONSTRAINT fk_910f4ad108744239d2 FOREIGN KEY ("ma_phan_lo_nguon",ma_bo_du_lieu) REFERENCES "kho"."phan_lo_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_910f4ad108744239d2 ON "kho"."dong_van_dong_hang" ("ma_phan_lo_nguon");
ALTER TABLE "kho"."dong_van_dong_hang" ADD CONSTRAINT fk_fef55b28d025d9ba54 FOREIGN KEY ("ma_phan_lo_dich",ma_bo_du_lieu) REFERENCES "kho"."phan_lo_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_fef55b28d025d9ba54 ON "kho"."dong_van_dong_hang" ("ma_phan_lo_dich");
ALTER TABLE "kho"."dong_van_dong_hang" ADD CONSTRAINT fk_cc59d4ff6f49befe00 FOREIGN KEY ("ma_vi_tri_nguon",ma_bo_du_lieu) REFERENCES "dung_chung"."vi_tri_giu_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_cc59d4ff6f49befe00 ON "kho"."dong_van_dong_hang" ("ma_vi_tri_nguon");
ALTER TABLE "kho"."dong_van_dong_hang" ADD CONSTRAINT fk_f1fcd06ff3b93cb81a FOREIGN KEY ("ma_vi_tri_dich",ma_bo_du_lieu) REFERENCES "dung_chung"."vi_tri_giu_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_f1fcd06ff3b93cb81a ON "kho"."dong_van_dong_hang" ("ma_vi_tri_dich");
ALTER TABLE "kho"."dong_van_dong_hang" ADD CONSTRAINT fk_3bbd32e025139057c3 FOREIGN KEY ("ma_don_vi_nhap",ma_bo_du_lieu) REFERENCES "dung_chung"."don_vi_tinh" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_3bbd32e025139057c3 ON "kho"."dong_van_dong_hang" ("ma_don_vi_nhap");
ALTER TABLE "kho"."dong_van_dong_hang" ADD CONSTRAINT fk_e1388662d10341b53d FOREIGN KEY ("ma_quy_doi",ma_bo_du_lieu) REFERENCES "danh_muc"."quy_doi_don_vi" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_e1388662d10341b53d ON "kho"."dong_van_dong_hang" ("ma_quy_doi");
ALTER TABLE "kho"."dong_van_dong_hang" ADD CONSTRAINT fk_3ae324c1bb659e6cb3 FOREIGN KEY ("ma_dong_nghiep_vu_goc",ma_bo_du_lieu) REFERENCES "kho"."dong_van_dong_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_3ae324c1bb659e6cb3 ON "kho"."dong_van_dong_hang" ("ma_dong_nghiep_vu_goc");
ALTER TABLE "kho"."dong_van_dong_hang" ADD CONSTRAINT fk_11b4983f7f49cbbfcd FOREIGN KEY ("ma_yeu_cau_hang",ma_bo_du_lieu) REFERENCES "kho"."yeu_cau_hang_va_vat_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_11b4983f7f49cbbfcd ON "kho"."dong_van_dong_hang" ("ma_yeu_cau_hang");
ALTER TABLE "kho"."dong_van_dong_hang" ADD CONSTRAINT fk_3b58e8d5c244e342df FOREIGN KEY ("ma_chung_tu_phuong_an_xu_ly",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_3b58e8d5c244e342df ON "kho"."dong_van_dong_hang" ("ma_chung_tu_phuong_an_xu_ly");
ALTER TABLE "kho"."dong_van_dong_hang" ADD CONSTRAINT fk_22c975eafc6ec2fb18 FOREIGN KEY ("ma_chung_tu_cong_doan",ma_bo_du_lieu) REFERENCES "san_xuat"."cong_doan_san_xuat" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_22c975eafc6ec2fb18 ON "kho"."dong_van_dong_hang" ("ma_chung_tu_cong_doan");
ALTER TABLE "kho"."dong_van_dong_hang" ADD CONSTRAINT fk_74c0b0d11b82a20e9b FOREIGN KEY ("ma_dong_cap_vat_tu_nguon",ma_bo_du_lieu) REFERENCES "kho"."dong_van_dong_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_74c0b0d11b82a20e9b ON "kho"."dong_van_dong_hang" ("ma_dong_cap_vat_tu_nguon");
ALTER TABLE "kho"."yeu_cau_hang_va_vat_tu" ADD CONSTRAINT fk_8f5d52dff7bf4810db FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_8f5d52dff7bf4810db ON "kho"."yeu_cau_hang_va_vat_tu" ("ma_dinh_danh");
ALTER TABLE "kho"."yeu_cau_hang_va_vat_tu" ADD CONSTRAINT fk_bf8fae17d74f780b59 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_bf8fae17d74f780b59 ON "kho"."yeu_cau_hang_va_vat_tu" ("ma_bo_du_lieu");
ALTER TABLE "kho"."yeu_cau_hang_va_vat_tu" ADD CONSTRAINT fk_8c3879a13572694246 FOREIGN KEY ("ma_dong_nguon_nghiep_vu",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_8c3879a13572694246 ON "kho"."yeu_cau_hang_va_vat_tu" ("ma_dong_nguon_nghiep_vu");
ALTER TABLE "kho"."yeu_cau_hang_va_vat_tu" ADD CONSTRAINT fk_68322178d9d2383d1c FOREIGN KEY ("ma_mat_hang",ma_bo_du_lieu) REFERENCES "danh_muc"."mat_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_68322178d9d2383d1c ON "kho"."yeu_cau_hang_va_vat_tu" ("ma_mat_hang");
ALTER TABLE "kho"."yeu_cau_hang_va_vat_tu" ADD CONSTRAINT fk_205b8208c9ffc998b3 FOREIGN KEY ("ma_don_vi",ma_bo_du_lieu) REFERENCES "dung_chung"."don_vi_tinh" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_205b8208c9ffc998b3 ON "kho"."yeu_cau_hang_va_vat_tu" ("ma_don_vi");
ALTER TABLE "kho"."yeu_cau_hang_va_vat_tu" ADD CONSTRAINT fk_baff991885d2eba514 FOREIGN KEY ("ma_yeu_cau_hang_bi_thay",ma_bo_du_lieu) REFERENCES "kho"."yeu_cau_hang_va_vat_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_baff991885d2eba514 ON "kho"."yeu_cau_hang_va_vat_tu" ("ma_yeu_cau_hang_bi_thay");
ALTER TABLE "kho"."su_kien_giu_khoa_va_dang_ve" ADD CONSTRAINT fk_0f5246a678c64258ae FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_0f5246a678c64258ae ON "kho"."su_kien_giu_khoa_va_dang_ve" ("ma_bo_du_lieu");
ALTER TABLE "kho"."su_kien_giu_khoa_va_dang_ve" ADD CONSTRAINT fk_13b81c8f19e6df8b3c FOREIGN KEY ("ma_dong_don_mua",ma_bo_du_lieu) REFERENCES "mua_hang"."dong_don_mua_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_13b81c8f19e6df8b3c ON "kho"."su_kien_giu_khoa_va_dang_ve" ("ma_dong_don_mua");
ALTER TABLE "kho"."su_kien_giu_khoa_va_dang_ve" ADD CONSTRAINT fk_95b233436724a7fdb9 FOREIGN KEY ("ma_yeu_cau_hang",ma_bo_du_lieu) REFERENCES "kho"."yeu_cau_hang_va_vat_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_95b233436724a7fdb9 ON "kho"."su_kien_giu_khoa_va_dang_ve" ("ma_yeu_cau_hang");
ALTER TABLE "kho"."su_kien_giu_khoa_va_dang_ve" ADD CONSTRAINT fk_9bee959a5ebfeb41dc FOREIGN KEY ("ma_su_kien_dang_ve_bi_thay",ma_bo_du_lieu) REFERENCES "kho"."su_kien_giu_khoa_va_dang_ve" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_9bee959a5ebfeb41dc ON "kho"."su_kien_giu_khoa_va_dang_ve" ("ma_su_kien_dang_ve_bi_thay");
ALTER TABLE "kho"."su_kien_giu_khoa_va_dang_ve" ADD CONSTRAINT fk_6fd19ab5dff627e12a FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_6fd19ab5dff627e12a ON "kho"."su_kien_giu_khoa_va_dang_ve" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "kho"."su_kien_giu_khoa_va_dang_ve" ADD CONSTRAINT fk_1133f9ea33a4f5ef76 FOREIGN KEY ("ma_phan_lo",ma_bo_du_lieu) REFERENCES "kho"."phan_lo_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_1133f9ea33a4f5ef76 ON "kho"."su_kien_giu_khoa_va_dang_ve" ("ma_phan_lo");
ALTER TABLE "kho"."su_kien_giu_khoa_va_dang_ve" ADD CONSTRAINT fk_dc0024430f028d1d21 FOREIGN KEY ("ma_vi_tri",ma_bo_du_lieu) REFERENCES "dung_chung"."vi_tri_giu_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_dc0024430f028d1d21 ON "kho"."su_kien_giu_khoa_va_dang_ve" ("ma_vi_tri");
ALTER TABLE "kho"."su_kien_giu_khoa_va_dang_ve" ADD CONSTRAINT fk_bb0792b634f12664d8 FOREIGN KEY ("ma_su_kien_goc",ma_bo_du_lieu) REFERENCES "kho"."su_kien_giu_khoa_va_dang_ve" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_bb0792b634f12664d8 ON "kho"."su_kien_giu_khoa_va_dang_ve" ("ma_su_kien_goc");
ALTER TABLE "kho"."su_kien_giu_khoa_va_dang_ve" ADD CONSTRAINT fk_50358790bd9bc739dd FOREIGN KEY ("ma_dong_van_dong_hang",ma_bo_du_lieu) REFERENCES "kho"."dong_van_dong_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_50358790bd9bc739dd ON "kho"."su_kien_giu_khoa_va_dang_ve" ("ma_dong_van_dong_hang");
ALTER TABLE "kho"."su_kien_giu_khoa_va_dang_ve" ADD CONSTRAINT fk_b05b14037a36954c32 FOREIGN KEY ("ma_phe_duyet",ma_bo_du_lieu) REFERENCES "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_b05b14037a36954c32 ON "kho"."su_kien_giu_khoa_va_dang_ve" ("ma_phe_duyet");
ALTER TABLE "kho"."su_kien_giu_khoa_va_dang_ve" ADD CONSTRAINT fk_2d43f2a6b6f02bbe0c FOREIGN KEY ("ma_phieu_kiem_chat_luong",ma_bo_du_lieu) REFERENCES "chat_luong"."phieu_kiem_tra_chat_luong" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_2d43f2a6b6f02bbe0c ON "kho"."su_kien_giu_khoa_va_dang_ve" ("ma_phieu_kiem_chat_luong");
ALTER TABLE "kho"."su_kien_giu_khoa_va_dang_ve" ADD CONSTRAINT fk_27f140b4e80873c867 FOREIGN KEY ("ma_chung_tu_phuong_an_xu_ly",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_27f140b4e80873c867 ON "kho"."su_kien_giu_khoa_va_dang_ve" ("ma_chung_tu_phuong_an_xu_ly");
ALTER TABLE "kho"."su_kien_giu_khoa_va_dang_ve" ADD CONSTRAINT fk_7f20d94f24f2e40b95 FOREIGN KEY ("ma_nhan_vien_thuc_hien",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_7f20d94f24f2e40b95 ON "kho"."su_kien_giu_khoa_va_dang_ve" ("ma_nhan_vien_thuc_hien");
ALTER TABLE "kho"."dong_kiem_ke" ADD CONSTRAINT fk_12b37cc2df73d9482f FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_12b37cc2df73d9482f ON "kho"."dong_kiem_ke" ("ma_dinh_danh");
ALTER TABLE "kho"."dong_kiem_ke" ADD CONSTRAINT fk_2266d23469a26a0e3a FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_2266d23469a26a0e3a ON "kho"."dong_kiem_ke" ("ma_bo_du_lieu");
ALTER TABLE "kho"."dong_kiem_ke" ADD CONSTRAINT fk_b6326642b5886bd4c1 FOREIGN KEY ("ma_bien_ban_kiem_ke",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_b6326642b5886bd4c1 ON "kho"."dong_kiem_ke" ("ma_bien_ban_kiem_ke");
ALTER TABLE "kho"."dong_kiem_ke" ADD CONSTRAINT fk_cf0ec1601279209202 FOREIGN KEY ("ma_phan_lo",ma_bo_du_lieu) REFERENCES "kho"."phan_lo_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_cf0ec1601279209202 ON "kho"."dong_kiem_ke" ("ma_phan_lo");
ALTER TABLE "kho"."dong_kiem_ke" ADD CONSTRAINT fk_1f74d070b6d28625e6 FOREIGN KEY ("ma_vi_tri",ma_bo_du_lieu) REFERENCES "dung_chung"."vi_tri_giu_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_1f74d070b6d28625e6 ON "kho"."dong_kiem_ke" ("ma_vi_tri");
ALTER TABLE "kho"."dong_kiem_ke" ADD CONSTRAINT fk_5859db5ab81dd39493 FOREIGN KEY ("ma_dong_dieu_chinh",ma_bo_du_lieu) REFERENCES "kho"."dong_van_dong_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_5859db5ab81dd39493 ON "kho"."dong_kiem_ke" ("ma_dong_dieu_chinh");
ALTER TABLE "san_xuat"."phien_ban_dinh_muc_san_xuat" ADD CONSTRAINT fk_1a8a93f61518ffc10d FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_1a8a93f61518ffc10d ON "san_xuat"."phien_ban_dinh_muc_san_xuat" ("ma_dinh_danh");
ALTER TABLE "san_xuat"."phien_ban_dinh_muc_san_xuat" ADD CONSTRAINT fk_1bb81242ef075058f9 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_1bb81242ef075058f9 ON "san_xuat"."phien_ban_dinh_muc_san_xuat" ("ma_bo_du_lieu");
ALTER TABLE "san_xuat"."phien_ban_dinh_muc_san_xuat" ADD CONSTRAINT fk_c4dd5fdc13996be19f FOREIGN KEY ("ma_mat_hang_dau_ra",ma_bo_du_lieu) REFERENCES "danh_muc"."mat_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_c4dd5fdc13996be19f ON "san_xuat"."phien_ban_dinh_muc_san_xuat" ("ma_mat_hang_dau_ra");
ALTER TABLE "san_xuat"."phien_ban_dinh_muc_san_xuat" ADD CONSTRAINT fk_9a7f4890b4011afd66 FOREIGN KEY ("ma_phien_ban_chinh_sach",ma_bo_du_lieu) REFERENCES "dung_chung"."phien_ban_chinh_sach" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_9a7f4890b4011afd66 ON "san_xuat"."phien_ban_dinh_muc_san_xuat" ("ma_phien_ban_chinh_sach");
ALTER TABLE "san_xuat"."dong_dinh_muc_vat_tu" ADD CONSTRAINT fk_f8f8356e8ed6dc62dc FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_f8f8356e8ed6dc62dc ON "san_xuat"."dong_dinh_muc_vat_tu" ("ma_dinh_danh");
ALTER TABLE "san_xuat"."dong_dinh_muc_vat_tu" ADD CONSTRAINT fk_46392e97d0e944bf20 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_46392e97d0e944bf20 ON "san_xuat"."dong_dinh_muc_vat_tu" ("ma_bo_du_lieu");
ALTER TABLE "san_xuat"."dong_dinh_muc_vat_tu" ADD CONSTRAINT fk_df1514a926a14abd26 FOREIGN KEY ("ma_chung_tu_dinh_muc",ma_bo_du_lieu) REFERENCES "san_xuat"."phien_ban_dinh_muc_san_xuat" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_df1514a926a14abd26 ON "san_xuat"."dong_dinh_muc_vat_tu" ("ma_chung_tu_dinh_muc");
ALTER TABLE "san_xuat"."dong_dinh_muc_vat_tu" ADD CONSTRAINT fk_7d5f489f3a6f1612fa FOREIGN KEY ("ma_mat_hang",ma_bo_du_lieu) REFERENCES "danh_muc"."mat_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_7d5f489f3a6f1612fa ON "san_xuat"."dong_dinh_muc_vat_tu" ("ma_mat_hang");
ALTER TABLE "san_xuat"."dong_dinh_muc_vat_tu" ADD CONSTRAINT fk_c94428929d37813380 FOREIGN KEY ("ma_don_vi",ma_bo_du_lieu) REFERENCES "dung_chung"."don_vi_tinh" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_c94428929d37813380 ON "san_xuat"."dong_dinh_muc_vat_tu" ("ma_don_vi");
ALTER TABLE "san_xuat"."nguon_luc_san_xuat" ADD CONSTRAINT fk_ccfdca66029afdcfe3 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_ccfdca66029afdcfe3 ON "san_xuat"."nguon_luc_san_xuat" ("ma_bo_du_lieu");
ALTER TABLE "san_xuat"."nguon_luc_san_xuat" ADD CONSTRAINT fk_acf0e9ba02745d0222 FOREIGN KEY ("ma_vi_tri",ma_bo_du_lieu) REFERENCES "dung_chung"."vi_tri_giu_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_acf0e9ba02745d0222 ON "san_xuat"."nguon_luc_san_xuat" ("ma_vi_tri");
ALTER TABLE "san_xuat"."nguon_luc_san_xuat" ADD CONSTRAINT fk_e7fa5a844e9c923114 FOREIGN KEY ("ma_phien_ban_chinh_sach",ma_bo_du_lieu) REFERENCES "dung_chung"."phien_ban_chinh_sach" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_e7fa5a844e9c923114 ON "san_xuat"."nguon_luc_san_xuat" ("ma_phien_ban_chinh_sach");
ALTER TABLE "san_xuat"."nguon_luc_san_xuat" ADD CONSTRAINT fk_6d3a4047ee95fb90be FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_6d3a4047ee95fb90be ON "san_xuat"."nguon_luc_san_xuat" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "san_xuat"."lenh_san_xuat" ADD CONSTRAINT fk_1b4914353fa153592e FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_1b4914353fa153592e ON "san_xuat"."lenh_san_xuat" ("ma_dinh_danh");
ALTER TABLE "san_xuat"."lenh_san_xuat" ADD CONSTRAINT fk_8c859075e2ef5e4416 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_8c859075e2ef5e4416 ON "san_xuat"."lenh_san_xuat" ("ma_bo_du_lieu");
ALTER TABLE "san_xuat"."lenh_san_xuat" ADD CONSTRAINT fk_78073c6cd4775fd786 FOREIGN KEY ("ma_chung_tu_dinh_muc",ma_bo_du_lieu) REFERENCES "san_xuat"."phien_ban_dinh_muc_san_xuat" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_78073c6cd4775fd786 ON "san_xuat"."lenh_san_xuat" ("ma_chung_tu_dinh_muc");
ALTER TABLE "san_xuat"."lenh_san_xuat" ADD CONSTRAINT fk_691f0d512918e7142a FOREIGN KEY ("ma_dong_don_hang_nguon",ma_bo_du_lieu) REFERENCES "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_691f0d512918e7142a ON "san_xuat"."lenh_san_xuat" ("ma_dong_don_hang_nguon");
ALTER TABLE "san_xuat"."lenh_san_xuat" ADD CONSTRAINT fk_ff116485ea72ff0298 FOREIGN KEY ("ma_ho_so_xu_ly_nguon",ma_bo_du_lieu) REFERENCES "kinh_doanh"."ho_so_xu_ly" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_ff116485ea72ff0298 ON "san_xuat"."lenh_san_xuat" ("ma_ho_so_xu_ly_nguon");
ALTER TABLE "san_xuat"."lenh_san_xuat" ADD CONSTRAINT fk_b5d374a54e74fb36c6 FOREIGN KEY ("ma_phien_ban_chinh_sach",ma_bo_du_lieu) REFERENCES "dung_chung"."phien_ban_chinh_sach" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_b5d374a54e74fb36c6 ON "san_xuat"."lenh_san_xuat" ("ma_phien_ban_chinh_sach");
ALTER TABLE "san_xuat"."lenh_san_xuat" ADD CONSTRAINT fk_c0de0974791a450a86 FOREIGN KEY ("ma_chung_tu_quyet_dinh_chot_lenh",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_c0de0974791a450a86 ON "san_xuat"."lenh_san_xuat" ("ma_chung_tu_quyet_dinh_chot_lenh");
ALTER TABLE "san_xuat"."lo_san_xuat" ADD CONSTRAINT fk_1fcf5a3d7f7642cc91 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_1fcf5a3d7f7642cc91 ON "san_xuat"."lo_san_xuat" ("ma_bo_du_lieu");
ALTER TABLE "san_xuat"."lo_san_xuat" ADD CONSTRAINT fk_f46d8289508e71571d FOREIGN KEY ("ma_lenh_san_xuat",ma_bo_du_lieu) REFERENCES "san_xuat"."lenh_san_xuat" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_f46d8289508e71571d ON "san_xuat"."lo_san_xuat" ("ma_lenh_san_xuat");
ALTER TABLE "san_xuat"."lo_san_xuat" ADD CONSTRAINT fk_74491f997d7029b151 FOREIGN KEY ("ma_lo_thanh_pham_dau_ra",ma_bo_du_lieu) REFERENCES "kho"."lo_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_74491f997d7029b151 ON "san_xuat"."lo_san_xuat" ("ma_lo_thanh_pham_dau_ra");
ALTER TABLE "san_xuat"."lo_san_xuat" ADD CONSTRAINT fk_5f6f3f49095d0e3e03 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_5f6f3f49095d0e3e03 ON "san_xuat"."lo_san_xuat" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "san_xuat"."cong_doan_san_xuat" ADD CONSTRAINT fk_6155d1bcde752b3eed FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_6155d1bcde752b3eed ON "san_xuat"."cong_doan_san_xuat" ("ma_dinh_danh");
ALTER TABLE "san_xuat"."cong_doan_san_xuat" ADD CONSTRAINT fk_6c22ad3fee905f4911 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_6c22ad3fee905f4911 ON "san_xuat"."cong_doan_san_xuat" ("ma_bo_du_lieu");
ALTER TABLE "san_xuat"."cong_doan_san_xuat" ADD CONSTRAINT fk_acb54c5f09199fc575 FOREIGN KEY ("ma_lo_san_xuat",ma_bo_du_lieu) REFERENCES "san_xuat"."lo_san_xuat" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_acb54c5f09199fc575 ON "san_xuat"."cong_doan_san_xuat" ("ma_lo_san_xuat");
ALTER TABLE "san_xuat"."cong_doan_san_xuat" ADD CONSTRAINT fk_ddb182d448beb1cfa1 FOREIGN KEY ("ma_phien_ban_chinh_sach",ma_bo_du_lieu) REFERENCES "dung_chung"."phien_ban_chinh_sach" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_ddb182d448beb1cfa1 ON "san_xuat"."cong_doan_san_xuat" ("ma_phien_ban_chinh_sach");
ALTER TABLE "san_xuat"."lich_nguoi_va_nguon_luc" ADD CONSTRAINT fk_f0836357b4a3f0dcef FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_f0836357b4a3f0dcef ON "san_xuat"."lich_nguoi_va_nguon_luc" ("ma_bo_du_lieu");
ALTER TABLE "san_xuat"."lich_nguoi_va_nguon_luc" ADD CONSTRAINT fk_796cf8652e355b3cc7 FOREIGN KEY ("ma_nguon_luc",ma_bo_du_lieu) REFERENCES "san_xuat"."nguon_luc_san_xuat" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_796cf8652e355b3cc7 ON "san_xuat"."lich_nguoi_va_nguon_luc" ("ma_nguon_luc");
ALTER TABLE "san_xuat"."lich_nguoi_va_nguon_luc" ADD CONSTRAINT fk_eb3d030809c4cd7667 FOREIGN KEY ("ma_chung_tu_cong_doan",ma_bo_du_lieu) REFERENCES "san_xuat"."cong_doan_san_xuat" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_eb3d030809c4cd7667 ON "san_xuat"."lich_nguoi_va_nguon_luc" ("ma_chung_tu_cong_doan");
ALTER TABLE "san_xuat"."lich_nguoi_va_nguon_luc" ADD CONSTRAINT fk_0c88d4b7d2f7aeab7a FOREIGN KEY ("ma_lich_bi_thay",ma_bo_du_lieu) REFERENCES "san_xuat"."lich_nguoi_va_nguon_luc" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_0c88d4b7d2f7aeab7a ON "san_xuat"."lich_nguoi_va_nguon_luc" ("ma_lich_bi_thay");
ALTER TABLE "san_xuat"."lich_nguoi_va_nguon_luc" ADD CONSTRAINT fk_7e4ff5c5b3e659fa70 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_7e4ff5c5b3e659fa70 ON "san_xuat"."lich_nguoi_va_nguon_luc" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "san_xuat"."lich_nguoi_va_nguon_luc" ADD CONSTRAINT fk_beb437a8994599a88d FOREIGN KEY ("ma_phien_ban_chung_tu",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_beb437a8994599a88d ON "san_xuat"."lich_nguoi_va_nguon_luc" ("ma_phien_ban_chung_tu");
ALTER TABLE "san_xuat"."lich_nguoi_va_nguon_luc" ADD CONSTRAINT fk_195089f98d5b91b57d FOREIGN KEY ("ma_nhan_vien",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_195089f98d5b91b57d ON "san_xuat"."lich_nguoi_va_nguon_luc" ("ma_nhan_vien");
ALTER TABLE "san_xuat"."lich_nguoi_va_nguon_luc" ADD CONSTRAINT fk_870ce0bfa95e5d34d2 FOREIGN KEY ("ma_ngay_va_ca_lam_viec",ma_bo_du_lieu) REFERENCES "nhan_su"."ngay_va_ca_lam_viec" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_870ce0bfa95e5d34d2 ON "san_xuat"."lich_nguoi_va_nguon_luc" ("ma_ngay_va_ca_lam_viec");
ALTER TABLE "chat_luong"."phieu_kiem_tra_chat_luong" ADD CONSTRAINT fk_5ea5edf2d33eb1c228 FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_5ea5edf2d33eb1c228 ON "chat_luong"."phieu_kiem_tra_chat_luong" ("ma_dinh_danh");
ALTER TABLE "chat_luong"."phieu_kiem_tra_chat_luong" ADD CONSTRAINT fk_79b87c3b9402f61c8e FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_79b87c3b9402f61c8e ON "chat_luong"."phieu_kiem_tra_chat_luong" ("ma_bo_du_lieu");
ALTER TABLE "chat_luong"."phieu_kiem_tra_chat_luong" ADD CONSTRAINT fk_60f926fd12a06b3ead FOREIGN KEY ("ma_dong_nguon_nghiep_vu",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_60f926fd12a06b3ead ON "chat_luong"."phieu_kiem_tra_chat_luong" ("ma_dong_nguon_nghiep_vu");
ALTER TABLE "chat_luong"."phieu_kiem_tra_chat_luong" ADD CONSTRAINT fk_40a832afa4c8695128 FOREIGN KEY ("ma_lo_hang",ma_bo_du_lieu) REFERENCES "kho"."lo_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_40a832afa4c8695128 ON "chat_luong"."phieu_kiem_tra_chat_luong" ("ma_lo_hang");
ALTER TABLE "chat_luong"."phieu_kiem_tra_chat_luong" ADD CONSTRAINT fk_d9dc2d7166d1e0ac4e FOREIGN KEY ("ma_phien_ban_bo_tieu_chi",ma_bo_du_lieu) REFERENCES "dung_chung"."phien_ban_chinh_sach" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_d9dc2d7166d1e0ac4e ON "chat_luong"."phieu_kiem_tra_chat_luong" ("ma_phien_ban_bo_tieu_chi");
ALTER TABLE "chat_luong"."phieu_kiem_tra_chat_luong" ADD CONSTRAINT fk_d38584ce6bfc410aef FOREIGN KEY ("ma_chung_tu_mau",ma_bo_du_lieu) REFERENCES "kinh_doanh"."mau_khach_duyet" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_d38584ce6bfc410aef ON "chat_luong"."phieu_kiem_tra_chat_luong" ("ma_chung_tu_mau");
ALTER TABLE "chat_luong"."phieu_kiem_tra_chat_luong" ADD CONSTRAINT fk_77e608f4a881697094 FOREIGN KEY ("ma_nhan_vien_kiem_chat_luong",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_77e608f4a881697094 ON "chat_luong"."phieu_kiem_tra_chat_luong" ("ma_nhan_vien_kiem_chat_luong");
ALTER TABLE "chat_luong"."ket_qua_tung_tieu_chi_kiem_tra" ADD CONSTRAINT fk_14a3dce115d2afab72 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_14a3dce115d2afab72 ON "chat_luong"."ket_qua_tung_tieu_chi_kiem_tra" ("ma_bo_du_lieu");
ALTER TABLE "chat_luong"."ket_qua_tung_tieu_chi_kiem_tra" ADD CONSTRAINT fk_dbbe5f8f0556d22a20 FOREIGN KEY ("ma_phieu_kiem_chat_luong",ma_bo_du_lieu) REFERENCES "chat_luong"."phieu_kiem_tra_chat_luong" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_dbbe5f8f0556d22a20 ON "chat_luong"."ket_qua_tung_tieu_chi_kiem_tra" ("ma_phieu_kiem_chat_luong");
ALTER TABLE "chat_luong"."ket_qua_tung_tieu_chi_kiem_tra" ADD CONSTRAINT fk_25693345da09b29115 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_25693345da09b29115 ON "chat_luong"."ket_qua_tung_tieu_chi_kiem_tra" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "giao_hang"."dot_giao_hang" ADD CONSTRAINT fk_20b4765540c5f0b9b8 FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_20b4765540c5f0b9b8 ON "giao_hang"."dot_giao_hang" ("ma_dinh_danh");
ALTER TABLE "giao_hang"."dot_giao_hang" ADD CONSTRAINT fk_ba7d28391f529c0095 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_ba7d28391f529c0095 ON "giao_hang"."dot_giao_hang" ("ma_bo_du_lieu");
ALTER TABLE "giao_hang"."dot_giao_hang" ADD CONSTRAINT fk_0fdf1ada62b4cbdab8 FOREIGN KEY ("ma_chung_tu_don_hang",ma_bo_du_lieu) REFERENCES "kinh_doanh"."bao_gia_va_don_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_0fdf1ada62b4cbdab8 ON "giao_hang"."dot_giao_hang" ("ma_chung_tu_don_hang");
ALTER TABLE "giao_hang"."dot_giao_hang" ADD CONSTRAINT fk_65dad2f9a8764f6d20 FOREIGN KEY ("ma_ben_nhan",ma_bo_du_lieu) REFERENCES "dung_chung"."doi_tac" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_65dad2f9a8764f6d20 ON "giao_hang"."dot_giao_hang" ("ma_ben_nhan");
ALTER TABLE "giao_hang"."dot_giao_hang" ADD CONSTRAINT fk_49eefaac1e337c7129 FOREIGN KEY ("ma_ben_van_chuyen",ma_bo_du_lieu) REFERENCES "dung_chung"."doi_tac" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_49eefaac1e337c7129 ON "giao_hang"."dot_giao_hang" ("ma_ben_van_chuyen");
ALTER TABLE "giao_hang"."dot_giao_hang" ADD CONSTRAINT fk_e74945f59c79ca1259 FOREIGN KEY ("ma_can_cu_dai_dien_nhan_hang",ma_bo_du_lieu) REFERENCES "dung_chung"."can_cu_dai_dien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_e74945f59c79ca1259 ON "giao_hang"."dot_giao_hang" ("ma_can_cu_dai_dien_nhan_hang");
ALTER TABLE "giao_hang"."dong_giao_va_nhan_hang" ADD CONSTRAINT fk_6db55867e656d8f737 FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_6db55867e656d8f737 ON "giao_hang"."dong_giao_va_nhan_hang" ("ma_dinh_danh");
ALTER TABLE "giao_hang"."dong_giao_va_nhan_hang" ADD CONSTRAINT fk_814da53aaf67205251 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_814da53aaf67205251 ON "giao_hang"."dong_giao_va_nhan_hang" ("ma_bo_du_lieu");
ALTER TABLE "giao_hang"."dong_giao_va_nhan_hang" ADD CONSTRAINT fk_6844b3e8c774ec0c98 FOREIGN KEY ("ma_chung_tu_dot_giao",ma_bo_du_lieu) REFERENCES "giao_hang"."dot_giao_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_6844b3e8c774ec0c98 ON "giao_hang"."dong_giao_va_nhan_hang" ("ma_chung_tu_dot_giao");
ALTER TABLE "giao_hang"."dong_giao_va_nhan_hang" ADD CONSTRAINT fk_af9f6011f3882f29cb FOREIGN KEY ("ma_dong_don_hang",ma_bo_du_lieu) REFERENCES "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_af9f6011f3882f29cb ON "giao_hang"."dong_giao_va_nhan_hang" ("ma_dong_don_hang");
ALTER TABLE "giao_hang"."dong_giao_va_nhan_hang" ADD CONSTRAINT fk_c5a102cd3256c3d1e9 FOREIGN KEY ("ma_dong_thuc_xuat_giao_hang",ma_bo_du_lieu) REFERENCES "kho"."dong_van_dong_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_c5a102cd3256c3d1e9 ON "giao_hang"."dong_giao_va_nhan_hang" ("ma_dong_thuc_xuat_giao_hang");
ALTER TABLE "giao_hang"."dong_giao_va_nhan_hang" ADD CONSTRAINT fk_b81b04eecc8b12f570 FOREIGN KEY ("ma_dong_giao_du_kien",ma_bo_du_lieu) REFERENCES "giao_hang"."dong_giao_va_nhan_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_b81b04eecc8b12f570 ON "giao_hang"."dong_giao_va_nhan_hang" ("ma_dong_giao_du_kien");
ALTER TABLE "giao_hang"."dong_giao_va_nhan_hang" ADD CONSTRAINT fk_c1c36544dfda1339cd FOREIGN KEY ("ma_lien_he_nguoi_nhan_hang",ma_bo_du_lieu) REFERENCES "dung_chung"."lien_he_doi_tac" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_c1c36544dfda1339cd ON "giao_hang"."dong_giao_va_nhan_hang" ("ma_lien_he_nguoi_nhan_hang");
ALTER TABLE "tai_chinh"."quy_va_tai_khoan_tien" ADD CONSTRAINT fk_671c7746bdb39c3a5d FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_671c7746bdb39c3a5d ON "tai_chinh"."quy_va_tai_khoan_tien" ("ma_bo_du_lieu");
ALTER TABLE "tai_chinh"."quy_va_tai_khoan_tien" ADD CONSTRAINT fk_92445e3c08ecdf0c92 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_92445e3c08ecdf0c92 ON "tai_chinh"."quy_va_tai_khoan_tien" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "tai_chinh"."de_nghi_chi_tien" ADD CONSTRAINT fk_00b2fa517efcc2e209 FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_00b2fa517efcc2e209 ON "tai_chinh"."de_nghi_chi_tien" ("ma_dinh_danh");
ALTER TABLE "tai_chinh"."de_nghi_chi_tien" ADD CONSTRAINT fk_d7c747ded8d23e39ab FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_d7c747ded8d23e39ab ON "tai_chinh"."de_nghi_chi_tien" ("ma_bo_du_lieu");
ALTER TABLE "tai_chinh"."de_nghi_chi_tien" ADD CONSTRAINT fk_4793dbe19201fb5df7 FOREIGN KEY ("ma_doi_tac_huong_tien",ma_bo_du_lieu) REFERENCES "dung_chung"."doi_tac" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_4793dbe19201fb5df7 ON "tai_chinh"."de_nghi_chi_tien" ("ma_doi_tac_huong_tien");
ALTER TABLE "tai_chinh"."de_nghi_chi_tien" ADD CONSTRAINT fk_061556f2231d5434da FOREIGN KEY ("ma_nhan_vien_huong_tien",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_061556f2231d5434da ON "tai_chinh"."de_nghi_chi_tien" ("ma_nhan_vien_huong_tien");
ALTER TABLE "tai_chinh"."de_nghi_chi_tien" ADD CONSTRAINT fk_5b1c567793ea237fde FOREIGN KEY ("ma_nghia_vu_thanh_toan",ma_bo_du_lieu) REFERENCES "tai_chinh"."nghia_vu_va_dieu_chinh" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_5b1c567793ea237fde ON "tai_chinh"."de_nghi_chi_tien" ("ma_nghia_vu_thanh_toan");
ALTER TABLE "tai_chinh"."de_nghi_chi_tien" ADD CONSTRAINT fk_315579d55924e37dfc FOREIGN KEY ("ma_phe_duyet",ma_bo_du_lieu) REFERENCES "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_315579d55924e37dfc ON "tai_chinh"."de_nghi_chi_tien" ("ma_phe_duyet");
ALTER TABLE "tai_chinh"."de_nghi_chi_tien" ADD CONSTRAINT fk_188356ac1d3ae4c6dd FOREIGN KEY ("ma_quy_hoac_tai_khoan_dich",ma_bo_du_lieu) REFERENCES "tai_chinh"."quy_va_tai_khoan_tien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_188356ac1d3ae4c6dd ON "tai_chinh"."de_nghi_chi_tien" ("ma_quy_hoac_tai_khoan_dich");
ALTER TABLE "tai_chinh"."bien_dong_tien_thuc" ADD CONSTRAINT fk_fb2acf35c94b136d70 FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_fb2acf35c94b136d70 ON "tai_chinh"."bien_dong_tien_thuc" ("ma_dinh_danh");
ALTER TABLE "tai_chinh"."bien_dong_tien_thuc" ADD CONSTRAINT fk_0e191cd7097ddc47f9 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_0e191cd7097ddc47f9 ON "tai_chinh"."bien_dong_tien_thuc" ("ma_bo_du_lieu");
ALTER TABLE "tai_chinh"."bien_dong_tien_thuc" ADD CONSTRAINT fk_efffe43f6d8fed380f FOREIGN KEY ("ma_quy_hoac_tai_khoan_tien",ma_bo_du_lieu) REFERENCES "tai_chinh"."quy_va_tai_khoan_tien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_efffe43f6d8fed380f ON "tai_chinh"."bien_dong_tien_thuc" ("ma_quy_hoac_tai_khoan_tien");
ALTER TABLE "tai_chinh"."bien_dong_tien_thuc" ADD CONSTRAINT fk_b7be015c8a9d0ccb19 FOREIGN KEY ("ma_chung_tu_de_nghi_chi",ma_bo_du_lieu) REFERENCES "tai_chinh"."de_nghi_chi_tien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_b7be015c8a9d0ccb19 ON "tai_chinh"."bien_dong_tien_thuc" ("ma_chung_tu_de_nghi_chi");
ALTER TABLE "tai_chinh"."bien_dong_tien_thuc" ADD CONSTRAINT fk_1d8432cafb7c031cee FOREIGN KEY ("ma_doi_tac",ma_bo_du_lieu) REFERENCES "dung_chung"."doi_tac" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_1d8432cafb7c031cee ON "tai_chinh"."bien_dong_tien_thuc" ("ma_doi_tac");
ALTER TABLE "tai_chinh"."bien_dong_tien_thuc" ADD CONSTRAINT fk_e7b413a840bf2286fa FOREIGN KEY ("ma_nhan_vien",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_e7b413a840bf2286fa ON "tai_chinh"."bien_dong_tien_thuc" ("ma_nhan_vien");
ALTER TABLE "tai_chinh"."bien_dong_tien_thuc" ADD CONSTRAINT fk_52e328fbe521aa85a1 FOREIGN KEY ("ma_can_cu_dai_dien",ma_bo_du_lieu) REFERENCES "dung_chung"."can_cu_dai_dien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_52e328fbe521aa85a1 ON "tai_chinh"."bien_dong_tien_thuc" ("ma_can_cu_dai_dien");
ALTER TABLE "tai_chinh"."bien_dong_tien_thuc" ADD CONSTRAINT fk_96114babface34ac9f FOREIGN KEY ("ma_bien_nhan_xac_nhan_giao_dich",ma_bo_du_lieu) REFERENCES "truy_cap"."bien_nhan_xac_nhan_giao_dich" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_96114babface34ac9f ON "tai_chinh"."bien_dong_tien_thuc" ("ma_bien_nhan_xac_nhan_giao_dich");
ALTER TABLE "tai_chinh"."nghia_vu_va_dieu_chinh" ADD CONSTRAINT fk_67405a4f3d8889439c FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_67405a4f3d8889439c ON "tai_chinh"."nghia_vu_va_dieu_chinh" ("ma_bo_du_lieu");
ALTER TABLE "tai_chinh"."nghia_vu_va_dieu_chinh" ADD CONSTRAINT fk_863d2ed6de4589345a FOREIGN KEY ("ma_dong_nguon_nghiep_vu",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_863d2ed6de4589345a ON "tai_chinh"."nghia_vu_va_dieu_chinh" ("ma_dong_nguon_nghiep_vu");
ALTER TABLE "tai_chinh"."nghia_vu_va_dieu_chinh" ADD CONSTRAINT fk_6f49594480794cb301 FOREIGN KEY ("ma_doi_tac",ma_bo_du_lieu) REFERENCES "dung_chung"."doi_tac" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_6f49594480794cb301 ON "tai_chinh"."nghia_vu_va_dieu_chinh" ("ma_doi_tac");
ALTER TABLE "tai_chinh"."nghia_vu_va_dieu_chinh" ADD CONSTRAINT fk_ecbe9801bb3d7a356a FOREIGN KEY ("ma_nhan_vien",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_ecbe9801bb3d7a356a ON "tai_chinh"."nghia_vu_va_dieu_chinh" ("ma_nhan_vien");
ALTER TABLE "tai_chinh"."nghia_vu_va_dieu_chinh" ADD CONSTRAINT fk_d2c664b5a67195f4b0 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_d2c664b5a67195f4b0 ON "tai_chinh"."nghia_vu_va_dieu_chinh" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "tai_chinh"."nghia_vu_va_dieu_chinh" ADD CONSTRAINT fk_5c98ccebcc8bd1b7cd FOREIGN KEY ("ma_nghia_vu_goc",ma_bo_du_lieu) REFERENCES "tai_chinh"."nghia_vu_va_dieu_chinh" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_5c98ccebcc8bd1b7cd ON "tai_chinh"."nghia_vu_va_dieu_chinh" ("ma_nghia_vu_goc");
ALTER TABLE "tai_chinh"."nghia_vu_va_dieu_chinh" ADD CONSTRAINT fk_4f9ff86b6b8345fbe2 FOREIGN KEY ("ma_su_kien_dieu_chinh_goc",ma_bo_du_lieu) REFERENCES "tai_chinh"."nghia_vu_va_dieu_chinh" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_4f9ff86b6b8345fbe2 ON "tai_chinh"."nghia_vu_va_dieu_chinh" ("ma_su_kien_dieu_chinh_goc");
ALTER TABLE "tai_chinh"."nghia_vu_va_dieu_chinh" ADD CONSTRAINT fk_9d7f389b9f7f1d9a4d FOREIGN KEY ("ma_phe_duyet",ma_bo_du_lieu) REFERENCES "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_9d7f389b9f7f1d9a4d ON "tai_chinh"."nghia_vu_va_dieu_chinh" ("ma_phe_duyet");
ALTER TABLE "tai_chinh"."su_kien_su_dung_nguon_tien" ADD CONSTRAINT fk_566147fab7054b33d3 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_566147fab7054b33d3 ON "tai_chinh"."su_kien_su_dung_nguon_tien" ("ma_bo_du_lieu");
ALTER TABLE "tai_chinh"."su_kien_su_dung_nguon_tien" ADD CONSTRAINT fk_12c04a69aeb0840c64 FOREIGN KEY ("ma_bien_dong_tien_thuc",ma_bo_du_lieu) REFERENCES "tai_chinh"."bien_dong_tien_thuc" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_12c04a69aeb0840c64 ON "tai_chinh"."su_kien_su_dung_nguon_tien" ("ma_bien_dong_tien_thuc");
ALTER TABLE "tai_chinh"."su_kien_su_dung_nguon_tien" ADD CONSTRAINT fk_65368ef9c0880419f0 FOREIGN KEY ("ma_nghia_vu_thanh_toan",ma_bo_du_lieu) REFERENCES "tai_chinh"."nghia_vu_va_dieu_chinh" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_65368ef9c0880419f0 ON "tai_chinh"."su_kien_su_dung_nguon_tien" ("ma_nghia_vu_thanh_toan");
ALTER TABLE "tai_chinh"."su_kien_su_dung_nguon_tien" ADD CONSTRAINT fk_8579f9d9ab9d1f8e41 FOREIGN KEY ("ma_su_kien_su_dung_tien_goc",ma_bo_du_lieu) REFERENCES "tai_chinh"."su_kien_su_dung_nguon_tien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_8579f9d9ab9d1f8e41 ON "tai_chinh"."su_kien_su_dung_nguon_tien" ("ma_su_kien_su_dung_tien_goc");
ALTER TABLE "tai_chinh"."su_kien_su_dung_nguon_tien" ADD CONSTRAINT fk_2565f80bf1f3e737a0 FOREIGN KEY ("ma_bien_dong_tien_thuc_hoan",ma_bo_du_lieu) REFERENCES "tai_chinh"."bien_dong_tien_thuc" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_2565f80bf1f3e737a0 ON "tai_chinh"."su_kien_su_dung_nguon_tien" ("ma_bien_dong_tien_thuc_hoan");
ALTER TABLE "tai_chinh"."su_kien_su_dung_nguon_tien" ADD CONSTRAINT fk_f6eea34ac23943c85c FOREIGN KEY ("ma_can_cu_dai_dien",ma_bo_du_lieu) REFERENCES "dung_chung"."can_cu_dai_dien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_f6eea34ac23943c85c ON "tai_chinh"."su_kien_su_dung_nguon_tien" ("ma_can_cu_dai_dien");
ALTER TABLE "tai_chinh"."su_kien_su_dung_nguon_tien" ADD CONSTRAINT fk_32fc1e87be98225041 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_32fc1e87be98225041 ON "tai_chinh"."su_kien_su_dung_nguon_tien" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "tai_chinh"."dong_ghi_nhan_ban" ADD CONSTRAINT fk_f41d31321b8235417f FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_f41d31321b8235417f ON "tai_chinh"."dong_ghi_nhan_ban" ("ma_dinh_danh");
ALTER TABLE "tai_chinh"."dong_ghi_nhan_ban" ADD CONSTRAINT fk_e6e9e3f869cec4a82d FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_e6e9e3f869cec4a82d ON "tai_chinh"."dong_ghi_nhan_ban" ("ma_bo_du_lieu");
ALTER TABLE "tai_chinh"."dong_ghi_nhan_ban" ADD CONSTRAINT fk_253f4b034ccd9589d8 FOREIGN KEY ("ma_chung_tu_ghi_ban",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_253f4b034ccd9589d8 ON "tai_chinh"."dong_ghi_nhan_ban" ("ma_chung_tu_ghi_ban");
ALTER TABLE "tai_chinh"."dong_ghi_nhan_ban" ADD CONSTRAINT fk_45dbe99a6fdc2a2cec FOREIGN KEY ("ma_dong_xac_nhan_khach_nhan",ma_bo_du_lieu) REFERENCES "giao_hang"."dong_giao_va_nhan_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_45dbe99a6fdc2a2cec ON "tai_chinh"."dong_ghi_nhan_ban" ("ma_dong_xac_nhan_khach_nhan");
ALTER TABLE "tai_chinh"."dong_ghi_nhan_ban" ADD CONSTRAINT fk_a50bbc854d296ddbd5 FOREIGN KEY ("ma_dong_ghi_ban_goc",ma_bo_du_lieu) REFERENCES "tai_chinh"."dong_ghi_nhan_ban" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_a50bbc854d296ddbd5 ON "tai_chinh"."dong_ghi_nhan_ban" ("ma_dong_ghi_ban_goc");
ALTER TABLE "tai_chinh"."dong_ghi_nhan_ban" ADD CONSTRAINT fk_14d89404404a51cb93 FOREIGN KEY ("ma_dong_don_hang",ma_bo_du_lieu) REFERENCES "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_14d89404404a51cb93 ON "tai_chinh"."dong_ghi_nhan_ban" ("ma_dong_don_hang");
ALTER TABLE "tai_chinh"."doi_chieu_nghia_vu_mua" ADD CONSTRAINT fk_b2cdb31f1a70f43ec3 FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_b2cdb31f1a70f43ec3 ON "tai_chinh"."doi_chieu_nghia_vu_mua" ("ma_dinh_danh");
ALTER TABLE "tai_chinh"."doi_chieu_nghia_vu_mua" ADD CONSTRAINT fk_0adcb4a2b15e566ee3 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_0adcb4a2b15e566ee3 ON "tai_chinh"."doi_chieu_nghia_vu_mua" ("ma_bo_du_lieu");
ALTER TABLE "tai_chinh"."doi_chieu_nghia_vu_mua" ADD CONSTRAINT fk_959d3e518d313fa8b5 FOREIGN KEY ("ma_dong_don_mua",ma_bo_du_lieu) REFERENCES "mua_hang"."dong_don_mua_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_959d3e518d313fa8b5 ON "tai_chinh"."doi_chieu_nghia_vu_mua" ("ma_dong_don_mua");
ALTER TABLE "tai_chinh"."doi_chieu_nghia_vu_mua" ADD CONSTRAINT fk_bd7cb0ca865c509bb0 FOREIGN KEY ("ma_dong_nhan_hang_mua",ma_bo_du_lieu) REFERENCES "kho"."dong_van_dong_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_bd7cb0ca865c509bb0 ON "tai_chinh"."doi_chieu_nghia_vu_mua" ("ma_dong_nhan_hang_mua");
ALTER TABLE "tai_chinh"."doi_chieu_nghia_vu_mua" ADD CONSTRAINT fk_c0c25d9a51d5e12569 FOREIGN KEY ("ma_phieu_kiem_chat_luong",ma_bo_du_lieu) REFERENCES "chat_luong"."phieu_kiem_tra_chat_luong" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_c0c25d9a51d5e12569 ON "tai_chinh"."doi_chieu_nghia_vu_mua" ("ma_phieu_kiem_chat_luong");
ALTER TABLE "tai_chinh"."doi_chieu_nghia_vu_mua" ADD CONSTRAINT fk_6e59c9804c38c41389 FOREIGN KEY ("ma_nha_cung_cap",ma_bo_du_lieu) REFERENCES "dung_chung"."doi_tac" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_6e59c9804c38c41389 ON "tai_chinh"."doi_chieu_nghia_vu_mua" ("ma_nha_cung_cap");
ALTER TABLE "tai_chinh"."dong_doi_chieu_quy_ngan_hang" ADD CONSTRAINT fk_b586c67bcee302c158 FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_b586c67bcee302c158 ON "tai_chinh"."dong_doi_chieu_quy_ngan_hang" ("ma_dinh_danh");
ALTER TABLE "tai_chinh"."dong_doi_chieu_quy_ngan_hang" ADD CONSTRAINT fk_53dbfa0467721173d1 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_53dbfa0467721173d1 ON "tai_chinh"."dong_doi_chieu_quy_ngan_hang" ("ma_bo_du_lieu");
ALTER TABLE "tai_chinh"."dong_doi_chieu_quy_ngan_hang" ADD CONSTRAINT fk_7927fa2a3d5b6547a5 FOREIGN KEY ("ma_quy_hoac_tai_khoan_tien",ma_bo_du_lieu) REFERENCES "tai_chinh"."quy_va_tai_khoan_tien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_7927fa2a3d5b6547a5 ON "tai_chinh"."dong_doi_chieu_quy_ngan_hang" ("ma_quy_hoac_tai_khoan_tien");
ALTER TABLE "tai_chinh"."dong_doi_chieu_quy_ngan_hang" ADD CONSTRAINT fk_fcf25a6f0f9f1a807d FOREIGN KEY ("ma_bien_dong_tien_thuc",ma_bo_du_lieu) REFERENCES "tai_chinh"."bien_dong_tien_thuc" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_fcf25a6f0f9f1a807d ON "tai_chinh"."dong_doi_chieu_quy_ngan_hang" ("ma_bien_dong_tien_thuc");
ALTER TABLE "tai_chinh"."nguon_chi_phi" ADD CONSTRAINT fk_907236776ff09a199d FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_907236776ff09a199d ON "tai_chinh"."nguon_chi_phi" ("ma_dinh_danh");
ALTER TABLE "tai_chinh"."nguon_chi_phi" ADD CONSTRAINT fk_4fdd678f369d7d9064 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_4fdd678f369d7d9064 ON "tai_chinh"."nguon_chi_phi" ("ma_bo_du_lieu");
ALTER TABLE "tai_chinh"."nguon_chi_phi" ADD CONSTRAINT fk_94c389c5d1e3a8b3b7 FOREIGN KEY ("ma_dong_nguon_nghiep_vu",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_94c389c5d1e3a8b3b7 ON "tai_chinh"."nguon_chi_phi" ("ma_dong_nguon_nghiep_vu");
ALTER TABLE "tai_chinh"."nguon_chi_phi" ADD CONSTRAINT fk_e6c7f9c093201d5e10 FOREIGN KEY ("ma_dong_thu_nhap_nhan_vien",ma_bo_du_lieu) REFERENCES "nhan_su"."thu_nhap_nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_e6c7f9c093201d5e10 ON "tai_chinh"."nguon_chi_phi" ("ma_dong_thu_nhap_nhan_vien");
ALTER TABLE "tai_chinh"."nguon_chi_phi" ADD CONSTRAINT fk_45badbbe4d97ddd850 FOREIGN KEY ("ma_dong_vat_tu_thuc_dung",ma_bo_du_lieu) REFERENCES "kho"."dong_van_dong_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_45badbbe4d97ddd850 ON "tai_chinh"."nguon_chi_phi" ("ma_dong_vat_tu_thuc_dung");
ALTER TABLE "tai_chinh"."nguon_chi_phi" ADD CONSTRAINT fk_d1738a3a4d62248f6f FOREIGN KEY ("ma_phien_ban_chinh_sach",ma_bo_du_lieu) REFERENCES "dung_chung"."phien_ban_chinh_sach" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_d1738a3a4d62248f6f ON "tai_chinh"."nguon_chi_phi" ("ma_phien_ban_chinh_sach");
ALTER TABLE "tai_chinh"."nguon_chi_phi" ADD CONSTRAINT fk_62c6779fd732b68800 FOREIGN KEY ("ma_nguon_chi_phi_bi_thay",ma_bo_du_lieu) REFERENCES "tai_chinh"."nguon_chi_phi" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_62c6779fd732b68800 ON "tai_chinh"."nguon_chi_phi" ("ma_nguon_chi_phi_bi_thay");
ALTER TABLE "tai_chinh"."phan_bo_chi_phi" ADD CONSTRAINT fk_023b80b2c0e1a49e14 FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_023b80b2c0e1a49e14 ON "tai_chinh"."phan_bo_chi_phi" ("ma_dinh_danh");
ALTER TABLE "tai_chinh"."phan_bo_chi_phi" ADD CONSTRAINT fk_db8cf8663acb97b845 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_db8cf8663acb97b845 ON "tai_chinh"."phan_bo_chi_phi" ("ma_bo_du_lieu");
ALTER TABLE "tai_chinh"."phan_bo_chi_phi" ADD CONSTRAINT fk_d3c804b3775579adb0 FOREIGN KEY ("ma_nguon_chi_phi",ma_bo_du_lieu) REFERENCES "tai_chinh"."nguon_chi_phi" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_d3c804b3775579adb0 ON "tai_chinh"."phan_bo_chi_phi" ("ma_nguon_chi_phi");
ALTER TABLE "tai_chinh"."phan_bo_chi_phi" ADD CONSTRAINT fk_f038c5ab53fc80f7f1 FOREIGN KEY ("ma_lo_san_xuat",ma_bo_du_lieu) REFERENCES "san_xuat"."lo_san_xuat" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_f038c5ab53fc80f7f1 ON "tai_chinh"."phan_bo_chi_phi" ("ma_lo_san_xuat");
ALTER TABLE "tai_chinh"."phan_bo_chi_phi" ADD CONSTRAINT fk_569ce1ac493e16d029 FOREIGN KEY ("ma_phien_ban_chinh_sach",ma_bo_du_lieu) REFERENCES "dung_chung"."phien_ban_chinh_sach" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_569ce1ac493e16d029 ON "tai_chinh"."phan_bo_chi_phi" ("ma_phien_ban_chinh_sach");
ALTER TABLE "tai_chinh"."phan_bo_chi_phi" ADD CONSTRAINT fk_7e508f89c4518789af FOREIGN KEY ("ma_ban_phan_bo_chi_phi_bi_thay",ma_bo_du_lieu) REFERENCES "tai_chinh"."phan_bo_chi_phi" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_7e508f89c4518789af ON "tai_chinh"."phan_bo_chi_phi" ("ma_ban_phan_bo_chi_phi_bi_thay");
ALTER TABLE "tai_chinh"."can_cu_phan_bo_chi_phi" ADD CONSTRAINT fk_5a7f89310ef23a2f51 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_5a7f89310ef23a2f51 ON "tai_chinh"."can_cu_phan_bo_chi_phi" ("ma_bo_du_lieu");
ALTER TABLE "tai_chinh"."can_cu_phan_bo_chi_phi" ADD CONSTRAINT fk_f856d146c41c23e57f FOREIGN KEY ("ma_dong_phan_bo_chi_phi",ma_bo_du_lieu) REFERENCES "tai_chinh"."phan_bo_chi_phi" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_f856d146c41c23e57f ON "tai_chinh"."can_cu_phan_bo_chi_phi" ("ma_dong_phan_bo_chi_phi");
ALTER TABLE "tai_chinh"."can_cu_phan_bo_chi_phi" ADD CONSTRAINT fk_2ae5f1a93fb6a2fc58 FOREIGN KEY ("ma_khoang_cong_thuc_te",ma_bo_du_lieu) REFERENCES "nhan_su"."khoang_cong_thuc_te" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_2ae5f1a93fb6a2fc58 ON "tai_chinh"."can_cu_phan_bo_chi_phi" ("ma_khoang_cong_thuc_te");
ALTER TABLE "tai_chinh"."can_cu_phan_bo_chi_phi" ADD CONSTRAINT fk_b43c5fecebcd2c0d3d FOREIGN KEY ("ma_lich_nguon_luc",ma_bo_du_lieu) REFERENCES "san_xuat"."lich_nguoi_va_nguon_luc" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_b43c5fecebcd2c0d3d ON "tai_chinh"."can_cu_phan_bo_chi_phi" ("ma_lich_nguon_luc");
ALTER TABLE "tai_chinh"."can_cu_phan_bo_chi_phi" ADD CONSTRAINT fk_5019e4d3ab9d6afbe2 FOREIGN KEY ("ma_dong_vat_tu_thuc_dung",ma_bo_du_lieu) REFERENCES "kho"."dong_van_dong_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_5019e4d3ab9d6afbe2 ON "tai_chinh"."can_cu_phan_bo_chi_phi" ("ma_dong_vat_tu_thuc_dung");
ALTER TABLE "tai_chinh"."can_cu_phan_bo_chi_phi" ADD CONSTRAINT fk_3ea285b121f32e6c79 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_3ea285b121f32e6c79 ON "tai_chinh"."can_cu_phan_bo_chi_phi" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "tai_chinh"."bien_dong_gia_tri" ADD CONSTRAINT fk_6e6d937b8d0c4da523 FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_6e6d937b8d0c4da523 ON "tai_chinh"."bien_dong_gia_tri" ("ma_dinh_danh");
ALTER TABLE "tai_chinh"."bien_dong_gia_tri" ADD CONSTRAINT fk_c83f41fdaafcc9275f FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_c83f41fdaafcc9275f ON "tai_chinh"."bien_dong_gia_tri" ("ma_bo_du_lieu");
ALTER TABLE "tai_chinh"."bien_dong_gia_tri" ADD CONSTRAINT fk_f705a24aa121c6604a FOREIGN KEY ("ma_mat_hang",ma_bo_du_lieu) REFERENCES "danh_muc"."mat_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_f705a24aa121c6604a ON "tai_chinh"."bien_dong_gia_tri" ("ma_mat_hang");
ALTER TABLE "tai_chinh"."bien_dong_gia_tri" ADD CONSTRAINT fk_973c690486480e5efb FOREIGN KEY ("ma_dong_van_dong_hang",ma_bo_du_lieu) REFERENCES "kho"."dong_van_dong_hang" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_973c690486480e5efb ON "tai_chinh"."bien_dong_gia_tri" ("ma_dong_van_dong_hang");
ALTER TABLE "tai_chinh"."bien_dong_gia_tri" ADD CONSTRAINT fk_268ee8db967bc84e0c FOREIGN KEY ("ma_chung_tu_ban_chot_gia_thanh",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_268ee8db967bc84e0c ON "tai_chinh"."bien_dong_gia_tri" ("ma_chung_tu_ban_chot_gia_thanh");
ALTER TABLE "tai_chinh"."bien_dong_gia_tri" ADD CONSTRAINT fk_897bba6d1db5c46e79 FOREIGN KEY ("ma_dong_ghi_ban",ma_bo_du_lieu) REFERENCES "tai_chinh"."dong_ghi_nhan_ban" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_897bba6d1db5c46e79 ON "tai_chinh"."bien_dong_gia_tri" ("ma_dong_ghi_ban");
ALTER TABLE "tai_chinh"."bien_dong_gia_tri" ADD CONSTRAINT fk_bcd03aca8818f7f1bc FOREIGN KEY ("ma_bien_dong_gia_tri_goc",ma_bo_du_lieu) REFERENCES "tai_chinh"."bien_dong_gia_tri" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_bcd03aca8818f7f1bc ON "tai_chinh"."bien_dong_gia_tri" ("ma_bien_dong_gia_tri_goc");
ALTER TABLE "nhan_su"."nhan_vien" ADD CONSTRAINT fk_218f7ddb93d53f307c FOREIGN KEY ("ma_nguoi_that") REFERENCES "truy_cap"."dinh_danh_nguoi" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_218f7ddb93d53f307c ON "nhan_su"."nhan_vien" ("ma_nguoi_that");
ALTER TABLE "nhan_su"."nhan_vien" ADD CONSTRAINT fk_94fc3932dec1411d07 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_94fc3932dec1411d07 ON "nhan_su"."nhan_vien" ("ma_bo_du_lieu");
ALTER TABLE "nhan_su"."nhan_vien" ADD CONSTRAINT fk_e79dc31e706516b070 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_e79dc31e706516b070 ON "nhan_su"."nhan_vien" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "nhan_su"."ho_so_lam_viec_theo_hieu_luc" ADD CONSTRAINT fk_b7ab7e7a48ef2d7d3b FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_b7ab7e7a48ef2d7d3b ON "nhan_su"."ho_so_lam_viec_theo_hieu_luc" ("ma_dinh_danh");
ALTER TABLE "nhan_su"."ho_so_lam_viec_theo_hieu_luc" ADD CONSTRAINT fk_1fc961cf4e49980e58 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_1fc961cf4e49980e58 ON "nhan_su"."ho_so_lam_viec_theo_hieu_luc" ("ma_bo_du_lieu");
ALTER TABLE "nhan_su"."ho_so_lam_viec_theo_hieu_luc" ADD CONSTRAINT fk_c38abe6d643ea441da FOREIGN KEY ("ma_nhan_vien",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_c38abe6d643ea441da ON "nhan_su"."ho_so_lam_viec_theo_hieu_luc" ("ma_nhan_vien");
ALTER TABLE "nhan_su"."ho_so_lam_viec_theo_hieu_luc" ADD CONSTRAINT fk_406f6ce4e93f84815e FOREIGN KEY ("ma_bo_phan",ma_bo_du_lieu) REFERENCES "dung_chung"."bo_phan" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_406f6ce4e93f84815e ON "nhan_su"."ho_so_lam_viec_theo_hieu_luc" ("ma_bo_phan");
ALTER TABLE "nhan_su"."ho_so_lam_viec_theo_hieu_luc" ADD CONSTRAINT fk_5aac11ca5b73ae806d FOREIGN KEY ("ma_nhan_vien_quan_ly",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_5aac11ca5b73ae806d ON "nhan_su"."ho_so_lam_viec_theo_hieu_luc" ("ma_nhan_vien_quan_ly");
ALTER TABLE "nhan_su"."ho_so_lam_viec_theo_hieu_luc" ADD CONSTRAINT fk_34bd92985c5130013e FOREIGN KEY ("ma_phien_ban_chinh_sach_thu_nhap",ma_bo_du_lieu) REFERENCES "dung_chung"."phien_ban_chinh_sach" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_34bd92985c5130013e ON "nhan_su"."ho_so_lam_viec_theo_hieu_luc" ("ma_phien_ban_chinh_sach_thu_nhap");
ALTER TABLE "nhan_su"."ho_so_ky_nang_va_an_toan" ADD CONSTRAINT fk_86d179dabfa7845a19 FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_86d179dabfa7845a19 ON "nhan_su"."ho_so_ky_nang_va_an_toan" ("ma_dinh_danh");
ALTER TABLE "nhan_su"."ho_so_ky_nang_va_an_toan" ADD CONSTRAINT fk_84f80c885784e3eb95 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_84f80c885784e3eb95 ON "nhan_su"."ho_so_ky_nang_va_an_toan" ("ma_bo_du_lieu");
ALTER TABLE "nhan_su"."ho_so_ky_nang_va_an_toan" ADD CONSTRAINT fk_2b29786c9e298eb08f FOREIGN KEY ("ma_nhan_vien",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_2b29786c9e298eb08f ON "nhan_su"."ho_so_ky_nang_va_an_toan" ("ma_nhan_vien");
ALTER TABLE "nhan_su"."ngay_va_ca_lam_viec" ADD CONSTRAINT fk_fc2ceb843dff38efa3 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_fc2ceb843dff38efa3 ON "nhan_su"."ngay_va_ca_lam_viec" ("ma_bo_du_lieu");
ALTER TABLE "nhan_su"."ngay_va_ca_lam_viec" ADD CONSTRAINT fk_bb6421d77a5fea20cd FOREIGN KEY ("ma_phien_ban_chinh_sach",ma_bo_du_lieu) REFERENCES "dung_chung"."phien_ban_chinh_sach" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_bb6421d77a5fea20cd ON "nhan_su"."ngay_va_ca_lam_viec" ("ma_phien_ban_chinh_sach");
ALTER TABLE "nhan_su"."ngay_va_ca_lam_viec" ADD CONSTRAINT fk_7e91c2f3e364b03760 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_7e91c2f3e364b03760 ON "nhan_su"."ngay_va_ca_lam_viec" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "nhan_su"."khoang_cong_thuc_te" ADD CONSTRAINT fk_d5b21a9edb0367b1e9 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_d5b21a9edb0367b1e9 ON "nhan_su"."khoang_cong_thuc_te" ("ma_bo_du_lieu");
ALTER TABLE "nhan_su"."khoang_cong_thuc_te" ADD CONSTRAINT fk_127e58beda40115b2e FOREIGN KEY ("ma_chung_tu_ban_cong",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_127e58beda40115b2e ON "nhan_su"."khoang_cong_thuc_te" ("ma_chung_tu_ban_cong");
ALTER TABLE "nhan_su"."khoang_cong_thuc_te" ADD CONSTRAINT fk_011320d2417e0c4545 FOREIGN KEY ("ma_chung_tu_cong_doan",ma_bo_du_lieu) REFERENCES "san_xuat"."cong_doan_san_xuat" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_011320d2417e0c4545 ON "nhan_su"."khoang_cong_thuc_te" ("ma_chung_tu_cong_doan");
ALTER TABLE "nhan_su"."khoang_cong_thuc_te" ADD CONSTRAINT fk_4ba032b79f2708686c FOREIGN KEY ("ma_chung_tu_de_nghi_nghi",ma_bo_du_lieu) REFERENCES "nhan_su"."de_nghi_nghi" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_4ba032b79f2708686c ON "nhan_su"."khoang_cong_thuc_te" ("ma_chung_tu_de_nghi_nghi");
ALTER TABLE "nhan_su"."khoang_cong_thuc_te" ADD CONSTRAINT fk_995b715e23b1fb5ff1 FOREIGN KEY ("ma_quyet_dinh_duyet_lam_them",ma_bo_du_lieu) REFERENCES "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_995b715e23b1fb5ff1 ON "nhan_su"."khoang_cong_thuc_te" ("ma_quyet_dinh_duyet_lam_them");
ALTER TABLE "nhan_su"."khoang_cong_thuc_te" ADD CONSTRAINT fk_52b0220770c6bf9158 FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_52b0220770c6bf9158 ON "nhan_su"."khoang_cong_thuc_te" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "nhan_su"."de_nghi_nghi" ADD CONSTRAINT fk_4e415acfa442f816bc FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_4e415acfa442f816bc ON "nhan_su"."de_nghi_nghi" ("ma_dinh_danh");
ALTER TABLE "nhan_su"."de_nghi_nghi" ADD CONSTRAINT fk_4c8ce06d6b9065b706 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_4c8ce06d6b9065b706 ON "nhan_su"."de_nghi_nghi" ("ma_bo_du_lieu");
ALTER TABLE "nhan_su"."de_nghi_nghi" ADD CONSTRAINT fk_781744ece72d45756f FOREIGN KEY ("ma_nhan_vien",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_781744ece72d45756f ON "nhan_su"."de_nghi_nghi" ("ma_nhan_vien");
ALTER TABLE "nhan_su"."de_nghi_nghi" ADD CONSTRAINT fk_21bcc5f79070e4264e FOREIGN KEY ("ma_nhan_vien_lam_thay",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_21bcc5f79070e4264e ON "nhan_su"."de_nghi_nghi" ("ma_nhan_vien_lam_thay");
ALTER TABLE "nhan_su"."de_nghi_nghi" ADD CONSTRAINT fk_55fc06035d45f64fdb FOREIGN KEY ("ma_phien_ban_chinh_sach",ma_bo_du_lieu) REFERENCES "dung_chung"."phien_ban_chinh_sach" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_55fc06035d45f64fdb ON "nhan_su"."de_nghi_nghi" ("ma_phien_ban_chinh_sach");
ALTER TABLE "nhan_su"."de_nghi_nghi" ADD CONSTRAINT fk_8db49f7b3911fa7fc1 FOREIGN KEY ("ma_phe_duyet",ma_bo_du_lieu) REFERENCES "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_8db49f7b3911fa7fc1 ON "nhan_su"."de_nghi_nghi" ("ma_phe_duyet");
ALTER TABLE "nhan_su"."su_kien_phep" ADD CONSTRAINT fk_8722af2f611f69076d FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_8722af2f611f69076d ON "nhan_su"."su_kien_phep" ("ma_dinh_danh");
ALTER TABLE "nhan_su"."su_kien_phep" ADD CONSTRAINT fk_7a3c7a19e07d8d3e94 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_7a3c7a19e07d8d3e94 ON "nhan_su"."su_kien_phep" ("ma_bo_du_lieu");
ALTER TABLE "nhan_su"."su_kien_phep" ADD CONSTRAINT fk_8dd33d6179685b3683 FOREIGN KEY ("ma_nhan_vien",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_8dd33d6179685b3683 ON "nhan_su"."su_kien_phep" ("ma_nhan_vien");
ALTER TABLE "nhan_su"."su_kien_phep" ADD CONSTRAINT fk_50ea7acd03ab9c0991 FOREIGN KEY ("ma_chung_tu_de_nghi_nghi",ma_bo_du_lieu) REFERENCES "nhan_su"."de_nghi_nghi" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_50ea7acd03ab9c0991 ON "nhan_su"."su_kien_phep" ("ma_chung_tu_de_nghi_nghi");
ALTER TABLE "nhan_su"."su_kien_phep" ADD CONSTRAINT fk_c6b9df973d4c4441d7 FOREIGN KEY ("ma_su_kien_giu_goc",ma_bo_du_lieu) REFERENCES "nhan_su"."su_kien_phep" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_c6b9df973d4c4441d7 ON "nhan_su"."su_kien_phep" ("ma_su_kien_giu_goc");
ALTER TABLE "nhan_su"."su_kien_phep" ADD CONSTRAINT fk_7fc7d11ea085008e52 FOREIGN KEY ("ma_phe_duyet",ma_bo_du_lieu) REFERENCES "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_7fc7d11ea085008e52 ON "nhan_su"."su_kien_phep" ("ma_phe_duyet");
ALTER TABLE "nhan_su"."thu_nhap_nhan_vien" ADD CONSTRAINT fk_60a74d04790171e9ba FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_60a74d04790171e9ba ON "nhan_su"."thu_nhap_nhan_vien" ("ma_dinh_danh");
ALTER TABLE "nhan_su"."thu_nhap_nhan_vien" ADD CONSTRAINT fk_eba77ac040f2747435 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_eba77ac040f2747435 ON "nhan_su"."thu_nhap_nhan_vien" ("ma_bo_du_lieu");
ALTER TABLE "nhan_su"."thu_nhap_nhan_vien" ADD CONSTRAINT fk_34391f92ec24784f42 FOREIGN KEY ("ma_chung_tu_ky_tinh_thu_nhap",ma_bo_du_lieu) REFERENCES "dung_chung"."ky_nghiep_vu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_34391f92ec24784f42 ON "nhan_su"."thu_nhap_nhan_vien" ("ma_chung_tu_ky_tinh_thu_nhap");
ALTER TABLE "nhan_su"."thu_nhap_nhan_vien" ADD CONSTRAINT fk_f124620ab580135997 FOREIGN KEY ("ma_nhan_vien",ma_bo_du_lieu) REFERENCES "nhan_su"."nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_f124620ab580135997 ON "nhan_su"."thu_nhap_nhan_vien" ("ma_nhan_vien");
ALTER TABLE "nhan_su"."thu_nhap_nhan_vien" ADD CONSTRAINT fk_4e5522d998fa825ec5 FOREIGN KEY ("ma_ho_so_lam_viec_theo_hieu_luc",ma_bo_du_lieu) REFERENCES "nhan_su"."ho_so_lam_viec_theo_hieu_luc" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_4e5522d998fa825ec5 ON "nhan_su"."thu_nhap_nhan_vien" ("ma_ho_so_lam_viec_theo_hieu_luc");
ALTER TABLE "nhan_su"."thu_nhap_nhan_vien" ADD CONSTRAINT fk_e77bfbcb824c275181 FOREIGN KEY ("ma_phe_duyet",ma_bo_du_lieu) REFERENCES "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_e77bfbcb824c275181 ON "nhan_su"."thu_nhap_nhan_vien" ("ma_phe_duyet");
ALTER TABLE "nhan_su"."thu_nhap_nhan_vien" ADD CONSTRAINT fk_f0df7a4211e6286830 FOREIGN KEY ("ma_dong_thu_nhap_goc",ma_bo_du_lieu) REFERENCES "nhan_su"."thu_nhap_nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_f0df7a4211e6286830 ON "nhan_su"."thu_nhap_nhan_vien" ("ma_dong_thu_nhap_goc");
ALTER TABLE "nhan_su"."khoan_thu_nhap_co_can_cu" ADD CONSTRAINT fk_842899519ac60d53b7 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_842899519ac60d53b7 ON "nhan_su"."khoan_thu_nhap_co_can_cu" ("ma_bo_du_lieu");
ALTER TABLE "nhan_su"."khoan_thu_nhap_co_can_cu" ADD CONSTRAINT fk_885c57702634dd6e39 FOREIGN KEY ("ma_dong_thu_nhap_nhan_vien",ma_bo_du_lieu) REFERENCES "nhan_su"."thu_nhap_nhan_vien" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_885c57702634dd6e39 ON "nhan_su"."khoan_thu_nhap_co_can_cu" ("ma_dong_thu_nhap_nhan_vien");
ALTER TABLE "nhan_su"."khoan_thu_nhap_co_can_cu" ADD CONSTRAINT fk_fb7b9ea82bcb094444 FOREIGN KEY ("ma_phien_ban_chinh_sach",ma_bo_du_lieu) REFERENCES "dung_chung"."phien_ban_chinh_sach" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_fb7b9ea82bcb094444 ON "nhan_su"."khoan_thu_nhap_co_can_cu" ("ma_phien_ban_chinh_sach");
ALTER TABLE "nhan_su"."khoan_thu_nhap_co_can_cu" ADD CONSTRAINT fk_036f289e577c4515a0 FOREIGN KEY ("ma_phe_duyet",ma_bo_du_lieu) REFERENCES "dung_chung"."de_nghi_va_quyet_dinh_phe_duyet" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_036f289e577c4515a0 ON "nhan_su"."khoan_thu_nhap_co_can_cu" ("ma_phe_duyet");
ALTER TABLE "nhan_su"."khoan_thu_nhap_co_can_cu" ADD CONSTRAINT fk_250ec2e3c958e787ac FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_250ec2e3c958e787ac ON "nhan_su"."khoan_thu_nhap_co_can_cu" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "truy_cap"."phien_dang_nhap" ADD CONSTRAINT fk_c24f43952b6c6b5691 FOREIGN KEY ("ma_tai_khoan") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_c24f43952b6c6b5691 ON "truy_cap"."phien_dang_nhap" ("ma_tai_khoan");
ALTER TABLE "truy_cap"."phien_dang_nhap" ADD CONSTRAINT fk_034ccdb8512ce0fc0e FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_034ccdb8512ce0fc0e ON "truy_cap"."phien_dang_nhap" ("ma_tai_khoan_thuc_hien");
ALTER TABLE "tai_chinh"."nguon_cua_ban_chot_gia_thanh" ADD CONSTRAINT fk_8dce27d3fc7409d7ea FOREIGN KEY ("ma_dinh_danh",ma_bo_du_lieu) REFERENCES "dung_chung"."dong_chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_8dce27d3fc7409d7ea ON "tai_chinh"."nguon_cua_ban_chot_gia_thanh" ("ma_dinh_danh");
ALTER TABLE "tai_chinh"."nguon_cua_ban_chot_gia_thanh" ADD CONSTRAINT fk_8af7107bcd100f7292 FOREIGN KEY ("ma_bo_du_lieu") REFERENCES "dung_chung"."bo_du_lieu_mo_phong" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_8af7107bcd100f7292 ON "tai_chinh"."nguon_cua_ban_chot_gia_thanh" ("ma_bo_du_lieu");
ALTER TABLE "tai_chinh"."nguon_cua_ban_chot_gia_thanh" ADD CONSTRAINT fk_efa0f2d62338191588 FOREIGN KEY ("ma_chung_tu_ban_chot_gia_thanh",ma_bo_du_lieu) REFERENCES "dung_chung"."chung_tu" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_efa0f2d62338191588 ON "tai_chinh"."nguon_cua_ban_chot_gia_thanh" ("ma_chung_tu_ban_chot_gia_thanh");
ALTER TABLE "tai_chinh"."nguon_cua_ban_chot_gia_thanh" ADD CONSTRAINT fk_7c8206d88d22f88b65 FOREIGN KEY ("ma_dong_phan_bo_chi_phi",ma_bo_du_lieu) REFERENCES "tai_chinh"."phan_bo_chi_phi" ("ma_dinh_danh",ma_bo_du_lieu) ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_7c8206d88d22f88b65 ON "tai_chinh"."nguon_cua_ban_chot_gia_thanh" ("ma_dong_phan_bo_chi_phi");
ALTER TABLE "truy_cap"."dinh_danh_nguoi" ADD CONSTRAINT fk_5a312382b83de1eb4c FOREIGN KEY ("ma_tai_khoan_thuc_hien") REFERENCES "truy_cap"."tai_khoan_dang_nhap" ("ma_dinh_danh") ON DELETE RESTRICT DEFERRABLE INITIALLY IMMEDIATE;
CREATE INDEX lk_5a312382b83de1eb4c ON "truy_cap"."dinh_danh_nguoi" ("ma_tai_khoan_thuc_hien");
CREATE FUNCTION nen_tang.nguon_00() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_phieu_van_dong_hang" IS NOT NULL THEN SELECT "loai" FROM "dung_chung"."chung_tu" WHERE ma_dinh_danh=NEW."ma_phieu_van_dong_hang" INTO v; IF v IS NULL OR v NOT IN ('van_dong_hang') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_00' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_00 AFTER INSERT OR UPDATE ON "kho"."dong_van_dong_hang" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_00();
CREATE FUNCTION nen_tang.nguon_01() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_bien_ban_kiem_ke" IS NOT NULL THEN SELECT "loai" FROM "dung_chung"."chung_tu" WHERE ma_dinh_danh=NEW."ma_bien_ban_kiem_ke" INTO v; IF v IS NULL OR v NOT IN ('kiem_ke') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_01' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_01 AFTER INSERT OR UPDATE ON "kho"."dong_kiem_ke" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_01();
CREATE FUNCTION nen_tang.nguon_02() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_chung_tu_ghi_ban" IS NOT NULL THEN SELECT "loai" FROM "dung_chung"."chung_tu" WHERE ma_dinh_danh=NEW."ma_chung_tu_ghi_ban" INTO v; IF v IS NULL OR v NOT IN ('ghi_ban','giam_ban','tang_ban') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_02' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_02 AFTER INSERT OR UPDATE ON "tai_chinh"."dong_ghi_nhan_ban" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_02();
CREATE FUNCTION nen_tang.nguon_03() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_chung_tu_ban_chot_gia_thanh" IS NOT NULL THEN SELECT "loai" FROM "dung_chung"."chung_tu" WHERE ma_dinh_danh=NEW."ma_chung_tu_ban_chot_gia_thanh" INTO v; IF v IS NULL OR v NOT IN ('chot_gia_thanh') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_03' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_03 AFTER INSERT OR UPDATE ON "tai_chinh"."nguon_cua_ban_chot_gia_thanh" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_03();
CREATE FUNCTION nen_tang.nguon_04() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_chung_tu_ban_cong" IS NOT NULL THEN SELECT "loai" FROM "dung_chung"."chung_tu" WHERE ma_dinh_danh=NEW."ma_chung_tu_ban_cong" INTO v; IF v IS NULL OR v NOT IN ('cong') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_04' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_04 AFTER INSERT OR UPDATE ON "nhan_su"."khoang_cong_thuc_te" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_04();
CREATE FUNCTION nen_tang.nguon_05() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_chung_tu_ky_tinh_thu_nhap" IS NOT NULL THEN SELECT "loai_ky" FROM "dung_chung"."ky_nghiep_vu" WHERE ma_dinh_danh=NEW."ma_chung_tu_ky_tinh_thu_nhap" INTO v; IF v IS NULL OR v NOT IN ('thu_nhap') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_05' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_05 AFTER INSERT OR UPDATE ON "nhan_su"."thu_nhap_nhan_vien" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_05();
CREATE FUNCTION nen_tang.nguon_06() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_dong_xac_nhan_khach_nhan" IS NOT NULL THEN SELECT "loai_dong_giao" FROM "giao_hang"."dong_giao_va_nhan_hang" WHERE ma_dinh_danh=NEW."ma_dong_xac_nhan_khach_nhan" INTO v; IF v IS NULL OR v NOT IN ('nhan_thuc') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_06' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_06 AFTER INSERT OR UPDATE ON "tai_chinh"."dong_ghi_nhan_ban" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_06();
CREATE FUNCTION nen_tang.nguon_07() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_nghia_vu_thanh_toan" IS NOT NULL THEN SELECT "loai_ban_ghi_nghia_vu" FROM "tai_chinh"."nghia_vu_va_dieu_chinh" WHERE ma_dinh_danh=NEW."ma_nghia_vu_thanh_toan" INTO v; IF v IS NULL OR v NOT IN ('xac_lap') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_07' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_07 AFTER INSERT OR UPDATE ON "tai_chinh"."su_kien_su_dung_nguon_tien" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_07();
CREATE FUNCTION nen_tang.nguon_08() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_dong_giao_du_kien" IS NOT NULL THEN SELECT "loai_dong_giao" FROM "giao_hang"."dong_giao_va_nhan_hang" WHERE ma_dinh_danh=NEW."ma_dong_giao_du_kien" INTO v; IF v IS NULL OR v NOT IN ('giao_du_kien') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_08' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_08 AFTER INSERT OR UPDATE ON "giao_hang"."dong_giao_va_nhan_hang" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_08();
CREATE FUNCTION nen_tang.nguon_09() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_nghia_vu_goc" IS NOT NULL THEN SELECT "loai_ban_ghi_nghia_vu" FROM "tai_chinh"."nghia_vu_va_dieu_chinh" WHERE ma_dinh_danh=NEW."ma_nghia_vu_goc" INTO v; IF v IS NULL OR v NOT IN ('xac_lap') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_09' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_09 AFTER INSERT OR UPDATE ON "tai_chinh"."nghia_vu_va_dieu_chinh" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_09();
CREATE FUNCTION nen_tang.nguon_10() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_nhom_mau" IS NOT NULL THEN SELECT "loai_mat_hang" FROM "danh_muc"."mat_hang" WHERE ma_dinh_danh=NEW."ma_nhom_mau" INTO v; IF v IS NULL OR v NOT IN ('nhom_mau') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_10' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_10 AFTER INSERT OR UPDATE ON "danh_muc"."mat_hang" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_10();
CREATE FUNCTION nen_tang.nguon_11() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_dong_cap_vat_tu_nguon" IS NOT NULL THEN SELECT p.loai_van_dong_kho FROM "kho"."dong_van_dong_hang" d JOIN dung_chung.chung_tu p ON p.ma_dinh_danh=d.ma_phieu_van_dong_hang WHERE d.ma_dinh_danh=NEW."ma_dong_cap_vat_tu_nguon" INTO v; IF v IS NULL OR v NOT IN ('cap_phat') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_11' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_11 AFTER INSERT OR UPDATE ON "kho"."dong_van_dong_hang" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_11();
CREATE FUNCTION nen_tang.nguon_12() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_dong_vat_tu_thuc_dung" IS NOT NULL THEN SELECT p.loai_van_dong_kho FROM "kho"."dong_van_dong_hang" d JOIN dung_chung.chung_tu p ON p.ma_dinh_danh=d.ma_phieu_van_dong_hang WHERE d.ma_dinh_danh=NEW."ma_dong_vat_tu_thuc_dung" INTO v; IF v IS NULL OR v NOT IN ('thuc_dung') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_12' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_12 AFTER INSERT OR UPDATE ON "tai_chinh"."nguon_chi_phi" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_12();
CREATE FUNCTION nen_tang.nguon_13() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_dong_vat_tu_thuc_dung" IS NOT NULL THEN SELECT p.loai_van_dong_kho FROM "kho"."dong_van_dong_hang" d JOIN dung_chung.chung_tu p ON p.ma_dinh_danh=d.ma_phieu_van_dong_hang WHERE d.ma_dinh_danh=NEW."ma_dong_vat_tu_thuc_dung" INTO v; IF v IS NULL OR v NOT IN ('thuc_dung') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_13' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_13 AFTER INSERT OR UPDATE ON "tai_chinh"."can_cu_phan_bo_chi_phi" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_13();
CREATE FUNCTION nen_tang.nguon_14() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_dong_tu_van_goc" IS NOT NULL THEN SELECT "giai_doan_dong" FROM "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" WHERE ma_dinh_danh=NEW."ma_dong_tu_van_goc" INTO v; IF v IS NULL OR v NOT IN ('tu_van') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_14' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_14 AFTER INSERT OR UPDATE ON "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_14();
CREATE FUNCTION nen_tang.nguon_15() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_ho_so_lien_quan" IS NOT NULL THEN SELECT "loai_ho_so_xu_ly" FROM "kinh_doanh"."ho_so_xu_ly" WHERE ma_dinh_danh=NEW."ma_ho_so_lien_quan" INTO v; IF v IS NULL OR v NOT IN ('thuong_mai','chat_luong') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_15' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_15 AFTER INSERT OR UPDATE ON "kinh_doanh"."ho_so_xu_ly" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_15();
CREATE FUNCTION nen_tang.nguon_16() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_mat_hang" IS NOT NULL THEN SELECT "loai_mat_hang" FROM "danh_muc"."mat_hang" WHERE ma_dinh_danh=NEW."ma_mat_hang" INTO v; IF v IS NULL OR v NOT IN ('nhom_mau','bien_the','vat_tu','bao_ho') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_16' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_16 AFTER INSERT OR UPDATE ON "danh_muc"."ma_goi_khac" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_16();
CREATE FUNCTION nen_tang.nguon_17() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_mat_hang" IS NOT NULL THEN SELECT "loai_mat_hang" FROM "danh_muc"."mat_hang" WHERE ma_dinh_danh=NEW."ma_mat_hang" INTO v; IF v IS NULL OR v NOT IN ('bien_the','vat_tu','bao_ho') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_17' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_17 AFTER INSERT OR UPDATE ON "danh_muc"."quy_doi_don_vi" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_17();
CREATE FUNCTION nen_tang.nguon_18() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_mat_hang" IS NOT NULL THEN SELECT "loai_mat_hang" FROM "danh_muc"."mat_hang" WHERE ma_dinh_danh=NEW."ma_mat_hang" INTO v; IF v IS NULL OR v NOT IN ('bien_the','vat_tu','bao_ho') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_18' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_18 AFTER INSERT OR UPDATE ON "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_18();
CREATE FUNCTION nen_tang.nguon_19() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_ho_so_giao_bu" IS NOT NULL THEN SELECT "loai_ho_so_xu_ly" FROM "kinh_doanh"."ho_so_xu_ly" WHERE ma_dinh_danh=NEW."ma_ho_so_giao_bu" INTO v; IF v IS NULL OR v NOT IN ('thuong_mai') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_19' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_19 AFTER INSERT OR UPDATE ON "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_19();
CREATE FUNCTION nen_tang.nguon_20() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_dong_don_hang" IS NOT NULL THEN SELECT "giai_doan_dong" FROM "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" WHERE ma_dinh_danh=NEW."ma_dong_don_hang" INTO v; IF v IS NULL OR v NOT IN ('bao_gia','don_hang') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_20' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_20 AFTER INSERT OR UPDATE ON "kinh_doanh"."mau_khach_duyet" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_20();
CREATE FUNCTION nen_tang.nguon_21() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_dong_don_hang_goc" IS NOT NULL THEN SELECT "giai_doan_dong" FROM "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" WHERE ma_dinh_danh=NEW."ma_dong_don_hang_goc" INTO v; IF v IS NULL OR v NOT IN ('bao_gia','don_hang') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_21' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_21 AFTER INSERT OR UPDATE ON "kinh_doanh"."ho_so_xu_ly" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_21();
CREATE FUNCTION nen_tang.nguon_22() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_dong_don_hang_moi" IS NOT NULL THEN SELECT "giai_doan_dong" FROM "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" WHERE ma_dinh_danh=NEW."ma_dong_don_hang_moi" INTO v; IF v IS NULL OR v NOT IN ('bao_gia','don_hang') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_22' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_22 AFTER INSERT OR UPDATE ON "kinh_doanh"."ho_so_xu_ly" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_22();
CREATE FUNCTION nen_tang.nguon_23() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_mat_hang" IS NOT NULL THEN SELECT "loai_mat_hang" FROM "danh_muc"."mat_hang" WHERE ma_dinh_danh=NEW."ma_mat_hang" INTO v; IF v IS NULL OR v NOT IN ('bien_the','vat_tu','bao_ho') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_23' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_23 AFTER INSERT OR UPDATE ON "mua_hang"."dong_don_mua_hang" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_23();
CREATE FUNCTION nen_tang.nguon_24() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_su_kien_dang_ve_bi_thay" IS NOT NULL THEN SELECT "loai" FROM "kho"."su_kien_giu_khoa_va_dang_ve" WHERE ma_dinh_danh=NEW."ma_su_kien_dang_ve_bi_thay" INTO v; IF v IS NULL OR v NOT IN ('giu_dang_ve','giai_phong_dang_ve') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_24' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_24 AFTER INSERT OR UPDATE ON "kho"."su_kien_giu_khoa_va_dang_ve" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_24();
CREATE FUNCTION nen_tang.nguon_25() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_mat_hang" IS NOT NULL THEN SELECT "loai_mat_hang" FROM "danh_muc"."mat_hang" WHERE ma_dinh_danh=NEW."ma_mat_hang" INTO v; IF v IS NULL OR v NOT IN ('bien_the','vat_tu','bao_ho') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_25' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_25 AFTER INSERT OR UPDATE ON "kho"."lo_hang" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_25();
CREATE FUNCTION nen_tang.nguon_26() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_mat_hang" IS NOT NULL THEN SELECT "loai_mat_hang" FROM "danh_muc"."mat_hang" WHERE ma_dinh_danh=NEW."ma_mat_hang" INTO v; IF v IS NULL OR v NOT IN ('bien_the','vat_tu','bao_ho') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_26' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_26 AFTER INSERT OR UPDATE ON "kho"."yeu_cau_hang_va_vat_tu" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_26();
CREATE FUNCTION nen_tang.nguon_27() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_su_kien_goc" IS NOT NULL THEN SELECT "loai" FROM "kho"."su_kien_giu_khoa_va_dang_ve" WHERE ma_dinh_danh=NEW."ma_su_kien_goc" INTO v; IF v IS NULL OR v NOT IN ('giu_ton','khoa_chat_luong') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_27' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_27 AFTER INSERT OR UPDATE ON "kho"."su_kien_giu_khoa_va_dang_ve" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_27();
CREATE FUNCTION nen_tang.nguon_28() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_mat_hang_dau_ra" IS NOT NULL THEN SELECT "loai_mat_hang" FROM "danh_muc"."mat_hang" WHERE ma_dinh_danh=NEW."ma_mat_hang_dau_ra" INTO v; IF v IS NULL OR v NOT IN ('bien_the','vat_tu','bao_ho') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_28' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_28 AFTER INSERT OR UPDATE ON "san_xuat"."phien_ban_dinh_muc_san_xuat" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_28();
CREATE FUNCTION nen_tang.nguon_29() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_mat_hang" IS NOT NULL THEN SELECT "loai_mat_hang" FROM "danh_muc"."mat_hang" WHERE ma_dinh_danh=NEW."ma_mat_hang" INTO v; IF v IS NULL OR v NOT IN ('bien_the','vat_tu','bao_ho') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_29' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_29 AFTER INSERT OR UPDATE ON "san_xuat"."dong_dinh_muc_vat_tu" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_29();
CREATE FUNCTION nen_tang.nguon_30() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_dong_don_hang_nguon" IS NOT NULL THEN SELECT "giai_doan_dong" FROM "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" WHERE ma_dinh_danh=NEW."ma_dong_don_hang_nguon" INTO v; IF v IS NULL OR v NOT IN ('bao_gia','don_hang') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_30' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_30 AFTER INSERT OR UPDATE ON "san_xuat"."lenh_san_xuat" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_30();
CREATE FUNCTION nen_tang.nguon_31() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_ho_so_xu_ly_nguon" IS NOT NULL THEN SELECT "loai_ho_so_xu_ly" FROM "kinh_doanh"."ho_so_xu_ly" WHERE ma_dinh_danh=NEW."ma_ho_so_xu_ly_nguon" INTO v; IF v IS NULL OR v NOT IN ('thuong_mai') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_31' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_31 AFTER INSERT OR UPDATE ON "san_xuat"."lenh_san_xuat" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_31();
CREATE FUNCTION nen_tang.nguon_32() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_dong_don_hang" IS NOT NULL THEN SELECT "giai_doan_dong" FROM "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" WHERE ma_dinh_danh=NEW."ma_dong_don_hang" INTO v; IF v IS NULL OR v NOT IN ('bao_gia','don_hang') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_32' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_32 AFTER INSERT OR UPDATE ON "giao_hang"."dong_giao_va_nhan_hang" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_32();
CREATE FUNCTION nen_tang.nguon_33() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_nghia_vu_thanh_toan" IS NOT NULL THEN SELECT "loai_ban_ghi_nghia_vu" FROM "tai_chinh"."nghia_vu_va_dieu_chinh" WHERE ma_dinh_danh=NEW."ma_nghia_vu_thanh_toan" INTO v; IF v IS NULL OR v NOT IN ('xac_lap') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_33' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_33 AFTER INSERT OR UPDATE ON "tai_chinh"."de_nghi_chi_tien" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_33();
CREATE FUNCTION nen_tang.nguon_34() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_su_kien_dieu_chinh_goc" IS NOT NULL THEN SELECT "loai_ban_ghi_nghia_vu" FROM "tai_chinh"."nghia_vu_va_dieu_chinh" WHERE ma_dinh_danh=NEW."ma_su_kien_dieu_chinh_goc" INTO v; IF v IS NULL OR v NOT IN ('dieu_chinh_tien','doi_han') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_34' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_34 AFTER INSERT OR UPDATE ON "tai_chinh"."nghia_vu_va_dieu_chinh" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_34();
CREATE FUNCTION nen_tang.nguon_35() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_ho_so_xu_ly_thuong_mai" IS NOT NULL THEN SELECT "loai_ho_so_xu_ly" FROM "kinh_doanh"."ho_so_xu_ly" WHERE ma_dinh_danh=NEW."ma_ho_so_xu_ly_thuong_mai" INTO v; IF v IS NULL OR v NOT IN ('thuong_mai') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_35' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_35 AFTER INSERT OR UPDATE ON "dung_chung"."chung_tu" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_35();
CREATE FUNCTION nen_tang.nguon_36() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_dong_don_hang" IS NOT NULL THEN SELECT "giai_doan_dong" FROM "kinh_doanh"."dong_tu_van_bao_gia_va_don_hang" WHERE ma_dinh_danh=NEW."ma_dong_don_hang" INTO v; IF v IS NULL OR v NOT IN ('bao_gia','don_hang') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_36' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_36 AFTER INSERT OR UPDATE ON "tai_chinh"."dong_ghi_nhan_ban" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_36();
CREATE FUNCTION nen_tang.nguon_37() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_mat_hang" IS NOT NULL THEN SELECT "loai_mat_hang" FROM "danh_muc"."mat_hang" WHERE ma_dinh_danh=NEW."ma_mat_hang" INTO v; IF v IS NULL OR v NOT IN ('bien_the','vat_tu','bao_ho') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_37' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_37 AFTER INSERT OR UPDATE ON "tai_chinh"."bien_dong_gia_tri" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_37();
CREATE FUNCTION nen_tang.nguon_38() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_chung_tu_ban_chot_gia_thanh" IS NOT NULL THEN SELECT "loai" FROM "dung_chung"."chung_tu" WHERE ma_dinh_danh=NEW."ma_chung_tu_ban_chot_gia_thanh" INTO v; IF v IS NULL OR v NOT IN ('chot_gia_thanh') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_38' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_38 AFTER INSERT OR UPDATE ON "tai_chinh"."bien_dong_gia_tri" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_38();
CREATE FUNCTION nen_tang.nguon_39() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_lich_bi_thay" IS NOT NULL THEN SELECT "doi_tuong_lich" FROM "san_xuat"."lich_nguoi_va_nguon_luc" WHERE ma_dinh_danh=NEW."ma_lich_bi_thay" INTO v; IF v IS NULL OR v NOT IN ('nguon_luc','nhan_vien') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_39' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_39 AFTER INSERT OR UPDATE ON "san_xuat"."lich_nguoi_va_nguon_luc" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_39();
CREATE FUNCTION nen_tang.nguon_40() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_ban_chung_tu_bi_thay" IS NOT NULL THEN SELECT "loai" FROM "dung_chung"."chung_tu" WHERE ma_dinh_danh=NEW."ma_ban_chung_tu_bi_thay" INTO v; IF v IS NULL OR v NOT IN ('cong') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_40' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_40 AFTER INSERT OR UPDATE ON "dung_chung"."chung_tu" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_40();
CREATE FUNCTION nen_tang.nguon_41() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_ban_ky_bi_thay" IS NOT NULL THEN SELECT "loai_ky" FROM "dung_chung"."ky_nghiep_vu" WHERE ma_dinh_danh=NEW."ma_ban_ky_bi_thay" INTO v; IF v IS NULL OR v NOT IN ('thu_nhap') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_41' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_41 AFTER INSERT OR UPDATE ON "dung_chung"."ky_nghiep_vu" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_41();
CREATE FUNCTION nen_tang.nguon_42() RETURNS trigger LANGUAGE plpgsql AS $$ DECLARE v text; BEGIN
 IF NEW."ma_phien_ban_chung_tu" IS NOT NULL THEN SELECT "loai" FROM "dung_chung"."chung_tu" WHERE ma_dinh_danh=NEW."ma_phien_ban_chung_tu" INTO v; IF v IS NULL OR v NOT IN ('nhu_cau_khach','bao_gia','don_hang','mau_khach','thay_doi_thuong_mai','don_mua','van_dong_hang','ton_dau','kiem_ke','dinh_muc','lenh_san_xuat','cong_doan','kiem_chat_luong','xu_ly_chat_luong','giao_hang','ghi_ban','giam_ban','tang_ban','de_nghi_chi','chot_gia_thanh','ho_so_lam_viec','ky_nang','su_co','ban_giao_dung_cu','phan_cong','cong','nghi','ky_thu_nhap','khach_nhan','doi_chieu_mua','tien_thuc','tien_dau','dieu_chinh_nghia_vu','nguon_chi_phi','phan_bo_chi_phi','su_kien_phep','nhu_cau_vat_tu','quyet_dinh_danh_muc','quyet_dinh_chinh_sach','quyet_dinh_cap_quyen','quyet_dinh_chot_ky','de_nghi_nhan_su','quyet_dinh_chot_lenh') THEN RAISE EXCEPTION 'Nguồn không đúng loại: nguon_42' USING ERRCODE='23514'; END IF; END IF; RETURN NEW; END $$;
 CREATE CONSTRAINT TRIGGER nguon_42 AFTER INSERT OR UPDATE ON "dung_chung"."trao_doi_va_ban_giao" DEFERRABLE INITIALLY IMMEDIATE FOR EACH ROW EXECUTE FUNCTION nen_tang.nguon_42();
CREATE UNIQUE INDEX ten_tai_khoan ON truy_cap.tai_khoan_dang_nhap(lower(ten_dang_nhap));
CREATE UNIQUE INDEX ma_nguoi ON truy_cap.dinh_danh_nguoi(ma_dinh_danh_nguoi);
CREATE UNIQUE INDEX ma_phien ON truy_cap.phien_dang_nhap(ban_bam_ma_phien_dang_nhap);
CREATE UNIQUE INDEX khoa_bien_nhan ON truy_cap.bien_nhan_xac_nhan_giao_dich(ma_bo_du_lieu,ma_tai_khoan,khoa_chong_xac_nhan_lap);
CREATE UNIQUE INDEX ma_ban_chung_tu ON dung_chung.chung_tu(ma_bo_du_lieu,ma_nghiep_vu,so_phien_ban_chung_tu);
CREATE UNIQUE INDEX ma_ban_chinh_sach ON dung_chung.phien_ban_chinh_sach(ma_bo_du_lieu,ma_nghiep_vu,so_phien_ban);
CREATE UNIQUE INDEX mot_doanh_nghiep ON dung_chung.doanh_nghiep(ma_bo_du_lieu);
CREATE UNIQUE INDEX ma_bo ON dung_chung.bo_du_lieu_mo_phong(ma_nghiep_vu,phien_ban_bo_mo_phong,che_do);
ALTER TABLE danh_muc.mat_hang ADD CHECK (loai_mat_hang <> 'bien_the' OR (ma_nhom_mau IS NOT NULL AND ma_don_vi_co_so IS NOT NULL));
ALTER TABLE kho.dong_van_dong_hang ADD CHECK (so_luong_do_theo_don_vi_co_so>0 AND so_luong_theo_don_vi_nhap>0 AND he_so_quy_doi_tai_lan_ghi_nhan>0);
ALTER TABLE tai_chinh.bien_dong_tien_thuc ADD CHECK (so_tien>=0);
ALTER TABLE tai_chinh.bien_dong_gia_tri ADD CHECK (so_tien>=0);
ALTER TABLE chat_luong.phieu_kiem_tra_chat_luong ADD CHECK (so_luong_thuc_kiem>=0 AND so_luong_ket_luan_dat>=0 AND so_luong_ket_luan_loi>=0 AND so_luong_cho_ket_luan>=0 AND so_luong_thuc_kiem=so_luong_ket_luan_dat+so_luong_ket_luan_loi+so_luong_cho_ket_luan);
CREATE TABLE nen_tang.phien_ban_cau_truc (ma_phien_ban text PRIMARY KEY,ma_kiem_toan_ven text NOT NULL,thoi_diem_ap_dung timestamptz NOT NULL DEFAULT now());
 CREATE TABLE nen_tang.ban_nhap_bieu_mau (ma_dinh_danh uuid PRIMARY KEY,ma_bo_du_lieu uuid NOT NULL REFERENCES dung_chung.bo_du_lieu_mo_phong(ma_dinh_danh),ma_tai_khoan uuid NOT NULL REFERENCES truy_cap.tai_khoan_dang_nhap(ma_dinh_danh),loai_bieu_mau text NOT NULL,noi_dung_nhap jsonb NOT NULL,so_phien_ban bigint NOT NULL DEFAULT 1,thoi_diem_cap_nhat timestamptz NOT NULL DEFAULT now(), UNIQUE(ma_bo_du_lieu,ma_tai_khoan,ma_dinh_danh));
 CREATE TABLE nen_tang.gioi_han_dang_nhap (khoa_da_bam text PRIMARY KEY,so_lan_sai integer NOT NULL DEFAULT 0,thoi_diem_bat_dau timestamptz NOT NULL DEFAULT now());
