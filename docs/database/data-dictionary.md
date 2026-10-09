# Từ điển cơ sở dữ liệu tinh gọn Nasaki — B29

Thiết kế thay mô hình 91 bảng trước B29; chưa tạo DB/lập trình. Tên tiếng Việt không dấu, nhãn/mô tả có dấu. [Thiết kế](../database-design.md), [rà cả 91 bảng](optimization-review.md), [mọi trường](fields.csv), [nhập liệu](input-responsibility.md), [loại nguồn](source-contracts.csv), [thuộc tính đóng](structured-fields.md).

Nhóm/bảng chỉ là nơi lưu; người dùng thao tác theo công việc. Chứng từ và dòng chung do hệ thống tạo, đầu nghiệp vụ dùng khóa chung, không nhập lại mã/người lập/phiên bản. Thông tin kỹ thuật không thay dữ kiện, quyết định hoặc kết luận thực. Quyền, kết quả từng tiêu chí QC và từng khoản thu nhập vẫn có bảng con để kiểm liên kết và đối chiếu; người dùng làm trong cùng biểu mẫu, không nhập đầu phiếu lần hai. Không dùng JSON để che giảm số bảng. Quyền và kiểu nguồn được kiểm kể cả khi bảng đã gộp.

### T001 Doanh nghiệp

**Tên bảng:** `dung_chung.doanh_nghiep`. **Phụ trách:** Dùng chung.

**Mục đích:** Một đơn vị doanh nghiệp..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của doanh nghiệp, phục vụ một đơn vị doanh nghiệp; được ghi bởi dùng chung theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ten` | Tên | Văn bản | Tên của doanh nghiệp, phục vụ một đơn vị doanh nghiệp; được ghi bởi dùng chung theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `mui_gio` | Múi giờ | Văn bản | Múi giờ của doanh nghiệp, phục vụ một đơn vị doanh nghiệp; được ghi bởi dùng chung theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `tien_te` | Tiền tệ | Phân loại có danh sách đóng | Tiền tệ của doanh nghiệp, phục vụ một đơn vị doanh nghiệp; được ghi bởi dùng chung theo hồ sơ nguồn của bảng. Giá trị cho phép: VND. Giá trị: VND. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `che_do` | Chế độ | Phân loại có danh sách đóng | Chế độ của doanh nghiệp, phục vụ một đơn vị doanh nghiệp; được ghi bởi dùng chung theo hồ sơ nguồn của bảng. Giá trị cho phép: mo_phong. Giá trị: mo_phong. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Một công ty trong mỗi bộ mô phỏng; không suy ra đa pháp nhân.

**Yêu cầu:** FR01, FR33.

### T002 Bộ phận

**Tên bảng:** `dung_chung.bo_phan`. **Phụ trách:** Nhân sự.

**Mục đích:** Nhóm công việc của 50 người..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của bộ phận, phục vụ nhóm công việc của 50 người; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ten` | Tên | Văn bản | Tên của bộ phận, phục vụ nhóm công việc của 50 người; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dang_su_dung` | Đang sử dụng | Có/không | Đang sử dụng của bộ phận, phục vụ nhóm công việc của 50 người; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_doanh_nghiep` | Mã doanh nghiệp | Mã UUID | Mã doanh nghiệp liên kết dung_chung.doanh_nghiep đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doanh_nghiep |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Mã duy nhất trong công ty; nhóm hành chính không đồng nghĩa bốn nhân sự chuyên trách.

**Yêu cầu:** FR01, FR28.

### T003 Vị trí giữ hàng

**Tên bảng:** `dung_chung.vi_tri_giu_hang`. **Phụ trách:** Kho / sản xuất / giao hàng.

**Mục đích:** Nơi chịu trách nhiệm giữ hàng..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của vị trí giữ hàng, phục vụ nơi chịu trách nhiệm giữ hàng; được ghi bởi kho / sản xuất / giao hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của vị trí giữ hàng, phục vụ nơi chịu trách nhiệm giữ hàng; được ghi bởi kho / sản xuất / giao hàng theo hồ sơ nguồn của bảng. Giá trị cho phép: vung_trong_kho; xuong; dang_giao; ben_ngoai. Giá trị: vung_trong_kho; xuong; dang_giao; ben_ngoai. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_kho_vat_ly` | Mã kho vật lý | Văn bản | Mã kho vật lý của vị trí giữ hàng, phục vụ nơi chịu trách nhiệm giữ hàng; được ghi bởi kho / sản xuất / giao hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dang_su_dung` | Đang sử dụng | Có/không | Đang sử dụng của vị trí giữ hàng, phục vụ nơi chịu trách nhiệm giữ hàng; được ghi bởi kho / sản xuất / giao hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_doanh_nghiep` | Mã doanh nghiệp | Mã UUID | Mã doanh nghiệp liên kết dung_chung.doanh_nghiep đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doanh_nghiep |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** VT/TP/CC/HL cùng KHO-01. Xưởng/đang giao không cộng vào tồn kho; không dùng vị trí làm kết luận kiểm chất lượng.

**Yêu cầu:** FR01, FR15, FR16, FR21.

### T004 Đơn vị tính

**Tên bảng:** `dung_chung.don_vi_tinh`. **Phụ trách:** Dùng chung.

**Mục đích:** Đơn vị và độ chính xác..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của đơn vị tính, phục vụ đơn vị và độ chính xác; được ghi bởi dùng chung theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dai_luong` | Đại lượng | Phân loại có danh sách đóng | Đại lượng của đơn vị tính, phục vụ đơn vị và độ chính xác; được ghi bởi dùng chung theo hồ sơ nguồn của bảng. Giá trị cho phép: vien; hang_loat; the_tich; thoi_gian. Giá trị: vien; hang_loat; the_tich; thoi_gian. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_chu_so_thap_phan_duoc_phep` | Số chữ số thập phân được phép | Số nguyên nhỏ | Số chữ số thập phân được phép của đơn vị tính, phục vụ đơn vị và độ chính xác; được ghi bởi dùng chung theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Viên=0 số lẻ; kg/lít=3; phút công số nguyên. Đơn vị đóng gói quy đổi theo mặt hàng.

**Yêu cầu:** FR01, FR16, FR29.

### T005 Chứng từ

**Tên bảng:** `dung_chung.chung_tu`. **Phụ trách:** Bộ phận giữ chứng từ; Kho / người xác nhận thực theo nguồn; Kho, người đếm/đối chiếu khác nhau; Kế toán; Tài chính cùng sản xuất đối chiếu; Tổ trưởng ghi / quản lý xác nhận / nhân sự chốt.

**Mục đích:** Lưu theo loại và bản: Định danh một phiên bản chứng từ.; Phiếu và sự kiện thực vào/ra/chuyển.; Mốc và phạm vi kiểm kê.; Ghi nhận bán hoặc điều chỉnh thương mại.; Bản giá thành lô được chốt hoặc tạm tính.; Một bản công người/ngày/ca..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của chứng từ, phục vụ định danh một phiên bản chứng từ; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của chứng từ, phục vụ định danh một phiên bản chứng từ; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng. Giá trị cho phép: nhu_cau_khach; bao_gia; don_hang; mau_khach; thay_doi_thuong_mai; don_mua; van_dong_hang; ton_dau; kiem_ke; dinh_muc; lenh_san_xuat; cong_doan; kiem_chat_luong; xu_ly_chat_luong; giao_hang; ghi_ban; giam_ban; tang_ban; de_nghi_chi; chot_gia_thanh; ho_so_lam_viec; ky_nang; su_co; ban_giao_dung_cu; phan_cong; cong; nghi; ky_thu_nhap; khach_nhan; doi_chieu_mua; tien_thuc; tien_dau; dieu_chinh_nghia_vu; nguon_chi_phi; phan_bo_chi_phi; su_kien_phep; nhu_cau_vat_tu; quyet_dinh_danh_muc; quyet_dinh_chinh_sach; quyet_dinh_cap_quyen; quyet_dinh_chot_ky; de_nghi_nhan_su; quyet_dinh_chot_lenh. Giá trị: nhu_cau_khach; bao_gia; don_hang; mau_khach; thay_doi_thuong_mai; don_mua; van_dong_hang; ton_dau; kiem_ke; dinh_muc; lenh_san_xuat; cong_doan; kiem_chat_luong; xu_ly_chat_luong; giao_hang; ghi_ban; giam_ban; tang_ban; de_nghi_chi; chot_gia_thanh; ho_so_lam_viec; ky_nang; su_co; ban_giao_dung_cu; phan_cong; cong; nghi; ky_thu_nhap; khach_nhan; doi_chieu_mua; tien_thuc; tien_dau; dieu_chinh_nghia_vu; nguon_chi_phi; phan_bo_chi_phi; su_kien_phep; nhu_cau_vat_tu; quyet_dinh_danh_muc; quyet_dinh_chinh_sach; quyet_dinh_cap_quyen; quyet_dinh_chot_ky; de_nghi_nhan_su; quyet_dinh_chot_lenh. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_phien_ban_chung_tu` | Số phiên bản chứng từ | Số nguyên | Số phiên bản chứng từ của chứng từ, phục vụ định danh một phiên bản chứng từ; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_phe_duyet` | Trạng thái phê duyệt | Phân loại có danh sách đóng | Trạng thái phê duyệt của chứng từ, phục vụ định danh một phiên bản chứng từ; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng. Giá trị cho phép: nhap; da_trinh; da_tu_choi; da_duyet; da_rut; da_bi_thay_ban. Giá trị: nhap; da_trinh; da_tu_choi; da_duyet; da_rut; da_bi_thay_ban; khong_yeu_cau. Loại không cần phê duyệt theo B24 dùng khong_yeu_cau; vẫn phải xác nhận thực đúng quyền, không tạo quyết định giả. | Sự kiện hoặc quyết định được ghi nhận | — |
| `thoi_diem_co_hieu_luc` | Thời điểm có hiệu lực | Thời điểm có múi giờ | Thời điểm người có thẩm quyền quy định nội dung bắt đầu áp dụng, tách với thời điểm hệ thống ghi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |
| `ly_do` | Lý do | Văn bản | Lý do của chứng từ, phục vụ định danh một phiên bản chứng từ; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_goc` | Mã chứng từ gốc | Mã UUID | Mã chứng từ gốc liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_nhan_vien_phu_trach` | Mã nhân viên phụ trách | Mã UUID | Mã nhân viên phụ trách liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_tai_khoan_lap_chung_tu` | Mã tài khoản lập chứng từ | Mã UUID | Mã tài khoản lập chứng từ liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | truy_cap.tai_khoan_dang_nhap |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `loai_van_dong_kho` | Loại | Phân loại có danh sách đóng | Loại của phiếu vận động hàng, phục vụ phiếu và sự kiện thực vào/ra/chuyển; được ghi bởi kho / người xác nhận thực theo nguồn theo hồ sơ nguồn của bảng. Giá trị cho phép: dau_ky; nhan_hang; chuyen_noi_bo; chia_phan_chat_luong; cap_phat; tra_hang; thuc_dung; xuat_giao; tieu_huy; dieu_chinh_kiem_ke. Giá trị: dau_ky; nhan_hang; chuyen_noi_bo; chia_phan_chat_luong; cap_phat; tra_hang; thuc_dung; xuat_giao; tieu_huy; dieu_chinh_kiem_ke. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_ghi_so` | Trạng thái xác nhận thực hiện | Phân loại có danh sách đóng | Trạng thái xác nhận thực hiện của phiếu vận động hàng, phục vụ phiếu và sự kiện thực vào/ra/chuyển; được ghi bởi kho / người xác nhận thực theo nguồn theo hồ sơ nguồn của bảng. Giá trị cho phép: nhap; da_ghi_so. Giá trị: nhap; da_ghi_so. | Sự kiện hoặc quyết định được ghi nhận | — |
| `thoi_diem_thuc_hien_nghiep_vu` | Thời điểm thực hiện nghiệp vụ | Thời điểm có múi giờ | Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thu_tu_ghi_so` | Thứ tự ghi sổ | Số nguyên | Thứ tự ghi sổ của phiếu vận động hàng, phục vụ phiếu và sự kiện thực vào/ra/chuyển; được ghi bởi kho / người xác nhận thực theo nguồn theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `ma_bien_nhan_xac_nhan_giao_dich` | Mã biên nhận xác nhận giao dịch | Mã UUID | Mã biên nhận xác nhận giao dịch liên kết truy_cap.bien_nhan_xac_nhan_giao_dich đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | truy_cap.bien_nhan_xac_nhan_giao_dich |
| `thoi_diem_moc_doi_chieu` | Thời điểm mốc đối chiếu | Thời điểm có múi giờ | Thời điểm mốc đối chiếu của biên bản kiểm kê, phục vụ mốc và phạm vi kiểm kê; được ghi bởi kho, người đếm/đối chiếu khác nhau theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `pham_vi` | Phạm vi | Văn bản | Phạm vi của biên bản kiểm kê, phục vụ mốc và phạm vi kiểm kê; được ghi bởi kho, người đếm/đối chiếu khác nhau theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: dang_dem; da_ra_soat; da_duyet; da_ghi_so. Giá trị: dang_dem; da_ra_soat; da_duyet; da_ghi_so. | Sự kiện hoặc quyết định được ghi nhận | — |
| `thoi_diem_bat_dau_ngung_giao_dich_kiem_ke` | Thời điểm bắt đầu ngừng giao dịch kiểm kê | Thời điểm có múi giờ | Thời điểm bắt đầu ngừng giao dịch kiểm kê của biên bản kiểm kê, phục vụ mốc và phạm vi kiểm kê; được ghi bởi kho, người đếm/đối chiếu khác nhau theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_ngung_giao_dich_kiem_ke` | Thời điểm kết thúc ngừng giao dịch kiểm kê | Thời điểm có múi giờ | Thời điểm kết thúc ngừng giao dịch kiểm kê của biên bản kiểm kê, phục vụ mốc và phạm vi kiểm kê; được ghi bởi kho, người đếm/đối chiếu khác nhau theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_nhan_vien_dem_thuc` | Mã nhân viên đếm thực | Mã UUID | Mã nhân viên đếm thực liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_nhan_vien_doi_chieu` | Mã nhân viên đối chiếu | Mã UUID | Mã nhân viên đối chiếu liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `pham_vi_mo_phong_thue` | Phạm vi mô phỏng thuế | Phân loại có danh sách đóng | Phạm vi mô phỏng thuế của chứng từ ghi nhận bán, phục vụ ghi nhận bán hoặc điều chỉnh thương mại; được ghi bởi kế toán theo hồ sơ nguồn của bảng. Giá trị cho phép: chua_mo_phong. Giá trị: chua_mo_phong. | Dữ liệu kỹ thuật | — |
| `ma_chung_tu_don_hang` | Mã chứng từ đơn hàng | Mã UUID | Mã chứng từ đơn hàng liên kết kinh_doanh.bao_gia_va_don_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.bao_gia_va_don_hang |
| `ma_ho_so_xu_ly_thuong_mai` | Mã hồ sơ xử lý thương mại | Mã UUID | Mã hồ sơ xử lý thương mại liên kết kinh_doanh.ho_so_xu_ly đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.ho_so_xu_ly |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `tinh_trang_chot_gia_thanh` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: tam_tinh; da_xac_nhan. Giá trị: tam_tinh; da_xac_nhan. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ma_lo_san_xuat` | Mã lô sản xuất | Mã UUID | Mã lô sản xuất liên kết san_xuat.lo_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.lo_san_xuat |
| `ma_phien_ban_chinh_sach_dinh_gia` | Mã phiên bản chính sách định giá | Mã UUID | Mã phiên bản chính sách định giá liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `tinh_trang_xac_nhan_cong` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: nhap; cho_xu_ly; da_xac_nhan; da_chot. Giá trị: nhap; cho_xu_ly; da_xac_nhan; da_chot. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ma_nguon_nhap_du_lieu` | Mã nguồn nhập dữ liệu | Văn bản | Mã nguồn nhập dữ liệu của bản công người ngày ca, phục vụ một bản công người/ngày/ca; được ghi bởi tổ trưởng ghi / quản lý xác nhận / hr chốt theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_nhan_vien` | Mã nhân viên | Mã UUID | Mã nhân viên liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_ngay_va_ca_lam_viec` | Mã ngày và ca làm việc | Mã UUID | Mã ngày và ca làm việc liên kết nhan_su.ngay_va_ca_lam_viec đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.ngay_va_ca_lam_viec |
| `ma_ban_chung_tu_bi_thay` | Mã bản công bị thay | Mã UUID | Mã bản công bị thay liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_nhan_vien_xac_nhan` | Mã nhân viên xác nhận | Mã UUID | Mã nhân viên xác nhận liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_ky` | Mã kỳ | Mã UUID | Mã kỳ liên kết dung_chung.ky_nghiep_vu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.ky_nghiep_vu |

**Ràng buộc:** Đầu chung là nơi sở hữu mã/bản, người lập, thời điểm tạo, nhật ký và chống ghi đồng thời. Các đầu kho/kiểm kê/ghi bán/chốt giá thành/công người-ngày trước đây lưu ngay đây theo loai. Mọi trường riêng chỉ dùng cho đúng loại: kho cần loại vận động/thời điểm/thứ tự/ghi sổ; kiểm kê cần mốc/phạm vi/ngừng giao dịch/người đếm-kiểm; bán cần đơn/phương án/thực hiện; chốt giá thành cần lô/chính sách/quyết định; công cần người/ngày-ca/kỳ/nguồn/xác nhận. Bản đã dùng bất biến, nguồn điều chỉnh nối gốc. Một chứng từ có đúng một loại, các trường không áp dụng phải trống, không tạo đầu nghiệp vụ thứ hai. Điều kiện nguồn Phiếu vận động hàng: đã ghi sổ mới tác động lượng. Phiếu xưởng tổ trưởng xác nhận phạm vi sản xuất; kho không tự sửa công/thực dùng. Không ghi lùi trước mốc/biến động liên quan. Điều kiện nguồn Biên bản kiểm kê: Đóng giao dịch phần đếm hoặc ghi đối chiếu giữa hai mốc; duyệt không tự điều chỉnh. Điều kiện nguồn Chứng từ ghi nhận bán: Sale thường chỉ sau chấp nhận; giảm bán/tăng bán có căn cứ và quyết định; không hóa đơn pháp lý. Điều kiện nguồn Bản chốt giá thành: Bản chốt lưu quyết định và danh sách phân bổ/nguồn đúng phiên bản. Tổng giá thành, lượng đạt và danh sách thiếu được tính khi đọc từ nguồn đã liên kết, không có cột tổng nhập tay. Chưa đủ lượng, lỗi và nguồn thì giữ tạm tính. Điều kiện nguồn Bản công người ngày ca: Duy nhất người/ngày/ca/bản; chỉ một bản hiện hành có hiệu lực. Thiếu nguồn giữ chờ xử lý; sửa sau chốt thêm bản điều chỉnh, không xóa công cũ.

**Yêu cầu:** FR01, FR03, FR04, FR05, FR06, FR08, FR10, FR13, FR15, FR16, FR18, FR20, FR21, FR22, FR26, FR27, FR29, FR30, FR31, FR33.

### T006 Dòng chứng từ

**Tên bảng:** `dung_chung.dong_chung_tu`. **Phụ trách:** Bộ phận giữ chứng từ.

**Mục đích:** Mã dòng chung để liên kết và duyệt đúng phần..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `so_thu_tu_dong` | Số thứ tự dòng | Số nguyên | Số thứ tự dòng của dòng chứng từ, phục vụ mã dòng chung để liên kết và duyệt đúng phần; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của dòng chứng từ, phục vụ mã dòng chung để liên kết và duyệt đúng phần; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng. Giá trị cho phép: dong_bao_gia_don_hang; dong_don_mua; dong_van_dong; dong_kiem_ke; dong_dinh_muc; dong_giao_hang; dong_ghi_ban; xac_nhan_khach_nhan; doi_chieu_mua; nguon_chi_phi; phan_bo_chi_phi; yeu_cau_hang_vat_tu; dong_thu_nhap; dong_tien_thuc; dong_gia_tri. Giá trị: dong_bao_gia_don_hang; dong_don_mua; dong_van_dong; dong_kiem_ke; dong_dinh_muc; dong_giao_hang; dong_ghi_ban; xac_nhan_khach_nhan; doi_chieu_mua; nguon_chi_phi; phan_bo_chi_phi; yeu_cau_hang_vat_tu; dong_thu_nhap; dong_tien_thuc; dong_gia_tri. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Mã phiên bản chứng từ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Duy nhất(chứng từ,so_thu_tu_dong). Mỗi dòng có đúng một phần mở rộng nghiệp vụ phù hợp loai; không lưu tiền/lượng lần hai ở đây.

**Yêu cầu:** FR03, FR04, FR05, FR06, FR08, FR27.

### T007 Liên kết chứng từ

**Tên bảng:** `dung_chung.lien_ket_chung_tu`. **Phụ trách:** Bộ phận giữ chứng từ.

**Mục đích:** Nguồn, thay đổi, đảo hoặc thay thế..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `quan_he` | Quan hệ | Phân loại có danh sách đóng | Quan hệ của liên kết chứng từ, phục vụ nguồn, thay đổi, đảo hoặc thay thế; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng. Giá trị cho phép: nguon_goc; dieu_chinh_ban_goc; dao_nguon_goc; thay_ban_truoc; phu_thuoc. Giá trị: nguon_goc; dieu_chinh_ban_goc; dao_nguon_goc; thay_ban_truoc; phu_thuoc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_nguon_lien_ket` | Mã chứng từ nguồn liên kết | Mã UUID | Mã chứng từ nguồn liên kết liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_chung_tu_dich_lien_ket` | Mã chứng từ đích liên kết | Mã UUID | Mã chứng từ đích liên kết liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |

**Ràng buộc:** Không tự liên kết; duy nhất hai nguồn+loại; kiểm chu trình cho quan hệ thay thế/phụ thuộc. Liên kết không thay FK lượng ở bảng nghiệp vụ.

**Yêu cầu:** FR04, FR06, FR10, FR19, FR27.

### T008 Đề nghị và quyết định phê duyệt

**Tên bảng:** `dung_chung.de_nghi_va_quyet_dinh_phe_duyet`. **Phụ trách:** Theo bảng thẩm quyền B24.

**Mục đích:** Đề nghị, kiểm và quyết định đúng phiên bản..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `hanh_dong` | Hành động | Phân loại có danh sách đóng | Hành động của đề nghị và quyết định phê duyệt, phục vụ đề nghị, kiểm và quyết định đúng phiên bản; được ghi bởi theo bảng thẩm quyền b24 theo hồ sơ nguồn của bảng. Giá trị cho phép: xem; tao; kiem_tra; phe_duyet; xac_nhan; nhan; xuat_du_lieu; huy; dieu_chinh; khoi_phuc; chot_ky; mo_lai_ky; danh_gia_dap_ung; quyet_dinh_uu_tien; chot_lenh. Giá trị: xem; tao; kiem_tra; phe_duyet; xac_nhan; nhan; xuat_du_lieu; huy; dieu_chinh; khoi_phuc; chot_ky; mo_lai_ky; danh_gia_dap_ung; quyet_dinh_uu_tien; chot_lenh. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: da_de_nghi; da_kiem_tra; da_duyet; da_tu_choi; da_thu_hoi_quyen. Giá trị: da_de_nghi; da_kiem_tra; da_duyet; da_tu_choi; da_thu_hoi_quyen. | Sự kiện hoặc quyết định được ghi nhận | — |
| `thoi_diem_de_nghi` | Thời điểm đề nghị | Thời điểm có múi giờ | Thời điểm đề nghị của đề nghị và quyết định phê duyệt, phục vụ đề nghị, kiểm và quyết định đúng phiên bản; được ghi bởi theo bảng thẩm quyền b24 theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_quyet_dinh` | Thời điểm quyết định | Thời điểm có múi giờ | Thời điểm quyết định của đề nghị và quyết định phê duyệt, phục vụ đề nghị, kiểm và quyết định đúng phiên bản; được ghi bởi theo bảng thẩm quyền b24 theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `gioi_han_so_luong_duoc_duyet` | Giới hạn số lượng được duyệt | Số lượng chính xác | Giới hạn số lượng được duyệt của đề nghị và quyết định phê duyệt, phục vụ đề nghị, kiểm và quyết định đúng phiên bản; được ghi bởi theo bảng thẩm quyền b24 theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `gioi_han_so_tien_duoc_duyet` | Giới hạn số tiền được duyệt | Số tiền VND nguyên đồng | Giới hạn số tiền được duyệt của đề nghị và quyết định phê duyệt, phục vụ đề nghị, kiểm và quyết định đúng phiên bản; được ghi bởi theo bảng thẩm quyền b24 theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ly_do` | Lý do | Văn bản | Lý do của đề nghị và quyết định phê duyệt, phục vụ đề nghị, kiểm và quyết định đúng phiên bản; được ghi bởi theo bảng thẩm quyền b24 theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Mã phiên bản chứng từ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_dong_chung_tu` | Mã dòng chứng từ | Mã UUID | Mã dòng chứng từ liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.dong_chung_tu |
| `ma_nhan_vien_de_nghi` | Mã nhân viên đề nghị | Mã UUID | Mã nhân viên đề nghị liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_nhan_vien_kiem_tra` | Mã nhân viên kiểm tra | Mã UUID | Mã nhân viên kiểm tra liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_nhan_vien_quyet_dinh` | Mã nhân viên quyết định | Mã UUID | Mã nhân viên quyết định liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_uy_quyen` | Mã ủy quyền | Mã UUID | Mã ủy quyền liên kết truy_cap.uy_quyen đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | truy_cap.uy_quyen |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** ma_dong_chung_tu có thể trống để duyệt cả nguồn; các người kiểm/duyệt có thể trống khi còn chờ. Dòng phải thuộc đúng chứng từ. So người thật, không chỉ tài khoản. Duyệt tự hưởng hoặc ngoài ủy quyền bị ngăn.

**Yêu cầu:** FR03, FR06, FR08, FR10, FR18, FR24, FR30, FR31.

### T009 Trao đổi và bàn giao

**Tên bảng:** `dung_chung.trao_doi_va_ban_giao`. **Phụ trách:** Người giao và người nhận; Kinh doanh; Nhân sự / kho.

**Mục đích:** Lưu theo loại và bản: Bàn giao từng phần, việc chờ và phản hồi.; Các kênh và lần tiếp nhận.; Cấp/trả đồ bảo hộ và dụng cụ..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: da_gui; da_chap_nhan; can_bo_sung; da_huy. Giá trị: da_gui; da_chap_nhan; can_bo_sung; da_huy. | Sự kiện hoặc quyết định được ghi nhận | — |
| `so_luong_de_nghi` | Số lượng đề nghị | Số lượng chính xác | Số lượng đề nghị của bàn giao công việc, phục vụ bàn giao từng phần, việc chờ và phản hồi; được ghi bởi người giao và người nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_duoc_chap_nhan` | Số lượng được chấp nhận | Số lượng chính xác | Số lượng được chấp nhận của bàn giao công việc, phục vụ bàn giao từng phần, việc chờ và phản hồi; được ghi bởi người giao và người nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_can_hoan_thanh` | Thời điểm cần hoàn thành | Thời điểm có múi giờ | Thời điểm cần hoàn thành của bàn giao công việc, phục vụ bàn giao từng phần, việc chờ và phản hồi; được ghi bởi người giao và người nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_nhan` | Thời điểm nhận | Thời điểm có múi giờ | Thời điểm nhận của bàn giao công việc, phục vụ bàn giao từng phần, việc chờ và phản hồi; được ghi bởi người giao và người nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ly_do_con_thieu` | Lý do còn thiếu | Văn bản | Lý do còn thiếu của bàn giao công việc, phục vụ bàn giao từng phần, việc chờ và phản hồi; được ghi bởi người giao và người nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Mã phiên bản chứng từ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_dong_chung_tu` | Mã dòng chứng từ | Mã UUID | Mã dòng chứng từ liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.dong_chung_tu |
| `ma_nhan_vien_ban_giao` | Mã nhân viên bàn giao | Mã UUID | Mã nhân viên bàn giao liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_nhan_vien_nhan_ban_giao` | Mã nhân viên nhận bàn giao | Mã UUID | Mã nhân viên nhận bàn giao liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_don_vi` | Mã đơn vị | Mã UUID | Mã đơn vị liên kết dung_chung.don_vi_tinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.don_vi_tinh |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |
| `kenh_tiep_nhan` | Kênh tiếp nhận | Phân loại có danh sách đóng | Kênh tiếp nhận của lần tiếp nhận nhu cầu, phục vụ các kênh và lần tiếp nhận; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. Giá trị cho phép: dien_thoai; thu_dien_tu; trang_mang; lien_he_ca_nhan; gioi_thieu. Giá trị: dien_thoai; thu_dien_tu; trang_mang; lien_he_ca_nhan; gioi_thieu. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `noi_dung_tiep_nhan` | Nội dung tiếp nhận | Văn bản | Nội dung tiếp nhận của lần tiếp nhận nhu cầu, phục vụ các kênh và lần tiếp nhận; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_doi_chieu_ben_ngoai` | Mã đối chiếu bên ngoài | Văn bản | Mã đối chiếu bên ngoài của lần tiếp nhận nhu cầu, phục vụ các kênh và lần tiếp nhận; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_tai_khoan_nhap_du_lieu` | Mã tài khoản nhập dữ liệu | Mã UUID | Mã tài khoản nhập dữ liệu liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | truy_cap.tai_khoan_dang_nhap |
| `loai_ban_giao_dung_cu` | Loại | Phân loại có danh sách đóng | Loại của bàn giao bảo hộ dụng cụ, phục vụ cấp/trả đồ bảo hộ và dụng cụ; được ghi bởi nhân sự / kho theo hồ sơ nguồn của bảng. Giá trị cho phép: cap_phat; tra_hang; thay_the. Giá trị: cap_phat; tra_hang; thay_the. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_thuc_hien_nghiep_vu` | Thời điểm thực hiện nghiệp vụ | Thời điểm có múi giờ | Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `can_cu_tiep_nhan` | Căn cứ tiếp nhận | Văn bản | Căn cứ tiếp nhận của bàn giao bảo hộ dụng cụ, phục vụ cấp/trả đồ bảo hộ và dụng cụ; được ghi bởi nhân sự / kho theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_nhan_vien` | Mã nhân viên | Mã UUID | Mã nhân viên liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_dong_van_dong_hang` | Mã dòng vận động hàng | Mã UUID | Mã dòng vận động hàng liên kết kho.dong_van_dong_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.dong_van_dong_hang |
| `ma_ban_giao_goc` | Mã bàn giao dụng cụ gốc | Mã UUID | Mã bàn giao dụng cụ gốc liên kết dung_chung.trao_doi_va_ban_giao đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.trao_doi_va_ban_giao |
| `loai_trao_doi` | Loại trao đổi hoặc bàn giao | Phân loại có danh sách đóng | Phân biệt nội dung tiếp nhận khách, giao việc và bàn giao dụng cụ; quyền/điều kiện từng loại được kiểm riêng. Giá trị: tiep_nhan_khach; ban_giao_cong_viec; ban_giao_dung_cu. | Thông tin nghiệp vụ có căn cứ | — |

**Ràng buộc:** Một dòng có đúng loại tiếp nhận khách/giao việc/bàn giao dụng cụ. Tiếp nhận cần nội dung/kênh/mốc, không đòi bên nhận việc; giao việc cần bên nhận/phạm vi/hạn và xác nhận nhận; dụng cụ cần nhân viên/căn cứ/phiếu kho thực khi có hàng kho, không xuất lần hai. Quyền theo loại, không dùng ghi chú làm quyết định hoặc số liệu kho. Điều kiện nguồn Lần tiếp nhận nhu cầu: Nhiều kênh thuộc cùng inquiry, không tạo nhiều đơn tự động. Điều kiện nguồn Bàn giao bảo hộ dụng cụ: Hàng có kho liên kết phiếu thực đúng một lần; bàn giao không xuất thêm. Không phải hệ tài sản/khấu hao.

**Yêu cầu:** FR04, FR07, FR10, FR16, FR28, FR32.

### T010 Chứng cứ đính kèm

**Tên bảng:** `dung_chung.chung_cu_dinh_kem`. **Phụ trách:** Bộ phận của nguồn.

**Mục đích:** Chỉ mục chứng cứ trong kho tệp..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `khoa_tep_trong_noi_luu` | Khóa tệp trong nơi lưu | Văn bản | Khóa tệp trong nơi lưu của chứng cứ đính kèm, phục vụ chỉ mục chứng cứ trong kho tệp; được ghi bởi bộ phận của nguồn theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `ma_kiem_toan_ven` | Mã kiểm toàn vẹn | Văn bản | Mã kiểm toàn vẹn của chứng cứ đính kèm, phục vụ chỉ mục chứng cứ trong kho tệp; được ghi bởi bộ phận của nguồn theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `loai_dinh_dang_tep` | Loại định dạng tệp | Văn bản | Loại định dạng tệp của chứng cứ đính kèm, phục vụ chỉ mục chứng cứ trong kho tệp; được ghi bởi bộ phận của nguồn theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `dung_luong_tep_tinh_theo_byte` | Dung lượng tệp tính theo byte | Số nguyên | Dung lượng tệp tính theo byte của chứng cứ đính kèm, phục vụ chỉ mục chứng cứ trong kho tệp; được ghi bởi bộ phận của nguồn theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `muc_nhay_cam` | Mức nhạy cảm | Phân loại có danh sách đóng | Mức nhạy cảm của chứng cứ đính kèm, phục vụ chỉ mục chứng cứ trong kho tệp; được ghi bởi bộ phận của nguồn theo hồ sơ nguồn của bảng. Giá trị cho phép: duoc_xem_trong_mo_phong; noi_bo; thu_nhap. Giá trị: duoc_xem_trong_mo_phong; noi_bo; thu_nhap. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `gia_lap` | Giả lập | Có/không | Giả lập của chứng cứ đính kèm, phục vụ chỉ mục chứng cứ trong kho tệp; được ghi bởi bộ phận của nguồn theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Mã phiên bản chứng từ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_dong_chung_tu` | Mã dòng chứng từ | Mã UUID | Mã dòng chứng từ liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.dong_chung_tu |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Tệp ngoài DB/Git; đường dẫn không công khai; kiểm quyền theo nguồn. Không chứa chữ ký giả như thật.

**Yêu cầu:** FR08, FR09, FR17, FR21, FR28, FR31.

### T011 Nhật ký thao tác

**Tên bảng:** `dung_chung.nhat_ky_thao_tac`. **Phụ trách:** Hệ thống, giới hạn theo nguồn.

**Mục đích:** Dấu vết thao tác và thay đổi..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `hanh_dong` | Hành động | Văn bản | Hành động của nhật ký thao tác, phục vụ dấu vết thao tác và thay đổi; được ghi bởi hệ thống, giới hạn theo nguồn theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |
| `khoa_lien_ket_thao_tac` | Khóa liên kết thao tác | Mã UUID | Khóa liên kết thao tác của nhật ký thao tác, phục vụ dấu vết thao tác và thay đổi; được ghi bởi hệ thống, giới hạn theo nguồn theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `noi_dung_thay_doi_da_luoc_du_lieu_nhay_cam` | Nội dung thay đổi đã lược dữ liệu nhạy cảm | Nội dung có cấu trúc đóng | Nội dung thay đổi đã lược dữ liệu nhạy cảm của nhật ký thao tác, phục vụ dấu vết thao tác và thay đổi; được ghi bởi hệ thống, giới hạn theo nguồn theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ly_do` | Lý do | Văn bản | Lý do của nhật ký thao tác, phục vụ dấu vết thao tác và thay đổi; được ghi bởi hệ thống, giới hạn theo nguồn theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Mã phiên bản chứng từ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `ma_nhan_vien_duoc_ghi_nhan_thay` | Mã nhân viên được ghi nhận thay | Mã UUID | Mã nhân viên được ghi nhận thay liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |

**Ràng buộc:** Chỉ thêm; người nhập và người được nhập thay riêng; log chung không chứa lương/mật khẩu. Không thay sổ lượng/tiền.

**Yêu cầu:** FR02, FR03, FR05, FR06, FR28, FR33.

### T012 Kỳ nghiệp vụ

**Tên bảng:** `dung_chung.ky_nghiep_vu`. **Phụ trách:** Nhân sự / tài chính / kho theo loại kỳ; Nhân sự lập / tài chính kiểm.

**Mục đích:** Lưu theo loại và bản: Chốt và mở lại kỳ.; Kỳ và phiên bản bảng thu nhập..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai_ky` | Loại kỳ | Phân loại có danh sách đóng | Kỳ kho/công/thu nhập/tài chính độc lập; bản tính thu nhập là loại kỳ thu nhập có nguồn công/chính sách cố định. Giá trị: kho; cong; thu_nhap; tai_chinh. | Thông tin nghiệp vụ có căn cứ | — |
| `ngay_bat_dau` | Ngày bắt đầu | Ngày địa phương | Ngày bắt đầu của kỳ nghiệp vụ, phục vụ chốt và mở lại kỳ; được ghi bởi nhân sự / tài chính / kho theo loại kỳ theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_ket_thuc` | Ngày kết thúc | Ngày địa phương | Ngày kết thúc của kỳ nghiệp vụ, phục vụ chốt và mở lại kỳ; được ghi bởi nhân sự / tài chính / kho theo loại kỳ theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: dang_mo; da_chot. Giá trị: dang_mo; da_chot. | Sự kiện hoặc quyết định được ghi nhận | — |
| `thoi_diem_chot` | Thời điểm chốt | Thời điểm có múi giờ | Thời điểm chốt của kỳ nghiệp vụ, phục vụ chốt và mở lại kỳ; được ghi bởi nhân sự / tài chính / kho theo loại kỳ theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_quyet_dinh_chot_ky` | Mã chứng từ quyết định chốt kỳ | Mã UUID | Mã chứng từ quyết định chốt kỳ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |
| `so_phien_ban_chung_tu` | Số phiên bản chứng từ | Số nguyên | Số phiên bản chứng từ của kỳ tính thu nhập, phục vụ kỳ và phiên bản bảng thu nhập; được ghi bởi nhân sự lập / tài chính kiểm theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `gioi_han_mo_phong` | Giới hạn mô phỏng | Phân loại có danh sách đóng | Giới hạn mô phỏng của kỳ tính thu nhập, phục vụ kỳ và phiên bản bảng thu nhập; được ghi bởi nhân sự lập / tài chính kiểm theo hồ sơ nguồn của bảng. Giá trị cho phép: chua_mo_phong_khoan_bat_buoc. Giá trị: chua_mo_phong_khoan_bat_buoc. | Dữ liệu kỹ thuật | — |
| `ma_chung_tu_ky_thu_nhap` | Mã phiên bản chứng từ | Mã UUID | Mã phiên bản chứng từ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_ky_goc` | Mã kỳ | Mã UUID | Mã kỳ liên kết dung_chung.ky_nghiep_vu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.ky_nghiep_vu |
| `ma_chung_tu_chot_cong` | Mã chứng từ chốt công | Mã UUID | Mã chứng từ chốt công liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `ma_ban_ky_bi_thay` | Mã kỳ tính thu nhập bị thay | Mã UUID | Mã kỳ tính thu nhập bị thay liên kết dung_chung.ky_nghiep_vu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.ky_nghiep_vu |

**Ràng buộc:** Các loại kỳ có bản/hiệu lực riêng; chốt công không chốt lương hoặc tiền. Kỳ thu nhập cố định nguồn chốt công/chính sách và bản bị thay. Tổng/tiến độ tính từ nguồn; dòng giám đốc kiểm độc lập. Không sửa bản đã chốt, không tự đóng theo lịch. Điều kiện nguồn Kỳ tính thu nhập: Kỳ tính cố định kỳ công và bản chính sách. Duyệt thuộc từng dòng và quyết định; tình trạng duyệt toàn kỳ tính từ các nguồn đó, không có cột cho phép một thao tác hợp thức hóa mọi dòng. Chốt kỳ theo chứng từ và kỳ nghiệp vụ.

**Yêu cầu:** FR06, FR30, FR31.

### T013 Phiên bản chính sách

**Tên bảng:** `dung_chung.phien_ban_chinh_sach`. **Phụ trách:** Bộ phận phụ trách chính sách.

**Mục đích:** Tham số có hiệu lực và căn cứ..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của phiên bản chính sách, phục vụ tham số có hiệu lực và căn cứ; được ghi bởi bộ phận phụ trách chính sách theo hồ sơ nguồn của bảng. Giá trị cho phép: lich_lam; xac_dinh_gia; kiem_chat_luong; san_xuat; thu_nhap; nghi; dinh_gia; canh_bao_ton. Giá trị: lich_lam; xac_dinh_gia; kiem_chat_luong; san_xuat; thu_nhap; nghi; dinh_gia; canh_bao_ton. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của phiên bản chính sách, phục vụ tham số có hiệu lực và căn cứ; được ghi bởi bộ phận phụ trách chính sách theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_phien_ban` | Số phiên bản | Số nguyên | Số phiên bản của phiên bản chính sách, phục vụ tham số có hiệu lực và căn cứ; được ghi bởi bộ phận phụ trách chính sách theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_hieu_luc` | Thời điểm bắt đầu hiệu lực | Thời điểm có múi giờ | Thời điểm bắt đầu hiệu lực của phiên bản chính sách, phục vụ tham số có hiệu lực và căn cứ; được ghi bởi bộ phận phụ trách chính sách theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_hieu_luc` | Thời điểm kết thúc hiệu lực | Thời điểm có múi giờ | Thời điểm kết thúc hiệu lực của phiên bản chính sách, phục vụ tham số có hiệu lực và căn cứ; được ghi bởi bộ phận phụ trách chính sách theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `tham_so` | Tham số | Nội dung có cấu trúc đóng | Các tham số khai báo có cấu trúc và đơn vị, gắn chứng từ căn cứ/người khai báo/hiệu lực/duyệt; thiếu căn cứ để chờ, không nạp mặc định rồi coi chính sách doanh nghiệp. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `gia_lap` | Giả lập | Có/không | Giả lập của phiên bản chính sách, phục vụ tham số có hiệu lực và căn cứ; được ghi bởi bộ phận phụ trách chính sách theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_khai_bao` | Thời điểm khai báo | Thời điểm có múi giờ | Thời điểm khai báo của phiên bản chính sách, phục vụ tham số có hiệu lực và căn cứ; được ghi bởi bộ phận phụ trách chính sách theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `ma_chung_tu_can_cu_khai_bao` | Mã chứng từ căn cứ khai báo | Mã UUID | Mã chứng từ căn cứ khai báo liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_nguoi_khai_bao_du_lieu` | Mã người khai báo dữ liệu | Mã UUID | Mã người khai báo dữ liệu liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Tham số chỉ có hiệu lực khi có chứng từ căn cứ, người khai báo, mốc hiệu lực và quyết định phê duyệt đúng phạm vi; bản đề xuất hoặc thiếu căn cứ không điều khiển giao dịch. Không đặt mặc định để suy kết luận kiểm chất lượng, tự duyệt hoặc phát sinh nhu cầu mua. Bản sửa nối bản trước.

**Yêu cầu:** FR01, FR07, FR08, FR12, FR17, FR26, FR30, FR31.

### T014 Bộ dữ liệu mô phỏng

**Tên bảng:** `dung_chung.bo_du_lieu_mo_phong`. **Phụ trách:** Quản trị bộ mô phỏng.

**Mục đích:** Cách ly cơ sở, mốc và nhánh..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của bộ dữ liệu mô phỏng, phục vụ cách ly cơ sở, mốc và nhánh; được ghi bởi quản trị bộ mô phỏng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `phien_ban_bo_mo_phong` | Phiên bản bộ mô phỏng | Văn bản | Phiên bản bộ mô phỏng của bộ dữ liệu mô phỏng, phục vụ cách ly cơ sở, mốc và nhánh; được ghi bởi quản trị bộ mô phỏng theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `che_do` | Chế độ | Phân loại có danh sách đóng | Chế độ của bộ dữ liệu mô phỏng, phục vụ cách ly cơ sở, mốc và nhánh; được ghi bởi quản trị bộ mô phỏng theo hồ sơ nguồn của bảng. Giá trị cho phép: dau_ky; anh_chup_da_hoan_thanh; nhanh_thu. Giá trị: dau_ky; anh_chup_da_hoan_thanh; nhanh_thu. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_kich_ban_kiem_tra` | Mã kịch bản kiểm tra | Văn bản | Mã kịch bản kiểm tra của bộ dữ liệu mô phỏng, phục vụ cách ly cơ sở, mốc và nhánh; được ghi bởi quản trị bộ mô phỏng theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `thoi_diem_moc_goc` | Thời điểm mốc gốc | Thời điểm có múi giờ | Thời điểm mốc gốc của bộ dữ liệu mô phỏng, phục vụ cách ly cơ sở, mốc và nhánh; được ghi bởi quản trị bộ mô phỏng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: chuan_bi_vao_lam; du_dieu_kien_bat_dau; luu_tru. Giá trị: chuan_bi_vao_lam; du_dieu_kien_bat_dau; luu_tru. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ma_kiem_toan_ven_bo_nap` | Mã kiểm toàn vẹn bộ nạp | Văn bản | Mã kiểm toàn vẹn bộ nạp của bộ dữ liệu mô phỏng, phục vụ cách ly cơ sở, mốc và nhánh; được ghi bởi quản trị bộ mô phỏng theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `ma_bo_du_lieu_cha` | Mã bộ dữ liệu cha | Mã UUID | Mã bộ dữ liệu cha liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.bo_du_lieu_mo_phong |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Duy nhất(ma_nghiep_vu,phien_ban_bo_mo_phong,che_do). Mọi dòng nghiệp vụ gắn workspace_id; nhánh không cộng vào cơ sở. Khôi phục làm bộ mới, giữ bộ cũ lưu trữ; không xóa người dùng/secret.

**Yêu cầu:** FR01, FR05, FR33.

### T015 Tài khoản đăng nhập

**Tên bảng:** `truy_cap.tai_khoan_dang_nhap`. **Phụ trách:** Quản trị truy cập theo quyết định.

**Mục đích:** Tài khoản của người thật..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ten_dang_nhap` | Tên đăng nhập | Văn bản | Tên đăng nhập của tài khoản đăng nhập, phục vụ tài khoản của người thật; được ghi bởi quản trị truy cập theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ban_bam_thong_tin_xac_thuc` | Bản băm thông tin xác thực | Văn bản | Bản băm thông tin xác thực của tài khoản đăng nhập, phục vụ tài khoản của người thật; được ghi bởi quản trị truy cập theo quyết định theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: dang_su_dung; ngung_su_dung. Giá trị: dang_su_dung; ngung_su_dung. | Sự kiện hoặc quyết định được ghi nhận | — |
| `so_phien_ban_quyen_xac_thuc` | Số phiên bản quyền xác thực | Số nguyên | Số phiên bản quyền xác thực của tài khoản đăng nhập, phục vụ tài khoản của người thật; được ghi bởi quản trị truy cập theo quyết định theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `ma_nguoi_that` | Mã người thật | Mã UUID | Mã người thật liên kết truy_cap.dinh_danh_nguoi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | truy_cap.dinh_danh_nguoi |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Nhiều tài khoản trỏ một person ổn định. Hồ sơ nhân sự theo bộ nối cùng person; không bắt 50 người có tài khoản. Credential chỉ băm, không bản rõ hoặc Git.

**Yêu cầu:** FR02, FR03, FR28.

### T016 Vai trò công việc

**Tên bảng:** `truy_cap.vai_tro_cong_viec`. **Phụ trách:** Quản trị truy cập.

**Mục đích:** Nhóm quyền công việc..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của vai trò công việc, phục vụ nhóm quyền công việc; được ghi bởi quản trị truy cập theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ten` | Tên | Văn bản | Tên của vai trò công việc, phục vụ nhóm quyền công việc; được ghi bởi quản trị truy cập theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Vai trò không là phòng ban/người duyệt mới. Các chi tiết thuộc bảng con, tự nối đúng bản cha trong cùng biểu mẫu; không bắt tạo một công việc/phiếu riêng cho mỗi dòng.

**Yêu cầu:** FR02.

### T017 Quyền thao tác

**Tên bảng:** `truy_cap.quyen_thao_tac`. **Phụ trách:** Quản trị truy cập.

**Mục đích:** Quyền của từng vai trò..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai_doi_tuong_phan_quyen` | Loại đối tượng phân quyền | Phân loại có danh sách đóng | Loại đối tượng phân quyền của quyền thao tác, phục vụ quyền của từng vai trò; được ghi bởi quản trị truy cập theo hồ sơ nguồn của bảng. Giá trị cho phép: dung_chung.doanh_nghiep; dung_chung.bo_phan; dung_chung.vi_tri_giu_hang; dung_chung.don_vi_tinh; dung_chung.chung_tu; dung_chung.dong_chung_tu; dung_chung.lien_ket_chung_tu; dung_chung.de_nghi_va_quyet_dinh_phe_duyet; dung_chung.trao_doi_va_ban_giao; dung_chung.chung_cu_dinh_kem; dung_chung.nhat_ky_thao_tac; dung_chung.ky_nghiep_vu; dung_chung.phien_ban_chinh_sach; dung_chung.bo_du_lieu_mo_phong; truy_cap.tai_khoan_dang_nhap; truy_cap.vai_tro_cong_viec; truy_cap.quyen_thao_tac; truy_cap.cap_vai_tro; truy_cap.uy_quyen; truy_cap.bien_nhan_xac_nhan_giao_dich; danh_muc.mat_hang; danh_muc.mat_hang; danh_muc.ma_goi_khac; danh_muc.quy_doi_don_vi; dung_chung.doi_tac; dung_chung.lien_he_doi_tac; dung_chung.can_cu_dai_dien; kinh_doanh.nhu_cau_khach_hang; dung_chung.trao_doi_va_ban_giao; kinh_doanh.dong_tu_van_bao_gia_va_don_hang; kinh_doanh.bao_gia_va_don_hang; kinh_doanh.dong_tu_van_bao_gia_va_don_hang; kinh_doanh.mau_khach_duyet; kinh_doanh.ho_so_xu_ly; mua_hang.don_mua_hang; mua_hang.dong_don_mua_hang; kho.su_kien_giu_khoa_va_dang_ve; kho.lo_hang; kho.phan_lo_hang; dung_chung.chung_tu; kho.dong_van_dong_hang; kho.yeu_cau_hang_va_vat_tu; kho.su_kien_giu_khoa_va_dang_ve; dung_chung.chung_tu; kho.dong_kiem_ke; san_xuat.phien_ban_dinh_muc_san_xuat; san_xuat.dong_dinh_muc_vat_tu; san_xuat.nguon_luc_san_xuat; san_xuat.lenh_san_xuat; san_xuat.lo_san_xuat; san_xuat.cong_doan_san_xuat; san_xuat.lich_nguoi_va_nguon_luc; kho.dong_van_dong_hang; chat_luong.phieu_kiem_tra_chat_luong; chat_luong.ket_qua_tung_tieu_chi_kiem_tra; kho.su_kien_giu_khoa_va_dang_ve; kinh_doanh.ho_so_xu_ly; giao_hang.dot_giao_hang; giao_hang.dong_giao_va_nhan_hang; giao_hang.dong_giao_va_nhan_hang; tai_chinh.quy_va_tai_khoan_tien; tai_chinh.de_nghi_chi_tien; tai_chinh.bien_dong_tien_thuc; tai_chinh.nghia_vu_va_dieu_chinh; tai_chinh.nghia_vu_va_dieu_chinh; tai_chinh.su_kien_su_dung_nguon_tien; dung_chung.chung_tu; tai_chinh.dong_ghi_nhan_ban; tai_chinh.doi_chieu_nghia_vu_mua; tai_chinh.dong_doi_chieu_quy_ngan_hang; tai_chinh.nguon_chi_phi; tai_chinh.phan_bo_chi_phi; tai_chinh.can_cu_phan_bo_chi_phi; dung_chung.chung_tu; tai_chinh.bien_dong_gia_tri; nhan_su.nhan_vien; nhan_su.ho_so_lam_viec_theo_hieu_luc; nhan_su.ho_so_ky_nang_va_an_toan; dung_chung.trao_doi_va_ban_giao; nhan_su.ngay_va_ca_lam_viec; san_xuat.lich_nguoi_va_nguon_luc; dung_chung.chung_tu; nhan_su.khoang_cong_thuc_te; nhan_su.de_nghi_nghi; nhan_su.su_kien_phep; dung_chung.ky_nghiep_vu; nhan_su.thu_nhap_nhan_vien; nhan_su.khoan_thu_nhap_co_can_cu; truy_cap.phien_dang_nhap; tai_chinh.nguon_cua_ban_chot_gia_thanh; truy_cap.dinh_danh_nguoi. Giá trị: dung_chung.doanh_nghiep; dung_chung.bo_phan; dung_chung.vi_tri_giu_hang; dung_chung.don_vi_tinh; dung_chung.chung_tu; dung_chung.dong_chung_tu; dung_chung.lien_ket_chung_tu; dung_chung.de_nghi_va_quyet_dinh_phe_duyet; dung_chung.trao_doi_va_ban_giao; dung_chung.chung_cu_dinh_kem; dung_chung.nhat_ky_thao_tac; dung_chung.ky_nghiep_vu; dung_chung.phien_ban_chinh_sach; dung_chung.bo_du_lieu_mo_phong; truy_cap.tai_khoan_dang_nhap; truy_cap.vai_tro_cong_viec; truy_cap.quyen_thao_tac; truy_cap.cap_vai_tro; truy_cap.uy_quyen; truy_cap.bien_nhan_xac_nhan_giao_dich; danh_muc.mat_hang; danh_muc.mat_hang; danh_muc.ma_goi_khac; danh_muc.quy_doi_don_vi; dung_chung.doi_tac; dung_chung.lien_he_doi_tac; dung_chung.can_cu_dai_dien; kinh_doanh.nhu_cau_khach_hang; dung_chung.trao_doi_va_ban_giao; kinh_doanh.dong_tu_van_bao_gia_va_don_hang; kinh_doanh.bao_gia_va_don_hang; kinh_doanh.dong_tu_van_bao_gia_va_don_hang; kinh_doanh.mau_khach_duyet; kinh_doanh.ho_so_xu_ly; mua_hang.don_mua_hang; mua_hang.dong_don_mua_hang; kho.su_kien_giu_khoa_va_dang_ve; kho.lo_hang; kho.phan_lo_hang; dung_chung.chung_tu; kho.dong_van_dong_hang; kho.yeu_cau_hang_va_vat_tu; kho.su_kien_giu_khoa_va_dang_ve; dung_chung.chung_tu; kho.dong_kiem_ke; san_xuat.phien_ban_dinh_muc_san_xuat; san_xuat.dong_dinh_muc_vat_tu; san_xuat.nguon_luc_san_xuat; san_xuat.lenh_san_xuat; san_xuat.lo_san_xuat; san_xuat.cong_doan_san_xuat; san_xuat.lich_nguoi_va_nguon_luc; kho.dong_van_dong_hang; chat_luong.phieu_kiem_tra_chat_luong; chat_luong.ket_qua_tung_tieu_chi_kiem_tra; kho.su_kien_giu_khoa_va_dang_ve; kinh_doanh.ho_so_xu_ly; giao_hang.dot_giao_hang; giao_hang.dong_giao_va_nhan_hang; giao_hang.dong_giao_va_nhan_hang; tai_chinh.quy_va_tai_khoan_tien; tai_chinh.de_nghi_chi_tien; tai_chinh.bien_dong_tien_thuc; tai_chinh.nghia_vu_va_dieu_chinh; tai_chinh.nghia_vu_va_dieu_chinh; tai_chinh.su_kien_su_dung_nguon_tien; dung_chung.chung_tu; tai_chinh.dong_ghi_nhan_ban; tai_chinh.doi_chieu_nghia_vu_mua; tai_chinh.dong_doi_chieu_quy_ngan_hang; tai_chinh.nguon_chi_phi; tai_chinh.phan_bo_chi_phi; tai_chinh.can_cu_phan_bo_chi_phi; dung_chung.chung_tu; tai_chinh.bien_dong_gia_tri; nhan_su.nhan_vien; nhan_su.ho_so_lam_viec_theo_hieu_luc; nhan_su.ho_so_ky_nang_va_an_toan; dung_chung.trao_doi_va_ban_giao; nhan_su.ngay_va_ca_lam_viec; san_xuat.lich_nguoi_va_nguon_luc; dung_chung.chung_tu; nhan_su.khoang_cong_thuc_te; nhan_su.de_nghi_nghi; nhan_su.su_kien_phep; dung_chung.ky_nghiep_vu; nhan_su.thu_nhap_nhan_vien; nhan_su.khoan_thu_nhap_co_can_cu; truy_cap.phien_dang_nhap; tai_chinh.nguon_cua_ban_chot_gia_thanh; truy_cap.dinh_danh_nguoi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `hanh_dong` | Hành động | Phân loại có danh sách đóng | Hành động của quyền thao tác, phục vụ quyền của từng vai trò; được ghi bởi quản trị truy cập theo hồ sơ nguồn của bảng. Giá trị cho phép: xem; tao; kiem_tra; phe_duyet; xac_nhan; dieu_chinh; xuat_khau. Giá trị: xem; tao; kiem_tra; phe_duyet; xac_nhan; dieu_chinh; xuat_khau. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `pham_vi` | Phạm vi | Phân loại có danh sách đóng | Phạm vi của quyền thao tác, phục vụ quyền của từng vai trò; được ghi bởi quản trị truy cập theo hồ sơ nguồn của bảng. Giá trị cho phép: tu_than; da_phan_cong; bo_phan; doanh_nghiep. Giá trị: tu_than; da_phan_cong; bo_phan; doanh_nghiep. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `cac_nhom_du_lieu_nhay_cam` | Các nhóm dữ liệu nhạy cảm | Phân loại có danh sách đóng | Các nhóm dữ liệu nhạy cảm của quyền thao tác, phục vụ quyền của từng vai trò; được ghi bởi quản trị truy cập theo hồ sơ nguồn của bảng. Giá trị cho phép: luong_ca_nhan; ho_so_ca_nhan; cong_ca_nhan; chung_cu_han_che; nguon_chi_phi_ca_nhan; thong_tin_xac_thuc. Giá trị: luong_ca_nhan; ho_so_ca_nhan; cong_ca_nhan; chung_cu_han_che; nguon_chi_phi_ca_nhan; thong_tin_xac_thuc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_vai_tro` | Mã vai trò | Mã UUID | Mã vai trò liên kết truy_cap.vai_tro_cong_viec đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | truy_cap.vai_tro_cong_viec |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Duy nhất(role,nguồn lực,hanh_dong,pham_vi); quyền xuất và xem lương tách. Mặc định từ chối.

**Yêu cầu:** FR02, FR32.

### T018 Cấp vai trò

**Tên bảng:** `truy_cap.cap_vai_tro`. **Phụ trách:** Quản trị truy cập theo quyết định.

**Mục đích:** Cấp vai trò có hiệu lực..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `thoi_diem_bat_dau_hieu_luc` | Thời điểm bắt đầu hiệu lực | Thời điểm có múi giờ | Thời điểm bắt đầu hiệu lực của cấp vai trò, phục vụ cấp vai trò có hiệu lực; được ghi bởi quản trị truy cập theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_hieu_luc` | Thời điểm kết thúc hiệu lực | Thời điểm có múi giờ | Thời điểm kết thúc hiệu lực của cấp vai trò, phục vụ cấp vai trò có hiệu lực; được ghi bởi quản trị truy cập theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_thu_hoi_quyen` | Thời điểm thu hồi quyền | Thời điểm có múi giờ | Thời điểm thu hồi quyền của cấp vai trò, phục vụ cấp vai trò có hiệu lực; được ghi bởi quản trị truy cập theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_tai_khoan` | Mã tài khoản | Mã UUID | Mã tài khoản liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | truy_cap.tai_khoan_dang_nhap |
| `ma_vai_tro` | Mã vai trò | Mã UUID | Mã vai trò liên kết truy_cap.vai_tro_cong_viec đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | truy_cap.vai_tro_cong_viec |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Không tự cấp cho mình; ngừng quyền khi nghỉ hiệu lực. Cấp quyền chỉ là nguồn cho kiểm tra, không được mở toàn dữ liệu.

**Yêu cầu:** FR02, FR28.

### T019 Ủy quyền

**Tên bảng:** `truy_cap.uy_quyen`. **Phụ trách:** Giám đốc / người có thẩm quyền.

**Mục đích:** Ủy quyền giới hạn..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `hanh_dong` | Hành động | Phân loại có danh sách đóng | Hành động của ủy quyền, phục vụ ủy quyền giới hạn; được ghi bởi giám đốc / người có thẩm quyền theo hồ sơ nguồn của bảng. Giá trị cho phép: xem; tao; kiem_tra; phe_duyet; xac_nhan; nhan; xuat_du_lieu; huy; dieu_chinh; khoi_phuc; chot_ky; mo_lai_ky; danh_gia_dap_ung; quyet_dinh_uu_tien; chot_lenh. Giá trị: xem; tao; kiem_tra; phe_duyet; xac_nhan; nhan; xuat_du_lieu; huy; dieu_chinh; khoi_phuc; chot_ky; mo_lai_ky; danh_gia_dap_ung; quyet_dinh_uu_tien; chot_lenh. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai_doi_tuong_phan_quyen` | Loại đối tượng phân quyền | Phân loại có danh sách đóng | Loại đối tượng phân quyền của ủy quyền, phục vụ ủy quyền giới hạn; được ghi bởi giám đốc / người có thẩm quyền theo hồ sơ nguồn của bảng. Giá trị cho phép: dung_chung.doanh_nghiep; dung_chung.bo_phan; dung_chung.vi_tri_giu_hang; dung_chung.don_vi_tinh; dung_chung.chung_tu; dung_chung.dong_chung_tu; dung_chung.lien_ket_chung_tu; dung_chung.de_nghi_va_quyet_dinh_phe_duyet; dung_chung.trao_doi_va_ban_giao; dung_chung.chung_cu_dinh_kem; dung_chung.nhat_ky_thao_tac; dung_chung.ky_nghiep_vu; dung_chung.phien_ban_chinh_sach; dung_chung.bo_du_lieu_mo_phong; truy_cap.tai_khoan_dang_nhap; truy_cap.vai_tro_cong_viec; truy_cap.quyen_thao_tac; truy_cap.cap_vai_tro; truy_cap.uy_quyen; truy_cap.bien_nhan_xac_nhan_giao_dich; danh_muc.mat_hang; danh_muc.mat_hang; danh_muc.ma_goi_khac; danh_muc.quy_doi_don_vi; dung_chung.doi_tac; dung_chung.lien_he_doi_tac; dung_chung.can_cu_dai_dien; kinh_doanh.nhu_cau_khach_hang; dung_chung.trao_doi_va_ban_giao; kinh_doanh.dong_tu_van_bao_gia_va_don_hang; kinh_doanh.bao_gia_va_don_hang; kinh_doanh.dong_tu_van_bao_gia_va_don_hang; kinh_doanh.mau_khach_duyet; kinh_doanh.ho_so_xu_ly; mua_hang.don_mua_hang; mua_hang.dong_don_mua_hang; kho.su_kien_giu_khoa_va_dang_ve; kho.lo_hang; kho.phan_lo_hang; dung_chung.chung_tu; kho.dong_van_dong_hang; kho.yeu_cau_hang_va_vat_tu; kho.su_kien_giu_khoa_va_dang_ve; dung_chung.chung_tu; kho.dong_kiem_ke; san_xuat.phien_ban_dinh_muc_san_xuat; san_xuat.dong_dinh_muc_vat_tu; san_xuat.nguon_luc_san_xuat; san_xuat.lenh_san_xuat; san_xuat.lo_san_xuat; san_xuat.cong_doan_san_xuat; san_xuat.lich_nguoi_va_nguon_luc; kho.dong_van_dong_hang; chat_luong.phieu_kiem_tra_chat_luong; chat_luong.ket_qua_tung_tieu_chi_kiem_tra; kho.su_kien_giu_khoa_va_dang_ve; kinh_doanh.ho_so_xu_ly; giao_hang.dot_giao_hang; giao_hang.dong_giao_va_nhan_hang; giao_hang.dong_giao_va_nhan_hang; tai_chinh.quy_va_tai_khoan_tien; tai_chinh.de_nghi_chi_tien; tai_chinh.bien_dong_tien_thuc; tai_chinh.nghia_vu_va_dieu_chinh; tai_chinh.nghia_vu_va_dieu_chinh; tai_chinh.su_kien_su_dung_nguon_tien; dung_chung.chung_tu; tai_chinh.dong_ghi_nhan_ban; tai_chinh.doi_chieu_nghia_vu_mua; tai_chinh.dong_doi_chieu_quy_ngan_hang; tai_chinh.nguon_chi_phi; tai_chinh.phan_bo_chi_phi; tai_chinh.can_cu_phan_bo_chi_phi; dung_chung.chung_tu; tai_chinh.bien_dong_gia_tri; nhan_su.nhan_vien; nhan_su.ho_so_lam_viec_theo_hieu_luc; nhan_su.ho_so_ky_nang_va_an_toan; dung_chung.trao_doi_va_ban_giao; nhan_su.ngay_va_ca_lam_viec; san_xuat.lich_nguoi_va_nguon_luc; dung_chung.chung_tu; nhan_su.khoang_cong_thuc_te; nhan_su.de_nghi_nghi; nhan_su.su_kien_phep; dung_chung.ky_nghiep_vu; nhan_su.thu_nhap_nhan_vien; nhan_su.khoan_thu_nhap_co_can_cu; truy_cap.phien_dang_nhap; tai_chinh.nguon_cua_ban_chot_gia_thanh; truy_cap.dinh_danh_nguoi. Giá trị: dung_chung.doanh_nghiep; dung_chung.bo_phan; dung_chung.vi_tri_giu_hang; dung_chung.don_vi_tinh; dung_chung.chung_tu; dung_chung.dong_chung_tu; dung_chung.lien_ket_chung_tu; dung_chung.de_nghi_va_quyet_dinh_phe_duyet; dung_chung.trao_doi_va_ban_giao; dung_chung.chung_cu_dinh_kem; dung_chung.nhat_ky_thao_tac; dung_chung.ky_nghiep_vu; dung_chung.phien_ban_chinh_sach; dung_chung.bo_du_lieu_mo_phong; truy_cap.tai_khoan_dang_nhap; truy_cap.vai_tro_cong_viec; truy_cap.quyen_thao_tac; truy_cap.cap_vai_tro; truy_cap.uy_quyen; truy_cap.bien_nhan_xac_nhan_giao_dich; danh_muc.mat_hang; danh_muc.mat_hang; danh_muc.ma_goi_khac; danh_muc.quy_doi_don_vi; dung_chung.doi_tac; dung_chung.lien_he_doi_tac; dung_chung.can_cu_dai_dien; kinh_doanh.nhu_cau_khach_hang; dung_chung.trao_doi_va_ban_giao; kinh_doanh.dong_tu_van_bao_gia_va_don_hang; kinh_doanh.bao_gia_va_don_hang; kinh_doanh.dong_tu_van_bao_gia_va_don_hang; kinh_doanh.mau_khach_duyet; kinh_doanh.ho_so_xu_ly; mua_hang.don_mua_hang; mua_hang.dong_don_mua_hang; kho.su_kien_giu_khoa_va_dang_ve; kho.lo_hang; kho.phan_lo_hang; dung_chung.chung_tu; kho.dong_van_dong_hang; kho.yeu_cau_hang_va_vat_tu; kho.su_kien_giu_khoa_va_dang_ve; dung_chung.chung_tu; kho.dong_kiem_ke; san_xuat.phien_ban_dinh_muc_san_xuat; san_xuat.dong_dinh_muc_vat_tu; san_xuat.nguon_luc_san_xuat; san_xuat.lenh_san_xuat; san_xuat.lo_san_xuat; san_xuat.cong_doan_san_xuat; san_xuat.lich_nguoi_va_nguon_luc; kho.dong_van_dong_hang; chat_luong.phieu_kiem_tra_chat_luong; chat_luong.ket_qua_tung_tieu_chi_kiem_tra; kho.su_kien_giu_khoa_va_dang_ve; kinh_doanh.ho_so_xu_ly; giao_hang.dot_giao_hang; giao_hang.dong_giao_va_nhan_hang; giao_hang.dong_giao_va_nhan_hang; tai_chinh.quy_va_tai_khoan_tien; tai_chinh.de_nghi_chi_tien; tai_chinh.bien_dong_tien_thuc; tai_chinh.nghia_vu_va_dieu_chinh; tai_chinh.nghia_vu_va_dieu_chinh; tai_chinh.su_kien_su_dung_nguon_tien; dung_chung.chung_tu; tai_chinh.dong_ghi_nhan_ban; tai_chinh.doi_chieu_nghia_vu_mua; tai_chinh.dong_doi_chieu_quy_ngan_hang; tai_chinh.nguon_chi_phi; tai_chinh.phan_bo_chi_phi; tai_chinh.can_cu_phan_bo_chi_phi; dung_chung.chung_tu; tai_chinh.bien_dong_gia_tri; nhan_su.nhan_vien; nhan_su.ho_so_lam_viec_theo_hieu_luc; nhan_su.ho_so_ky_nang_va_an_toan; dung_chung.trao_doi_va_ban_giao; nhan_su.ngay_va_ca_lam_viec; san_xuat.lich_nguoi_va_nguon_luc; dung_chung.chung_tu; nhan_su.khoang_cong_thuc_te; nhan_su.de_nghi_nghi; nhan_su.su_kien_phep; dung_chung.ky_nghiep_vu; nhan_su.thu_nhap_nhan_vien; nhan_su.khoan_thu_nhap_co_can_cu; truy_cap.phien_dang_nhap; tai_chinh.nguon_cua_ban_chot_gia_thanh; truy_cap.dinh_danh_nguoi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_hieu_luc` | Thời điểm bắt đầu hiệu lực | Thời điểm có múi giờ | Thời điểm bắt đầu hiệu lực của ủy quyền, phục vụ ủy quyền giới hạn; được ghi bởi giám đốc / người có thẩm quyền theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_hieu_luc` | Thời điểm kết thúc hiệu lực | Thời điểm có múi giờ | Thời điểm kết thúc hiệu lực của ủy quyền, phục vụ ủy quyền giới hạn; được ghi bởi giám đốc / người có thẩm quyền theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `gioi_han_so_luong_duoc_duyet` | Giới hạn số lượng được duyệt | Số lượng chính xác | Giới hạn số lượng được duyệt của ủy quyền, phục vụ ủy quyền giới hạn; được ghi bởi giám đốc / người có thẩm quyền theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `gioi_han_so_tien_duoc_duyet` | Giới hạn số tiền được duyệt | Số tiền VND nguyên đồng | Giới hạn số tiền được duyệt của ủy quyền, phục vụ ủy quyền giới hạn; được ghi bởi giám đốc / người có thẩm quyền theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_thu_hoi_quyen` | Thời điểm thu hồi quyền | Thời điểm có múi giờ | Thời điểm thu hồi quyền của ủy quyền, phục vụ ủy quyền giới hạn; được ghi bởi giám đốc / người có thẩm quyền theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_nhan_vien_giao_uy_quyen` | Mã nhân viên giao ủy quyền | Mã UUID | Mã nhân viên giao ủy quyền liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_nhan_vien_nhan_uy_quyen` | Mã nhân viên nhận ủy quyền | Mã UUID | Mã nhân viên nhận ủy quyền liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Mã phiên bản chứng từ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Nguồn cụ thể có thể trống nếu phạm vi loại; không ủy quyền tiếp; không tự hưởng; duyệt mới kiểm thời hạn, quyết định cũ giữ nguyên.

**Yêu cầu:** FR02, FR03, FR24, FR31.

### T020 Biên nhận xác nhận giao dịch

**Tên bảng:** `truy_cap.bien_nhan_xac_nhan_giao_dich`. **Phụ trách:** Hệ thống.

**Mục đích:** Chống ghi trùng và đối chiếu mất phản hồi..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `khoa_chong_xac_nhan_lap` | Khóa chống xác nhận lặp | Văn bản | Khóa chống xác nhận lặp của biên nhận xác nhận giao dịch, phục vụ chống ghi trùng và đối chiếu mất phản hồi; được ghi bởi hệ thống theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `hanh_dong` | Hành động | Phân loại có danh sách đóng | Hành động của biên nhận xác nhận giao dịch, phục vụ chống ghi trùng và đối chiếu mất phản hồi; được ghi bởi hệ thống theo hồ sơ nguồn của bảng. Giá trị cho phép: xem; tao; kiem_tra; phe_duyet; xac_nhan; nhan; xuat_du_lieu; huy; dieu_chinh; khoi_phuc; chot_ky; mo_lai_ky; danh_gia_dap_ung; quyet_dinh_uu_tien; chot_lenh. Giá trị: xem; tao; kiem_tra; phe_duyet; xac_nhan; nhan; xuat_du_lieu; huy; dieu_chinh; khoi_phuc; chot_ky; mo_lai_ky; danh_gia_dap_ung; quyet_dinh_uu_tien; chot_lenh. | Dữ liệu kỹ thuật | — |
| `ban_bam_noi_dung_yeu_cau` | Bản băm nội dung yêu cầu | Văn bản | Bản băm nội dung yêu cầu của biên nhận xác nhận giao dịch, phục vụ chống ghi trùng và đối chiếu mất phản hồi; được ghi bởi hệ thống theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: da_ghi_toan_phan. Giá trị: da_ghi_toan_phan. | Sự kiện hoặc quyết định được ghi nhận | — |
| `thoi_diem_ghi_nhan_toan_phan` | Thời điểm ghi nhận toàn phần | Thời điểm có múi giờ | Thời điểm ghi nhận toàn phần của biên nhận xác nhận giao dịch, phục vụ chống ghi trùng và đối chiếu mất phản hồi; được ghi bởi hệ thống theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `cac_ma_ket_qua_da_ghi_nhan` | Các mã kết quả đã ghi nhận | Nội dung có cấu trúc đóng | Các mã kết quả đã ghi nhận của biên nhận xác nhận giao dịch, phục vụ chống ghi trùng và đối chiếu mất phản hồi; được ghi bởi hệ thống theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_tai_khoan` | Mã tài khoản | Mã UUID | Mã tài khoản liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Mã phiên bản chứng từ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.chung_tu |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |

**Ràng buộc:** Duy nhất(bộ dữ liệu,hanh_dong,khoa_chong_xac_nhan_lap); cùng khóa khác nội dung từ chối. Tạo trong cùng giao dịch nguyên tử với kết quả, không ghi thành công trước commit.

**Yêu cầu:** FR05, FR33.

### T021 Mặt hàng và nhóm mẫu

**Tên bảng:** `danh_muc.mat_hang`. **Phụ trách:** Kinh doanh / sản xuất; Kho cùng bộ phận sử dụng.

**Mục đích:** Lưu theo loại và bản: Nhóm mẫu ngói/Terrazzo.; Vật tư hoặc biến thể có thể giao dịch..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của sản phẩm, phục vụ nhóm mẫu ngói/gạch terrazzo; được ghi bởi kinh doanh / sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ten` | Tên | Văn bản | Tên của sản phẩm, phục vụ nhóm mẫu ngói/gạch terrazzo; được ghi bởi kinh doanh / sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `nhom_san_pham` | Nhóm sản phẩm | Phân loại có danh sách đóng | Nhóm sản phẩm của sản phẩm, phục vụ nhóm mẫu ngói/gạch terrazzo; được ghi bởi kinh doanh / sản xuất theo hồ sơ nguồn của bảng. Giá trị cho phép: ngoi; gach_terrazzo; phu_kien. Giá trị: ngoi; gach_terrazzo; phu_kien. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dang_su_dung` | Đang sử dụng | Có/không | Đang sử dụng của sản phẩm, phục vụ nhóm mẫu ngói/gạch terrazzo; được ghi bởi kinh doanh / sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng. Giá trị cho phép: vat_tu; thanh_pham; bao_ho. Giá trị: vat_tu; thanh_pham; bao_ho. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_mau` | Mã màu | Văn bản | Mã màu của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_quy_cach` | Mã quy cách | Văn bản | Mã quy cách của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `chieu_rong_mi_li_met` | Chiều rộng mi li mét | Số thập phân chính xác | Chiều rộng mi li mét của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `chieu_dai_mi_li_met` | Chiều dài mi li mét | Số thập phân chính xác | Chiều dài mi li mét của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_vien_tren_met_vuong_theo_quy_cach` | Số viên trên mét vuông theo quy cách | Số thập phân chính xác | Số viên trên mét vuông theo quy cách của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `bat_buoc_duyet_mau_rieng` | Bắt buộc duyệt mẫu riêng | Có/không | Bắt buộc duyệt mẫu riêng của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_nhom_mau` | Mã sản phẩm | Mã UUID | Mã sản phẩm liên kết danh_muc.mat_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.mat_hang |
| `ma_don_vi_co_so` | Mã đơn vị cơ sở | Mã UUID | Mã đơn vị cơ sở liên kết dung_chung.don_vi_tinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.don_vi_tinh |
| `ma_phien_ban_quy_cach` | Mã phiên bản quy cách | Mã UUID | Mã phiên bản quy cách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `loai_mat_hang` | Loại mặt hàng | Phân loại có danh sách đóng | Nhóm mẫu là dòng danh mục cha; vật tư/biến thể/bảo hộ mới là đối tượng giao dịch kho. Giá trị: nhom_mau; bien_the; vat_tu; bao_ho. | Thông tin nghiệp vụ có căn cứ | — |

**Ràng buộc:** Nhóm mẫu không có giao dịch lượng, các dòng biến thể/vật tư/bảo hộ mới được tham chiếu bởi vận động/định mức. ma_nhom_mau là FK tự tham chiếu đúng loại nhóm, không chu trình; mã gọi khác trỏ đúng một dòng. Quy cách thay quan trọng tạo mã/bản mới, không sửa ngược lịch sử. Ràng buộc loại đích kiểm tại xác nhận và khi lưu quan hệ. Điều kiện nguồn Sản phẩm: Không giữ tồn theo sản phẩm cha; mã khác có nguồn B07.

**Yêu cầu:** FR01, FR07, FR08, FR11, FR16.

### T022 Mã gọi khác

**Tên bảng:** `danh_muc.ma_goi_khac`. **Phụ trách:** Kinh doanh / kho.

**Mục đích:** Mã trang mạng/cũ trỏ mã chuẩn..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_goi_khac` | Mã gọi khác | Văn bản | Mã gọi khác của mã gọi khác, phục vụ mã trang mạng/cũ trỏ mã chuẩn; được ghi bởi kinh doanh / kho theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `chung_cu` | Chứng cứ | Văn bản | Chứng cứ của mã gọi khác, phục vụ mã trang mạng/cũ trỏ mã chuẩn; được ghi bởi kinh doanh / kho theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_hieu_luc` | Thời điểm bắt đầu hiệu lực | Ngày địa phương | Thời điểm bắt đầu hiệu lực của mã gọi khác, phục vụ mã trang mạng/cũ trỏ mã chuẩn; được ghi bởi kinh doanh / kho theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_mat_hang` | Mã sản phẩm | Mã UUID | Mã sản phẩm liên kết danh_muc.mat_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.mat_hang |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Chính xác một đích product hoặc mặt hàng; duy nhất ma_goi_khac chuẩn hóa; ma_goi_khac product không tự đoán màu.

**Yêu cầu:** FR01, FR07.

### T023 Quy đổi đơn vị

**Tên bảng:** `danh_muc.quy_doi_don_vi`. **Phụ trách:** Kho / mua hàng.

**Mục đích:** Quy đổi đóng gói theo hàng, có bản..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `so_phien_ban` | Số phiên bản | Số nguyên | Số phiên bản của quy đổi đơn vị, phục vụ quy đổi đóng gói theo hàng, có bản; được ghi bởi kho / mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `he_so` | Hệ số | Số thập phân chính xác | Hệ số của quy đổi đơn vị, phục vụ quy đổi đóng gói theo hàng, có bản; được ghi bởi kho / mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_hieu_luc` | Thời điểm bắt đầu hiệu lực | Ngày địa phương | Thời điểm bắt đầu hiệu lực của quy đổi đơn vị, phục vụ quy đổi đóng gói theo hàng, có bản; được ghi bởi kho / mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_hieu_luc` | Thời điểm kết thúc hiệu lực | Ngày địa phương | Thời điểm kết thúc hiệu lực của quy đổi đơn vị, phục vụ quy đổi đóng gói theo hàng, có bản; được ghi bởi kho / mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_mat_hang` | Mã mặt hàng | Mã UUID | Mã mặt hàng liên kết danh_muc.mat_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.mat_hang |
| `ma_don_vi_quy_doi_nguon` | Mã đơn vị quy đổi nguồn | Mã UUID | Mã đơn vị quy đổi nguồn liên kết dung_chung.don_vi_tinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.don_vi_tinh |
| `ma_don_vi_quy_doi_dich` | Mã đơn vị quy đổi đích | Mã UUID | Mã đơn vị quy đổi đích liên kết dung_chung.don_vi_tinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.don_vi_tinh |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Factor>0; không sửa bản đã dùng; CEM 50kg/bao chỉ cho CEM. Thiếu quy đổi bị ngăn.

**Yêu cầu:** FR01, FR14, FR15, FR16.

### T024 Đối tác

**Tên bảng:** `dung_chung.doi_tac`. **Phụ trách:** Kinh doanh / mua hàng.

**Mục đích:** Một đối tác dùng chung mua/bán/trả/nhận..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của đối tác, phục vụ một đối tác dùng chung mua/bán/trả/nhận; được ghi bởi kinh doanh / mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ten` | Tên | Văn bản | Tên của đối tác, phục vụ một đối tác dùng chung mua/bán/trả/nhận; được ghi bởi kinh doanh / mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `cac_vai_tro` | Các vai trò | Phân loại có danh sách đóng | Các vai trò của đối tác, phục vụ một đối tác dùng chung mua/bán/trả/nhận; được ghi bởi kinh doanh / mua hàng theo hồ sơ nguồn của bảng. Giá trị cho phép: khach_hang; nha_cung_cap; ben_tra_tien; ben_nhan_hang; ben_van_chuyen. Giá trị: khach_hang; nha_cung_cap; ben_tra_tien; ben_nhan_hang; ben_van_chuyen. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `nhom_khach_hang` | Nhóm khách hàng | Phân loại có danh sách đóng | Nhóm khách hàng của đối tác, phục vụ một đối tác dùng chung mua/bán/trả/nhận; được ghi bởi kinh doanh / mua hàng theo hồ sơ nguồn của bảng. Giá trị cho phép: dai_ly; nha_thau; chu_cong_trinh; khach_le; xuat_khau. Giá trị: dai_ly; nha_thau; chu_cong_trinh; khach_le; xuat_khau. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dang_su_dung` | Đang sử dụng | Có/không | Đang sử dụng của đối tác, phục vụ một đối tác dùng chung mua/bán/trả/nhận; được ghi bởi kinh doanh / mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Một đối tác nhiều vai trò, không sao chép riêng cho từng bộ phận; chưa rõ bên trả được để chờ.

**Yêu cầu:** FR01, FR07, FR08, FR14, FR23, FR25.

### T025 Liên hệ đối tác

**Tên bảng:** `dung_chung.lien_he_doi_tac`. **Phụ trách:** Bộ phận phụ trách đối tác.

**Mục đích:** Người liên hệ và địa điểm..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ten` | Tên | Văn bản | Tên của liên hệ đối tác, phục vụ người liên hệ và địa điểm; được ghi bởi bộ phận phụ trách đối tác theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `kenh_lien_he` | Kênh liên hệ | Văn bản | Kênh liên hệ của liên hệ đối tác, phục vụ người liên hệ và địa điểm; được ghi bởi bộ phận phụ trách đối tác theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dia_chi` | Địa chỉ | Văn bản | Địa chỉ của liên hệ đối tác, phục vụ người liên hệ và địa điểm; được ghi bởi bộ phận phụ trách đối tác theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dang_su_dung` | Đang sử dụng | Có/không | Đang sử dụng của liên hệ đối tác, phục vụ người liên hệ và địa điểm; được ghi bởi bộ phận phụ trách đối tác theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_doi_tac` | Mã đối tác | Mã UUID | Mã đối tác liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Địa chỉ giao lưu ảnh chụp trên đợt/đơn để thay liên hệ không sửa lịch sử.

**Yêu cầu:** FR07, FR08, FR21.

### T026 Căn cứ đại diện

**Tên bảng:** `dung_chung.can_cu_dai_dien`. **Phụ trách:** Kinh doanh / tài chính.

**Mục đích:** Căn cứ đại diện hoặc trả thay..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `hanh_dong` | Hành động | Phân loại có danh sách đóng | Hành động của căn cứ đại diện, phục vụ căn cứ đại diện hoặc trả thay; được ghi bởi kinh doanh / tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: xac_nhan_don; duyet_mau; doi_don; tra_thay; nhan. Giá trị: xac_nhan_don; duyet_mau; doi_don; tra_thay; nhan. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_hieu_luc` | Thời điểm bắt đầu hiệu lực | Thời điểm có múi giờ | Thời điểm bắt đầu hiệu lực của căn cứ đại diện, phục vụ căn cứ đại diện hoặc trả thay; được ghi bởi kinh doanh / tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_hieu_luc` | Thời điểm kết thúc hiệu lực | Thời điểm có múi giờ | Thời điểm kết thúc hiệu lực của căn cứ đại diện, phục vụ căn cứ đại diện hoặc trả thay; được ghi bởi kinh doanh / tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_chung_tu_lam_can_cu` | Mã chứng từ làm căn cứ | Mã UUID | Mã chứng từ làm căn cứ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_doi_tac` | Mã đối tác | Mã UUID | Mã đối tác liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `ma_lien_he` | Mã liên hệ | Mã UUID | Mã liên hệ liên kết dung_chung.lien_he_doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.lien_he_doi_tac |
| `ma_chung_tu_xac_dinh_pham_vi` | Mã chứng từ xác định phạm vi | Mã UUID | Mã chứng từ xác định phạm vi liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_doi_tac_dai_dien` | Mã đối tác đại diện | Mã UUID | Mã đối tác đại diện liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Scope có thể trống nếu giấy đại diện chung; trả thay không quyền đổi/duyệt mẫu; kiểm đúng nguồn/thời hạn. ma_doi_tac là bên được đại diện; ma_doi_tac_dai_dien là tổ chức đại diện/trả thay nếu khác, contact là người ký căn cứ.

**Yêu cầu:** FR08, FR09, FR10, FR23.

### T027 Nhu cầu khách hàng

**Tên bảng:** `kinh_doanh.nhu_cau_khach_hang`. **Phụ trách:** Kinh doanh.

**Mục đích:** Một nhu cầu, nhiều lần liên hệ..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.chung_tu |
| `trang_thai_thuc_hien` | Trạng thái thực hiện | Phân loại có danh sách đóng | Trạng thái của sự kiện do người phụ trách xác nhận; không tự nạp đã hoàn tất. Trạng thái tổng hợp từ nhiều sự kiện chỉ tính khi xem. Giá trị cho phép: dang_mo; dang_lam_ro; da_bao_gia; da_chuyen_thanh_don; da_chot. Giá trị: dang_mo; dang_lam_ro; da_bao_gia; da_chuyen_thanh_don; da_chot. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ghi_chu_cong_trinh` | Ghi chú công trình | Văn bản | Ghi chú công trình của nhu cầu khách hàng, phục vụ một nhu cầu, nhiều lần liên hệ; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `tinh_trang_dieu_kien_xuat_khau` | Tình trạng điều kiện xuất khẩu | Phân loại có danh sách đóng | Tình trạng điều kiện xuất khẩu của nhu cầu khách hàng, phục vụ một nhu cầu, nhiều lần liên hệ; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. Giá trị cho phép: khong_ap_dung; cho_xu_ly; da_xac_dinh. Giá trị: khong_ap_dung; cho_xu_ly; da_xac_dinh. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_khach_hang` | Mã khách hàng | Mã UUID | Mã khách hàng liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `ma_lien_he` | Mã liên hệ | Mã UUID | Mã liên hệ liên kết dung_chung.lien_he_doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.lien_he_doi_tac |

**Ràng buộc:** Nhu cầu chưa đủ không tự thành đơn; khách xuất khẩu chờ điều kiện. Đầu nghiệp vụ dùng cùng ma_dinh_danh với Chứng từ; không có mã đầu/bộ thông tin lập/phiên bản ghi riêng. Các vai trò nghiệp vụ thực vẫn có trường nguồn riêng.

**Yêu cầu:** FR07.

### T028 Báo giá và đơn hàng

**Tên bảng:** `kinh_doanh.bao_gia_va_don_hang`. **Phụ trách:** Kinh doanh.

**Mục đích:** Báo giá hoặc đơn đúng phiên bản..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.chung_tu |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. Giá trị cho phép: bao_gia; don_hang. Giá trị: bao_gia; don_hang. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_het_hieu_luc` | Thời điểm hết hiệu lực | Thời điểm có múi giờ | Thời điểm hết hiệu lực của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_xac_nhan` | Thời điểm xác nhận | Thời điểm có múi giờ | Thời điểm xác nhận của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien_dat_coc_yeu_cau` | Số tiền đặt cọc yêu cầu | Số tiền VND nguyên đồng | Số tiền đặt cọc yêu cầu của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dieu_kien_thanh_toan` | Điều kiện thanh toán | Văn bản | Điều kiện thanh toán của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dieu_kien_giao_hang` | Điều kiện giao hàng | Văn bản | Điều kiện giao hàng của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `pham_vi_mo_phong_thue` | Phạm vi mô phỏng thuế | Phân loại có danh sách đóng | Phạm vi mô phỏng thuế của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. Giá trị cho phép: chua_mo_phong. Giá trị: chua_mo_phong. | Dữ liệu kỹ thuật | — |
| `can_cu_khach_xac_nhan` | Căn cứ khách xác nhận | Văn bản | Căn cứ khách xác nhận của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_nhu_cau_khach` | Mã chứng từ nhu cầu khách | Mã UUID | Mã chứng từ nhu cầu khách liên kết kinh_doanh.nhu_cau_khach_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.nhu_cau_khach_hang |
| `ma_ben_mua` | Mã bên mua | Mã UUID | Mã bên mua liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `ma_ben_tra_tien` | Mã bên trả tiền | Mã UUID | Mã bên trả tiền liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `ma_ben_nhan` | Mã bên nhận | Mã UUID | Mã bên nhận liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `ma_can_cu_dai_dien` | Mã căn cứ đại diện | Mã UUID | Mã căn cứ đại diện liên kết dung_chung.can_cu_dai_dien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.can_cu_dai_dien |
| `ma_phien_ban_chinh_sach_gia` | Mã phiên bản chính sách giá | Mã UUID | Mã phiên bản chính sách giá liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |

**Ràng buộc:** bên trả tiền/bên nhận hàng có thể khác buyer; ảnh chụp tên/địa chỉ/thỏa thuận ở chứng từ. Đơn liên kết báo giá, không sao giá động; thuế chưa mô phỏng không là 0%. Đầu nghiệp vụ dùng cùng ma_dinh_danh với Chứng từ; không có mã đầu/bộ thông tin lập/phiên bản ghi riêng. Các vai trò nghiệp vụ thực vẫn có trường nguồn riêng.

**Yêu cầu:** FR08, FR21, FR23.

### T029 Dòng tư vấn, báo giá và đơn hàng

**Tên bảng:** `kinh_doanh.dong_tu_van_bao_gia_va_don_hang`. **Phụ trách:** Kinh doanh / sản xuất kiểm; Kinh doanh.

**Mục đích:** Lưu theo loại và bản: Tư vấn số viên từ diện tích.; Cam kết từng biến thể và giá..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `dien_tich_met_vuong` | Diện tích mét vuông | Số thập phân chính xác | Diện tích mét vuông của thông số tư vấn, phục vụ tư vấn số viên từ diện tích; được ghi bởi kinh doanh / sản xuất kiểm theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_vien_tren_met_vuong_theo_quy_cach` | Số viên trên mét vuông theo quy cách | Số thập phân chính xác | Số viên trên mét vuông theo quy cách của thông số tư vấn, phục vụ tư vấn số viên từ diện tích; được ghi bởi kinh doanh / sản xuất kiểm theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ty_le_du_phong_tu_van` | Tỷ lệ dự phòng tư vấn | Tỷ lệ từ 0 đến 1 | Tỷ lệ dự phòng tư vấn của thông số tư vấn, phục vụ tư vấn số viên từ diện tích; được ghi bởi kinh doanh / sản xuất kiểm theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `tinh_trang_khach_chot_luong` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: uoc_tinh; khach_da_xac_nhan. Giá trị: uoc_tinh; khach_da_xac_nhan. | Sự kiện hoặc quyết định được ghi nhận | — |
| `can_cu_khach_xac_nhan` | Căn cứ khách xác nhận | Văn bản | Căn cứ khách xác nhận của thông số tư vấn, phục vụ tư vấn số viên từ diện tích; được ghi bởi kinh doanh / sản xuất kiểm theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_vien_khach_xac_nhan` | Số viên khách xác nhận | Số lượng chính xác | Số viên được khách xác nhận trong căn cứ riêng; nếu chưa xác nhận để trống, số viên ước tính chỉ là kết quả tính khi xem. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_nhu_cau_khach` | Mã chứng từ nhu cầu khách | Mã UUID | Mã chứng từ nhu cầu khách liên kết kinh_doanh.nhu_cau_khach_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.nhu_cau_khach_hang |
| `ma_mat_hang` | Mã mặt hàng | Mã UUID | Mã mặt hàng liên kết danh_muc.mat_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.mat_hang |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `so_vien_thoa_thuan` | Số viên thỏa thuận | Số lượng chính xác | Số viên thỏa thuận của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `don_gia_niem_yet_tham_chieu` | Đơn giá niêm yết tham chiếu | Số thập phân chính xác | Đơn giá niêm yết tham chiếu của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai_chiet_khau` | Loại chiết khấu | Phân loại có danh sách đóng | Loại chiết khấu của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. Giá trị cho phép: khong_ap_dung; ty_le; so_tien. Giá trị: khong_ap_dung; ty_le; so_tien. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `gia_tri_chiet_khau` | Giá trị chiết khấu | Số thập phân chính xác | Giá trị chiết khấu của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `don_gia_thoa_thuan` | Đơn giá thỏa thuận | Số thập phân chính xác | Đơn giá thỏa thuận của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien_thoa_thuan` | Số tiền thỏa thuận | Số tiền VND nguyên đồng | Số tiền thỏa thuận của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_giao_khach_yeu_cau` | Ngày giao khách yêu cầu | Ngày địa phương | Ngày giao khách yêu cầu của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `muc_dich_dong_hang` | Mục đích dòng hàng | Phân loại có danh sách đóng | Mục đích dòng hàng của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. Giá trị cho phép: ghi_ban; giao_bu. Giá trị: ghi_ban; giao_bu. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `quy_cach_ky_thuat_ban_luu_tai_thoi_diem` | Quy cách kỹ thuật bản lưu tại thời điểm | Nội dung có cấu trúc đóng | Quy cách kỹ thuật bản lưu tại thời điểm của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `ma_chung_tu_don_hang` | Mã chứng từ đơn hàng | Mã UUID | Mã chứng từ đơn hàng liên kết kinh_doanh.bao_gia_va_don_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.bao_gia_va_don_hang |
| `ma_chung_tu_mau_khach_da_duyet` | Mã chứng từ mẫu khách đã duyệt | Mã UUID | Mã chứng từ mẫu khách đã duyệt liên kết kinh_doanh.mau_khach_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.mau_khach_duyet |
| `ma_ho_so_giao_bu` | Mã hồ sơ giao bù | Mã UUID | Mã hồ sơ giao bù liên kết kinh_doanh.ho_so_xu_ly đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.ho_so_xu_ly |
| `giai_doan_dong` | Giai đoạn dòng thương mại | Phân loại có danh sách đóng | Dòng tư vấn thuộc nhu cầu; dòng báo giá/đơn thuộc chứng từ tương ứng. Chuyển bước tạo bản/dòng mới liên kết gốc, không sửa lịch sử. Giá trị: tu_van; bao_gia; don_hang. | Thông tin nghiệp vụ có căn cứ | — |
| `ma_dong_tu_van_goc` | Mã dòng tư vấn gốc | Mã UUID | Mã dòng tư vấn gốc liên kết kinh_doanh.dong_tu_van_bao_gia_va_don_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin nghiệp vụ có căn cứ | kinh_doanh.dong_tu_van_bao_gia_va_don_hang |

**Ràng buộc:** Tư vấn trỏ nhu cầu, báo giá/đơn trỏ đầu thương mại: đúng một đầu theo giai_doan_dong. Tư vấn chưa bắt nhập giá/tiền/cọc; tính số viên từ diện tích/tham số, khách chốt có căn cứ riêng. Báo giá/đơn giữ lượng/quy cách/giá thỏa thuận theo bản; chuyển bước tạo dòng mới liên kết tư vấn gốc. Tổng giao/bán/thiếu không nhập tay. Điều kiện nguồn Thông số tư vấn: Diện tích, định mức viên/mét vuông và tỷ lệ dự phòng có nguồn khai báo. Số viên ước tính làm tròn lên khi xem; khách xác nhận lượng thì ghi riêng cùng chứng cứ. Phụ kiện là dòng riêng, dự phòng tư vấn không tự tăng định mức vật tư.

**Yêu cầu:** FR07, FR08, FR10, FR11, FR21, FR22, FR27.

### T030 Mẫu khách duyệt

**Tên bảng:** `kinh_doanh.mau_khach_duyet`. **Phụ trách:** Kinh doanh cùng sản xuất/kiểm chất lượng.

**Mục đích:** Mẫu riêng và khách duyệt đúng bản..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.chung_tu |
| `so_luong_mau_rieng` | Số lượng mẫu riêng | Số lượng chính xác | Số lượng mẫu riêng của mẫu khách duyệt, phục vụ mẫu riêng và khách duyệt đúng bản; được ghi bởi kinh doanh cùng sản xuất/kiểm chất lượng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `quyet_dinh_cua_khach` | Quyết định của khách | Phân loại có danh sách đóng | Quyết định của khách của mẫu khách duyệt, phục vụ mẫu riêng và khách duyệt đúng bản; được ghi bởi kinh doanh cùng sản xuất/kiểm chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: cho_xu_ly; da_duyet; da_tu_choi. Giá trị: cho_xu_ly; da_duyet; da_tu_choi. | Sự kiện hoặc quyết định được ghi nhận | — |
| `thoi_diem_quyet_dinh` | Thời điểm quyết định | Thời điểm có múi giờ | Thời điểm quyết định của mẫu khách duyệt, phục vụ mẫu riêng và khách duyệt đúng bản; được ghi bởi kinh doanh cùng sản xuất/kiểm chất lượng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `chung_cu` | Chứng cứ | Văn bản | Chứng cứ của mẫu khách duyệt, phục vụ mẫu riêng và khách duyệt đúng bản; được ghi bởi kinh doanh cùng sản xuất/kiểm chất lượng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_dong_don_hang` | Mã dòng đơn hàng | Mã UUID | Mã dòng đơn hàng liên kết kinh_doanh.dong_tu_van_bao_gia_va_don_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.dong_tu_van_bao_gia_va_don_hang |
| `ma_lenh_san_xuat_mau` | Mã lệnh sản xuất mẫu | Mã UUID | Mã lệnh sản xuất mẫu liên kết san_xuat.lenh_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.lenh_san_xuat |
| `ma_phieu_kiem_chat_luong` | Mã phiếu kiểm chất lượng | Mã UUID | Mã phiếu kiểm chất lượng liên kết chat_luong.phieu_kiem_tra_chat_luong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | chat_luong.phieu_kiem_tra_chat_luong |
| `ma_can_cu_dai_dien_khach` | Mã căn cứ đại diện khách | Mã UUID | Mã căn cứ đại diện khách liên kết dung_chung.can_cu_dai_dien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.can_cu_dai_dien |

**Ràng buộc:** Mẫu tách lệnh/phiếu và lượng bán. Quan hệ quay vòng tạo qua nháp trong giao dịch nguyên tử, bắt buộc đủ FK khi duyệt; duyệt nội bộ không thay khách. Đầu nghiệp vụ dùng cùng ma_dinh_danh với Chứng từ; không có mã đầu/bộ thông tin lập/phiên bản ghi riêng. Các vai trò nghiệp vụ thực vẫn có trường nguồn riêng.

**Yêu cầu:** FR09, FR10.

### T031 Hồ sơ xử lý thương mại và chất lượng

**Tên bảng:** `kinh_doanh.ho_so_xu_ly`. **Phụ trách:** Kinh doanh giữ việc; Quản lý đề nghị / giám đốc duyệt / thực hiện.

**Mục đích:** Lưu theo loại và bản: Đổi/hủy, phản ánh, trả/thu hồi và phương án thương mại.; Phương án lỗi, làm lại, loại bỏ, thu hồi..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.chung_tu |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của hồ sơ thay đổi và xử lý thương mại, phục vụ đổi/hủy, phản ánh, trả/thu hồi và phương án thương mại; được ghi bởi kinh doanh giữ việc theo hồ sơ nguồn của bảng. Giá trị cho phép: thay_doi; huy; tra_hang; khieu_nai; thu_hoi. Giá trị: thay_doi; huy; tra_hang; khieu_nai; thu_hoi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_bi_anh_huong` | Số lượng bị ảnh hưởng | Số lượng chính xác | Số lượng bị ảnh hưởng của hồ sơ thay đổi và xử lý thương mại, phục vụ đổi/hủy, phản ánh, trả/thu hồi và phương án thương mại; được ghi bởi kinh doanh giữ việc theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `phuong_an_xu_ly` | Phương án xử lý | Phân loại có danh sách đóng | Phương án xử lý của hồ sơ thay đổi và xử lý thương mại, phục vụ đổi/hủy, phản ánh, trả/thu hồi và phương án thương mại; được ghi bởi kinh doanh giữ việc theo hồ sơ nguồn của bảng. Giá trị cho phép: cho_xu_ly; giam_ban; hoan_tien; giao_bu; tai_xu_ly; huy; loi. Giá trị: cho_xu_ly; giam_ban; hoan_tien; giao_bu; tai_xu_ly; huy; loi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_da_bat_dau_tai_luc_danh_gia` | Số lượng đã bắt đầu tại lúc đánh giá | Số lượng chính xác | Số lượng đã bắt đầu tại lúc đánh giá của hồ sơ thay đổi và xử lý thương mại, phục vụ đổi/hủy, phản ánh, trả/thu hồi và phương án thương mại; được ghi bởi kinh doanh giữ việc theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `can_cu_khach_xac_nhan` | Căn cứ khách xác nhận | Văn bản | Căn cứ khách xác nhận của hồ sơ thay đổi và xử lý thương mại, phục vụ đổi/hủy, phản ánh, trả/thu hồi và phương án thương mại; được ghi bởi kinh doanh giữ việc theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ghi_chu_giai_quyet_thuong_mai` | Ghi chú giải quyết thương mại | Văn bản | Ghi chú giải quyết thương mại của hồ sơ thay đổi và xử lý thương mại, phục vụ đổi/hủy, phản ánh, trả/thu hồi và phương án thương mại; được ghi bởi kinh doanh giữ việc theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_dong_don_hang_goc` | Mã dòng đơn hàng gốc | Mã UUID | Mã dòng đơn hàng gốc liên kết kinh_doanh.dong_tu_van_bao_gia_va_don_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.dong_tu_van_bao_gia_va_don_hang |
| `ma_dong_don_hang_moi` | Mã dòng đơn hàng mới | Mã UUID | Mã dòng đơn hàng mới liên kết kinh_doanh.dong_tu_van_bao_gia_va_don_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.dong_tu_van_bao_gia_va_don_hang |
| `ma_dong_ghi_ban_goc` | Mã dòng ghi bán gốc | Mã UUID | Mã dòng ghi bán gốc liên kết tai_chinh.dong_ghi_nhan_ban đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.dong_ghi_nhan_ban |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `hanh_dong_xu_ly_chat_luong` | Hành động | Phân loại có danh sách đóng | Hành động của phương án xử lý chất lượng, phục vụ phương án lỗi, làm lại, loại bỏ, thu hồi; được ghi bởi quản lý đề nghị / giám đốc duyệt / thực hiện theo hồ sơ nguồn của bảng. Giá trị cho phép: tai_xu_ly; tieu_huy; tra_nha_cung_cap; thu_hoi; ha_loai. Giá trị: tai_xu_ly; tieu_huy; tra_nha_cung_cap; thu_hoi; ha_loai. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_duoc_duyet_xu_ly` | Số lượng được duyệt xử lý | Số lượng chính xác | Số lượng được duyệt xử lý của phương án xử lý chất lượng, phục vụ phương án lỗi, làm lại, loại bỏ, thu hồi; được ghi bởi quản lý đề nghị / giám đốc duyệt / thực hiện theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ghi_chu_phuong_an_xu_ly` | Ghi chú phương án xử lý | Văn bản | Ghi chú phương án xử lý của phương án xử lý chất lượng, phục vụ phương án lỗi, làm lại, loại bỏ, thu hồi; được ghi bởi quản lý đề nghị / giám đốc duyệt / thực hiện theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_phieu_kiem_chat_luong` | Mã phiếu kiểm chất lượng | Mã UUID | Mã phiếu kiểm chất lượng liên kết chat_luong.phieu_kiem_tra_chat_luong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | chat_luong.phieu_kiem_tra_chat_luong |
| `ma_phan_lo_xu_ly` | Mã phần lô | Mã UUID | Mã phần lô liên kết kho.phan_lo_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.phan_lo_hang |
| `ma_ho_so_lien_quan` | Mã hồ sơ xử lý thương mại | Mã UUID | Mã hồ sơ xử lý thương mại liên kết kinh_doanh.ho_so_xu_ly đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.ho_so_xu_ly |
| `loai_ho_so_xu_ly` | Loại hồ sơ xử lý | Phân loại có danh sách đóng | Phân biệt phương án chất lượng nội bộ với thương mại; một vụ việc có thể có hai hồ sơ liên kết, không dùng duyệt QC thay duyệt tiền. Giá trị: thuong_mai; chat_luong. | Thông tin nghiệp vụ có căn cứ | — |

**Ràng buộc:** Hồ sơ thương mại và chất lượng có loại/quyền/căn cứ khác nhau. Chất lượng dùng phiếu kiểm/phần lô/phương án/lượng được duyệt; thương mại dùng đơn/bán/khách/tiền. Khi một vụ việc cần cả hai tạo hai hồ sơ liên kết ma_ho_so_lien_quan, không dùng một quyết định thay quyết định khác. Các cột tiền/thương mại ẩn và bị chặn đọc với vai chỉ QC; lượng xử lý thực từ vận động/công đoạn, duyệt chưa giảm. Điều kiện nguồn Phương án xử lý chất lượng: Phương án xử lý do kiểm chất lượng đề nghị, có quyết định duyệt theo chứng từ. Lượng thực xử lý lấy từ vận động hàng hoặc công đoạn liên kết đúng phương án; tình trạng thực hiện chỉ tính khi xem. Duyệt tiêu hủy không giảm lượng; thu hồi chưa về không tăng kho. Đầu nghiệp vụ dùng cùng ma_dinh_danh với Chứng từ; không có mã đầu/bộ thông tin lập/phiên bản ghi riêng. Các vai trò nghiệp vụ thực vẫn có trường nguồn riêng.

**Yêu cầu:** FR10, FR18, FR19, FR27.

### T032 Đơn mua hàng

**Tên bảng:** `mua_hang.don_mua_hang`. **Phụ trách:** Mua hàng.

**Mục đích:** Đặt mua theo nhu cầu đã duyệt..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.chung_tu |
| `ma_chung_tu_nha_cung_cap` | Mã chứng từ nhà cung cấp | Văn bản | Mã chứng từ nhà cung cấp của đơn mua hàng, phục vụ đặt mua theo nhu cầu đã duyệt; được ghi bởi mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_cam_ket` | Ngày cam kết | Ngày địa phương | Ngày cam kết của đơn mua hàng, phục vụ đặt mua theo nhu cầu đã duyệt; được ghi bởi mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dieu_kien_thanh_toan` | Điều kiện thanh toán | Văn bản | Điều kiện thanh toán của đơn mua hàng, phục vụ đặt mua theo nhu cầu đã duyệt; được ghi bởi mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ghi_chu_doi_chieu_nguon_cung` | Ghi chú đối chiếu nguồn cung | Văn bản | Ghi chú đối chiếu nguồn cung của đơn mua hàng, phục vụ đặt mua theo nhu cầu đã duyệt; được ghi bởi mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_nha_cung_cap` | Mã nhà cung cấp | Mã UUID | Mã nhà cung cấp liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |

**Ràng buộc:** Không bắt ba báo giá; duyệt đơn mua không có tồn/nợ/tiền; thay giá/lượng tạo bản mới. Đầu nghiệp vụ dùng cùng ma_dinh_danh với Chứng từ; không có mã đầu/bộ thông tin lập/phiên bản ghi riêng. Các vai trò nghiệp vụ thực vẫn có trường nguồn riêng.

**Yêu cầu:** FR14, FR24.

### T033 Dòng đơn mua hàng

**Tên bảng:** `mua_hang.dong_don_mua_hang`. **Phụ trách:** Mua hàng.

**Mục đích:** Lượng đặt, giá và đơn vị mua..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `so_luong_theo_don_vi_nhap` | Số lượng theo đơn vị nhập | Số lượng chính xác | Số lượng theo đơn vị nhập của dòng đơn mua hàng, phục vụ lượng đặt, giá và đơn vị mua; được ghi bởi mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `don_gia_mua` | Đơn giá mua | Số thập phân chính xác | Đơn giá mua của dòng đơn mua hàng, phục vụ lượng đặt, giá và đơn vị mua; được ghi bởi mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien_thoa_thuan` | Số tiền thỏa thuận | Số tiền VND nguyên đồng | Số tiền thỏa thuận của dòng đơn mua hàng, phục vụ lượng đặt, giá và đơn vị mua; được ghi bởi mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_cam_ket` | Ngày cam kết | Ngày địa phương | Ngày cam kết của dòng đơn mua hàng, phục vụ lượng đặt, giá và đơn vị mua; được ghi bởi mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_don_hang` | Mã chứng từ đơn hàng | Mã UUID | Mã chứng từ đơn hàng liên kết mua_hang.don_mua_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | mua_hang.don_mua_hang |
| `ma_mat_hang` | Mã mặt hàng | Mã UUID | Mã mặt hàng liên kết danh_muc.mat_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.mat_hang |
| `ma_don_vi_nhap` | Mã đơn vị nhập | Mã UUID | Mã đơn vị nhập liên kết dung_chung.don_vi_tinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.don_vi_tinh |
| `ma_quy_doi` | Mã quy đổi | Mã UUID | Mã quy đổi liên kết danh_muc.quy_doi_don_vi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.quy_doi_don_vi |

**Ràng buộc:** Lượng đặt nhập theo đơn vị thỏa thuận; lượng cơ sở tính từ đúng hệ số quy đổi đã lưu ở lần ký, không giữ cột tổng cơ sở độc lập. Đối chiếu nhận theo dòng và phiên bản; giá mua không tự thành tiền đã chi.

**Yêu cầu:** FR14, FR15, FR24.

### T034 Lô hàng

**Tên bảng:** `kho.lo_hang`. **Phụ trách:** Kho / sản xuất nguồn tạo.

**Mục đích:** Nhận dạng nguồn vật tư/thành phẩm..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của lô hàng, phục vụ nhận dạng nguồn vật tư/thành phẩm; được ghi bởi kho / sản xuất nguồn tạo theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_lo_nha_cung_cap` | Mã lô nhà cung cấp | Văn bản | Mã lô nhà cung cấp của lô hàng, phục vụ nhận dạng nguồn vật tư/thành phẩm; được ghi bởi kho / sản xuất nguồn tạo theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_san_xuat` | Ngày sản xuất | Ngày địa phương | Ngày sản xuất của lô hàng, phục vụ nhận dạng nguồn vật tư/thành phẩm; được ghi bởi kho / sản xuất nguồn tạo theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_het_han` | Ngày hết hạn | Ngày địa phương | Ngày hết hạn của lô hàng, phục vụ nhận dạng nguồn vật tư/thành phẩm; được ghi bởi kho / sản xuất nguồn tạo theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai_nguon_hinh_thanh_lo` | Loại nguồn hình thành lô | Phân loại có danh sách đóng | Loại nguồn hình thành lô của lô hàng, phục vụ nhận dạng nguồn vật tư/thành phẩm; được ghi bởi kho / sản xuất nguồn tạo theo hồ sơ nguồn của bảng. Giá trị cho phép: dau_ky; mua_hang; san_xuat; chua_ro. Giá trị: dau_ky; mua_hang; san_xuat; chua_ro. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_mat_hang` | Mã mặt hàng | Mã UUID | Mã mặt hàng liên kết danh_muc.mat_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.mat_hang |
| `ma_chung_tu_hinh_thanh_lo` | Mã chứng từ hình thành lô | Mã UUID | Mã chứng từ hình thành lô liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_lo_san_xuat_nguon` | Mã lô sản xuất nguồn | Mã UUID | Mã lô sản xuất nguồn liên kết san_xuat.lo_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.lo_san_xuat |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Duy nhất bộ dữ liệu+ma_nghiep_vu; chưa rõ có nhãn, không bịa nguồn. Lô có nhiều phần/vị trí; hạn có thể trống khi chưa xác định.

**Yêu cầu:** FR01, FR15, FR16, FR19.

### T035 Phần lô hàng

**Tên bảng:** `kho.phan_lo_hang`. **Phụ trách:** Kho, kiểm chất lượng giữ chất lượng.

**Mục đích:** Phần đồng nhất chất lượng/quyền sở hữu của một lô..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `tinh_trang_chat_luong` | Tình trạng chất lượng | Phân loại có danh sách đóng | Tình trạng chất lượng của phần lô hàng, phục vụ phần đồng nhất chất lượng/quyền sở hữu của một lô; được ghi bởi kho, kiểm chất lượng giữ chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: cho_xu_ly; dat; loi. Giá trị: cho_xu_ly; dat; loi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `quyen_so_huu` | Quyền sở hữu | Phân loại có danh sách đóng | Quyền sở hữu của phần lô hàng, phục vụ phần đồng nhất chất lượng/quyền sở hữu của một lô; được ghi bởi kho, kiểm chất lượng giữ chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: doanh_nghiep; ben_khac; chua_ro. Giá trị: doanh_nghiep; ben_khac; chua_ro. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `quy_cach_ky_thuat_ban_luu_tai_thoi_diem` | Quy cách kỹ thuật bản lưu tại thời điểm | Nội dung có cấu trúc đóng | Quy cách kỹ thuật bản lưu tại thời điểm của phần lô hàng, phục vụ phần đồng nhất chất lượng/quyền sở hữu của một lô; được ghi bởi kho, kiểm chất lượng giữ chất lượng theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_lo_hang` | Mã lô hàng | Mã UUID | Mã lô hàng liên kết kho.lo_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.lo_hang |
| `ma_phan_lo_cha` | Mã phần lô cha | Mã UUID | Mã phần lô cha liên kết kho.phan_lo_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.phan_lo_hang |
| `ma_phieu_ket_luan_chat_luong` | Mã phiếu kết luận chất lượng | Mã UUID | Mã phiếu kết luận chất lượng liên kết chat_luong.phieu_kiem_tra_chat_luong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | chat_luong.phieu_kiem_tra_chat_luong |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Không lưu lượng tồn tại đây. Tách phần chỉ bởi vận động cùng giao dịch nguyên tử, không tự sinh lượng. Giữ chất lượng riêng với vị trí/khóa; nhiều khóa cùng phần thì hết mọi khóa mới dùng.

**Yêu cầu:** FR11, FR15, FR17, FR19.

### T036 Dòng vận động hàng

**Tên bảng:** `kho.dong_van_dong_hang`. **Phụ trách:** Kho / xác nhận sản xuất đúng phạm vi; Sản xuất xác nhận.

**Mục đích:** Lưu theo loại và bản: Sổ lượng qua hai đầu trách nhiệm.; Thực dùng/hao hụt theo lô và nguồn cấp..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `so_luong_theo_don_vi_nhap` | Số lượng theo đơn vị nhập | Số lượng chính xác | Số lượng theo đơn vị nhập của dòng vận động hàng, phục vụ sổ lượng qua hai đầu trách nhiệm; được ghi bởi kho / xác nhận sản xuất đúng phạm vi theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_do_theo_don_vi_co_so` | Số lượng đo theo đơn vị cơ sở | Số lượng chính xác | Số đo thực của hàng bằng đơn vị cơ sở trên dòng xác nhận; nếu được quy đổi từ đơn vị nhập phải dẫn đúng bản quy đổi và phép tính, không tự làm tròn mất hàng. | Kết quả đã ghi nhận có căn cứ | — |
| `he_so_quy_doi_tai_lan_ghi_nhan` | Hệ số quy đổi tại lần ghi nhận | Số thập phân chính xác | Hệ số quy đổi tại lần ghi nhận của dòng vận động hàng, phục vụ sổ lượng qua hai đầu trách nhiệm; được ghi bởi kho / xác nhận sản xuất đúng phạm vi theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `ly_do` | Lý do | Văn bản | Lý do của dòng vận động hàng, phục vụ sổ lượng qua hai đầu trách nhiệm; được ghi bởi kho / xác nhận sản xuất đúng phạm vi theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phieu_van_dong_hang` | Mã phiếu vận động hàng | Mã UUID | Mã phiếu vận động hàng liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_phan_lo_nguon` | Mã phần lô nguồn | Mã UUID | Mã phần lô nguồn liên kết kho.phan_lo_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.phan_lo_hang |
| `ma_phan_lo_dich` | Mã phần lô đích | Mã UUID | Mã phần lô đích liên kết kho.phan_lo_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.phan_lo_hang |
| `ma_vi_tri_nguon` | Mã vị trí nguồn | Mã UUID | Mã vị trí nguồn liên kết dung_chung.vi_tri_giu_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.vi_tri_giu_hang |
| `ma_vi_tri_dich` | Mã vị trí đích | Mã UUID | Mã vị trí đích liên kết dung_chung.vi_tri_giu_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.vi_tri_giu_hang |
| `ma_don_vi_nhap` | Mã đơn vị nhập | Mã UUID | Mã đơn vị nhập liên kết dung_chung.don_vi_tinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.don_vi_tinh |
| `ma_quy_doi` | Mã quy đổi | Mã UUID | Mã quy đổi liên kết danh_muc.quy_doi_don_vi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.quy_doi_don_vi |
| `ma_dong_nghiep_vu_goc` | Mã dòng nghiệp vụ gốc | Mã UUID | Mã dòng nghiệp vụ gốc liên kết kho.dong_van_dong_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.dong_van_dong_hang |
| `ma_yeu_cau_hang` | Mã yêu cầu hàng | Mã UUID | Mã yêu cầu hàng liên kết kho.yeu_cau_hang_va_vat_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.yeu_cau_hang_va_vat_tu |
| `ma_chung_tu_phuong_an_xu_ly` | Mã chứng từ phương án xử lý | Mã UUID | Mã chứng từ phương án xử lý liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `loai_thuc_dung_vat_tu` | Loại | Phân loại có danh sách đóng | Loại của vật tư thực dùng, phục vụ thực dùng/hao hụt theo lô và nguồn cấp; được ghi bởi sản xuất xác nhận theo hồ sơ nguồn của bảng. Giá trị cho phép: thuc_dung; hao_hut_san_xuat. Giá trị: thuc_dung; hao_hut_san_xuat. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_chung_tu_cong_doan` | Mã chứng từ công đoạn | Mã UUID | Mã chứng từ công đoạn liên kết san_xuat.cong_doan_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.cong_doan_san_xuat |
| `ma_dong_cap_vat_tu_nguon` | Mã dòng cấp vật tư nguồn | Mã UUID | Mã dòng cấp vật tư nguồn liên kết kho.dong_van_dong_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.dong_van_dong_hang |

**Ràng buộc:** Lượng qua hai đầu trách nhiệm, chỉ ghi sổ khi nguồn đủ và xác nhận thực. Thực dùng/hao hụt là dòng vận động có công đoạn và dòng cấp gốc, không có bản lượng vật tư thực dùng thứ hai. Cấp=dùng+hao hụt+hoàn+còn tại xưởng. Chuyển đủ hai đầu; nhập ngoài/tiêu dùng/xuất ngoài có hình thái riêng; không âm/khóa/sai đơn vị/nguồn. Đảo nguồn kiểm phụ thuộc. Điều kiện nguồn Vật tư thực dùng: Một thực dùng vận động chỉ gắn một dùng phép. Cấp=đã dùng+hao hụt+đã hoàn+còn tại xưởng; dùng phép không sinh xuất lần hai. Hoàn theo phiếu kho, không thêm bản hoàn độc lập.

**Yêu cầu:** FR01, FR05, FR06, FR13, FR15, FR16, FR18, FR20, FR21, FR26, FR27.

### T037 Yêu cầu hàng và vật tư

**Tên bảng:** `kho.yeu_cau_hang_va_vat_tu`. **Phụ trách:** Kinh doanh / sản xuất lập; kho đối chiếu.

**Mục đích:** Nhu cầu hàng/vật tư không tự mất khi khóa lô..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `muc_dich` | Mục đích | Phân loại có danh sách đóng | Mục đích của yêu cầu hàng và vật tư, phục vụ nhu cầu hàng/vật tư không tự mất khi khóa lô; được ghi bởi kinh doanh / sản xuất lập; kho đối chiếu theo hồ sơ nguồn của bảng. Giá trị cho phép: ghi_ban; san_xuat; nhu_cau_tuong_lai_da_duyet; giao_bu. Giá trị: ghi_ban; san_xuat; nhu_cau_tuong_lai_da_duyet; giao_bu. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_can_theo_yeu_cau` | Số lượng cần theo yêu cầu | Số lượng chính xác | Lượng được người giữ nguồn yêu cầu, có dòng đơn/lệnh hoặc nhu cầu tương lai đã duyệt; không cài một nguồn giả chỉ để làm phép tính thiếu. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_can_dap_ung` | Ngày cần đáp ứng | Ngày địa phương | Ngày cần đáp ứng của yêu cầu hàng và vật tư, phục vụ nhu cầu hàng/vật tư không tự mất khi khóa lô; được ghi bởi kinh doanh / sản xuất lập; kho đối chiếu theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: dang_mo; da_chot; da_huy. Giá trị: dang_mo; da_chot; da_huy. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_dong_nguon_nghiep_vu` | Mã dòng nguồn nghiệp vụ | Mã UUID | Mã dòng nguồn nghiệp vụ liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.dong_chung_tu |
| `ma_mat_hang` | Mã mặt hàng | Mã UUID | Mã mặt hàng liên kết danh_muc.mat_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.mat_hang |
| `ma_don_vi` | Mã đơn vị | Mã UUID | Mã đơn vị liên kết dung_chung.don_vi_tinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.don_vi_tinh |
| `ma_yeu_cau_hang_bi_thay` | Mã yêu cầu hàng bị thay | Mã UUID | Mã yêu cầu hàng bị thay liên kết kho.yeu_cau_hang_va_vat_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.yeu_cau_hang_va_vat_tu |

**Ràng buộc:** Mỗi yêu cầu phải trỏ chứng từ và dòng nguồn đúng bản. Nhu cầu mua tương lai cần chứng từ riêng được duyệt; mã OTHER-001 trong bộ kiểm cũ chưa kèm hồ sơ duyệt đầy đủ nên không được nạp như nhu cầu hợp lệ. Đổi yêu cầu có bản thay; không xóa sự kiện giữ hay giao cũ.

**Yêu cầu:** FR11, FR12, FR14, FR16, FR20.

### T038 Sự kiện giữ, khóa và hàng đang về

**Tên bảng:** `kho.su_kien_giu_khoa_va_dang_ve`. **Phụ trách:** Mua hàng / kho; Kho; Chất lượng.

**Mục đích:** Lưu theo loại và bản: Dành phần đang về cho đúng nhu cầu.; Lịch sử giữ, dùng, giải phóng và mất hiệu lực.; Lịch sử khóa và giải phóng phần lô..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `so_luong_do_theo_don_vi_co_so` | Số lượng đo theo đơn vị cơ sở | Số lượng chính xác | Số đo thực của hàng bằng đơn vị cơ sở trên dòng xác nhận; nếu được quy đổi từ đơn vị nhập phải dẫn đúng bản quy đổi và phép tính, không tự làm tròn mất hàng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_co_hieu_luc` | Thời điểm có hiệu lực | Thời điểm có múi giờ | Thời điểm người có thẩm quyền quy định nội dung bắt đầu áp dụng, tách với thời điểm hệ thống ghi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_hieu_luc` | Thời điểm kết thúc hiệu lực | Thời điểm có múi giờ | Thời điểm kết thúc hiệu lực của phân bổ hàng đang về, phục vụ dành phần đang về cho đúng nhu cầu; được ghi bởi mua hàng / kho theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_dong_don_mua` | Mã dòng đơn mua | Mã UUID | Mã dòng đơn mua liên kết mua_hang.dong_don_mua_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | mua_hang.dong_don_mua_hang |
| `ma_yeu_cau_hang` | Mã yêu cầu hàng | Mã UUID | Mã yêu cầu hàng liên kết kho.yeu_cau_hang_va_vat_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.yeu_cau_hang_va_vat_tu |
| `ma_su_kien_dang_ve_bi_thay` | Mã bản phân bổ hàng về bị thay | Mã UUID | Mã bản phân bổ hàng về bị thay liên kết kho.su_kien_giu_khoa_va_dang_ve đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.su_kien_giu_khoa_va_dang_ve |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |
| `loai` | Loại sự kiện hàng | Phân loại có danh sách đóng | Sự kiện giữ/khóa nguồn hàng có phạm vi và người có quyền; đang về tách hoàn toàn khỏi tồn/khả dụng. Giá trị: giu_ton; dung_giu; giai_phong_giu; mat_hieu_luc_giu; khoa_chat_luong; giai_phong_khoa; giu_dang_ve; giai_phong_dang_ve. | Thông tin nghiệp vụ có căn cứ | — |
| `thoi_diem_thuc_hien_nghiep_vu` | Thời điểm thực hiện nghiệp vụ | Thời điểm có múi giờ | Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ly_do` | Lý do | Văn bản | Lý do của sự kiện giữ hàng, phục vụ lịch sử giữ, dùng, giải phóng và mất hiệu lực; được ghi bởi kho theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_phan_lo` | Mã phần lô | Mã UUID | Mã phần lô liên kết kho.phan_lo_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.phan_lo_hang |
| `ma_vi_tri` | Mã vị trí | Mã UUID | Mã vị trí liên kết dung_chung.vi_tri_giu_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.vi_tri_giu_hang |
| `ma_su_kien_goc` | Mã sự kiện giữ gốc | Mã UUID | Mã sự kiện giữ gốc liên kết kho.su_kien_giu_khoa_va_dang_ve đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.su_kien_giu_khoa_va_dang_ve |
| `ma_dong_van_dong_hang` | Mã dòng vận động hàng | Mã UUID | Mã dòng vận động hàng liên kết kho.dong_van_dong_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.dong_van_dong_hang |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |
| `ma_phieu_kiem_chat_luong` | Mã phiếu kiểm chất lượng | Mã UUID | Mã phiếu kiểm chất lượng liên kết chat_luong.phieu_kiem_tra_chat_luong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | chat_luong.phieu_kiem_tra_chat_luong |
| `ma_chung_tu_phuong_an_xu_ly` | Mã chứng từ phương án xử lý | Mã UUID | Mã chứng từ phương án xử lý liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_nhan_vien_thuc_hien` | Mã nhân viên thực hiện | Mã UUID | Mã nhân viên thực hiện liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |

**Ràng buộc:** Giữ tồn cần yêu cầu/phần lô/vị trí/lượng; dùng/giải phóng/mất hiệu lực nối sự kiện giữ gốc. Khóa chất lượng cần phần lô/căn cứ QC/người có quyền; bỏ khóa nối khóa gốc, không dùng quyền kho để bỏ khóa. Khóa một phần phải chia phần trước; nhiều khóa không nhân lượng bị khóa, chỉ dùng sau hết mọi khóa. Giữ đang về cần dòng mua/yêu cầu/lượng, không có phần lô thực và không cộng tồn. Ba loại nguồn có điều kiện và quyền riêng; không được tự giữ từ số thiếu hoặc tự coi QC đạt. Xác nhận khóa và mất hiệu lực giữ cùng giao dịch. Điều kiện nguồn Phân bổ hàng đang về: Dành hàng đang về không vượt phần còn của đơn mua và nhu cầu có căn cứ. Mốc bắt đầu/kết thúc do người phụ trách xác nhận; phần hoàn tất tính từ phiếu nhận liên quan, không nạp trạng thái đã đáp ứng. Điều kiện nguồn Sự kiện khóa chất lượng: Khóa toàn portion; khóa một phần phải split lượng trước. giải phóng trỏ khóa gốc và cần kiểm chất lượng đủ điều kiện; còn khóa khác vẫn khóa. Khóa không giảm tồn nhưng mất hiệu lực giữ giữ hợp lệ.

**Yêu cầu:** FR05, FR11, FR14, FR17, FR19, FR20, FR21.

### T039 Dòng kiểm kê

**Tên bảng:** `kho.dong_kiem_ke`. **Phụ trách:** Kho.

**Mục đích:** Đếm thực theo lô/vị trí/điều kiện..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `so_luong_dem_thuc` | Số lượng đếm thực | Số lượng chính xác | Số lượng đếm thực của dòng kiểm kê, phục vụ đếm thực theo lô/vị trí/điều kiện; được ghi bởi kho theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_so_tai_moc_kiem_ke` | Số lượng sổ tại mốc kiểm kê | Số lượng chính xác | Ảnh chụp số sổ dựng từ các vận động đã xác nhận tới mốc/thu_tu kiểm kê; chỉ đối chiếu với đếm thực, không là đầu vào mới cho tồn. | Kết quả đã ghi nhận có căn cứ | — |
| `ly_do` | Lý do | Văn bản | Lý do của dòng kiểm kê, phục vụ đếm thực theo lô/vị trí/điều kiện; được ghi bởi kho theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_bien_ban_kiem_ke` | Mã biên bản kiểm kê | Mã UUID | Mã biên bản kiểm kê liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_phan_lo` | Mã phần lô | Mã UUID | Mã phần lô liên kết kho.phan_lo_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.phan_lo_hang |
| `ma_vi_tri` | Mã vị trí | Mã UUID | Mã vị trí liên kết dung_chung.vi_tri_giu_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.vi_tri_giu_hang |
| `ma_dong_dieu_chinh` | Mã dòng điều chỉnh | Mã UUID | Mã dòng điều chỉnh liên kết kho.dong_van_dong_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.dong_van_dong_hang |

**Ràng buộc:** Book bản lưu tại mốc có cutoff/thu_tu, chênh tính ra; điều chỉnh có nguồn, không sửa book để khớp.

**Yêu cầu:** FR20.

### T040 Phiên bản định mức sản xuất

**Tên bảng:** `san_xuat.phien_ban_dinh_muc_san_xuat`. **Phụ trách:** Sản xuất.

**Mục đích:** Một phiên bản định mức/công đoạn..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.chung_tu |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của phiên bản định mức sản xuất, phục vụ một phiên bản định mức/công đoạn; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_phien_ban` | Số phiên bản | Số nguyên | Số phiên bản của phiên bản định mức sản xuất, phục vụ một phiên bản định mức/công đoạn; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_chuan_lam_can_cu_dinh_muc` | Số lượng chuẩn làm căn cứ định mức | Số lượng chính xác | Số lượng chuẩn làm căn cứ định mức của phiên bản định mức sản xuất, phục vụ một phiên bản định mức/công đoạn; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ty_le_dat_du_kien` | Tỷ lệ đạt dự kiến | Tỷ lệ từ 0 đến 1 | Tỷ lệ dự kiến do sản xuất khai báo trong bản định mức được duyệt; dùng lập kế hoạch, tuyệt đối không sinh kết quả kiểm chất lượng thực tế. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_hieu_luc` | Thời điểm bắt đầu hiệu lực | Ngày địa phương | Thời điểm bắt đầu hiệu lực của phiên bản định mức sản xuất, phục vụ một phiên bản định mức/công đoạn; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_hieu_luc` | Thời điểm kết thúc hiệu lực | Ngày địa phương | Thời điểm kết thúc hiệu lực của phiên bản định mức sản xuất, phục vụ một phiên bản định mức/công đoạn; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_mat_hang_dau_ra` | Mã mặt hàng đầu ra | Mã UUID | Mã mặt hàng đầu ra liên kết danh_muc.mat_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.mat_hang |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |

**Ràng buộc:** Bản đã dùng bất biến, tỷ lệ chỉ kế hoạch; cùng mã không chồng hiệu lực. Đầu nghiệp vụ dùng cùng ma_dinh_danh với Chứng từ; không có mã đầu/bộ thông tin lập/phiên bản ghi riêng. Các vai trò nghiệp vụ thực vẫn có trường nguồn riêng.

**Yêu cầu:** FR12, FR13, FR16.

### T041 Dòng định mức vật tư

**Tên bảng:** `san_xuat.dong_dinh_muc_vat_tu`. **Phụ trách:** Sản xuất.

**Mục đích:** Vật tư và công đoạn tiêu dùng theo định mức sản xuất..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `luong_vat_tu_theo_dinh_muc` | Lượng vật tư theo định mức | Số lượng chính xác | Lượng vật tư theo định mức của dòng định mức vật tư, phục vụ vật tư và công đoạn tiêu dùng theo bom; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_cong_doan` | Mã công đoạn | Văn bản | Mã công đoạn của dòng định mức vật tư, phục vụ vật tư và công đoạn tiêu dùng theo bom; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thu_tu` | Thứ tự | Số nguyên | Thứ tự của dòng định mức vật tư, phục vụ vật tư và công đoạn tiêu dùng theo bom; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_dinh_muc` | Mã chứng từ định mức | Mã UUID | Mã chứng từ định mức liên kết san_xuat.phien_ban_dinh_muc_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.phien_ban_dinh_muc_san_xuat |
| `ma_mat_hang` | Mã mặt hàng | Mã UUID | Mã mặt hàng liên kết danh_muc.mat_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.mat_hang |
| `ma_don_vi` | Mã đơn vị | Mã UUID | Mã đơn vị liên kết dung_chung.don_vi_tinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.don_vi_tinh |

**Ràng buộc:** Qty>0, đúng dai_luong, không cộng dự phòng hai lần.

**Yêu cầu:** FR12, FR16.

### T042 Nguồn lực sản xuất

**Tên bảng:** `san_xuat.nguon_luc_san_xuat`. **Phụ trách:** Sản xuất.

**Mục đích:** Nguồn tạo hình/hoàn thiện/chỗ dưỡng hộ..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của nguồn lực sản xuất, phục vụ nguồn tạo hình/hoàn thiện/chỗ dưỡng hộ; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của nguồn lực sản xuất, phục vụ nguồn tạo hình/hoàn thiện/chỗ dưỡng hộ; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. Giá trị cho phép: may; vi_tri_thao_tac; cho_duong_ho. Giá trị: may; vi_tri_thao_tac; cho_duong_ho. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `suc_chua_theo_luong` | Sức chứa theo lượng | Số lượng chính xác | Sức chứa theo lượng của nguồn lực sản xuất, phục vụ nguồn tạo hình/hoàn thiện/chỗ dưỡng hộ; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `nang_luc_thoi_gian_tinh_theo_phut` | Năng lực thời gian tính theo phút | Số nguyên | Năng lực thời gian tính theo phút của nguồn lực sản xuất, phục vụ nguồn tạo hình/hoàn thiện/chỗ dưỡng hộ; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ky_nang_bat_buoc` | Kỹ năng bắt buộc | Văn bản | Kỹ năng bắt buộc của nguồn lực sản xuất, phục vụ nguồn tạo hình/hoàn thiện/chỗ dưỡng hộ; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_vi_tri` | Mã vị trí | Mã UUID | Mã vị trí liên kết dung_chung.vi_tri_giu_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.vi_tri_giu_hang |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Một xưởng, nhiều nguồn; chỗ dưỡng hộ 8.000 là giới hạn lượng, khác giờ máy.

**Yêu cầu:** FR12, FR13.

### T043 Lệnh sản xuất

**Tên bảng:** `san_xuat.lenh_san_xuat`. **Phụ trách:** Quản lý sản xuất.

**Mục đích:** Lệnh theo đơn/làm sẵn/mẫu/làm lại..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.chung_tu |
| `muc_dich` | Mục đích | Phân loại có danh sách đóng | Mục đích của lệnh sản xuất, phục vụ lệnh theo đơn/làm sẵn/mẫu/làm lại; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng. Giá trị cho phép: theo_don_khach; lam_san; mau; tai_xu_ly. Giá trị: theo_don_khach; lam_san; mau; tai_xu_ly. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_dat_can_dap_ung` | Số lượng đạt cần đáp ứng | Số lượng chính xác | Lượng đạt người đề nghị muốn đáp ứng; lưu ý nhu cầu khai báo khác phần thiếu được tính từ tồn và giữ tại mốc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_bat_dau_du_kien` | Số lượng bắt đầu dự kiến | Số lượng chính xác | Số lượng bắt đầu do người lập kế hoạch đề nghị trong bản lệnh/lô; có căn cứ đơn hoặc quyết định làm sẵn, không tự lấy ngưỡng tồn ép thành lệnh. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_cam_ket` | Ngày cam kết | Ngày địa phương | Ngày cam kết của lệnh sản xuất, phục vụ lệnh theo đơn/làm sẵn/mẫu/làm lại; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `uu_tien` | Ưu tiên | Số nguyên | Mức ưu tiên được quản lý và giám đốc quyết định có lý do/căn cứ; thứ tự tính từ ngày giao chỉ là đề xuất hiển thị, không tự ghi quyết định. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ly_do_quyet_dinh_uu_tien` | Lý do quyết định ưu tiên | Văn bản | Lý do quyết định ưu tiên của lệnh sản xuất, phục vụ lệnh theo đơn/làm sẵn/mẫu/làm lại; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_dinh_muc` | Mã chứng từ định mức | Mã UUID | Mã chứng từ định mức liên kết san_xuat.phien_ban_dinh_muc_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.phien_ban_dinh_muc_san_xuat |
| `ma_dong_don_hang_nguon` | Mã dòng đơn hàng nguồn | Mã UUID | Mã dòng đơn hàng nguồn liên kết kinh_doanh.dong_tu_van_bao_gia_va_don_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.dong_tu_van_bao_gia_va_don_hang |
| `ma_ho_so_xu_ly_nguon` | Mã hồ sơ xử lý nguồn | Mã UUID | Mã hồ sơ xử lý nguồn liên kết kinh_doanh.ho_so_xu_ly đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.ho_so_xu_ly |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `ma_chung_tu_quyet_dinh_chot_lenh` | Mã chứng từ quyết định chốt lệnh | Mã UUID | Mã chứng từ quyết định chốt lệnh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |

**Ràng buộc:** Làm sẵn có quyết định sản xuất riêng, không tạo đơn khách giả. Ưu tiên cần người quyết định và lý do. Mẫu/cọc/vật tư đủ trước thực hiện. Tiến độ tính từ công đoạn/kiểm chất lượng; chốt lệnh có chứng từ quyết định riêng sau đối chiếu dở dang/lỗi/chi phí. Đầu nghiệp vụ dùng cùng ma_dinh_danh với Chứng từ; không có mã đầu/bộ thông tin lập/phiên bản ghi riêng. Các vai trò nghiệp vụ thực vẫn có trường nguồn riêng.

**Yêu cầu:** FR09, FR10, FR12, FR13, FR18.

### T044 Lô sản xuất

**Tên bảng:** `san_xuat.lo_san_xuat`. **Phụ trách:** Sản xuất.

**Mục đích:** Một lô thực hiện của lệnh..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của lô sản xuất, phục vụ một lô thực hiện của lệnh; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_bat_dau_du_kien` | Số lượng bắt đầu dự kiến | Số lượng chính xác | Số lượng bắt đầu do người lập kế hoạch đề nghị trong bản lệnh/lô; có căn cứ đơn hoặc quyết định làm sẵn, không tự lấy ngưỡng tồn ép thành lệnh. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_lenh_san_xuat` | Mã lệnh sản xuất | Mã UUID | Mã lệnh sản xuất liên kết san_xuat.lenh_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.lenh_san_xuat |
| `ma_lo_thanh_pham_dau_ra` | Mã lô thành phẩm đầu ra | Mã UUID | Mã lô thành phẩm đầu ra liên kết kho.lo_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.lo_hang |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Kế hoạch là khai báo dự kiến; thực bắt đầu/hoàn thành lấy từ công đoạn, lượng đạt/lỗi lấy từ kiểm chất lượng. Tiến độ tính từ những sự kiện này, không nhập cột trạng thái lô tổng hợp. Lô thành phẩm liên kết đúng lô sản xuất.

**Yêu cầu:** FR12, FR13, FR17, FR19.

### T045 Công đoạn sản xuất

**Tên bảng:** `san_xuat.cong_doan_san_xuat`. **Phụ trách:** Sản xuất.

**Mục đích:** Công đoạn, thời điểm và sản lượng thực..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.chung_tu |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của công đoạn sản xuất, phục vụ công đoạn, thời điểm và sản lượng thực; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thu_tu` | Thứ tự | Số nguyên | Thứ tự của công đoạn sản xuất, phục vụ công đoạn, thời điểm và sản lượng thực; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_du_kien` | Thời điểm bắt đầu dự kiến | Thời điểm có múi giờ | Thời điểm bắt đầu dự kiến của công đoạn sản xuất, phục vụ công đoạn, thời điểm và sản lượng thực; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_du_kien` | Thời điểm kết thúc dự kiến | Thời điểm có múi giờ | Thời điểm kết thúc dự kiến của công đoạn sản xuất, phục vụ công đoạn, thời điểm và sản lượng thực; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_thuc_te` | Thời điểm bắt đầu thực tế | Thời điểm có múi giờ | Thời điểm bắt đầu thực tế của công đoạn sản xuất, phục vụ công đoạn, thời điểm và sản lượng thực; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_thuc_te` | Thời điểm kết thúc thực tế | Thời điểm có múi giờ | Thời điểm kết thúc thực tế của công đoạn sản xuất, phục vụ công đoạn, thời điểm và sản lượng thực; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_thuc_bat_dau` | Số lượng thực bắt đầu | Số lượng chính xác | Lượng thực đã bắt đầu công đoạn, có thời điểm và xác nhận nguồn. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_thuc_hoan_thanh` | Số lượng thực hoàn thành | Số lượng chính xác | Lượng hoàn thành thực được tổ trưởng ghi và người quản lý xác nhận; không lấy lượng kế hoạch làm thực tế. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_thuc_hien` | Trạng thái thực hiện | Phân loại có danh sách đóng | Trạng thái của sự kiện do người phụ trách xác nhận; không tự nạp đã hoàn tất. Trạng thái tổng hợp từ nhiều sự kiện chỉ tính khi xem. Giá trị cho phép: du_kien; dang_thuc_hien; dang_cho; hoan_thanh. Giá trị: du_kien; dang_thuc_hien; dang_cho; hoan_thanh. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ly_do` | Lý do | Văn bản | Lý do của công đoạn sản xuất, phục vụ công đoạn, thời điểm và sản lượng thực; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_lo_san_xuat` | Mã lô sản xuất | Mã UUID | Mã lô sản xuất liên kết san_xuat.lo_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.lo_san_xuat |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |

**Ràng buộc:** Bắt đầu/kết thúc và lượng thực có người ghi/xác nhận. Phần chưa hoàn thành tính từ thực bắt đầu trừ thực hoàn thành. Trạng thái thao tác cần mốc/lý do; không tự coi lượng kế hoạch là thực tế. Thời gian chờ sản phẩm không sinh công người. Đầu nghiệp vụ dùng cùng ma_dinh_danh với Chứng từ; không có mã đầu/bộ thông tin lập/phiên bản ghi riêng. Các vai trò nghiệp vụ thực vẫn có trường nguồn riêng.

**Yêu cầu:** FR12, FR13, FR17.

### T046 Lịch người và nguồn lực

**Tên bảng:** `san_xuat.lich_nguoi_va_nguon_luc`. **Phụ trách:** Quản lý sản xuất; Quản lý / nhân sự kiểm.

**Mục đích:** Lưu theo loại và bản: Lịch nguồn lực và giờ máy thực.; Phân công dự kiến từng người..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của lịch và sử dụng nguồn lực, phục vụ lịch nguồn lực và giờ máy thực; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng. Giá trị cho phép: du_kien; thuc_te. Giá trị: du_kien; thuc_te. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_khoang` | Thời điểm bắt đầu khoảng | Thời điểm có múi giờ | Thời điểm bắt đầu khoảng của lịch và sử dụng nguồn lực, phục vụ lịch nguồn lực và giờ máy thực; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_khoang` | Thời điểm kết thúc khoảng | Thời điểm có múi giờ | Thời điểm kết thúc khoảng của lịch và sử dụng nguồn lực, phục vụ lịch nguồn lực và giờ máy thực; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_chiem_cho` | Số lượng chiếm chỗ | Số lượng chính xác | Số lượng chiếm chỗ của lịch và sử dụng nguồn lực, phục vụ lịch nguồn lực và giờ máy thực; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: dang_su_dung; da_huy. Giá trị: dang_su_dung; da_huy; du_kien. | Sự kiện hoặc quyết định được ghi nhận | — |
| `muc_dich` | Mục đích | Phân loại có danh sách đóng | Mục đích của lịch và sử dụng nguồn lực, phục vụ lịch nguồn lực và giờ máy thực; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng. Giá trị cho phép: tao_hinh; hoan_thien; duong_ho; chuan_bi_may; bao_tri. Giá trị: tao_hinh; hoan_thien; duong_ho; chuan_bi_may; bao_tri; lam_viec; dao_tao; khac_co_ly_do. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_nguon_luc` | Mã nguồn lực | Mã UUID | Mã nguồn lực liên kết san_xuat.nguon_luc_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.nguon_luc_san_xuat |
| `ma_chung_tu_cong_doan` | Mã chứng từ công đoạn | Mã UUID | Mã chứng từ công đoạn liên kết san_xuat.cong_doan_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.cong_doan_san_xuat |
| `ma_lich_bi_thay` | Mã lịch nguồn lực bị thay | Mã UUID | Mã lịch nguồn lực bị thay liên kết san_xuat.lich_nguoi_va_nguon_luc đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.lich_nguoi_va_nguon_luc |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Mã phiên bản chứng từ liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_nhan_vien` | Mã nhân viên | Mã UUID | Mã nhân viên liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_ngay_va_ca_lam_viec` | Mã ngày và ca làm việc | Mã UUID | Mã ngày và ca làm việc liên kết nhan_su.ngay_va_ca_lam_viec đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.ngay_va_ca_lam_viec |
| `doi_tuong_lich` | Đối tượng lịch | Phân loại có danh sách đóng | Một dòng lịch thuộc máy/chỗ giữ hoặc người; thực công của người lưu ở khoảng công, không sao giờ thành công. Giá trị: nguon_luc; nhan_vien. | Thông tin nghiệp vụ có căn cứ | — |

**Ràng buộc:** Một dòng có đúng đối tượng nguồn lực hoặc nhân viên. Máy/chỗ giữ dùng ma_nguon_luc và lượng chiếm chỗ/phút thực; người dùng ma_nhan_vien/ngày-ca, chỉ lịch dự kiến. Công người thực nằm ở khoảng công; không nhân giờ người thành giờ máy. Kiểm chồng giờ/nghỉ/kỹ năng/hiệu lực và tổng sức chứa. Bản sửa nối lịch gốc. Điều kiện nguồn Phân công dự kiến: Operation có thể trống nếu không SX; không trùng người/nghỉ; đủ qualification và người dang_su_dung; dự kiến không làm công thực.

**Yêu cầu:** FR12, FR13, FR26, FR28, FR29, FR30.

### T047 Phiếu kiểm tra chất lượng

**Tên bảng:** `chat_luong.phieu_kiem_tra_chat_luong`. **Phụ trách:** Chất lượng.

**Mục đích:** Hồ sơ kiểm tra đúng nguồn/phạm vi..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.chung_tu |
| `loai_kiem_tra_chat_luong` | Loại kiểm tra chất lượng | Phân loại có danh sách đóng | Loại kiểm tra chất lượng của phiếu kiểm tra chất lượng, phục vụ hồ sơ kiểm tra đúng nguồn/phạm vi; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: dau_vao; trong_san_xuat; thanh_pham; mau; tra_hang; xuat_giao. Giá trị: dau_vao; trong_san_xuat; thanh_pham; mau; tra_hang; xuat_giao. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_thuc_kiem` | Số lượng thực kiểm | Số lượng chính xác | Lượng đã được thực kiểm hoặc đối chiếu theo phạm vi và phương pháp trong hồ sơ kiểm chất lượng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_ket_luan_dat` | Số lượng kết luận đạt | Số lượng chính xác | Lượng người kiểm tra kết luận đạt trong phạm vi kiểm có căn cứ; không sinh từ tỷ lệ lỗi dự kiến. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_ket_luan_loi` | Số lượng kết luận lỗi | Số lượng chính xác | Lượng được người kiểm tra xác nhận lỗi; nguyên nhân lỗi có thể chồng loại, không cộng các loại lỗi thành lượng mới. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_cho_ket_luan` | Số lượng chờ kết luận | Số lượng chính xác | Lượng người kiểm tra chưa đủ căn cứ kết luận trong phạm vi kiểm; không suy từ kế hoạch thành một kết quả kiểm. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `pham_vi_kiem` | Phạm vi kiểm | Phân loại có danh sách đóng | Phạm vi kiểm của phiếu kiểm tra chất lượng, phục vụ hồ sơ kiểm tra đúng nguồn/phạm vi; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: toan_bo; mau. Giá trị: toan_bo; mau. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `tinh_trang_xac_nhan_ket_luan` | Tình trạng xác nhận kết luận | Phân loại có danh sách đóng | Tình trạng xác nhận kết luận của phiếu kiểm tra chất lượng, phục vụ hồ sơ kiểm tra đúng nguồn/phạm vi; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: cho_xu_ly; da_xac_nhan. Giá trị: cho_xu_ly; da_xac_nhan. | Sự kiện hoặc quyết định được ghi nhận | — |
| `thoi_diem_xac_nhan_ket_luan` | Thời điểm xác nhận kết luận | Thời điểm có múi giờ | Thời điểm xác nhận kết luận của phiếu kiểm tra chất lượng, phục vụ hồ sơ kiểm tra đúng nguồn/phạm vi; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_dong_nguon_nghiep_vu` | Mã dòng nguồn nghiệp vụ | Mã UUID | Mã dòng nguồn nghiệp vụ liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.dong_chung_tu |
| `ma_lo_hang` | Mã lô hàng | Mã UUID | Mã lô hàng liên kết kho.lo_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.lo_hang |
| `ma_phien_ban_bo_tieu_chi` | Mã phiên bản bộ tiêu chí | Mã UUID | Mã phiên bản bộ tiêu chí liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `ma_chung_tu_mau` | Mã chứng từ mẫu | Mã UUID | Mã chứng từ mẫu liên kết kinh_doanh.mau_khach_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.mau_khach_duyet |
| `ma_nhan_vien_kiem_chat_luong` | Mã nhân viên kiểm chất lượng | Mã UUID | Mã nhân viên kiểm chất lượng liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |

**Ràng buộc:** Good+lỗi+chờ xử lý đối chiếu nguồn và phạm vi; mẫu chưa có luật không suy rộng. Không ghi đạt từ ty_le_dat_du_kien. Phân phần kho đồng thời qua kho vận động. Các chi tiết thuộc bảng con, tự nối đúng bản cha trong cùng biểu mẫu; không bắt tạo một công việc/phiếu riêng cho mỗi dòng. Đầu nghiệp vụ dùng cùng ma_dinh_danh với Chứng từ; không có mã đầu/bộ thông tin lập/phiên bản ghi riêng. Các vai trò nghiệp vụ thực vẫn có trường nguồn riêng.

**Yêu cầu:** FR09, FR15, FR17, FR27.

### T048 Kết quả từng tiêu chí kiểm tra

**Tên bảng:** `chat_luong.ket_qua_tung_tieu_chi_kiem_tra`. **Phụ trách:** Chất lượng.

**Mục đích:** Số đo/ngoại quan và lỗi theo tiêu chí..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_tieu_chi_kiem` | Mã tiêu chí kiểm | Văn bản | Mã tiêu chí kiểm của kết quả từng tiêu chí kiểm tra, phục vụ số đo/ngoại quan và lỗi theo tiêu chí; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `gia_tri_do_thuc` | Giá trị đo thực | Số thập phân chính xác | Giá trị đo thực của kết quả từng tiêu chí kiểm tra, phục vụ số đo/ngoại quan và lỗi theo tiêu chí; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_don_vi_do` | Mã đơn vị đo | Văn bản | Mã đơn vị đo của kết quả từng tiêu chí kiểm tra, phục vụ số đo/ngoại quan và lỗi theo tiêu chí; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `noi_dung_quan_sat_thuc` | Nội dung quan sát thực | Văn bản | Nội dung quan sát thực của kết quả từng tiêu chí kiểm tra, phục vụ số đo/ngoại quan và lỗi theo tiêu chí; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ket_qua` | Kết quả | Phân loại có danh sách đóng | Kết quả của kết quả từng tiêu chí kiểm tra, phục vụ số đo/ngoại quan và lỗi theo tiêu chí; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: dat; khong_dat; cho_xu_ly. Giá trị: dat; khong_dat; cho_xu_ly. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_bi_anh_huong` | Số lượng bị ảnh hưởng | Số lượng chính xác | Số lượng bị ảnh hưởng của kết quả từng tiêu chí kiểm tra, phục vụ số đo/ngoại quan và lỗi theo tiêu chí; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phieu_kiem_chat_luong` | Mã phiếu kiểm chất lượng | Mã UUID | Mã phiếu kiểm chất lượng liên kết chat_luong.phieu_kiem_tra_chat_luong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | chat_luong.phieu_kiem_tra_chat_luong |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Từ danh sách tiêu chí đóng đúng so_phien_ban; số đo chiều và số viên lỗi khác nhau; lỗi có thể chồng loại, không cộng lỗi theo loại thay lượng lỗi.

**Yêu cầu:** FR17.

### T049 Đợt giao hàng

**Tên bảng:** `giao_hang.dot_giao_hang`. **Phụ trách:** Giao hàng phối hợp kinh doanh.

**Mục đích:** Một đợt soạn/rời/nhận..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.chung_tu |
| `dia_chi_nhan_tai_luc_giao` | Địa chỉ nhận tại lúc giao | Văn bản | Địa chỉ nhận tại lúc giao của đợt giao hàng, phục vụ một đợt soạn/rời/nhận; được ghi bởi giao hàng phối hợp kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ghi_chu_van_chuyen` | Ghi chú vận chuyển | Văn bản | Ghi chú vận chuyển của đợt giao hàng, phục vụ một đợt soạn/rời/nhận; được ghi bởi giao hàng phối hợp kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_roi_kho` | Thời điểm rời kho | Thời điểm có múi giờ | Thời điểm rời kho của đợt giao hàng, phục vụ một đợt soạn/rời/nhận; được ghi bởi giao hàng phối hợp kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_nhan` | Thời điểm nhận | Thời điểm có múi giờ | Thời điểm nhận của đợt giao hàng, phục vụ một đợt soạn/rời/nhận; được ghi bởi giao hàng phối hợp kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_don_hang` | Mã chứng từ đơn hàng | Mã UUID | Mã chứng từ đơn hàng liên kết kinh_doanh.bao_gia_va_don_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.bao_gia_va_don_hang |
| `ma_ben_nhan` | Mã bên nhận | Mã UUID | Mã bên nhận liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `ma_ben_van_chuyen` | Mã bên vận chuyển | Mã UUID | Mã bên vận chuyển liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `ma_can_cu_dai_dien_nhan_hang` | Mã căn cứ đại diện nhận hàng | Mã UUID | Mã căn cứ đại diện nhận hàng liên kết dung_chung.can_cu_dai_dien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.can_cu_dai_dien |

**Ràng buộc:** Địa chỉ và phương án giao là thỏa thuận. Mốc rời kho/nhận hàng có nguồn phiếu xuất và xác nhận khách; đã giao bao nhiêu, đang giao và tranh chấp dựng từ dòng giao/nhận và hồ sơ xử lý. Không lưu trạng thái giao tổng hợp để ép hoàn thành; khách nhận chưa tự ghi bán. Đầu nghiệp vụ dùng cùng ma_dinh_danh với Chứng từ; không có mã đầu/bộ thông tin lập/phiên bản ghi riêng. Các vai trò nghiệp vụ thực vẫn có trường nguồn riêng.

**Yêu cầu:** FR21.

### T050 Dòng giao và nhận hàng

**Tên bảng:** `giao_hang.dong_giao_va_nhan_hang`. **Phụ trách:** Giao hàng / kho ghi thực xuất; Giao hàng.

**Mục đích:** Lưu theo loại và bản: Biến thể/lô của đợt giao.; Kết quả khách nhận từng phần..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `so_luong_giao_du_kien` | Số lượng giao dự kiến | Số lượng chính xác | Số lượng giao dự kiến của dòng giao hàng, phục vụ biến thể/lô của đợt giao; được ghi bởi giao hàng / kho ghi thực xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_dot_giao` | Mã chứng từ đợt giao | Mã UUID | Mã chứng từ đợt giao liên kết giao_hang.dot_giao_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | giao_hang.dot_giao_hang |
| `ma_dong_don_hang` | Mã dòng đơn hàng | Mã UUID | Mã dòng đơn hàng liên kết kinh_doanh.dong_tu_van_bao_gia_va_don_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.dong_tu_van_bao_gia_va_don_hang |
| `ma_dong_thuc_xuat_giao_hang` | Mã dòng thực xuất giao hàng | Mã UUID | Mã dòng thực xuất giao hàng liên kết kho.dong_van_dong_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.dong_van_dong_hang |
| `so_luong_khach_thuc_nhan` | Số lượng khách thực nhận | Số lượng chính xác | Số lượng khách thực nhận của xác nhận khách nhận hàng, phục vụ kết quả khách nhận từng phần; được ghi bởi giao hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_duoc_chap_nhan` | Số lượng được chấp nhận | Số lượng chính xác | Số lượng được chấp nhận của xác nhận khách nhận hàng, phục vụ kết quả khách nhận từng phần; được ghi bởi giao hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_khach_tu_choi` | Số lượng khách từ chối | Số lượng chính xác | Số lượng khách từ chối của xác nhận khách nhận hàng, phục vụ kết quả khách nhận từng phần; được ghi bởi giao hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_hu_hong_duoc_ghi_nhan` | Số lượng hư hỏng được ghi nhận | Số lượng chính xác | Số lượng hư hỏng được ghi nhận của xác nhận khách nhận hàng, phục vụ kết quả khách nhận từng phần; được ghi bởi giao hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_thuc_hien_nghiep_vu` | Thời điểm thực hiện nghiệp vụ | Thời điểm có múi giờ | Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `chung_cu` | Chứng cứ | Văn bản | Chứng cứ của xác nhận khách nhận hàng, phục vụ kết quả khách nhận từng phần; được ghi bởi giao hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_dong_giao_du_kien` | Mã dòng giao hàng | Mã UUID | Mã dòng giao hàng liên kết giao_hang.dong_giao_va_nhan_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | giao_hang.dong_giao_va_nhan_hang |
| `ma_lien_he_nguoi_nhan_hang` | Mã liên hệ người nhận hàng | Mã UUID | Mã liên hệ người nhận hàng liên kết dung_chung.lien_he_doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.lien_he_doi_tac |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |
| `loai_dong_giao` | Loại dòng giao hoặc nhận | Phân loại có danh sách đóng | Dòng giao dự kiến có phiếu xuất; từng lần nhận thực là dòng con, giữ nhiều lần/nhận một phần mà không xuất lại. Giá trị: giao_du_kien; nhan_thuc. | Thông tin nghiệp vụ có căn cứ | — |

**Ràng buộc:** Dòng giao_du_kien trỏ đợt/đơn/phiếu xuất, không tự có khách nhận; dòng nhan_thuc trỏ dòng dự kiến gốc và giữ lượng thực nhận/chấp nhận/từ chối/căn cứ/mốc. FK gốc phải đúng loại giao_du_kien, cùng đợt/đơn/nguồn; tổng nhận không vượt thực xuất chưa ghi nhận. Đã chấp nhận+từ chối=đã nhận, hư hỏng nằm trong từ chối nếu áp dụng. Chứng từ bán chỉ tham chiếu dòng nhan_thuc đủ điều kiện; không xuất lần hai. Điều kiện nguồn Xác nhận khách nhận hàng: Tổng nhận không vượt thực xuất chưa ghi nhận; đã chấp nhận+refused=đã nhận, damaged là phân loại trong refused nếu áp dụng, không cộng đôi. Giữ lượng thiếu/đang giao riêng.

**Yêu cầu:** FR19, FR21, FR22, FR27.

### T051 Quỹ và tài khoản tiền

**Tên bảng:** `tai_chinh.quy_va_tai_khoan_tien`. **Phụ trách:** Tài chính.

**Mục đích:** Quỹ/tài khoản và số dư tính từ sổ..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của quỹ và tài khoản tiền, phục vụ quỹ/tài khoản và số dư tính từ sổ; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của quỹ và tài khoản tiền, phục vụ quỹ/tài khoản và số dư tính từ sổ; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: tien_mat; ngan_hang. Giá trị: tien_mat; ngan_hang. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `tien_te` | Tiền tệ | Phân loại có danh sách đóng | Tiền tệ của quỹ và tài khoản tiền, phục vụ quỹ/tài khoản và số dư tính từ sổ; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: VND. Giá trị: VND. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dang_su_dung` | Đang sử dụng | Có/không | Đang sử dụng của quỹ và tài khoản tiền, phục vụ quỹ/tài khoản và số dư tính từ sổ; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Không có cột số dư sửa tay; không tự thấu chi.

**Yêu cầu:** FR23, FR24, FR25.

### T052 Đề nghị chi tiền

**Tên bảng:** `tai_chinh.de_nghi_chi_tien`. **Phụ trách:** Kế toán / nhân sự lập; giám đốc duyệt.

**Mục đích:** Được phép chi theo nguồn..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.chung_tu |
| `so_tien_de_nghi` | Số tiền đề nghị | Số tiền VND nguyên đồng | Số tiền đề nghị của đề nghị chi tiền, phục vụ được phép chi theo nguồn; được ghi bởi kế toán / hr lập; giám đốc duyệt theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `muc_dich` | Mục đích | Phân loại có danh sách đóng | Mục đích của đề nghị chi tiền, phục vụ được phép chi theo nguồn; được ghi bởi kế toán / hr lập; giám đốc duyệt theo hồ sơ nguồn của bảng. Giá trị cho phép: nha_cung_cap; ung_truoc; thu_nhap; hoan_tien; chi_phi_ky; chuyen_noi_bo. Giá trị: nha_cung_cap; ung_truoc; thu_nhap; hoan_tien; chi_phi_ky; chuyen_noi_bo. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ten_nguoi_huong_tai_luc_de_nghi` | Tên người hưởng tại lúc đề nghị | Văn bản | Tên người hưởng tại lúc đề nghị của đề nghị chi tiền, phục vụ được phép chi theo nguồn; được ghi bởi kế toán / hr lập; giám đốc duyệt theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_doi_tac_huong_tien` | Mã đối tác hưởng tiền | Mã UUID | Mã đối tác hưởng tiền liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `ma_nhan_vien_huong_tien` | Mã nhân viên hưởng tiền | Mã UUID | Mã nhân viên hưởng tiền liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_nghia_vu_thanh_toan` | Mã nghĩa vụ thanh toán | Mã UUID | Mã nghĩa vụ thanh toán liên kết tai_chinh.nghia_vu_va_dieu_chinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.nghia_vu_va_dieu_chinh |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `ma_quy_hoac_tai_khoan_dich` | Mã quỹ hoặc tài khoản đích | Mã UUID | Mã quỹ hoặc tài khoản đích liên kết tai_chinh.quy_va_tai_khoan_tien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.quy_va_tai_khoan_tien |

**Ràng buộc:** Số tiền đề nghị có chủ thể và mục đích; duyệt từ quyết định riêng, chưa làm tiền giảm. Phần đã chi/còn chi tính từ biến động tiền được xác nhận, không có trạng thái đã trả nhập tay. Chi không vượt số được duyệt và số dư. Đầu nghiệp vụ dùng cùng ma_dinh_danh với Chứng từ; không có mã đầu/bộ thông tin lập/phiên bản ghi riêng. Các vai trò nghiệp vụ thực vẫn có trường nguồn riêng.

**Yêu cầu:** FR24, FR31.

### T053 Biến động tiền thực

**Tên bảng:** `tai_chinh.bien_dong_tien_thuc`. **Phụ trách:** Người thu/chi xác nhận.

**Mục đích:** Một biến động tiền thực hoặc số đầu..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `chieu_tang_giam` | Chiều tăng giảm | Phân loại có danh sách đóng | Chiều tăng giảm của biến động tiền thực, phục vụ một biến động tiền thực hoặc số đầu; được ghi bởi người thu/chi xác nhận theo hồ sơ nguồn của bảng. Giá trị cho phép: thu_vao; chi_ra; dau_ky. Giá trị: thu_vao; chi_ra; dau_ky. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien` | Số tiền | Số tiền VND nguyên đồng | Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_thuc_hien_nghiep_vu` | Thời điểm thực hiện nghiệp vụ | Thời điểm có múi giờ | Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_doi_chieu_ben_ngoai` | Mã đối chiếu bên ngoài | Văn bản | Mã đối chiếu bên ngoài của biến động tiền thực, phục vụ một biến động tiền thực hoặc số đầu; được ghi bởi người thu/chi xác nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `khoa_chuyen_quy_noi_bo` | Khóa chuyển quỹ nội bộ | Mã UUID | Khóa chuyển quỹ nội bộ của biến động tiền thực, phục vụ một biến động tiền thực hoặc số đầu; được ghi bởi người thu/chi xác nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `pham_vi_xac_dinh_chu_nguon_tien` | Phạm vi xác định chủ nguồn tiền | Phân loại có danh sách đóng | Phạm vi xác định chủ nguồn tiền của biến động tiền thực, phục vụ một biến động tiền thực hoặc số đầu; được ghi bởi người thu/chi xác nhận theo hồ sơ nguồn của bảng. Giá trị cho phép: chua_xac_dinh_chu_the; khach_hang; nha_cung_cap; nhan_vien; noi_bo. Giá trị: chua_xac_dinh_chu_the; khach_hang; nha_cung_cap; nhan_vien; noi_bo. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_ghi_so` | Trạng thái ghi sổ | Phân loại có danh sách đóng | Trạng thái ghi sổ của biến động tiền thực, phục vụ một biến động tiền thực hoặc số đầu; được ghi bởi người thu/chi xác nhận theo hồ sơ nguồn của bảng. Giá trị cho phép: nhap; da_ghi_so. Giá trị: nhap; da_ghi_so. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_quy_hoac_tai_khoan_tien` | Mã quỹ hoặc tài khoản tiền | Mã UUID | Mã quỹ hoặc tài khoản tiền liên kết tai_chinh.quy_va_tai_khoan_tien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.quy_va_tai_khoan_tien |
| `ma_chung_tu_de_nghi_chi` | Mã chứng từ đề nghị chi | Mã UUID | Mã chứng từ đề nghị chi liên kết tai_chinh.de_nghi_chi_tien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.de_nghi_chi_tien |
| `ma_doi_tac` | Mã đối tác | Mã UUID | Mã đối tác liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `ma_nhan_vien` | Mã nhân viên | Mã UUID | Mã nhân viên liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_can_cu_dai_dien` | Mã căn cứ đại diện | Mã UUID | Mã căn cứ đại diện liên kết dung_chung.can_cu_dai_dien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.can_cu_dai_dien |
| `ma_bien_nhan_xac_nhan_giao_dich` | Mã biên nhận xác nhận giao dịch | Mã UUID | Mã biên nhận xác nhận giao dịch liên kết truy_cap.bien_nhan_xac_nhan_giao_dich đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | truy_cap.bien_nhan_xac_nhan_giao_dich |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Amount>0, thực tế chứng cứ; đầu kỳ riêng không doanh thu. Out cần request/duyệt và đủ số dư. Transfer hai đầu cùng khóa/giao dịch nguyên tử. Thu chưa rõ cho party null và không được phân bổ. Chỉ đã ghi sổ có tiền thực; nháp không vào sổ hoặc nguồn phân bổ. ma_doi_tac/ma_nhan_vien ghi bên trả hoặc nhận thực, không đổi thành chủ nghĩa vụ khi trả thay.

**Yêu cầu:** FR05, FR23, FR24, FR25, FR31.

### T054 Nghĩa vụ và điều chỉnh

**Tên bảng:** `tai_chinh.nghia_vu_va_dieu_chinh`. **Phụ trách:** Tài chính.

**Mục đích:** Lưu theo loại và bản: Khoản phải thu/trả/hoàn theo nguồn.; Điều chỉnh nghĩa vụ không sửa gốc..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của nghĩa vụ thanh toán, phục vụ khoản phải thu/trả/hoàn theo nguồn; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: phai_thu; phai_tra; phai_hoan_tien; thu_hoi_ung. Giá trị: phai_thu; phai_tra; phai_hoan_tien; thu_hoi_ung. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien_nghia_vu_goc` | Số tiền nghĩa vụ gốc | Số tiền VND nguyên đồng | Khoản nghĩa vụ được xác lập theo chứng từ gốc đã đối chiếu, không phải số nợ cuối mong muốn. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_den_han_thanh_toan` | Ngày đến hạn thanh toán | Ngày địa phương | Ngày đến hạn thanh toán của nghĩa vụ thanh toán, phục vụ khoản phải thu/trả/hoàn theo nguồn; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ten_nguoi_huong_tai_luc_de_nghi` | Tên người hưởng tại lúc đề nghị | Văn bản | Tên người hưởng tại lúc đề nghị của nghĩa vụ thanh toán, phục vụ khoản phải thu/trả/hoàn theo nguồn; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_dong_nguon_nghiep_vu` | Mã dòng nguồn nghiệp vụ | Mã UUID | Mã dòng nguồn nghiệp vụ liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.dong_chung_tu |
| `ma_doi_tac` | Mã đối tác | Mã UUID | Mã đối tác liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `ma_nhan_vien` | Mã nhân viên | Mã UUID | Mã nhân viên liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |
| `loai_ban_ghi_nghia_vu` | Loại bản ghi nghĩa vụ | Phân loại có danh sách đóng | Bản gốc xác lập nghĩa vụ; điều chỉnh thêm dòng riêng nối gốc. Tổng nợ không cộng số gốc ở dòng điều chỉnh. Giá trị: xac_lap; dieu_chinh_tien; doi_han. | Thông tin nghiệp vụ có căn cứ | — |
| `chieu_tang_giam` | Chiều tăng giảm | Phân loại có danh sách đóng | Chiều tăng giảm của điều chỉnh nghĩa vụ, phục vụ điều chỉnh nghĩa vụ không sửa gốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: tang; giam. Giá trị: tang; giam. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien` | Số tiền | Số tiền VND nguyên đồng | Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_thuc_hien_nghiep_vu` | Thời điểm thực hiện nghiệp vụ | Thời điểm có múi giờ | Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ly_do` | Lý do | Văn bản | Lý do của điều chỉnh nghĩa vụ, phục vụ điều chỉnh nghĩa vụ không sửa gốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_den_han_moi` | Ngày đến hạn mới | Ngày địa phương | Ngày đến hạn mới của điều chỉnh nghĩa vụ, phục vụ điều chỉnh nghĩa vụ không sửa gốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_nghia_vu_goc` | Mã nghĩa vụ thanh toán | Mã UUID | Mã nghĩa vụ thanh toán liên kết tai_chinh.nghia_vu_va_dieu_chinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.nghia_vu_va_dieu_chinh |
| `ma_su_kien_dieu_chinh_goc` | Mã sự kiện gốc | Mã UUID | Mã sự kiện gốc liên kết tai_chinh.nghia_vu_va_dieu_chinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.nghia_vu_va_dieu_chinh |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Bản xac_lap giữ chủ, số gốc, hạn, dòng nguồn đủ điều kiện; điều chỉnh tiền/đổi hạn là bản thêm nối gốc đúng chủ/loại/bộ, không sao số gốc hoặc lập lại nghĩa vụ. Dòng đổi hạn không có tiền; dòng điều chỉnh tiền có chiều/số tiền/căn cứ/duyệt. Phân bổ tiền chỉ trỏ bản xac_lap. Nợ tại mốc=gốc±điều chỉnh−sử dụng tiền hợp lệ; phải trả mua chỉ sau đối chiếu, lương chưa duyệt chưa được phép chi. Điều kiện nguồn Điều chỉnh nghĩa vụ: Số gốc bất biến, phần điều chỉnh có nguồn bán/đối chiếu/phương án; không giảm quá còn hợp lệ. Chuyển phần đã thu thành nghĩa vụ hoàn phải tái phân loại ứng có căn cứ. Amount_change bắt chieu_tang_giam/so_tien>0; đổi hạn chỉ ngay_den_han_moi, không đổi tiền; due tại mốc dựng từ ngày gốc và sự kiện được duyệt, không sửa gốc.

**Yêu cầu:** FR06, FR22, FR24, FR25, FR27, FR30, FR31.

### T055 Sự kiện sử dụng nguồn tiền

**Tên bảng:** `tai_chinh.su_kien_su_dung_nguon_tien`. **Phụ trách:** Kế toán.

**Mục đích:** Dùng tiền cho nghĩa vụ hoặc giữ nguồn hoàn..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của sự kiện sử dụng nguồn tiền, phục vụ dùng tiền cho nghĩa vụ hoặc giữ nguồn hoàn; được ghi bởi kế toán theo hồ sơ nguồn của bảng. Giá trị cho phép: su_dung_tien_thanh_toan; dao_su_dung_tien; giu_nguon_hoan; giai_phong_nguon_hoan; thuc_dung_nguon_hoan. Giá trị: su_dung_tien_thanh_toan; dao_su_dung_tien; giu_nguon_hoan; giai_phong_nguon_hoan; thuc_dung_nguon_hoan. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien` | Số tiền | Số tiền VND nguyên đồng | Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_thuc_hien_nghiep_vu` | Thời điểm thực hiện nghiệp vụ | Thời điểm có múi giờ | Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_bien_dong_tien_thuc` | Mã biến động tiền thực | Mã UUID | Mã biến động tiền thực liên kết tai_chinh.bien_dong_tien_thuc đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.bien_dong_tien_thuc |
| `ma_nghia_vu_thanh_toan` | Mã nghĩa vụ thanh toán | Mã UUID | Mã nghĩa vụ thanh toán liên kết tai_chinh.nghia_vu_va_dieu_chinh đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.nghia_vu_va_dieu_chinh |
| `ma_su_kien_su_dung_tien_goc` | Mã sự kiện sử dụng tiền gốc | Mã UUID | Mã sự kiện sử dụng tiền gốc liên kết tai_chinh.su_kien_su_dung_nguon_tien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.su_kien_su_dung_nguon_tien |
| `ma_bien_dong_tien_thuc_hoan` | Mã biến động tiền thực hoàn | Mã UUID | Mã biến động tiền thực hoàn liên kết tai_chinh.bien_dong_tien_thuc đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.bien_dong_tien_thuc |
| `ma_can_cu_dai_dien` | Mã căn cứ đại diện | Mã UUID | Mã căn cứ đại diện liên kết dung_chung.can_cu_dai_dien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.can_cu_dai_dien |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |

**Ràng buộc:** Chỉ sử dụng tiền thanh toán đúng bên/hướng; tiền chưa dùng trừ cả phần bị giữ hoàn. Reverse không thu/chi mới. Consume_refund nối thực chi để phần thu cũ không trở lại khả dụng. Tổng không vượt nguồn/nghĩa vụ. tiền mặt.ma_doi_tac là người trả/nhận thực, obligation.ma_doi_tac là chủ nghĩa vụ; nếu khác bắt authority đúng represented party/agent/nguồn. Nguồn chưa rõ phải có hồ sơ đối chiếu xác định chủ trước sử dụng tiền thanh toán, không sửa tiền thực.

**Yêu cầu:** FR05, FR23, FR24, FR25, FR27, FR31.

### T056 Dòng ghi nhận bán

**Tên bảng:** `tai_chinh.dong_ghi_nhan_ban`. **Phụ trách:** Kế toán.

**Mục đích:** Doanh thu theo lượng/giá đã chấp nhận..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `so_vien_thoa_thuan` | Số viên thỏa thuận | Số lượng chính xác | Số viên thỏa thuận của dòng ghi nhận bán, phục vụ doanh thu theo lượng/giá đã chấp nhận; được ghi bởi kế toán theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `don_gia_tai_lan_ghi_nhan` | Đơn giá tại lần ghi nhận | Số thập phân chính xác | Đơn giá tại lần ghi nhận của dòng ghi nhận bán, phục vụ doanh thu theo lượng/giá đã chấp nhận; được ghi bởi kế toán theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `so_tien` | Số tiền | Số tiền VND nguyên đồng | Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối. | Kết quả đã ghi nhận có căn cứ | — |
| `tinh_trang_ghi_nhan_gia_von` | Tình trạng ghi nhận giá vốn | Phân loại có danh sách đóng | Tình trạng ghi nhận giá vốn của dòng ghi nhận bán, phục vụ doanh thu theo lượng/giá đã chấp nhận; được ghi bởi kế toán theo hồ sơ nguồn của bảng. Giá trị cho phép: tam_tinh; da_xac_nhan. Giá trị: tam_tinh; da_xac_nhan. | Kết quả đã ghi nhận có căn cứ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_ghi_ban` | Mã chứng từ ghi bán | Mã UUID | Mã chứng từ ghi bán liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_dong_xac_nhan_khach_nhan` | Mã dòng xác nhận khách nhận | Mã UUID | Mã dòng xác nhận khách nhận liên kết giao_hang.dong_giao_va_nhan_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | giao_hang.dong_giao_va_nhan_hang |
| `ma_dong_ghi_ban_goc` | Mã dòng ghi bán gốc | Mã UUID | Mã dòng ghi bán gốc liên kết tai_chinh.dong_ghi_nhan_ban đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.dong_ghi_nhan_ban |
| `ma_dong_don_hang` | Mã dòng đơn hàng | Mã UUID | Mã dòng đơn hàng liên kết kinh_doanh.dong_tu_van_bao_gia_va_don_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.dong_tu_van_bao_gia_va_don_hang |

**Ràng buộc:** Bán không vượt đã chấp nhận chưa ghi; giảm bán/tăng bán chỉ gốc đã ghi và phần còn; không xuất kho lần hai. Giá vốn nguồn value_entry, không nhân giá bán.

**Yêu cầu:** FR22, FR26, FR27.

### T057 Đối chiếu nghĩa vụ mua

**Tên bảng:** `tai_chinh.doi_chieu_nghia_vu_mua`. **Phụ trách:** Mua hàng / kế toán đối chiếu.

**Mục đích:** Chứng từ nghĩa vụ và giá trị mua được chấp nhận..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `so_luong_duoc_chap_nhan` | Số lượng được chấp nhận | Số lượng chính xác | Số lượng được chấp nhận của đối chiếu nghĩa vụ mua, phục vụ chứng từ nghĩa vụ và giá trị mua được chấp nhận; được ghi bởi mua hàng / kế toán đối chiếu theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien_doi_chieu_chap_nhan_mua` | Số tiền đối chiếu chấp nhận mua | Số tiền VND nguyên đồng | Số tiền đối chiếu chấp nhận mua của đối chiếu nghĩa vụ mua, phục vụ chứng từ nghĩa vụ và giá trị mua được chấp nhận; được ghi bởi mua hàng / kế toán đối chiếu theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `ma_chung_tu_nha_cung_cap` | Mã chứng từ nhà cung cấp | Văn bản | Mã chứng từ nhà cung cấp của đối chiếu nghĩa vụ mua, phục vụ chứng từ nghĩa vụ và giá trị mua được chấp nhận; được ghi bởi mua hàng / kế toán đối chiếu theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_den_han_thanh_toan` | Ngày đến hạn thanh toán | Ngày địa phương | Ngày đến hạn thanh toán của đối chiếu nghĩa vụ mua, phục vụ chứng từ nghĩa vụ và giá trị mua được chấp nhận; được ghi bởi mua hàng / kế toán đối chiếu theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_thuc_hien` | Trạng thái thực hiện | Phân loại có danh sách đóng | Trạng thái của sự kiện do người phụ trách xác nhận; không tự nạp đã hoàn tất. Trạng thái tổng hợp từ nhiều sự kiện chỉ tính khi xem. Giá trị cho phép: cho_xu_ly; da_xac_nhan; tranh_chap. Giá trị: cho_xu_ly; da_xac_nhan; tranh_chap. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_dong_don_mua` | Mã dòng đơn mua | Mã UUID | Mã dòng đơn mua liên kết mua_hang.dong_don_mua_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | mua_hang.dong_don_mua_hang |
| `ma_dong_nhan_hang_mua` | Mã dòng nhận hàng mua | Mã UUID | Mã dòng nhận hàng mua liên kết kho.dong_van_dong_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.dong_van_dong_hang |
| `ma_phieu_kiem_chat_luong` | Mã phiếu kiểm chất lượng | Mã UUID | Mã phiếu kiểm chất lượng liên kết chat_luong.phieu_kiem_tra_chat_luong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | chat_luong.phieu_kiem_tra_chat_luong |
| `ma_nha_cung_cap` | Mã nhà cung cấp | Mã UUID | Mã nhà cung cấp liên kết dung_chung.doi_tac đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |

**Ràng buộc:** Không vượt phần nhận/đạt/chưa đối chiếu; lỗi/thừa chờ riêng; nhà cung cấp reference chống nhập trùng theo nguồn, không giả nhận đạt cả đơn mua.

**Yêu cầu:** FR14, FR15, FR24.

### T058 Dòng đối chiếu quỹ ngân hàng

**Tên bảng:** `tai_chinh.dong_doi_chieu_quy_ngan_hang`. **Phụ trách:** Tài chính.

**Mục đích:** Đối chiếu quỹ/ngân hàng giả lập theo mốc..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `ma_doi_chieu_ben_ngoai` | Mã đối chiếu bên ngoài | Văn bản | Mã đối chiếu bên ngoài của dòng đối chiếu quỹ ngân hàng, phục vụ đối chiếu quỹ/ngân hàng giả lập theo mốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien_thuc_tren_nguon_doi_chieu` | Số tiền thực trên nguồn đối chiếu | Số tiền VND nguyên đồng | Số tiền thực trên nguồn đối chiếu của dòng đối chiếu quỹ ngân hàng, phục vụ đối chiếu quỹ/ngân hàng giả lập theo mốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `chieu_tang_giam` | Chiều tăng giảm | Phân loại có danh sách đóng | Chiều tăng giảm của dòng đối chiếu quỹ ngân hàng, phục vụ đối chiếu quỹ/ngân hàng giả lập theo mốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: thu_vao; chi_ra. Giá trị: thu_vao; chi_ra. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_quan_sat_nguon_doi_chieu` | Thời điểm quan sát nguồn đối chiếu | Thời điểm có múi giờ | Thời điểm quan sát nguồn đối chiếu của dòng đối chiếu quỹ ngân hàng, phục vụ đối chiếu quỹ/ngân hàng giả lập theo mốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: chua_doi_chieu; da_doi_chieu; tranh_chap. Giá trị: chua_doi_chieu; da_doi_chieu; tranh_chap. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_quy_hoac_tai_khoan_tien` | Mã quỹ hoặc tài khoản tiền | Mã UUID | Mã quỹ hoặc tài khoản tiền liên kết tai_chinh.quy_va_tai_khoan_tien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.quy_va_tai_khoan_tien |
| `ma_bien_dong_tien_thuc` | Mã biến động tiền thực | Mã UUID | Mã biến động tiền thực liên kết tai_chinh.bien_dong_tien_thuc đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.bien_dong_tien_thuc |

**Ràng buộc:** Movement có thể trống nếu chưa khớp; không tự sinh tiền từ sao kê. Chênh có hồ sơ xử lý, không sửa số cuối.

**Yêu cầu:** FR23, FR25.

### T059 Nguồn chi phí

**Tên bảng:** `tai_chinh.nguon_chi_phi`. **Phụ trách:** Tài chính; nhân sự cung cấp phần lương.

**Mục đích:** Một nguồn chi phí được đối chiếu..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của nguồn chi phí, phục vụ một nguồn chi phí được đối chiếu; được ghi bởi tài chính; hr cung cấp phần lương theo hồ sơ nguồn của bảng. Giá trị cho phép: vat_tu; nhan_cong; chi_phi_chung; bo_sung; co_the_thu_hoi. Giá trị: vat_tu; nhan_cong; chi_phi_chung; bo_sung; co_the_thu_hoi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien` | Số tiền | Số tiền VND nguyên đồng | Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối. | Kết quả đã ghi nhận có căn cứ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: tam_tinh; da_xac_nhan. Giá trị: tam_tinh; da_xac_nhan. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ghi_chu_can_cu_chi_phi` | Ghi chú căn cứ chi phí | Văn bản | Ghi chú căn cứ chi phí của nguồn chi phí, phục vụ một nguồn chi phí được đối chiếu; được ghi bởi tài chính; hr cung cấp phần lương theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_dong_nguon_nghiep_vu` | Mã dòng nguồn nghiệp vụ | Mã UUID | Mã dòng nguồn nghiệp vụ liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.dong_chung_tu |
| `ma_dong_thu_nhap_nhan_vien` | Mã dòng thu nhập nhân viên | Mã UUID | Mã dòng thu nhập nhân viên liên kết nhan_su.thu_nhap_nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.thu_nhap_nhan_vien |
| `ma_dong_vat_tu_thuc_dung` | Mã dòng vật tư thực dùng | Mã UUID | Mã dòng vật tư thực dùng liên kết kho.dong_van_dong_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.dong_van_dong_hang |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `ma_nguon_chi_phi_bi_thay` | Mã nguồn chi phí bị thay | Mã UUID | Mã nguồn chi phí bị thay liên kết tai_chinh.nguon_chi_phi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.nguon_chi_phi |

**Ràng buộc:** Duy nhất nguồn+loại+bản; vật tư/nhân công trỏ đúng loại nguồn, chi phí chung ma_dong_nguon_nghiep_vu chứng từ chi phí chứ không tiền chi. Nguồn thu hồi tách, không cộng trùng phải trả/chi tiền. Cost nguồn đầu vào có dòng riêng; ma_dong_nguon_nghiep_vu có thể trống chỉ với nguồn chi phí chung/bổ sung tự khai có chứng từ và duyệt; vật tư/nhân công phải có nguồn.

**Yêu cầu:** FR18, FR26, FR31.

### T060 Phân bổ chi phí

**Tên bảng:** `tai_chinh.phan_bo_chi_phi`. **Phụ trách:** Tài chính.

**Mục đích:** Phân bổ nguồn đến lô hoặc chi phí khác..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `so_tien` | Số tiền | Số tiền VND nguyên đồng | Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối. | Kết quả đã ghi nhận có căn cứ | — |
| `doi_tuong_chiu_chi_phi` | Đối tượng chịu chi phí | Phân loại có danh sách đóng | Đối tượng chịu chi phí của phân bổ chi phí, phục vụ phân bổ nguồn đến lô hoặc chi phí khác; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: lo_san_xuat; viec_khac_tai_xuong; ngoai_san_xuat; thu_hoi_gia_tri. Giá trị: lo_san_xuat; viec_khac_tai_xuong; ngoai_san_xuat; thu_hoi_gia_tri. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_can_cu_phan_bo` | Số lượng căn cứ phân bổ | Số thập phân chính xác | Số lượng căn cứ phân bổ của phân bổ chi phí, phục vụ phân bổ nguồn đến lô hoặc chi phí khác; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: tam_tinh; da_xac_nhan. Giá trị: tam_tinh; da_xac_nhan. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_nguon_chi_phi` | Mã nguồn chi phí | Mã UUID | Mã nguồn chi phí liên kết tai_chinh.nguon_chi_phi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.nguon_chi_phi |
| `ma_lo_san_xuat` | Mã lô sản xuất | Mã UUID | Mã lô sản xuất liên kết san_xuat.lo_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.lo_san_xuat |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `ma_ban_phan_bo_chi_phi_bi_thay` | Mã bản phân bổ chi phí bị thay | Mã UUID | Mã bản phân bổ chi phí bị thay liên kết tai_chinh.phan_bo_chi_phi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.phan_bo_chi_phi |

**Ràng buộc:** Batch có thể trống với nguồn khác; bản cũ giữ. Tổng phân bổ đang hiệu lực không vượt nguồn; nguyên liệu/nhân công/chung không cộng lại lúc chi tiền.

**Yêu cầu:** FR18, FR26, FR31.

### T061 Căn cứ phân bổ chi phí

**Tên bảng:** `tai_chinh.can_cu_phan_bo_chi_phi`. **Phụ trách:** Tài chính; sản xuất/nhân sự xác nhận nguồn giờ.

**Mục đích:** Các dòng thực làm/giờ máy/vật tư cho phân bổ..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai_can_cu_phan_bo` | Loại căn cứ phân bổ | Phân loại có danh sách đóng | Loại căn cứ phân bổ của căn cứ phân bổ chi phí, phục vụ các dòng thực làm/giờ máy/vật tư cho phân bổ; được ghi bởi tài chính; sản xuất/hr xác nhận nguồn giờ theo hồ sơ nguồn của bảng. Giá trị cho phép: phut_cong; phut_may; luong_vat_tu. Giá trị: phut_cong; phut_may; luong_vat_tu. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_can_cu_phan_bo` | Số lượng căn cứ phân bổ | Số thập phân chính xác | Số lượng căn cứ phân bổ của căn cứ phân bổ chi phí, phục vụ các dòng thực làm/giờ máy/vật tư cho phân bổ; được ghi bởi tài chính; sản xuất/hr xác nhận nguồn giờ theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_dong_phan_bo_chi_phi` | Mã dòng phân bổ chi phí | Mã UUID | Mã dòng phân bổ chi phí liên kết tai_chinh.phan_bo_chi_phi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.phan_bo_chi_phi |
| `ma_khoang_cong_thuc_te` | Mã khoảng công thực tế | Mã UUID | Mã khoảng công thực tế liên kết nhan_su.khoang_cong_thuc_te đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.khoang_cong_thuc_te |
| `ma_lich_nguon_luc` | Mã lịch nguồn lực | Mã UUID | Mã lịch nguồn lực liên kết san_xuat.lich_nguoi_va_nguon_luc đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.lich_nguoi_va_nguon_luc |
| `ma_dong_vat_tu_thuc_dung` | Mã dòng vật tư thực dùng | Mã UUID | Mã dòng vật tư thực dùng liên kết kho.dong_van_dong_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.dong_van_dong_hang |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Chính xác một nguồn phù hợp loai; máy phải thực tế; nhân công phải đã xác nhận/trực tiếp. Không lấy giờ người thành giờ máy.

**Yêu cầu:** FR12, FR26, FR29, FR31.

### T062 Biến động giá trị

**Tên bảng:** `tai_chinh.bien_dong_gia_tri`. **Phụ trách:** Tài chính.

**Mục đích:** Sổ giá trị kho/xưởng/đang giao/giá vốn..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `nhom_gia_tri_nguon` | Nhóm giá trị nguồn | Phân loại có danh sách đóng | Nhóm giá trị nguồn của biến động giá trị, phục vụ sổ giá trị kho/xưởng/đang giao/giá vốn; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: nguon_dau_vao; ton_hang; do_dang; dang_giao; gia_von; chi_phi_ky; thu_hoi_gia_tri. Giá trị: nguon_dau_vao; ton_hang; do_dang; dang_giao; gia_von; chi_phi_ky; thu_hoi_gia_tri. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `nhom_gia_tri_dich` | Nhóm giá trị đích | Phân loại có danh sách đóng | Nhóm giá trị đích của biến động giá trị, phục vụ sổ giá trị kho/xưởng/đang giao/giá vốn; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: nguon_dau_vao; ton_hang; do_dang; dang_giao; gia_von; chi_phi_ky; thu_hoi_gia_tri. Giá trị: nguon_dau_vao; ton_hang; do_dang; dang_giao; gia_von; chi_phi_ky; thu_hoi_gia_tri. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien` | Số tiền | Số tiền VND nguyên đồng | Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối. | Kết quả đã ghi nhận có căn cứ | — |
| `thoi_diem_thuc_hien_nghiep_vu` | Thời điểm thực hiện nghiệp vụ | Thời điểm có múi giờ | Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `tinh_trang_xac_nhan_dinh_gia` | Tình trạng xác nhận định giá | Phân loại có danh sách đóng | Tình trạng xác nhận định giá của biến động giá trị, phục vụ sổ giá trị kho/xưởng/đang giao/giá vốn; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: tam_tinh; da_xac_nhan. Giá trị: tam_tinh; da_xac_nhan. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `quy_tac_lam_tron_da_ap_dung` | Quy tắc làm tròn đã áp dụng | Văn bản | Quy tắc làm tròn đã áp dụng của biến động giá trị, phục vụ sổ giá trị kho/xưởng/đang giao/giá vốn; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_mat_hang` | Mã mặt hàng | Mã UUID | Mã mặt hàng liên kết danh_muc.mat_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.mat_hang |
| `ma_dong_van_dong_hang` | Mã dòng vận động hàng | Mã UUID | Mã dòng vận động hàng liên kết kho.dong_van_dong_hang đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.dong_van_dong_hang |
| `ma_chung_tu_ban_chot_gia_thanh` | Mã chứng từ bản chốt giá thành | Mã UUID | Mã chứng từ bản chốt giá thành liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_dong_ghi_ban` | Mã dòng ghi bán | Mã UUID | Mã dòng ghi bán liên kết tai_chinh.dong_ghi_nhan_ban đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.dong_ghi_nhan_ban |
| `ma_bien_dong_gia_tri_goc` | Mã biến động giá trị gốc | Mã UUID | Mã biến động giá trị gốc liên kết tai_chinh.bien_dong_gia_tri đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.bien_dong_gia_tri |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Hai bucket khác nhau, so_tien>0; mỗi biến động giá trị có đúng nguồn và chỉ ghi một lần theo hanh_dong. Chốt/sửa giá trị không thêm lượng; xuất hết mang giá trị còn. Theo mặt hàng/bộ dữ liệu và bucket, giữ lô vật lý riêng với bình quân.

**Yêu cầu:** FR06, FR15, FR16, FR22, FR26, FR27.

### T063 Nhân viên

**Tên bảng:** `nhan_su.nhan_vien`. **Phụ trách:** Nhân sự.

**Mục đích:** Một hồ sơ người, không bắt có tài khoản..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của nhân viên, phục vụ một hồ sơ người, không bắt có tài khoản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_nguoi_that` | Mã người thật | Mã UUID | Mã người thật liên kết truy_cap.dinh_danh_nguoi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | truy_cap.dinh_danh_nguoi |
| `ten` | Tên | Văn bản | Tên của nhân viên, phục vụ một hồ sơ người, không bắt có tài khoản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_vao_lam` | Ngày vào làm | Ngày địa phương | Ngày vào làm của nhân viên, phục vụ một hồ sơ người, không bắt có tài khoản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_nghi_viec` | Ngày nghỉ việc | Ngày địa phương | Ngày nghỉ việc của nhân viên, phục vụ một hồ sơ người, không bắt có tài khoản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Duy nhất(bộ dữ liệu,ma_nghiep_vu/ma_nguoi_that); định danh người ổn định, không tạo người thứ hai để tự duyệt; dữ liệu thật không Git. Dept/lương lịch sử ở employment, không số hiện tại thay quá khứ. Trạng thái tại mốc lấy employment hiệu lực, không cột trạng thái hiện tại thay quá khứ.

**Yêu cầu:** FR01, FR02, FR28, FR31.

### T064 Hồ sơ làm việc theo hiệu lực

**Tên bảng:** `nhan_su.ho_so_lam_viec_theo_hieu_luc`. **Phụ trách:** Nhân sự theo quyết định.

**Mục đích:** Hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.chung_tu |
| `thoi_diem_bat_dau_hieu_luc` | Thời điểm bắt đầu hiệu lực | Ngày địa phương | Thời điểm bắt đầu hiệu lực của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_hieu_luc` | Thời điểm kết thúc hiệu lực | Ngày địa phương | Thời điểm kết thúc hiệu lực của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai_ho_so_hop_dong` | Loại hồ sơ hợp đồng | Văn bản | Loại hồ sơ hợp đồng của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_ket_thuc_hop_dong` | Ngày kết thúc hợp đồng | Ngày địa phương | Ngày kết thúc hợp đồng của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `vi_tri_cong_viec` | Vị trí công việc | Văn bản | Vị trí công việc của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `luong_co_ban` | Lương cơ bản | Số tiền VND nguyên đồng | Lương cơ bản của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `phu_cap_co_dinh` | Phụ cấp cố định | Số tiền VND nguyên đồng | Phụ cấp cố định của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ghi_chu_thu_viec` | Ghi chú thử việc | Văn bản | Ghi chú thử việc của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `tinh_trang_lam_viec` | Tình trạng làm việc | Phân loại có danh sách đóng | Tình trạng làm việc của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng. Giá trị cho phép: chuan_bi_vao_lam; thu_viec; dang_su_dung; tam_ngung_lam; da_nghi_viec. Giá trị: chuan_bi_vao_lam; thu_viec; dang_su_dung; tam_ngung_lam; da_nghi_viec. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_nhan_vien` | Mã nhân viên | Mã UUID | Mã nhân viên liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_bo_phan` | Mã bộ phận | Mã UUID | Mã bộ phận liên kết dung_chung.bo_phan đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.bo_phan |
| `ma_nhan_vien_quan_ly` | Mã nhân viên quản lý | Mã UUID | Mã nhân viên quản lý liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_phien_ban_chinh_sach_thu_nhap` | Mã phiên bản chính sách thu nhập | Mã UUID | Mã phiên bản chính sách thu nhập liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |

**Ràng buộc:** Không chồng khoảng chính một người; thay đổi tạo bản mới đúng mốc; một bộ phận chính, không tăng đầu người do kiêm nhiệm. Đầu nghiệp vụ dùng cùng ma_dinh_danh với Chứng từ; không có mã đầu/bộ thông tin lập/phiên bản ghi riêng. Các vai trò nghiệp vụ thực vẫn có trường nguồn riêng.

**Yêu cầu:** FR28, FR31.

### T065 Hồ sơ kỹ năng và an toàn

**Tên bảng:** `nhan_su.ho_so_ky_nang_va_an_toan`. **Phụ trách:** Nhân sự / quản lý xác nhận.

**Mục đích:** Kỹ năng, hướng dẫn an toàn và sự cố cơ sở..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.chung_tu |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của hồ sơ kỹ năng và an toàn, phục vụ kỹ năng, hướng dẫn an toàn và sự cố cơ sở; được ghi bởi nhân sự / quản lý xác nhận theo hồ sơ nguồn của bảng. Giá trị cho phép: ky_nang; huan_luyen_an_toan; su_co. Giá trị: ky_nang; huan_luyen_an_toan; su_co. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của hồ sơ kỹ năng và an toàn, phục vụ kỹ năng, hướng dẫn an toàn và sự cố cơ sở; được ghi bởi nhân sự / quản lý xác nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_hieu_luc` | Thời điểm bắt đầu hiệu lực | Ngày địa phương | Thời điểm bắt đầu hiệu lực của hồ sơ kỹ năng và an toàn, phục vụ kỹ năng, hướng dẫn an toàn và sự cố cơ sở; được ghi bởi nhân sự / quản lý xác nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_hieu_luc` | Thời điểm kết thúc hiệu lực | Ngày địa phương | Thời điểm kết thúc hiệu lực của hồ sơ kỹ năng và an toàn, phục vụ kỹ năng, hướng dẫn an toàn và sự cố cơ sở; được ghi bởi nhân sự / quản lý xác nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: cho_xu_ly; du_dieu_kien; het_hieu_luc; da_chot. Giá trị: cho_xu_ly; du_dieu_kien; het_hieu_luc; da_chot. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ghi_chu_anh_huong_cong_viec` | Ghi chú ảnh hưởng công việc | Văn bản | Ghi chú ảnh hưởng công việc của hồ sơ kỹ năng và an toàn, phục vụ kỹ năng, hướng dẫn an toàn và sự cố cơ sở; được ghi bởi nhân sự / quản lý xác nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_nhan_vien` | Mã nhân viên | Mã UUID | Mã nhân viên liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |

**Ràng buộc:** Chỉ loại cần cho công đoạn; sự cố không cấp qualification, không tự phạt/khấu trừ; chứng cứ giả lập có nhãn. Đầu nghiệp vụ dùng cùng ma_dinh_danh với Chứng từ; không có mã đầu/bộ thông tin lập/phiên bản ghi riêng. Các vai trò nghiệp vụ thực vẫn có trường nguồn riêng.

**Yêu cầu:** FR12, FR28.

### T066 Ngày và ca làm việc

**Tên bảng:** `nhan_su.ngay_va_ca_lam_viec`. **Phụ trách:** Nhân sự.

**Mục đích:** Ngày làm và các khoảng ca có phiên bản..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ngay_lam_viec` | Ngày làm việc | Ngày địa phương | Ngày làm việc của ngày và ca làm việc, phục vụ ngày làm và các khoảng ca có phiên bản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai_ngay_theo_lich` | Loại ngày theo lịch | Phân loại có danh sách đóng | Loại ngày theo lịch của ngày và ca làm việc, phục vụ ngày làm và các khoảng ca có phiên bản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. Giá trị cho phép: lam_viec; nghi_tuan; ngay_le; ngoai_le. Giá trị: lam_viec; nghi_tuan; ngay_le; ngoai_le. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_ca` | Mã ca | Văn bản | Mã ca của ngày và ca làm việc, phục vụ ngày làm và các khoảng ca có phiên bản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `cac_khoang_lam_viec_trong_ca` | Các khoảng làm việc trong ca | Nội dung có cấu trúc đóng | Các khoảng làm việc trong ca của ngày và ca làm việc, phục vụ ngày làm và các khoảng ca có phiên bản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Mỗi ngày/ca thuộc đúng bản lịch. Khoảng làm việc không chồng và loại giờ nghỉ; số phút theo lịch tính từ khoảng, không nhập thêm cột tổng. 26 ngày chỉ là giả định bộ kiểm cũ.

**Yêu cầu:** FR12, FR29, FR30, FR31.

### T067 Khoảng công thực tế

**Tên bảng:** `nhan_su.khoang_cong_thuc_te`. **Phụ trách:** Tổ trưởng / quản lý xác nhận.

**Mục đích:** Khoảng thực làm/nghỉ/chờ và trực tiếp theo người..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `thoi_diem_bat_dau_khoang` | Thời điểm bắt đầu khoảng | Thời điểm có múi giờ | Thời điểm bắt đầu khoảng của khoảng công thực tế, phục vụ khoảng thực làm/nghỉ/chờ và trực tiếp theo người; được ghi bởi tổ trưởng / quản lý xác nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_khoang` | Thời điểm kết thúc khoảng | Thời điểm có múi giờ | Thời điểm kết thúc khoảng của khoảng công thực tế, phục vụ khoảng thực làm/nghỉ/chờ và trực tiếp theo người; được ghi bởi tổ trưởng / quản lý xác nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của khoảng công thực tế, phục vụ khoảng thực làm/nghỉ/chờ và trực tiếp theo người; được ghi bởi tổ trưởng / quản lý xác nhận theo hồ sơ nguồn của bảng. Giá trị cho phép: truc_tiep; ho_tro; dang_cho; dao_tao; cong_tac; nghi_huong_luong; nghi_khong_luong; chua_xac_minh; lam_them. Giá trị: truc_tiep; ho_tro; dang_cho; dao_tao; cong_tac; nghi_huong_luong; nghi_khong_luong; chua_xac_minh; lam_them. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `can_cu_huong_luong` | Căn cứ hưởng lương | Phân loại có danh sách đóng | Căn cứ hưởng lương của khoảng công thực tế, phục vụ khoảng thực làm/nghỉ/chờ và trực tiếp theo người; được ghi bởi tổ trưởng / quản lý xác nhận theo hồ sơ nguồn của bảng. Giá trị cho phép: huong_luong; khong_huong_luong; cho_chinh_sach. Giá trị: huong_luong; khong_huong_luong; cho_chinh_sach. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: cho_xu_ly; da_xac_nhan. Giá trị: cho_xu_ly; da_xac_nhan. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_ban_cong` | Mã chứng từ bản công | Mã UUID | Mã chứng từ bản công liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_chung_tu_cong_doan` | Mã chứng từ công đoạn | Mã UUID | Mã chứng từ công đoạn liên kết san_xuat.cong_doan_san_xuat đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.cong_doan_san_xuat |
| `ma_chung_tu_de_nghi_nghi` | Mã chứng từ đề nghị nghỉ | Mã UUID | Mã chứng từ đề nghị nghỉ liên kết nhan_su.de_nghi_nghi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.de_nghi_nghi |
| `ma_quyet_dinh_duyet_lam_them` | Mã quyết định duyệt làm thêm | Mã UUID | Mã quyết định duyệt làm thêm liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Một khoảng một loại; trực tiếp bắt operation, nghỉ bắt nguồn phép nếu thuộc phép; không trùng người/khoảng/bản hiện hành, không trưa. Thời gian chờ sản phẩm khác chờ có mặt của người.

**Yêu cầu:** FR12, FR26, FR29, FR30, FR31.

### T068 Đề nghị nghỉ

**Tên bảng:** `nhan_su.de_nghi_nghi`. **Phụ trách:** Quản lý duyệt / nhân sự kiểm.

**Mục đích:** Đề nghị nghỉ và bàn giao..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.chung_tu |
| `loai_nghi` | Loại nghỉ | Phân loại có danh sách đóng | Loại nghỉ của đề nghị nghỉ, phục vụ đề nghị nghỉ và bàn giao; được ghi bởi quản lý duyệt / hr kiểm theo hồ sơ nguồn của bảng. Giá trị cho phép: phep_nam_huong_luong; khong_huong_luong; nghi_om; khac_co_ly_do. Giá trị: phep_nam_huong_luong; khong_huong_luong; nghi_om; khac_co_ly_do. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_khoang` | Thời điểm bắt đầu khoảng | Thời điểm có múi giờ | Thời điểm bắt đầu khoảng của đề nghị nghỉ, phục vụ đề nghị nghỉ và bàn giao; được ghi bởi quản lý duyệt / hr kiểm theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_khoang` | Thời điểm kết thúc khoảng | Thời điểm có múi giờ | Thời điểm kết thúc khoảng của đề nghị nghỉ, phục vụ đề nghị nghỉ và bàn giao; được ghi bởi quản lý duyệt / hr kiểm theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: da_de_nghi; da_duyet; da_huy; da_dung. Giá trị: da_de_nghi; da_duyet; da_huy; da_dung. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ly_do` | Lý do | Văn bản | Lý do của đề nghị nghỉ, phục vụ đề nghị nghỉ và bàn giao; được ghi bởi quản lý duyệt / hr kiểm theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_nhan_vien` | Mã nhân viên | Mã UUID | Mã nhân viên liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_nhan_vien_lam_thay` | Mã nhân viên làm thay | Mã UUID | Mã nhân viên làm thay liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |

**Ràng buộc:** Người đề nghị ghi khoảng nghỉ và loại nghỉ. Phút trong lịch tính từ giao của khoảng nghỉ với ca, không giữ tổng sửa tay. Duyệt giữ phép; công thực đã xác nhận mới chuyển sang dùng phép. Hủy/chỉnh có sự kiện căn cứ. Đầu nghiệp vụ dùng cùng ma_dinh_danh với Chứng từ; không có mã đầu/bộ thông tin lập/phiên bản ghi riêng. Các vai trò nghiệp vụ thực vẫn có trường nguồn riêng.

**Yêu cầu:** FR12, FR30.

### T069 Sự kiện phép

**Tên bảng:** `nhan_su.su_kien_phep`. **Phụ trách:** Nhân sự.

**Mục đích:** Sổ phép đầu/phát sinh/giữ/dùng/điều chỉnh..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của sự kiện phép, phục vụ sổ phép đầu/phát sinh/giữ/dùng/điều chỉnh; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. Giá trị cho phép: dau_ky; phat_sinh_phep; giu_nguon; giai_phong; dung_phep; dieu_chinh_tang; dieu_chinh_giam. Giá trị: dau_ky; phat_sinh_phep; giu_nguon; giai_phong; dung_phep; dieu_chinh_tang; dieu_chinh_giam. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_phut_phat_sinh` | Số phút phát sinh | Số nguyên | Số phút phát sinh của sự kiện phép, phục vụ sổ phép đầu/phát sinh/giữ/dùng/điều chỉnh; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_thuc_hien_nghiep_vu` | Thời điểm thực hiện nghiệp vụ | Thời điểm có múi giờ | Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_nhan_vien` | Mã nhân viên | Mã UUID | Mã nhân viên liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_chung_tu_de_nghi_nghi` | Mã chứng từ đề nghị nghỉ | Mã UUID | Mã chứng từ đề nghị nghỉ liên kết nhan_su.de_nghi_nghi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.de_nghi_nghi |
| `ma_su_kien_giu_goc` | Mã sự kiện giữ gốc | Mã UUID | Mã sự kiện giữ gốc liên kết nhan_su.su_kien_phep đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.su_kien_phep |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Minutes>0; dùng phép giảm phần giữ nguồn còn và quỹ phép cùng giao dịch nguyên tử, không trừ đôi; xem mốc từ sổ, không cập nhật số dư tay.

**Yêu cầu:** FR06, FR30.

### T070 Thu nhập nhân viên

**Tên bảng:** `nhan_su.thu_nhap_nhan_vien`. **Phụ trách:** Nhân sự / tài chính kiểm tra / người duyệt đủ quyền.

**Mục đích:** Thu nhập một người, duyệt từng dòng..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: tam_tinh; da_kiem_tra; cho_kiem_tra_doc_lap; da_duyet. Giá trị: tam_tinh; da_kiem_tra; cho_kiem_tra_doc_lap; da_duyet. | Sự kiện hoặc quyết định được ghi nhận | — |
| `pham_vi_mo_phong_khoan_bat_buoc` | Phạm vi mô phỏng khoản bắt buộc | Phân loại có danh sách đóng | Phạm vi mô phỏng khoản bắt buộc của dòng thu nhập nhân viên, phục vụ thu nhập một người, duyệt từng dòng; được ghi bởi nhân sự / tài chính kiểm tra / người duyệt đủ quyền theo hồ sơ nguồn của bảng. Giá trị cho phép: chua_mo_phong. Giá trị: chua_mo_phong. | Dữ liệu kỹ thuật | — |
| `phep_tinh_ban_luu_tai_thoi_diem` | Phép tính bản lưu tại thời điểm | Nội dung có cấu trúc đóng | Phép tính bản lưu tại thời điểm của dòng thu nhập nhân viên, phục vụ thu nhập một người, duyệt từng dòng; được ghi bởi nhân sự / tài chính kiểm tra / người duyệt đủ quyền theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_ky_tinh_thu_nhap` | Mã chứng từ kỳ tính thu nhập | Mã UUID | Mã chứng từ kỳ tính thu nhập liên kết dung_chung.ky_nghiep_vu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.ky_nghiep_vu |
| `ma_nhan_vien` | Mã nhân viên | Mã UUID | Mã nhân viên liên kết nhan_su.nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_ho_so_lam_viec_theo_hieu_luc` | Mã hồ sơ làm việc theo hiệu lực | Mã UUID | Mã hồ sơ làm việc theo hiệu lực liên kết nhan_su.ho_so_lam_viec_theo_hieu_luc đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.ho_so_lam_viec_theo_hieu_luc |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `ma_dong_thu_nhap_goc` | Mã dòng thu nhập gốc | Mã UUID | Mã dòng thu nhập gốc liên kết nhan_su.thu_nhap_nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.thu_nhap_nhan_vien |

**Ràng buộc:** Một dòng cho mỗi người và kỳ/bản. Thu nhập tính từ từng khoản có căn cứ; bản lưu phép tính nối nguồn công/chính sách đúng phiên bản. Dòng giám đốc cần người kiểm tra độc lập. Đã trả/ứng/còn trả tính từ tiền thực và phân bổ, không nhập số cuối; chưa mô phỏng khấu trừ bắt buộc. Các chi tiết thuộc bảng con, tự nối đúng bản cha trong cùng biểu mẫu; không bắt tạo một công việc/phiếu riêng cho mỗi dòng.

**Yêu cầu:** FR06, FR24, FR26, FR30, FR31.

### T071 Khoản thu nhập có căn cứ

**Tên bảng:** `nhan_su.khoan_thu_nhap_co_can_cu`. **Phụ trách:** Nhân sự.

**Mục đích:** Từng khoản lương/phụ cấp/chênh có căn cứ..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của khoản thu nhập có căn cứ, phục vụ từng khoản lương/phụ cấp/chênh có căn cứ; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. Giá trị cho phép: luong_thoi_gian; phu_cap_co_dinh; thuong_da_duyet; lam_them; dieu_chinh. Giá trị: luong_thoi_gian; phu_cap_co_dinh; thuong_da_duyet; lam_them; dieu_chinh. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `chieu_tang_giam` | Chiều tăng giảm | Phân loại có danh sách đóng | Chiều tăng giảm của khoản thu nhập có căn cứ, phục vụ từng khoản lương/phụ cấp/chênh có căn cứ; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. Giá trị cho phép: tang; giam. Giá trị: tang; giam. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien` | Số tiền | Số tiền VND nguyên đồng | Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối. | Kết quả đã ghi nhận có căn cứ | — |
| `so_phut_duoc_lay_lam_can_cu` | Số phút được lấy làm căn cứ | Số nguyên | Số phút được lấy làm căn cứ của khoản thu nhập có căn cứ, phục vụ từng khoản lương/phụ cấp/chênh có căn cứ; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `don_gia_tinh_tai_lan_xac_nhan` | Đơn giá tính tại lần xác nhận | Số thập phân chính xác | Đơn giá tính tại lần xác nhận của khoản thu nhập có căn cứ, phục vụ từng khoản lương/phụ cấp/chênh có căn cứ; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `ly_do` | Lý do | Văn bản | Lý do của khoản thu nhập có căn cứ, phục vụ từng khoản lương/phụ cấp/chênh có căn cứ; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_dong_thu_nhap_nhan_vien` | Mã dòng thu nhập nhân viên | Mã UUID | Mã dòng thu nhập nhân viên liên kết nhan_su.thu_nhap_nhan_vien đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.thu_nhap_nhan_vien |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Mã phiên bản chính sách liên kết dung_chung.phien_ban_chinh_sach đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Mã phê duyệt liên kết dung_chung.de_nghi_va_quyet_dinh_phe_duyet đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Chỉ khoản đã dùng/chính sách có nguồn; không tự tiền phạt/khấu trừ pháp lý. Tổng thành thu nhập income đúng dấu; ứng không là component giảm chi phí.

**Yêu cầu:** FR26, FR30, FR31.

### T072 Phiên đăng nhập

**Tên bảng:** `truy_cap.phien_dang_nhap`. **Phụ trách:** Hệ thống xác thực.

**Mục đích:** Phiên đăng nhập có hạn và thu hồi..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ban_bam_ma_phien_dang_nhap` | Bản băm mã phiên đăng nhập | Văn bản | Bản băm mã phiên đăng nhập của phiên đăng nhập, phục vụ phiên đăng nhập có hạn và thu hồi; được ghi bởi hệ thống xác thực theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `thoi_diem_cap_phien` | Thời điểm cấp phiên | Thời điểm có múi giờ | Thời điểm cấp phiên của phiên đăng nhập, phục vụ phiên đăng nhập có hạn và thu hồi; được ghi bởi hệ thống xác thực theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `thoi_diem_het_hieu_luc` | Thời điểm hết hiệu lực | Thời điểm có múi giờ | Thời điểm hết hiệu lực của phiên đăng nhập, phục vụ phiên đăng nhập có hạn và thu hồi; được ghi bởi hệ thống xác thực theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `thoi_diem_thu_hoi_quyen` | Thời điểm thu hồi quyền | Thời điểm có múi giờ | Thời điểm thu hồi quyền của phiên đăng nhập, phục vụ phiên đăng nhập có hạn và thu hồi; được ghi bởi hệ thống xác thực theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `so_phien_ban_quyen_khi_cap_phien` | Số phiên bản quyền khi cấp phiên | Số nguyên | Số phiên bản quyền khi cấp phiên của phiên đăng nhập, phục vụ phiên đăng nhập có hạn và thu hồi; được ghi bởi hệ thống xác thực theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan` | Mã tài khoản | Mã UUID | Mã tài khoản liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Chỉ lưu băm mã phiên; kiểm tài khoản dang_su_dung/so_phien_ban_quyen_xac_thuc và hết hạn mỗi lần; nghỉ việc hoặc đổi quyền thu hồi phiên liên quan. Không log mã phiên.

**Yêu cầu:** FR02, FR28.

### T073 Nguồn của bản chốt giá thành

**Tên bảng:** `tai_chinh.nguon_cua_ban_chot_gia_thanh`. **Phụ trách:** Tài chính.

**Mục đích:** Chốt đúng các phân bổ nguồn của một bản giá thành..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã định danh liên kết dung_chung.dong_chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Mã bộ dữ liệu liên kết dung_chung.bo_du_lieu_mo_phong đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_ban_chot_gia_thanh` | Mã chứng từ bản chốt giá thành | Mã UUID | Mã chứng từ bản chốt giá thành liên kết dung_chung.chung_tu đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_dong_phan_bo_chi_phi` | Mã dòng phân bổ chi phí | Mã UUID | Mã dòng phân bổ chi phí liên kết tai_chinh.phan_bo_chi_phi đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.phan_bo_chi_phi |

**Ràng buộc:** Chốt giữ danh sách liên kết đúng bản phân bổ; ma_chung_tu_ban_chot_gia_thanh trỏ chứng từ loại chot_gia_thanh. Bản mới có thể dùng phân bổ nguồn không đổi qua liên kết nhiều-nhiều; không chuyển FK trên phân bổ rồi làm mất bản cũ. Tổng khi đọc, không sao tiền lần hai.

**Yêu cầu:** FR06, FR13, FR26.

### T074 Định danh người

**Tên bảng:** `truy_cap.dinh_danh_nguoi`. **Phụ trách:** Quản trị định danh phối hợp nhân sự.

**Mục đích:** Người thật ổn định qua tài khoản và các bộ mô phỏng..

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Loại nguồn | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_dinh_danh_nguoi` | Mã định danh người | Văn bản | Mã định danh người của định danh người, phục vụ người thật ổn định qua tài khoản và các bộ mô phỏng; được ghi bởi quản trị định danh phối hợp hr theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ten_hien_thi` | Tên hiển thị | Văn bản | Tên hiển thị của định danh người, phục vụ người thật ổn định qua tài khoản và các bộ mô phỏng; được ghi bởi quản trị định danh phối hợp hr theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: dang_su_dung; ngung_su_dung. Giá trị: dang_su_dung; ngung_su_dung. | Sự kiện hoặc quyết định được ghi nhận | — |
| `gia_lap` | Giả lập | Có/không | Giả lập của định danh người, phục vụ người thật ổn định qua tài khoản và các bộ mô phỏng; được ghi bởi quản trị định danh phối hợp hr theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Mã tài khoản thực hiện liên kết truy_cap.tai_khoan_dang_nhap đúng bản/bộ và vai trò; điều kiện loại nguồn trong ràng buộc. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc:** Định danh toàn hệ thống; duy nhất ma_dinh_danh_nguoi có kiểm căn cứ, không tự thêm người trùng để duyệt cho mình. Một person có nhiều tài khoản/hồ sơ mô phỏng nhưng vẫn cùng người.

**Yêu cầu:** FR02, FR03, FR28, FR33.
