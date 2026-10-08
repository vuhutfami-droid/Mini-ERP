# Từ điển cơ sở dữ liệu tiếng Việt

Theo B28, toàn bộ tên nhóm, bảng, trường và giá trị phân loại trong thiết kế hiện hành dùng tiếng Việt. Tên máy tính dùng tiếng Việt không dấu, nối bằng dấu gạch dưới; nhãn/mô tả có dấu. Đây là thiết kế, chưa tạo DB hoặc lập trình. [Thiết kế tổng thể](../database-design.md), [rà soát nguồn](source-review.md), [danh sách trường](fields.csv), [bảng nào cần nhập liệu](input-responsibility.md).

## Quy tắc đọc

Mã kỹ thuật do hệ thống cấp chỉ định danh/liên kết, không tự xác nhận nghiệp vụ. Nguồn nghiệp vụ, quyết định và tham số cần người khai báo/xác nhận, mốc và căn cứ. Kết quả tính không được nhập như nguồn thứ hai; chỉ kết quả chính thức đã ghi nhận mới giữ bản với đầy đủ nguồn tính. Dữ liệu thử không là Nasaki thật.

UUID, JSON, VND, PostgreSQL là ký hiệu kỹ thuật/đơn vị, không tên bảng hoặc trường. Khóa ngoại cùng bộ dùng mã bộ dữ liệu và mã định danh; năm bảng định danh người/tài khoản/vai trò/quyền/phiên toàn hệ thống không thuộc riêng một bộ. Các trường chung được liệt kê ngay trong mỗi bảng, tránh bỏ sót. Từng trường có phân loại nguồn và thời điểm cho phép ghi; không có giá trị mặc định thay quyết định.

### D001 Doanh nghiệp

**Tên bảng:** `dung_chung.doanh_nghiep`. **Phụ trách:** Dùng chung.

**Mục đích:** Một đơn vị doanh nghiệp.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của doanh nghiệp, phục vụ một đơn vị doanh nghiệp; được ghi bởi dùng chung theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ten` | Tên | Văn bản | Tên của doanh nghiệp, phục vụ một đơn vị doanh nghiệp; được ghi bởi dùng chung theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `mui_gio` | Múi giờ | Văn bản | Múi giờ của doanh nghiệp, phục vụ một đơn vị doanh nghiệp; được ghi bởi dùng chung theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `tien_te` | Tiền tệ | Phân loại có danh sách đóng | Tiền tệ của doanh nghiệp, phục vụ một đơn vị doanh nghiệp; được ghi bởi dùng chung theo hồ sơ nguồn của bảng. Giá trị cho phép: VND. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `che_do` | Chế độ | Phân loại có danh sách đóng | Chế độ của doanh nghiệp, phục vụ một đơn vị doanh nghiệp; được ghi bởi dùng chung theo hồ sơ nguồn của bảng. Giá trị cho phép: mo_phong. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Một công ty trong mỗi bộ mô phỏng; không suy ra đa pháp nhân.

**Yêu cầu:** FR01, FR33.

### D002 Bộ phận

**Tên bảng:** `dung_chung.bo_phan`. **Phụ trách:** Nhân sự.

**Mục đích:** Nhóm công việc của 50 người.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của bộ phận, phục vụ nhóm công việc của 50 người; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ten` | Tên | Văn bản | Tên của bộ phận, phục vụ nhóm công việc của 50 người; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dang_su_dung` | Đang sử dụng | Có/không | Đang sử dụng của bộ phận, phục vụ nhóm công việc của 50 người; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_doanh_nghiep` | Mã doanh nghiệp | Mã UUID | Liên kết tới dung_chung.doanh_nghiep; mã doanh nghiệp xác định đúng vai trò hoặc nguồn trong bộ phận. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doanh_nghiep |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Mã duy nhất trong công ty; nhóm hành chính không đồng nghĩa bốn nhân sự chuyên trách.

**Yêu cầu:** FR01, FR28.

### D003 Vị trí giữ hàng

**Tên bảng:** `dung_chung.vi_tri_giu_hang`. **Phụ trách:** Kho / sản xuất / giao hàng.

**Mục đích:** Nơi chịu trách nhiệm giữ hàng.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của vị trí giữ hàng, phục vụ nơi chịu trách nhiệm giữ hàng; được ghi bởi kho / sản xuất / giao hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của vị trí giữ hàng, phục vụ nơi chịu trách nhiệm giữ hàng; được ghi bởi kho / sản xuất / giao hàng theo hồ sơ nguồn của bảng. Giá trị cho phép: vung_trong_kho; xuong; dang_giao; ben_ngoai. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_kho_vat_ly` | Mã kho vật lý | Văn bản | Mã kho vật lý của vị trí giữ hàng, phục vụ nơi chịu trách nhiệm giữ hàng; được ghi bởi kho / sản xuất / giao hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dang_su_dung` | Đang sử dụng | Có/không | Đang sử dụng của vị trí giữ hàng, phục vụ nơi chịu trách nhiệm giữ hàng; được ghi bởi kho / sản xuất / giao hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_doanh_nghiep` | Mã doanh nghiệp | Mã UUID | Liên kết tới dung_chung.doanh_nghiep; mã doanh nghiệp xác định đúng vai trò hoặc nguồn trong vị trí giữ hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doanh_nghiep |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** VT/TP/CC/HL cùng KHO-01. Xưởng/đang giao không cộng vào tồn kho; không dùng vị trí làm kết luận kiểm chất lượng.

**Yêu cầu:** FR01, FR15, FR16, FR21.

### D004 Đơn vị tính

**Tên bảng:** `dung_chung.don_vi_tinh`. **Phụ trách:** Dùng chung.

**Mục đích:** Đơn vị và độ chính xác.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của đơn vị tính, phục vụ đơn vị và độ chính xác; được ghi bởi dùng chung theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dai_luong` | Đại lượng | Phân loại có danh sách đóng | Đại lượng của đơn vị tính, phục vụ đơn vị và độ chính xác; được ghi bởi dùng chung theo hồ sơ nguồn của bảng. Giá trị cho phép: vien; hang_loat; the_tich; thoi_gian. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_chu_so_thap_phan_duoc_phep` | Số chữ số thập phân được phép | Số nguyên nhỏ | Số chữ số thập phân được phép của đơn vị tính, phục vụ đơn vị và độ chính xác; được ghi bởi dùng chung theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Viên=0 số lẻ; kg/lít=3; phút công số nguyên. Đơn vị đóng gói quy đổi theo mặt hàng.

**Yêu cầu:** FR01, FR16, FR29.

### D005 Chứng từ

**Tên bảng:** `dung_chung.chung_tu`. **Phụ trách:** Bộ phận giữ chứng từ.

**Mục đích:** Định danh một phiên bản chứng từ.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của chứng từ, phục vụ định danh một phiên bản chứng từ; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của chứng từ, phục vụ định danh một phiên bản chứng từ; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng. Giá trị cho phép: nhu_cau_khach; bao_gia; don_hang; mau_khach; thay_doi_thuong_mai; don_mua; van_dong_hang; ton_dau; kiem_ke; dinh_muc; lenh_san_xuat; cong_doan; kiem_chat_luong; xu_ly_chat_luong; giao_hang; ghi_ban; giam_ban; tang_ban; de_nghi_chi; chot_gia_thanh; ho_so_lam_viec; ky_nang; su_co; ban_giao_dung_cu; phan_cong; cong; nghi; ky_thu_nhap; khach_nhan; doi_chieu_mua; tien_thuc; tien_dau; dieu_chinh_nghia_vu; nguon_chi_phi; phan_bo_chi_phi; su_kien_phep; nhu_cau_vat_tu; quyet_dinh_danh_muc; quyet_dinh_chinh_sach; quyet_dinh_cap_quyen; quyet_dinh_chot_ky; de_nghi_nhan_su; quyet_dinh_chot_lenh. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_phien_ban_chung_tu` | Số phiên bản chứng từ | Số nguyên | Số phiên bản chứng từ của chứng từ, phục vụ định danh một phiên bản chứng từ; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_phe_duyet` | Trạng thái phê duyệt | Phân loại có danh sách đóng | Trạng thái phê duyệt của chứng từ, phục vụ định danh một phiên bản chứng từ; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng. Giá trị cho phép: nhap; da_trinh; da_tu_choi; da_duyet; da_rut; da_bi_thay_ban. | Sự kiện hoặc quyết định được ghi nhận | — |
| `thoi_diem_co_hieu_luc` | Thời điểm có hiệu lực | Thời điểm có múi giờ | Thời điểm người có thẩm quyền quy định nội dung bắt đầu áp dụng, tách với thời điểm hệ thống ghi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |
| `ly_do` | Lý do | Văn bản | Lý do của chứng từ, phục vụ định danh một phiên bản chứng từ; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_goc` | Mã chứng từ gốc | Mã UUID | Liên kết tới dung_chung.chung_tu; mã chứng từ gốc xác định đúng vai trò hoặc nguồn trong chứng từ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_nhan_vien_phu_trach` | Mã nhân viên phụ trách | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên phụ trách xác định đúng vai trò hoặc nguồn trong chứng từ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_tai_khoan_lap_chung_tu` | Mã tài khoản lập chứng từ | Mã UUID | Liên kết tới truy_cap.tai_khoan_dang_nhap; mã tài khoản lập chứng từ xác định đúng vai trò hoặc nguồn trong chứng từ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | truy_cap.tai_khoan_dang_nhap |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |

**Ràng buộc nghiệp vụ:** Bản đầu ma_chung_tu_goc=tự thân; duy nhất(bộ dữ liệu,root,so_phien_ban_chung_tu). Mã duy nhất theo gốc/loại. Bản đã dùng bất biến; root/loai không đổi. Trạng thái thực hiện ở bảng nghiệp vụ, không suy từ đã duyệt.

**Yêu cầu:** FR01, FR03, FR04, FR05, FR06, FR08, FR10, FR33.

### D006 Dòng chứng từ

**Tên bảng:** `dung_chung.dong_chung_tu`. **Phụ trách:** Bộ phận giữ chứng từ.

**Mục đích:** Mã dòng chung để liên kết và duyệt đúng phần.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `so_thu_tu_dong` | Số thứ tự dòng | Số nguyên | Số thứ tự dòng của dòng chứng từ, phục vụ mã dòng chung để liên kết và duyệt đúng phần; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của dòng chứng từ, phục vụ mã dòng chung để liên kết và duyệt đúng phần; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng. Giá trị cho phép: dong_bao_gia_don_hang; dong_don_mua; dong_van_dong; dong_kiem_ke; dong_dinh_muc; dong_giao_hang; dong_ghi_ban; xac_nhan_khach_nhan; doi_chieu_mua; nguon_chi_phi; phan_bo_chi_phi; yeu_cau_hang_vat_tu; dong_thu_nhap. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong dòng chứng từ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Duy nhất(chứng từ,so_thu_tu_dong). Mỗi dòng có đúng một phần mở rộng nghiệp vụ phù hợp loai; không lưu tiền/lượng lần hai ở đây.

**Yêu cầu:** FR03, FR04, FR05, FR06, FR08, FR27.

### D007 Liên kết chứng từ

**Tên bảng:** `dung_chung.lien_ket_chung_tu`. **Phụ trách:** Bộ phận giữ chứng từ.

**Mục đích:** Nguồn, thay đổi, đảo hoặc thay thế.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `quan_he` | Quan hệ | Phân loại có danh sách đóng | Quan hệ của liên kết chứng từ, phục vụ nguồn, thay đổi, đảo hoặc thay thế; được ghi bởi bộ phận giữ chứng từ theo hồ sơ nguồn của bảng. Giá trị cho phép: nguon_goc; dieu_chinh_ban_goc; dao_nguon_goc; thay_ban_truoc; phu_thuoc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_nguon_lien_ket` | Mã chứng từ nguồn liên kết | Mã UUID | Liên kết tới dung_chung.chung_tu; mã chứng từ nguồn liên kết xác định đúng vai trò hoặc nguồn trong liên kết chứng từ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_chung_tu_dich_lien_ket` | Mã chứng từ đích liên kết | Mã UUID | Liên kết tới dung_chung.chung_tu; mã chứng từ đích liên kết xác định đúng vai trò hoặc nguồn trong liên kết chứng từ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |

**Ràng buộc nghiệp vụ:** Không tự liên kết; duy nhất hai nguồn+loại; kiểm chu trình cho quan hệ thay thế/phụ thuộc. Liên kết không thay FK lượng ở bảng nghiệp vụ.

**Yêu cầu:** FR04, FR06, FR10, FR19, FR27.

### D008 Đề nghị và quyết định phê duyệt

**Tên bảng:** `dung_chung.de_nghi_va_quyet_dinh_phe_duyet`. **Phụ trách:** Theo bảng thẩm quyền B24.

**Mục đích:** Đề nghị, kiểm và quyết định đúng phiên bản.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `hanh_dong` | Hành động | Phân loại có danh sách đóng | Hành động của đề nghị và quyết định phê duyệt, phục vụ đề nghị, kiểm và quyết định đúng phiên bản; được ghi bởi theo bảng thẩm quyền b24 theo hồ sơ nguồn của bảng. Giá trị cho phép: xem; tao; kiem_tra; phe_duyet; xac_nhan; nhan; xuat_du_lieu; huy; dieu_chinh; khoi_phuc; chot_ky; mo_lai_ky; danh_gia_dap_ung; quyet_dinh_uu_tien; chot_lenh. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: da_de_nghi; da_kiem_tra; da_duyet; da_tu_choi; da_thu_hoi_quyen. | Sự kiện hoặc quyết định được ghi nhận | — |
| `thoi_diem_de_nghi` | Thời điểm đề nghị | Thời điểm có múi giờ | Thời điểm đề nghị của đề nghị và quyết định phê duyệt, phục vụ đề nghị, kiểm và quyết định đúng phiên bản; được ghi bởi theo bảng thẩm quyền b24 theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_quyet_dinh` | Thời điểm quyết định | Thời điểm có múi giờ | Thời điểm quyết định của đề nghị và quyết định phê duyệt, phục vụ đề nghị, kiểm và quyết định đúng phiên bản; được ghi bởi theo bảng thẩm quyền b24 theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `gioi_han_so_luong_duoc_duyet` | Giới hạn số lượng được duyệt | Số lượng chính xác | Giới hạn số lượng được duyệt của đề nghị và quyết định phê duyệt, phục vụ đề nghị, kiểm và quyết định đúng phiên bản; được ghi bởi theo bảng thẩm quyền b24 theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `gioi_han_so_tien_duoc_duyet` | Giới hạn số tiền được duyệt | Số tiền VND nguyên đồng | Giới hạn số tiền được duyệt của đề nghị và quyết định phê duyệt, phục vụ đề nghị, kiểm và quyết định đúng phiên bản; được ghi bởi theo bảng thẩm quyền b24 theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ly_do` | Lý do | Văn bản | Lý do của đề nghị và quyết định phê duyệt, phục vụ đề nghị, kiểm và quyết định đúng phiên bản; được ghi bởi theo bảng thẩm quyền b24 theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong đề nghị và quyết định phê duyệt. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_dong_chung_tu` | Mã dòng chứng từ | Mã UUID | Liên kết tới dung_chung.dong_chung_tu; mã dòng chứng từ xác định đúng vai trò hoặc nguồn trong đề nghị và quyết định phê duyệt. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.dong_chung_tu |
| `ma_nhan_vien_de_nghi` | Mã nhân viên đề nghị | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên đề nghị xác định đúng vai trò hoặc nguồn trong đề nghị và quyết định phê duyệt. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_nhan_vien_kiem_tra` | Mã nhân viên kiểm tra | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên kiểm tra xác định đúng vai trò hoặc nguồn trong đề nghị và quyết định phê duyệt. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_nhan_vien_quyet_dinh` | Mã nhân viên quyết định | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên quyết định xác định đúng vai trò hoặc nguồn trong đề nghị và quyết định phê duyệt. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_uy_quyen` | Mã ủy quyền | Mã UUID | Liên kết tới truy_cap.uy_quyen; mã ủy quyền xác định đúng vai trò hoặc nguồn trong đề nghị và quyết định phê duyệt. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | truy_cap.uy_quyen |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** ma_dong_chung_tu có thể trống để duyệt cả nguồn; các người kiểm/duyệt có thể trống khi còn chờ. Dòng phải thuộc đúng chứng từ. So người thật, không chỉ tài khoản. Duyệt tự hưởng hoặc ngoài ủy quyền bị ngăn.

**Yêu cầu:** FR03, FR06, FR08, FR10, FR18, FR24, FR30, FR31.

### D009 Bàn giao công việc

**Tên bảng:** `dung_chung.ban_giao_cong_viec`. **Phụ trách:** Người giao và người nhận.

**Mục đích:** Bàn giao từng phần, việc chờ và phản hồi.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: da_gui; da_chap_nhan; can_bo_sung; da_huy. | Sự kiện hoặc quyết định được ghi nhận | — |
| `so_luong_de_nghi` | Số lượng đề nghị | Số lượng chính xác | Số lượng đề nghị của bàn giao công việc, phục vụ bàn giao từng phần, việc chờ và phản hồi; được ghi bởi người giao và người nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_duoc_chap_nhan` | Số lượng được chấp nhận | Số lượng chính xác | Số lượng được chấp nhận của bàn giao công việc, phục vụ bàn giao từng phần, việc chờ và phản hồi; được ghi bởi người giao và người nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_can_hoan_thanh` | Thời điểm cần hoàn thành | Thời điểm có múi giờ | Thời điểm cần hoàn thành của bàn giao công việc, phục vụ bàn giao từng phần, việc chờ và phản hồi; được ghi bởi người giao và người nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_nhan` | Thời điểm nhận | Thời điểm có múi giờ | Thời điểm nhận của bàn giao công việc, phục vụ bàn giao từng phần, việc chờ và phản hồi; được ghi bởi người giao và người nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ly_do_con_thieu` | Lý do còn thiếu | Văn bản | Lý do còn thiếu của bàn giao công việc, phục vụ bàn giao từng phần, việc chờ và phản hồi; được ghi bởi người giao và người nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong bàn giao công việc. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_dong_chung_tu` | Mã dòng chứng từ | Mã UUID | Liên kết tới dung_chung.dong_chung_tu; mã dòng chứng từ xác định đúng vai trò hoặc nguồn trong bàn giao công việc. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.dong_chung_tu |
| `ma_nhan_vien_ban_giao` | Mã nhân viên bàn giao | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên bàn giao xác định đúng vai trò hoặc nguồn trong bàn giao công việc. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_nhan_vien_nhan_ban_giao` | Mã nhân viên nhận bàn giao | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên nhận bàn giao xác định đúng vai trò hoặc nguồn trong bàn giao công việc. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_don_vi` | Mã đơn vị | Mã UUID | Liên kết tới dung_chung.don_vi_tinh; mã đơn vị xác định đúng vai trò hoặc nguồn trong bàn giao công việc. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.don_vi_tinh |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Lượng nhận không vượt gửi; dòng có thể trống cho việc không có dòng. Không tự tiếp nhận khi quá hạn. Hàng/tiền thực theo sổ riêng.

**Yêu cầu:** FR04, FR10, FR32.

### D010 Chứng cứ đính kèm

**Tên bảng:** `dung_chung.chung_cu_dinh_kem`. **Phụ trách:** Bộ phận của nguồn.

**Mục đích:** Chỉ mục chứng cứ trong kho tệp.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `khoa_tep_trong_noi_luu` | Khóa tệp trong nơi lưu | Văn bản | Khóa tệp trong nơi lưu của chứng cứ đính kèm, phục vụ chỉ mục chứng cứ trong kho tệp; được ghi bởi bộ phận của nguồn theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `ma_kiem_toan_ven` | Mã kiểm toàn vẹn | Văn bản | Mã kiểm toàn vẹn của chứng cứ đính kèm, phục vụ chỉ mục chứng cứ trong kho tệp; được ghi bởi bộ phận của nguồn theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `loai_dinh_dang_tep` | Loại định dạng tệp | Văn bản | Loại định dạng tệp của chứng cứ đính kèm, phục vụ chỉ mục chứng cứ trong kho tệp; được ghi bởi bộ phận của nguồn theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `dung_luong_tep_tinh_theo_byte` | Dung lượng tệp tính theo byte | Số nguyên | Dung lượng tệp tính theo byte của chứng cứ đính kèm, phục vụ chỉ mục chứng cứ trong kho tệp; được ghi bởi bộ phận của nguồn theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `muc_nhay_cam` | Mức nhạy cảm | Phân loại có danh sách đóng | Mức nhạy cảm của chứng cứ đính kèm, phục vụ chỉ mục chứng cứ trong kho tệp; được ghi bởi bộ phận của nguồn theo hồ sơ nguồn của bảng. Giá trị cho phép: duoc_xem_trong_mo_phong; noi_bo; thu_nhap. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `gia_lap` | Giả lập | Có/không | Giả lập của chứng cứ đính kèm, phục vụ chỉ mục chứng cứ trong kho tệp; được ghi bởi bộ phận của nguồn theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong chứng cứ đính kèm. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_dong_chung_tu` | Mã dòng chứng từ | Mã UUID | Liên kết tới dung_chung.dong_chung_tu; mã dòng chứng từ xác định đúng vai trò hoặc nguồn trong chứng cứ đính kèm. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.dong_chung_tu |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Tệp ngoài DB/Git; đường dẫn không công khai; kiểm quyền theo nguồn. Không chứa chữ ký giả như thật.

**Yêu cầu:** FR08, FR09, FR17, FR21, FR28, FR31.

### D011 Nhật ký thao tác

**Tên bảng:** `dung_chung.nhat_ky_thao_tac`. **Phụ trách:** Hệ thống, giới hạn theo nguồn.

**Mục đích:** Dấu vết thao tác và thay đổi.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `hanh_dong` | Hành động | Văn bản | Hành động của nhật ký thao tác, phục vụ dấu vết thao tác và thay đổi; được ghi bởi hệ thống, giới hạn theo nguồn theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |
| `khoa_lien_ket_thao_tac` | Khóa liên kết thao tác | Mã UUID | Khóa liên kết thao tác của nhật ký thao tác, phục vụ dấu vết thao tác và thay đổi; được ghi bởi hệ thống, giới hạn theo nguồn theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `noi_dung_thay_doi_da_luoc_du_lieu_nhay_cam` | Nội dung thay đổi đã lược dữ liệu nhạy cảm | Nội dung có cấu trúc đóng | Nội dung thay đổi đã lược dữ liệu nhạy cảm của nhật ký thao tác, phục vụ dấu vết thao tác và thay đổi; được ghi bởi hệ thống, giới hạn theo nguồn theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ly_do` | Lý do | Văn bản | Lý do của nhật ký thao tác, phục vụ dấu vết thao tác và thay đổi; được ghi bởi hệ thống, giới hạn theo nguồn theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong nhật ký thao tác. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `ma_nhan_vien_duoc_ghi_nhan_thay` | Mã nhân viên được ghi nhận thay | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên được ghi nhận thay xác định đúng vai trò hoặc nguồn trong nhật ký thao tác. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |

**Ràng buộc nghiệp vụ:** Chỉ thêm; người nhập và người được nhập thay riêng; log chung không chứa lương/mật khẩu. Không thay sổ lượng/tiền.

**Yêu cầu:** FR02, FR03, FR05, FR06, FR28, FR33.

### D012 Kỳ nghiệp vụ

**Tên bảng:** `dung_chung.ky_nghiep_vu`. **Phụ trách:** Nhân sự / tài chính / kho theo loại kỳ.

**Mục đích:** Chốt và mở lại kỳ.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `nhom_nghiep_vu` | Nhóm nghiệp vụ | Phân loại có danh sách đóng | Nhóm nghiệp vụ của kỳ nghiệp vụ, phục vụ chốt và mở lại kỳ; được ghi bởi nhân sự / tài chính / kho theo loại kỳ theo hồ sơ nguồn của bảng. Giá trị cho phép: cong; thu_nhap; kho; tai_chinh. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_bat_dau` | Ngày bắt đầu | Ngày địa phương | Ngày bắt đầu của kỳ nghiệp vụ, phục vụ chốt và mở lại kỳ; được ghi bởi nhân sự / tài chính / kho theo loại kỳ theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_ket_thuc` | Ngày kết thúc | Ngày địa phương | Ngày kết thúc của kỳ nghiệp vụ, phục vụ chốt và mở lại kỳ; được ghi bởi nhân sự / tài chính / kho theo loại kỳ theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: dang_mo; da_chot. | Sự kiện hoặc quyết định được ghi nhận | — |
| `thoi_diem_chot` | Thời điểm chốt | Thời điểm có múi giờ | Thời điểm chốt của kỳ nghiệp vụ, phục vụ chốt và mở lại kỳ; được ghi bởi nhân sự / tài chính / kho theo loại kỳ theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_quyet_dinh_chot_ky` | Mã chứng từ quyết định chốt kỳ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã chứng từ quyết định chốt kỳ xác định đúng vai trò hoặc nguồn trong kỳ nghiệp vụ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Chốt công không chốt lương/tiền. Mở lại cần quyết định, log; sửa quá khứ dùng bản điều chỉnh.

**Yêu cầu:** FR06, FR30, FR31.

### D013 Phiên bản chính sách

**Tên bảng:** `dung_chung.phien_ban_chinh_sach`. **Phụ trách:** Bộ phận phụ trách chính sách.

**Mục đích:** Tham số có hiệu lực và căn cứ.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của phiên bản chính sách, phục vụ tham số có hiệu lực và căn cứ; được ghi bởi bộ phận phụ trách chính sách theo hồ sơ nguồn của bảng. Giá trị cho phép: lich_lam; xac_dinh_gia; kiem_chat_luong; san_xuat; thu_nhap; nghi; dinh_gia; canh_bao_ton. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của phiên bản chính sách, phục vụ tham số có hiệu lực và căn cứ; được ghi bởi bộ phận phụ trách chính sách theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_phien_ban` | Số phiên bản | Số nguyên | Số phiên bản của phiên bản chính sách, phục vụ tham số có hiệu lực và căn cứ; được ghi bởi bộ phận phụ trách chính sách theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_hieu_luc` | Thời điểm bắt đầu hiệu lực | Thời điểm có múi giờ | Thời điểm bắt đầu hiệu lực của phiên bản chính sách, phục vụ tham số có hiệu lực và căn cứ; được ghi bởi bộ phận phụ trách chính sách theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_hieu_luc` | Thời điểm kết thúc hiệu lực | Thời điểm có múi giờ | Thời điểm kết thúc hiệu lực của phiên bản chính sách, phục vụ tham số có hiệu lực và căn cứ; được ghi bởi bộ phận phụ trách chính sách theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `tham_so` | Tham số | Nội dung có cấu trúc đóng | Các tham số khai báo có cấu trúc và đơn vị, gắn chứng từ căn cứ/người khai báo/hiệu lực/duyệt; thiếu căn cứ để chờ, không nạp mặc định rồi coi chính sách doanh nghiệp. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `gia_lap` | Giả lập | Có/không | Giả lập của phiên bản chính sách, phục vụ tham số có hiệu lực và căn cứ; được ghi bởi bộ phận phụ trách chính sách theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_khai_bao` | Thời điểm khai báo | Thời điểm có múi giờ | Thời điểm khai báo của phiên bản chính sách, phục vụ tham số có hiệu lực và căn cứ; được ghi bởi bộ phận phụ trách chính sách theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Liên kết tới dung_chung.de_nghi_va_quyet_dinh_phe_duyet; mã phê duyệt xác định đúng vai trò hoặc nguồn trong phiên bản chính sách. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `ma_chung_tu_can_cu_khai_bao` | Mã chứng từ căn cứ khai báo | Mã UUID | Liên kết tới dung_chung.chung_tu; mã chứng từ căn cứ khai báo xác định đúng vai trò hoặc nguồn trong phiên bản chính sách. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_nguoi_khai_bao_du_lieu` | Mã người khai báo dữ liệu | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã người khai báo dữ liệu xác định đúng vai trò hoặc nguồn trong phiên bản chính sách. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Tham số chỉ có hiệu lực khi có chứng từ căn cứ, người khai báo, mốc hiệu lực và quyết định phê duyệt đúng phạm vi; bản đề xuất hoặc thiếu căn cứ không điều khiển giao dịch. Không đặt mặc định để suy kết luận kiểm chất lượng, tự duyệt hoặc phát sinh nhu cầu mua. Bản sửa nối bản trước.

**Yêu cầu:** FR01, FR07, FR08, FR12, FR17, FR26, FR30, FR31.

### D014 Bộ dữ liệu mô phỏng

**Tên bảng:** `dung_chung.bo_du_lieu_mo_phong`. **Phụ trách:** Quản trị bộ mô phỏng.

**Mục đích:** Cách ly cơ sở, mốc và nhánh.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của bộ dữ liệu mô phỏng, phục vụ cách ly cơ sở, mốc và nhánh; được ghi bởi quản trị bộ mô phỏng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `phien_ban_bo_mo_phong` | Phiên bản bộ mô phỏng | Văn bản | Phiên bản bộ mô phỏng của bộ dữ liệu mô phỏng, phục vụ cách ly cơ sở, mốc và nhánh; được ghi bởi quản trị bộ mô phỏng theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `che_do` | Chế độ | Phân loại có danh sách đóng | Chế độ của bộ dữ liệu mô phỏng, phục vụ cách ly cơ sở, mốc và nhánh; được ghi bởi quản trị bộ mô phỏng theo hồ sơ nguồn của bảng. Giá trị cho phép: dau_ky; anh_chup_da_hoan_thanh; nhanh_thu. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_kich_ban_kiem_tra` | Mã kịch bản kiểm tra | Văn bản | Mã kịch bản kiểm tra của bộ dữ liệu mô phỏng, phục vụ cách ly cơ sở, mốc và nhánh; được ghi bởi quản trị bộ mô phỏng theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `thoi_diem_moc_goc` | Thời điểm mốc gốc | Thời điểm có múi giờ | Thời điểm mốc gốc của bộ dữ liệu mô phỏng, phục vụ cách ly cơ sở, mốc và nhánh; được ghi bởi quản trị bộ mô phỏng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: chuan_bi_vao_lam; du_dieu_kien_bat_dau; luu_tru. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ma_kiem_toan_ven_bo_nap` | Mã kiểm toàn vẹn bộ nạp | Văn bản | Mã kiểm toàn vẹn bộ nạp của bộ dữ liệu mô phỏng, phục vụ cách ly cơ sở, mốc và nhánh; được ghi bởi quản trị bộ mô phỏng theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `ma_bo_du_lieu_cha` | Mã bộ dữ liệu cha | Mã UUID | Liên kết tới dung_chung.bo_du_lieu_mo_phong; mã bộ dữ liệu cha xác định đúng vai trò hoặc nguồn trong bộ dữ liệu mô phỏng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.bo_du_lieu_mo_phong |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Duy nhất(ma_nghiep_vu,phien_ban_bo_mo_phong,che_do). Mọi dòng nghiệp vụ gắn workspace_id; nhánh không cộng vào cơ sở. Khôi phục làm bộ mới, giữ bộ cũ lưu trữ; không xóa người dùng/secret.

**Yêu cầu:** FR01, FR05, FR33.

### D015 Tài khoản đăng nhập

**Tên bảng:** `truy_cap.tai_khoan_dang_nhap`. **Phụ trách:** Quản trị truy cập theo quyết định.

**Mục đích:** Tài khoản của người thật.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ten_dang_nhap` | Tên đăng nhập | Văn bản | Tên đăng nhập của tài khoản đăng nhập, phục vụ tài khoản của người thật; được ghi bởi quản trị truy cập theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ban_bam_thong_tin_xac_thuc` | Bản băm thông tin xác thực | Văn bản | Bản băm thông tin xác thực của tài khoản đăng nhập, phục vụ tài khoản của người thật; được ghi bởi quản trị truy cập theo quyết định theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: dang_su_dung; ngung_su_dung. | Sự kiện hoặc quyết định được ghi nhận | — |
| `so_phien_ban_quyen_xac_thuc` | Số phiên bản quyền xác thực | Số nguyên | Số phiên bản quyền xác thực của tài khoản đăng nhập, phục vụ tài khoản của người thật; được ghi bởi quản trị truy cập theo quyết định theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `ma_nguoi_that` | Mã người thật | Mã UUID | Liên kết tới truy_cap.dinh_danh_nguoi; mã người thật xác định đúng vai trò hoặc nguồn trong tài khoản đăng nhập. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | truy_cap.dinh_danh_nguoi |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Nhiều tài khoản trỏ một person ổn định. Hồ sơ nhân sự theo bộ nối cùng person; không bắt 50 người có tài khoản. Credential chỉ băm, không bản rõ hoặc Git.

**Yêu cầu:** FR02, FR03, FR28.

### D016 Vai trò công việc

**Tên bảng:** `truy_cap.vai_tro_cong_viec`. **Phụ trách:** Quản trị truy cập.

**Mục đích:** Nhóm quyền công việc.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của vai trò công việc, phục vụ nhóm quyền công việc; được ghi bởi quản trị truy cập theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ten` | Tên | Văn bản | Tên của vai trò công việc, phục vụ nhóm quyền công việc; được ghi bởi quản trị truy cập theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Vai trò không là phòng ban/người duyệt mới.

**Yêu cầu:** FR02.

### D017 Quyền thao tác

**Tên bảng:** `truy_cap.quyen_thao_tac`. **Phụ trách:** Quản trị truy cập.

**Mục đích:** Quyền của từng vai trò.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai_doi_tuong_phan_quyen` | Loại đối tượng phân quyền | Phân loại có danh sách đóng | Loại đối tượng phân quyền của quyền thao tác, phục vụ quyền của từng vai trò; được ghi bởi quản trị truy cập theo hồ sơ nguồn của bảng. Giá trị cho phép: dung_chung.doanh_nghiep; dung_chung.bo_phan; dung_chung.vi_tri_giu_hang; dung_chung.don_vi_tinh; dung_chung.chung_tu; dung_chung.dong_chung_tu; dung_chung.lien_ket_chung_tu; dung_chung.de_nghi_va_quyet_dinh_phe_duyet; dung_chung.ban_giao_cong_viec; dung_chung.chung_cu_dinh_kem; dung_chung.nhat_ky_thao_tac; dung_chung.ky_nghiep_vu; dung_chung.phien_ban_chinh_sach; dung_chung.bo_du_lieu_mo_phong; truy_cap.tai_khoan_dang_nhap; truy_cap.vai_tro_cong_viec; truy_cap.quyen_thao_tac; truy_cap.cap_vai_tro; truy_cap.uy_quyen; truy_cap.bien_nhan_xac_nhan_giao_dich; danh_muc.san_pham; danh_muc.mat_hang; danh_muc.ma_goi_khac; danh_muc.quy_doi_don_vi; dung_chung.doi_tac; dung_chung.lien_he_doi_tac; dung_chung.can_cu_dai_dien; kinh_doanh.nhu_cau_khach_hang; kinh_doanh.lan_tiep_nhan_nhu_cau; kinh_doanh.thong_so_tu_van; kinh_doanh.bao_gia_va_don_hang; kinh_doanh.dong_bao_gia_va_don_hang; kinh_doanh.mau_khach_duyet; kinh_doanh.ho_so_thay_doi_va_xu_ly_thuong_mai; mua_hang.don_mua_hang; mua_hang.dong_don_mua_hang; mua_hang.phan_bo_hang_dang_ve; kho.lo_hang; kho.phan_lo_hang; kho.phieu_van_dong_hang; kho.dong_van_dong_hang; kho.yeu_cau_hang_va_vat_tu; kho.su_kien_giu_hang; kho.bien_ban_kiem_ke; kho.dong_kiem_ke; san_xuat.phien_ban_dinh_muc_san_xuat; san_xuat.dong_dinh_muc_vat_tu; san_xuat.nguon_luc_san_xuat; san_xuat.lenh_san_xuat; san_xuat.lo_san_xuat; san_xuat.cong_doan_san_xuat; san_xuat.lich_va_su_dung_nguon_luc; san_xuat.vat_tu_thuc_dung; chat_luong.phieu_kiem_tra_chat_luong; chat_luong.ket_qua_tung_tieu_chi_kiem_tra; chat_luong.su_kien_khoa_chat_luong; chat_luong.phuong_an_xu_ly_chat_luong; giao_hang.dot_giao_hang; giao_hang.dong_giao_hang; giao_hang.xac_nhan_khach_nhan_hang; tai_chinh.quy_va_tai_khoan_tien; tai_chinh.de_nghi_chi_tien; tai_chinh.bien_dong_tien_thuc; tai_chinh.nghia_vu_thanh_toan; tai_chinh.dieu_chinh_nghia_vu; tai_chinh.su_kien_su_dung_nguon_tien; tai_chinh.chung_tu_ghi_nhan_ban; tai_chinh.dong_ghi_nhan_ban; tai_chinh.doi_chieu_nghia_vu_mua; tai_chinh.dong_doi_chieu_quy_ngan_hang; tai_chinh.nguon_chi_phi; tai_chinh.phan_bo_chi_phi; tai_chinh.can_cu_phan_bo_chi_phi; tai_chinh.ban_chot_gia_thanh; tai_chinh.bien_dong_gia_tri; nhan_su.nhan_vien; nhan_su.ho_so_lam_viec_theo_hieu_luc; nhan_su.ho_so_ky_nang_va_an_toan; nhan_su.ban_giao_bao_ho_dung_cu; nhan_su.ngay_va_ca_lam_viec; nhan_su.phan_cong_du_kien; nhan_su.ban_cong_nguoi_ngay_ca; nhan_su.khoang_cong_thuc_te; nhan_su.de_nghi_nghi; nhan_su.su_kien_phep; nhan_su.ky_tinh_thu_nhap; nhan_su.dong_thu_nhap_nhan_vien; nhan_su.khoan_thu_nhap_co_can_cu; truy_cap.phien_dang_nhap; tai_chinh.nguon_cua_ban_chot_gia_thanh; truy_cap.dinh_danh_nguoi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `hanh_dong` | Hành động | Phân loại có danh sách đóng | Hành động của quyền thao tác, phục vụ quyền của từng vai trò; được ghi bởi quản trị truy cập theo hồ sơ nguồn của bảng. Giá trị cho phép: xem; tao; kiem_tra; phe_duyet; xac_nhan; dieu_chinh; xuat_khau. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `pham_vi` | Phạm vi | Phân loại có danh sách đóng | Phạm vi của quyền thao tác, phục vụ quyền của từng vai trò; được ghi bởi quản trị truy cập theo hồ sơ nguồn của bảng. Giá trị cho phép: tu_than; da_phan_cong; bo_phan; doanh_nghiep. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `cac_nhom_du_lieu_nhay_cam` | Các nhóm dữ liệu nhạy cảm | Phân loại có danh sách đóng | Các nhóm dữ liệu nhạy cảm của quyền thao tác, phục vụ quyền của từng vai trò; được ghi bởi quản trị truy cập theo hồ sơ nguồn của bảng. Giá trị cho phép: luong_ca_nhan; ho_so_ca_nhan; cong_ca_nhan; chung_cu_han_che; nguon_chi_phi_ca_nhan; thong_tin_xac_thuc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_vai_tro` | Mã vai trò | Mã UUID | Liên kết tới truy_cap.vai_tro_cong_viec; mã vai trò xác định đúng vai trò hoặc nguồn trong quyền thao tác. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | truy_cap.vai_tro_cong_viec |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Duy nhất(role,nguồn lực,hanh_dong,pham_vi); quyền xuất và xem lương tách. Mặc định từ chối.

**Yêu cầu:** FR02, FR32.

### D018 Cấp vai trò

**Tên bảng:** `truy_cap.cap_vai_tro`. **Phụ trách:** Quản trị truy cập theo quyết định.

**Mục đích:** Cấp vai trò có hiệu lực.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `thoi_diem_bat_dau_hieu_luc` | Thời điểm bắt đầu hiệu lực | Thời điểm có múi giờ | Thời điểm bắt đầu hiệu lực của cấp vai trò, phục vụ cấp vai trò có hiệu lực; được ghi bởi quản trị truy cập theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_hieu_luc` | Thời điểm kết thúc hiệu lực | Thời điểm có múi giờ | Thời điểm kết thúc hiệu lực của cấp vai trò, phục vụ cấp vai trò có hiệu lực; được ghi bởi quản trị truy cập theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_thu_hoi_quyen` | Thời điểm thu hồi quyền | Thời điểm có múi giờ | Thời điểm thu hồi quyền của cấp vai trò, phục vụ cấp vai trò có hiệu lực; được ghi bởi quản trị truy cập theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_tai_khoan` | Mã tài khoản | Mã UUID | Liên kết tới truy_cap.tai_khoan_dang_nhap; mã tài khoản xác định đúng vai trò hoặc nguồn trong cấp vai trò. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | truy_cap.tai_khoan_dang_nhap |
| `ma_vai_tro` | Mã vai trò | Mã UUID | Liên kết tới truy_cap.vai_tro_cong_viec; mã vai trò xác định đúng vai trò hoặc nguồn trong cấp vai trò. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | truy_cap.vai_tro_cong_viec |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Liên kết tới dung_chung.de_nghi_va_quyet_dinh_phe_duyet; mã phê duyệt xác định đúng vai trò hoặc nguồn trong cấp vai trò. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Không tự cấp cho mình; ngừng quyền khi nghỉ hiệu lực. Cấp quyền chỉ là nguồn cho kiểm tra, không được mở toàn dữ liệu.

**Yêu cầu:** FR02, FR28.

### D019 Ủy quyền

**Tên bảng:** `truy_cap.uy_quyen`. **Phụ trách:** Giám đốc / người có thẩm quyền.

**Mục đích:** Ủy quyền giới hạn.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `hanh_dong` | Hành động | Phân loại có danh sách đóng | Hành động của ủy quyền, phục vụ ủy quyền giới hạn; được ghi bởi giám đốc / người có thẩm quyền theo hồ sơ nguồn của bảng. Giá trị cho phép: xem; tao; kiem_tra; phe_duyet; xac_nhan; nhan; xuat_du_lieu; huy; dieu_chinh; khoi_phuc; chot_ky; mo_lai_ky; danh_gia_dap_ung; quyet_dinh_uu_tien; chot_lenh. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai_doi_tuong_phan_quyen` | Loại đối tượng phân quyền | Phân loại có danh sách đóng | Loại đối tượng phân quyền của ủy quyền, phục vụ ủy quyền giới hạn; được ghi bởi giám đốc / người có thẩm quyền theo hồ sơ nguồn của bảng. Giá trị cho phép: dung_chung.doanh_nghiep; dung_chung.bo_phan; dung_chung.vi_tri_giu_hang; dung_chung.don_vi_tinh; dung_chung.chung_tu; dung_chung.dong_chung_tu; dung_chung.lien_ket_chung_tu; dung_chung.de_nghi_va_quyet_dinh_phe_duyet; dung_chung.ban_giao_cong_viec; dung_chung.chung_cu_dinh_kem; dung_chung.nhat_ky_thao_tac; dung_chung.ky_nghiep_vu; dung_chung.phien_ban_chinh_sach; dung_chung.bo_du_lieu_mo_phong; truy_cap.tai_khoan_dang_nhap; truy_cap.vai_tro_cong_viec; truy_cap.quyen_thao_tac; truy_cap.cap_vai_tro; truy_cap.uy_quyen; truy_cap.bien_nhan_xac_nhan_giao_dich; danh_muc.san_pham; danh_muc.mat_hang; danh_muc.ma_goi_khac; danh_muc.quy_doi_don_vi; dung_chung.doi_tac; dung_chung.lien_he_doi_tac; dung_chung.can_cu_dai_dien; kinh_doanh.nhu_cau_khach_hang; kinh_doanh.lan_tiep_nhan_nhu_cau; kinh_doanh.thong_so_tu_van; kinh_doanh.bao_gia_va_don_hang; kinh_doanh.dong_bao_gia_va_don_hang; kinh_doanh.mau_khach_duyet; kinh_doanh.ho_so_thay_doi_va_xu_ly_thuong_mai; mua_hang.don_mua_hang; mua_hang.dong_don_mua_hang; mua_hang.phan_bo_hang_dang_ve; kho.lo_hang; kho.phan_lo_hang; kho.phieu_van_dong_hang; kho.dong_van_dong_hang; kho.yeu_cau_hang_va_vat_tu; kho.su_kien_giu_hang; kho.bien_ban_kiem_ke; kho.dong_kiem_ke; san_xuat.phien_ban_dinh_muc_san_xuat; san_xuat.dong_dinh_muc_vat_tu; san_xuat.nguon_luc_san_xuat; san_xuat.lenh_san_xuat; san_xuat.lo_san_xuat; san_xuat.cong_doan_san_xuat; san_xuat.lich_va_su_dung_nguon_luc; san_xuat.vat_tu_thuc_dung; chat_luong.phieu_kiem_tra_chat_luong; chat_luong.ket_qua_tung_tieu_chi_kiem_tra; chat_luong.su_kien_khoa_chat_luong; chat_luong.phuong_an_xu_ly_chat_luong; giao_hang.dot_giao_hang; giao_hang.dong_giao_hang; giao_hang.xac_nhan_khach_nhan_hang; tai_chinh.quy_va_tai_khoan_tien; tai_chinh.de_nghi_chi_tien; tai_chinh.bien_dong_tien_thuc; tai_chinh.nghia_vu_thanh_toan; tai_chinh.dieu_chinh_nghia_vu; tai_chinh.su_kien_su_dung_nguon_tien; tai_chinh.chung_tu_ghi_nhan_ban; tai_chinh.dong_ghi_nhan_ban; tai_chinh.doi_chieu_nghia_vu_mua; tai_chinh.dong_doi_chieu_quy_ngan_hang; tai_chinh.nguon_chi_phi; tai_chinh.phan_bo_chi_phi; tai_chinh.can_cu_phan_bo_chi_phi; tai_chinh.ban_chot_gia_thanh; tai_chinh.bien_dong_gia_tri; nhan_su.nhan_vien; nhan_su.ho_so_lam_viec_theo_hieu_luc; nhan_su.ho_so_ky_nang_va_an_toan; nhan_su.ban_giao_bao_ho_dung_cu; nhan_su.ngay_va_ca_lam_viec; nhan_su.phan_cong_du_kien; nhan_su.ban_cong_nguoi_ngay_ca; nhan_su.khoang_cong_thuc_te; nhan_su.de_nghi_nghi; nhan_su.su_kien_phep; nhan_su.ky_tinh_thu_nhap; nhan_su.dong_thu_nhap_nhan_vien; nhan_su.khoan_thu_nhap_co_can_cu; truy_cap.phien_dang_nhap; tai_chinh.nguon_cua_ban_chot_gia_thanh; truy_cap.dinh_danh_nguoi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_hieu_luc` | Thời điểm bắt đầu hiệu lực | Thời điểm có múi giờ | Thời điểm bắt đầu hiệu lực của ủy quyền, phục vụ ủy quyền giới hạn; được ghi bởi giám đốc / người có thẩm quyền theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_hieu_luc` | Thời điểm kết thúc hiệu lực | Thời điểm có múi giờ | Thời điểm kết thúc hiệu lực của ủy quyền, phục vụ ủy quyền giới hạn; được ghi bởi giám đốc / người có thẩm quyền theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `gioi_han_so_luong_duoc_duyet` | Giới hạn số lượng được duyệt | Số lượng chính xác | Giới hạn số lượng được duyệt của ủy quyền, phục vụ ủy quyền giới hạn; được ghi bởi giám đốc / người có thẩm quyền theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `gioi_han_so_tien_duoc_duyet` | Giới hạn số tiền được duyệt | Số tiền VND nguyên đồng | Giới hạn số tiền được duyệt của ủy quyền, phục vụ ủy quyền giới hạn; được ghi bởi giám đốc / người có thẩm quyền theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_thu_hoi_quyen` | Thời điểm thu hồi quyền | Thời điểm có múi giờ | Thời điểm thu hồi quyền của ủy quyền, phục vụ ủy quyền giới hạn; được ghi bởi giám đốc / người có thẩm quyền theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_nhan_vien_giao_uy_quyen` | Mã nhân viên giao ủy quyền | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên giao ủy quyền xác định đúng vai trò hoặc nguồn trong ủy quyền. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_nhan_vien_nhan_uy_quyen` | Mã nhân viên nhận ủy quyền | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên nhận ủy quyền xác định đúng vai trò hoặc nguồn trong ủy quyền. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong ủy quyền. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Liên kết tới dung_chung.de_nghi_va_quyet_dinh_phe_duyet; mã phê duyệt xác định đúng vai trò hoặc nguồn trong ủy quyền. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Nguồn cụ thể có thể trống nếu phạm vi loại; không ủy quyền tiếp; không tự hưởng; duyệt mới kiểm thời hạn, quyết định cũ giữ nguyên.

**Yêu cầu:** FR02, FR03, FR24, FR31.

### D020 Biên nhận xác nhận giao dịch

**Tên bảng:** `truy_cap.bien_nhan_xac_nhan_giao_dich`. **Phụ trách:** Hệ thống.

**Mục đích:** Chống ghi trùng và đối chiếu mất phản hồi.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `khoa_chong_xac_nhan_lap` | Khóa chống xác nhận lặp | Văn bản | Khóa chống xác nhận lặp của biên nhận xác nhận giao dịch, phục vụ chống ghi trùng và đối chiếu mất phản hồi; được ghi bởi hệ thống theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `hanh_dong` | Hành động | Phân loại có danh sách đóng | Hành động của biên nhận xác nhận giao dịch, phục vụ chống ghi trùng và đối chiếu mất phản hồi; được ghi bởi hệ thống theo hồ sơ nguồn của bảng. Giá trị cho phép: xem; tao; kiem_tra; phe_duyet; xac_nhan; nhan; xuat_du_lieu; huy; dieu_chinh; khoi_phuc; chot_ky; mo_lai_ky; danh_gia_dap_ung; quyet_dinh_uu_tien; chot_lenh. | Dữ liệu kỹ thuật | — |
| `ban_bam_noi_dung_yeu_cau` | Bản băm nội dung yêu cầu | Văn bản | Bản băm nội dung yêu cầu của biên nhận xác nhận giao dịch, phục vụ chống ghi trùng và đối chiếu mất phản hồi; được ghi bởi hệ thống theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: da_ghi_toan_phan. | Sự kiện hoặc quyết định được ghi nhận | — |
| `thoi_diem_ghi_nhan_toan_phan` | Thời điểm ghi nhận toàn phần | Thời điểm có múi giờ | Thời điểm ghi nhận toàn phần của biên nhận xác nhận giao dịch, phục vụ chống ghi trùng và đối chiếu mất phản hồi; được ghi bởi hệ thống theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `cac_ma_ket_qua_da_ghi_nhan` | Các mã kết quả đã ghi nhận | Nội dung có cấu trúc đóng | Các mã kết quả đã ghi nhận của biên nhận xác nhận giao dịch, phục vụ chống ghi trùng và đối chiếu mất phản hồi; được ghi bởi hệ thống theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_tai_khoan` | Mã tài khoản | Mã UUID | Liên kết tới truy_cap.tai_khoan_dang_nhap; mã tài khoản xác định đúng vai trò hoặc nguồn trong biên nhận xác nhận giao dịch. Mã phải tồn tại, đúng bản và phạm vi. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong biên nhận xác nhận giao dịch. Mã phải tồn tại, đúng bản và phạm vi. | Dữ liệu kỹ thuật | dung_chung.chung_tu |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |

**Ràng buộc nghiệp vụ:** Duy nhất(bộ dữ liệu,hanh_dong,khoa_chong_xac_nhan_lap); cùng khóa khác nội dung từ chối. Tạo trong cùng giao dịch nguyên tử với kết quả, không ghi thành công trước commit.

**Yêu cầu:** FR05, FR33.

### D021 Sản phẩm

**Tên bảng:** `danh_muc.san_pham`. **Phụ trách:** Kinh doanh / sản xuất.

**Mục đích:** Nhóm mẫu ngói/Terrazzo.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của sản phẩm, phục vụ nhóm mẫu ngói/gạch terrazzo; được ghi bởi kinh doanh / sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ten` | Tên | Văn bản | Tên của sản phẩm, phục vụ nhóm mẫu ngói/gạch terrazzo; được ghi bởi kinh doanh / sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `nhom_san_pham` | Nhóm sản phẩm | Phân loại có danh sách đóng | Nhóm sản phẩm của sản phẩm, phục vụ nhóm mẫu ngói/gạch terrazzo; được ghi bởi kinh doanh / sản xuất theo hồ sơ nguồn của bảng. Giá trị cho phép: ngoi; gach_terrazzo; phu_kien. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dang_su_dung` | Đang sử dụng | Có/không | Đang sử dụng của sản phẩm, phục vụ nhóm mẫu ngói/gạch terrazzo; được ghi bởi kinh doanh / sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Không giữ tồn theo sản phẩm cha; mã khác có nguồn B07.

**Yêu cầu:** FR01, FR07, FR08.

### D022 Mặt hàng

**Tên bảng:** `danh_muc.mat_hang`. **Phụ trách:** Kho cùng bộ phận sử dụng.

**Mục đích:** Vật tư hoặc biến thể có thể giao dịch.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ten` | Tên | Văn bản | Tên của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng. Giá trị cho phép: vat_tu; thanh_pham; bao_ho. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_mau` | Mã màu | Văn bản | Mã màu của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_quy_cach` | Mã quy cách | Văn bản | Mã quy cách của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `chieu_rong_mi_li_met` | Chiều rộng mi li mét | Số thập phân chính xác | Chiều rộng mi li mét của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `chieu_dai_mi_li_met` | Chiều dài mi li mét | Số thập phân chính xác | Chiều dài mi li mét của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_vien_tren_met_vuong_theo_quy_cach` | Số viên trên mét vuông theo quy cách | Số thập phân chính xác | Số viên trên mét vuông theo quy cách của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `bat_buoc_duyet_mau_rieng` | Bắt buộc duyệt mẫu riêng | Có/không | Bắt buộc duyệt mẫu riêng của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dang_su_dung` | Đang sử dụng | Có/không | Đang sử dụng của mặt hàng, phục vụ vật tư hoặc biến thể có thể giao dịch; được ghi bởi kho cùng bộ phận sử dụng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_san_pham` | Mã sản phẩm | Mã UUID | Liên kết tới danh_muc.san_pham; mã sản phẩm xác định đúng vai trò hoặc nguồn trong mặt hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.san_pham |
| `ma_don_vi_co_so` | Mã đơn vị cơ sở | Mã UUID | Liên kết tới dung_chung.don_vi_tinh; mã đơn vị cơ sở xác định đúng vai trò hoặc nguồn trong mặt hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.don_vi_tinh |
| `ma_phien_ban_quy_cach` | Mã phiên bản quy cách | Mã UUID | Liên kết tới dung_chung.phien_ban_chinh_sach; mã phiên bản quy cách xác định đúng vai trò hoặc nguồn trong mặt hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** product có thể trống cho vật tư/bảo hộ. Duy nhất(bộ dữ liệu,ma_nghiep_vu). Bản quy cách quan trọng tạo mặt hàng/spec mới và ngừng mã cũ, không sửa ngược lịch sử; density không là định mức sản xuất.

**Yêu cầu:** FR01, FR07, FR08, FR11, FR16.

### D023 Mã gọi khác

**Tên bảng:** `danh_muc.ma_goi_khac`. **Phụ trách:** Kinh doanh / kho.

**Mục đích:** Mã trang mạng/cũ trỏ mã chuẩn.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_goi_khac` | Mã gọi khác | Văn bản | Mã gọi khác của mã gọi khác, phục vụ mã trang mạng/cũ trỏ mã chuẩn; được ghi bởi kinh doanh / kho theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `chung_cu` | Chứng cứ | Văn bản | Chứng cứ của mã gọi khác, phục vụ mã trang mạng/cũ trỏ mã chuẩn; được ghi bởi kinh doanh / kho theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_hieu_luc` | Thời điểm bắt đầu hiệu lực | Ngày địa phương | Thời điểm bắt đầu hiệu lực của mã gọi khác, phục vụ mã trang mạng/cũ trỏ mã chuẩn; được ghi bởi kinh doanh / kho theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_san_pham` | Mã sản phẩm | Mã UUID | Liên kết tới danh_muc.san_pham; mã sản phẩm xác định đúng vai trò hoặc nguồn trong mã gọi khác. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.san_pham |
| `ma_mat_hang` | Mã mặt hàng | Mã UUID | Liên kết tới danh_muc.mat_hang; mã mặt hàng xác định đúng vai trò hoặc nguồn trong mã gọi khác. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.mat_hang |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Chính xác một đích product hoặc mặt hàng; duy nhất ma_goi_khac chuẩn hóa; ma_goi_khac product không tự đoán màu.

**Yêu cầu:** FR01, FR07.

### D024 Quy đổi đơn vị

**Tên bảng:** `danh_muc.quy_doi_don_vi`. **Phụ trách:** Kho / mua hàng.

**Mục đích:** Quy đổi đóng gói theo hàng, có bản.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `so_phien_ban` | Số phiên bản | Số nguyên | Số phiên bản của quy đổi đơn vị, phục vụ quy đổi đóng gói theo hàng, có bản; được ghi bởi kho / mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `he_so` | Hệ số | Số thập phân chính xác | Hệ số của quy đổi đơn vị, phục vụ quy đổi đóng gói theo hàng, có bản; được ghi bởi kho / mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_hieu_luc` | Thời điểm bắt đầu hiệu lực | Ngày địa phương | Thời điểm bắt đầu hiệu lực của quy đổi đơn vị, phục vụ quy đổi đóng gói theo hàng, có bản; được ghi bởi kho / mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_hieu_luc` | Thời điểm kết thúc hiệu lực | Ngày địa phương | Thời điểm kết thúc hiệu lực của quy đổi đơn vị, phục vụ quy đổi đóng gói theo hàng, có bản; được ghi bởi kho / mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_mat_hang` | Mã mặt hàng | Mã UUID | Liên kết tới danh_muc.mat_hang; mã mặt hàng xác định đúng vai trò hoặc nguồn trong quy đổi đơn vị. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.mat_hang |
| `ma_don_vi_quy_doi_nguon` | Mã đơn vị quy đổi nguồn | Mã UUID | Liên kết tới dung_chung.don_vi_tinh; mã đơn vị quy đổi nguồn xác định đúng vai trò hoặc nguồn trong quy đổi đơn vị. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.don_vi_tinh |
| `ma_don_vi_quy_doi_dich` | Mã đơn vị quy đổi đích | Mã UUID | Liên kết tới dung_chung.don_vi_tinh; mã đơn vị quy đổi đích xác định đúng vai trò hoặc nguồn trong quy đổi đơn vị. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.don_vi_tinh |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Liên kết tới dung_chung.de_nghi_va_quyet_dinh_phe_duyet; mã phê duyệt xác định đúng vai trò hoặc nguồn trong quy đổi đơn vị. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Factor>0; không sửa bản đã dùng; CEM 50kg/bao chỉ cho CEM. Thiếu quy đổi bị ngăn.

**Yêu cầu:** FR01, FR14, FR15, FR16.

### D025 Đối tác

**Tên bảng:** `dung_chung.doi_tac`. **Phụ trách:** Kinh doanh / mua hàng.

**Mục đích:** Một đối tác dùng chung mua/bán/trả/nhận.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của đối tác, phục vụ một đối tác dùng chung mua/bán/trả/nhận; được ghi bởi kinh doanh / mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ten` | Tên | Văn bản | Tên của đối tác, phục vụ một đối tác dùng chung mua/bán/trả/nhận; được ghi bởi kinh doanh / mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `cac_vai_tro` | Các vai trò | Phân loại có danh sách đóng | Các vai trò của đối tác, phục vụ một đối tác dùng chung mua/bán/trả/nhận; được ghi bởi kinh doanh / mua hàng theo hồ sơ nguồn của bảng. Giá trị cho phép: khach_hang; nha_cung_cap; ben_tra_tien; ben_nhan_hang; ben_van_chuyen. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `nhom_khach_hang` | Nhóm khách hàng | Phân loại có danh sách đóng | Nhóm khách hàng của đối tác, phục vụ một đối tác dùng chung mua/bán/trả/nhận; được ghi bởi kinh doanh / mua hàng theo hồ sơ nguồn của bảng. Giá trị cho phép: dai_ly; nha_thau; chu_cong_trinh; khach_le; xuat_khau. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dang_su_dung` | Đang sử dụng | Có/không | Đang sử dụng của đối tác, phục vụ một đối tác dùng chung mua/bán/trả/nhận; được ghi bởi kinh doanh / mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Một đối tác nhiều vai trò, không sao chép riêng cho từng bộ phận; chưa rõ bên trả được để chờ.

**Yêu cầu:** FR01, FR07, FR08, FR14, FR23, FR25.

### D026 Liên hệ đối tác

**Tên bảng:** `dung_chung.lien_he_doi_tac`. **Phụ trách:** Bộ phận phụ trách đối tác.

**Mục đích:** Người liên hệ và địa điểm.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ten` | Tên | Văn bản | Tên của liên hệ đối tác, phục vụ người liên hệ và địa điểm; được ghi bởi bộ phận phụ trách đối tác theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `kenh_lien_he` | Kênh liên hệ | Văn bản | Kênh liên hệ của liên hệ đối tác, phục vụ người liên hệ và địa điểm; được ghi bởi bộ phận phụ trách đối tác theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dia_chi` | Địa chỉ | Văn bản | Địa chỉ của liên hệ đối tác, phục vụ người liên hệ và địa điểm; được ghi bởi bộ phận phụ trách đối tác theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dang_su_dung` | Đang sử dụng | Có/không | Đang sử dụng của liên hệ đối tác, phục vụ người liên hệ và địa điểm; được ghi bởi bộ phận phụ trách đối tác theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_doi_tac` | Mã đối tác | Mã UUID | Liên kết tới dung_chung.doi_tac; mã đối tác xác định đúng vai trò hoặc nguồn trong liên hệ đối tác. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Địa chỉ giao lưu ảnh chụp trên đợt/đơn để thay liên hệ không sửa lịch sử.

**Yêu cầu:** FR07, FR08, FR21.

### D027 Căn cứ đại diện

**Tên bảng:** `dung_chung.can_cu_dai_dien`. **Phụ trách:** Kinh doanh / tài chính.

**Mục đích:** Căn cứ đại diện hoặc trả thay.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `hanh_dong` | Hành động | Phân loại có danh sách đóng | Hành động của căn cứ đại diện, phục vụ căn cứ đại diện hoặc trả thay; được ghi bởi kinh doanh / tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: xac_nhan_don; duyet_mau; doi_don; tra_thay; nhan. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_hieu_luc` | Thời điểm bắt đầu hiệu lực | Thời điểm có múi giờ | Thời điểm bắt đầu hiệu lực của căn cứ đại diện, phục vụ căn cứ đại diện hoặc trả thay; được ghi bởi kinh doanh / tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_hieu_luc` | Thời điểm kết thúc hiệu lực | Thời điểm có múi giờ | Thời điểm kết thúc hiệu lực của căn cứ đại diện, phục vụ căn cứ đại diện hoặc trả thay; được ghi bởi kinh doanh / tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_chung_tu_lam_can_cu` | Mã chứng từ làm căn cứ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã chứng từ làm căn cứ xác định đúng vai trò hoặc nguồn trong căn cứ đại diện. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_doi_tac` | Mã đối tác | Mã UUID | Liên kết tới dung_chung.doi_tac; mã đối tác xác định đúng vai trò hoặc nguồn trong căn cứ đại diện. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `ma_lien_he` | Mã liên hệ | Mã UUID | Liên kết tới dung_chung.lien_he_doi_tac; mã liên hệ xác định đúng vai trò hoặc nguồn trong căn cứ đại diện. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.lien_he_doi_tac |
| `ma_chung_tu_xac_dinh_pham_vi` | Mã chứng từ xác định phạm vi | Mã UUID | Liên kết tới dung_chung.chung_tu; mã chứng từ xác định phạm vi xác định đúng vai trò hoặc nguồn trong căn cứ đại diện. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_doi_tac_dai_dien` | Mã đối tác đại diện | Mã UUID | Liên kết tới dung_chung.doi_tac; mã đối tác đại diện xác định đúng vai trò hoặc nguồn trong căn cứ đại diện. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Scope có thể trống nếu giấy đại diện chung; trả thay không quyền đổi/duyệt mẫu; kiểm đúng nguồn/thời hạn. ma_doi_tac là bên được đại diện; ma_doi_tac_dai_dien là tổ chức đại diện/trả thay nếu khác, contact là người ký căn cứ.

**Yêu cầu:** FR08, FR09, FR10, FR23.

### D028 Nhu cầu khách hàng

**Tên bảng:** `kinh_doanh.nhu_cau_khach_hang`. **Phụ trách:** Kinh doanh.

**Mục đích:** Một nhu cầu, nhiều lần liên hệ.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `trang_thai_thuc_hien` | Trạng thái thực hiện | Phân loại có danh sách đóng | Trạng thái của sự kiện do người phụ trách xác nhận; không tự nạp đã hoàn tất. Trạng thái tổng hợp từ nhiều sự kiện chỉ tính khi xem. Giá trị cho phép: dang_mo; dang_lam_ro; da_bao_gia; da_chuyen_thanh_don; da_chot. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ghi_chu_cong_trinh` | Ghi chú công trình | Văn bản | Ghi chú công trình của nhu cầu khách hàng, phục vụ một nhu cầu, nhiều lần liên hệ; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `tinh_trang_dieu_kien_xuat_khau` | Tình trạng điều kiện xuất khẩu | Phân loại có danh sách đóng | Tình trạng điều kiện xuất khẩu của nhu cầu khách hàng, phục vụ một nhu cầu, nhiều lần liên hệ; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. Giá trị cho phép: khong_ap_dung; cho_xu_ly; da_xac_dinh. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong nhu cầu khách hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_khach_hang` | Mã khách hàng | Mã UUID | Liên kết tới dung_chung.doi_tac; mã khách hàng xác định đúng vai trò hoặc nguồn trong nhu cầu khách hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `ma_lien_he` | Mã liên hệ | Mã UUID | Liên kết tới dung_chung.lien_he_doi_tac; mã liên hệ xác định đúng vai trò hoặc nguồn trong nhu cầu khách hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.lien_he_doi_tac |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Nhu cầu chưa đủ không tự thành đơn; khách xuất khẩu chờ điều kiện.

**Yêu cầu:** FR07.

### D029 Lần tiếp nhận nhu cầu

**Tên bảng:** `kinh_doanh.lan_tiep_nhan_nhu_cau`. **Phụ trách:** Kinh doanh.

**Mục đích:** Các kênh và lần tiếp nhận.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `kenh_tiep_nhan` | Kênh tiếp nhận | Phân loại có danh sách đóng | Kênh tiếp nhận của lần tiếp nhận nhu cầu, phục vụ các kênh và lần tiếp nhận; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. Giá trị cho phép: dien_thoai; thu_dien_tu; trang_mang; lien_he_ca_nhan; gioi_thieu. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_nhan` | Thời điểm nhận | Thời điểm có múi giờ | Thời điểm nhận của lần tiếp nhận nhu cầu, phục vụ các kênh và lần tiếp nhận; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `noi_dung_tiep_nhan` | Nội dung tiếp nhận | Văn bản | Nội dung tiếp nhận của lần tiếp nhận nhu cầu, phục vụ các kênh và lần tiếp nhận; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_doi_chieu_ben_ngoai` | Mã đối chiếu bên ngoài | Văn bản | Mã đối chiếu bên ngoài của lần tiếp nhận nhu cầu, phục vụ các kênh và lần tiếp nhận; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_nhu_cau_khach` | Mã chứng từ nhu cầu khách | Mã UUID | Liên kết tới kinh_doanh.nhu_cau_khach_hang; mã chứng từ nhu cầu khách xác định đúng vai trò hoặc nguồn trong lần tiếp nhận nhu cầu. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.nhu_cau_khach_hang |
| `ma_tai_khoan_nhap_du_lieu` | Mã tài khoản nhập dữ liệu | Mã UUID | Liên kết tới truy_cap.tai_khoan_dang_nhap; mã tài khoản nhập dữ liệu xác định đúng vai trò hoặc nguồn trong lần tiếp nhận nhu cầu. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | truy_cap.tai_khoan_dang_nhap |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Nhiều kênh thuộc cùng inquiry, không tạo nhiều đơn tự động.

**Yêu cầu:** FR07.

### D030 Thông số tư vấn

**Tên bảng:** `kinh_doanh.thong_so_tu_van`. **Phụ trách:** Kinh doanh / sản xuất kiểm.

**Mục đích:** Tư vấn số viên từ diện tích.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `dien_tich_met_vuong` | Diện tích mét vuông | Số thập phân chính xác | Diện tích mét vuông của thông số tư vấn, phục vụ tư vấn số viên từ diện tích; được ghi bởi kinh doanh / sản xuất kiểm theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_vien_tren_met_vuong_theo_quy_cach` | Số viên trên mét vuông theo quy cách | Số thập phân chính xác | Số viên trên mét vuông theo quy cách của thông số tư vấn, phục vụ tư vấn số viên từ diện tích; được ghi bởi kinh doanh / sản xuất kiểm theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ty_le_du_phong_tu_van` | Tỷ lệ dự phòng tư vấn | Tỷ lệ từ 0 đến 1 | Tỷ lệ dự phòng tư vấn của thông số tư vấn, phục vụ tư vấn số viên từ diện tích; được ghi bởi kinh doanh / sản xuất kiểm theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: uoc_tinh; khach_da_xac_nhan. | Sự kiện hoặc quyết định được ghi nhận | — |
| `can_cu_khach_xac_nhan` | Căn cứ khách xác nhận | Văn bản | Căn cứ khách xác nhận của thông số tư vấn, phục vụ tư vấn số viên từ diện tích; được ghi bởi kinh doanh / sản xuất kiểm theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_vien_khach_xac_nhan` | Số viên khách xác nhận | Số lượng chính xác | Số viên được khách xác nhận trong căn cứ riêng; nếu chưa xác nhận để trống, số viên ước tính chỉ là kết quả tính khi xem. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_nhu_cau_khach` | Mã chứng từ nhu cầu khách | Mã UUID | Liên kết tới kinh_doanh.nhu_cau_khach_hang; mã chứng từ nhu cầu khách xác định đúng vai trò hoặc nguồn trong thông số tư vấn. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.nhu_cau_khach_hang |
| `ma_mat_hang` | Mã mặt hàng | Mã UUID | Liên kết tới danh_muc.mat_hang; mã mặt hàng xác định đúng vai trò hoặc nguồn trong thông số tư vấn. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.mat_hang |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Liên kết tới dung_chung.phien_ban_chinh_sach; mã phiên bản chính sách xác định đúng vai trò hoặc nguồn trong thông số tư vấn. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Diện tích, định mức viên/mét vuông và tỷ lệ dự phòng có nguồn khai báo. Số viên ước tính làm tròn lên khi xem; khách xác nhận lượng thì ghi riêng cùng chứng cứ. Phụ kiện là dòng riêng, dự phòng tư vấn không tự tăng định mức vật tư.

**Yêu cầu:** FR07.

### D031 Báo giá và đơn hàng

**Tên bảng:** `kinh_doanh.bao_gia_va_don_hang`. **Phụ trách:** Kinh doanh.

**Mục đích:** Báo giá hoặc đơn đúng phiên bản.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. Giá trị cho phép: bao_gia; don_hang. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_het_hieu_luc` | Thời điểm hết hiệu lực | Thời điểm có múi giờ | Thời điểm hết hiệu lực của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_xac_nhan` | Thời điểm xác nhận | Thời điểm có múi giờ | Thời điểm xác nhận của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien_dat_coc_yeu_cau` | Số tiền đặt cọc yêu cầu | Số tiền VND nguyên đồng | Số tiền đặt cọc yêu cầu của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dieu_kien_thanh_toan` | Điều kiện thanh toán | Văn bản | Điều kiện thanh toán của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dieu_kien_giao_hang` | Điều kiện giao hàng | Văn bản | Điều kiện giao hàng của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `pham_vi_mo_phong_thue` | Phạm vi mô phỏng thuế | Phân loại có danh sách đóng | Phạm vi mô phỏng thuế của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. Giá trị cho phép: chua_mo_phong. | Dữ liệu kỹ thuật | — |
| `can_cu_khach_xac_nhan` | Căn cứ khách xác nhận | Văn bản | Căn cứ khách xác nhận của báo giá và đơn hàng, phục vụ báo giá hoặc đơn đúng phiên bản; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong báo giá và đơn hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_chung_tu_nhu_cau_khach` | Mã chứng từ nhu cầu khách | Mã UUID | Liên kết tới kinh_doanh.nhu_cau_khach_hang; mã chứng từ nhu cầu khách xác định đúng vai trò hoặc nguồn trong báo giá và đơn hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.nhu_cau_khach_hang |
| `ma_ben_mua` | Mã bên mua | Mã UUID | Liên kết tới dung_chung.doi_tac; mã bên mua xác định đúng vai trò hoặc nguồn trong báo giá và đơn hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `ma_ben_tra_tien` | Mã bên trả tiền | Mã UUID | Liên kết tới dung_chung.doi_tac; mã bên trả tiền xác định đúng vai trò hoặc nguồn trong báo giá và đơn hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `ma_ben_nhan` | Mã bên nhận | Mã UUID | Liên kết tới dung_chung.doi_tac; mã bên nhận xác định đúng vai trò hoặc nguồn trong báo giá và đơn hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `ma_can_cu_dai_dien` | Mã căn cứ đại diện | Mã UUID | Liên kết tới dung_chung.can_cu_dai_dien; mã căn cứ đại diện xác định đúng vai trò hoặc nguồn trong báo giá và đơn hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.can_cu_dai_dien |
| `ma_phien_ban_chinh_sach_gia` | Mã phiên bản chính sách giá | Mã UUID | Liên kết tới dung_chung.phien_ban_chinh_sach; mã phiên bản chính sách giá xác định đúng vai trò hoặc nguồn trong báo giá và đơn hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** bên trả tiền/bên nhận hàng có thể khác buyer; ảnh chụp tên/địa chỉ/thỏa thuận ở chứng từ. Đơn liên kết báo giá, không sao giá động; thuế chưa mô phỏng không là 0%.

**Yêu cầu:** FR08, FR21, FR23.

### D032 Dòng báo giá và đơn hàng

**Tên bảng:** `kinh_doanh.dong_bao_gia_va_don_hang`. **Phụ trách:** Kinh doanh.

**Mục đích:** Cam kết từng biến thể và giá.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `so_vien_thoa_thuan` | Số viên thỏa thuận | Số lượng chính xác | Số viên thỏa thuận của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `don_gia_niem_yet_tham_chieu` | Đơn giá niêm yết tham chiếu | Số thập phân chính xác | Đơn giá niêm yết tham chiếu của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai_chiet_khau` | Loại chiết khấu | Phân loại có danh sách đóng | Loại chiết khấu của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. Giá trị cho phép: khong_ap_dung; ty_le; so_tien. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `gia_tri_chiet_khau` | Giá trị chiết khấu | Số thập phân chính xác | Giá trị chiết khấu của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `don_gia_thoa_thuan` | Đơn giá thỏa thuận | Số thập phân chính xác | Đơn giá thỏa thuận của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien_thoa_thuan` | Số tiền thỏa thuận | Số tiền VND nguyên đồng | Số tiền thỏa thuận của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_giao_khach_yeu_cau` | Ngày giao khách yêu cầu | Ngày địa phương | Ngày giao khách yêu cầu của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `muc_dich_dong_hang` | Mục đích dòng hàng | Phân loại có danh sách đóng | Mục đích dòng hàng của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. Giá trị cho phép: ghi_ban; giao_bu. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `quy_cach_ky_thuat_ban_luu_tai_thoi_diem` | Quy cách kỹ thuật bản lưu tại thời điểm | Nội dung có cấu trúc đóng | Quy cách kỹ thuật bản lưu tại thời điểm của dòng báo giá và đơn hàng, phục vụ cam kết từng biến thể và giá; được ghi bởi kinh doanh theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_don_hang` | Mã chứng từ đơn hàng | Mã UUID | Liên kết tới kinh_doanh.bao_gia_va_don_hang; mã chứng từ đơn hàng xác định đúng vai trò hoặc nguồn trong dòng báo giá và đơn hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.bao_gia_va_don_hang |
| `ma_mat_hang` | Mã mặt hàng | Mã UUID | Liên kết tới danh_muc.mat_hang; mã mặt hàng xác định đúng vai trò hoặc nguồn trong dòng báo giá và đơn hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.mat_hang |
| `ma_chung_tu_mau_khach_da_duyet` | Mã chứng từ mẫu khách đã duyệt | Mã UUID | Liên kết tới kinh_doanh.mau_khach_duyet; mã chứng từ mẫu khách đã duyệt xác định đúng vai trò hoặc nguồn trong dòng báo giá và đơn hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.mau_khach_duyet |
| `ma_ho_so_giao_bu` | Mã hồ sơ giao bù | Mã UUID | Liên kết tới kinh_doanh.ho_so_thay_doi_va_xu_ly_thuong_mai; mã hồ sơ giao bù xác định đúng vai trò hoặc nguồn trong dòng báo giá và đơn hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.ho_so_thay_doi_va_xu_ly_thuong_mai |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Mỗi dòng thuộc đúng đơn hàng/so_phien_ban; giá/giảm một lần, giữ các số thỏa thuận bất biến sau duyệt. Tổng đã giao/bán không là cột sửa tay.

**Yêu cầu:** FR08, FR10, FR11, FR21, FR22, FR27.

### D033 Mẫu khách duyệt

**Tên bảng:** `kinh_doanh.mau_khach_duyet`. **Phụ trách:** Kinh doanh cùng sản xuất/kiểm chất lượng.

**Mục đích:** Mẫu riêng và khách duyệt đúng bản.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `so_luong_mau_rieng` | Số lượng mẫu riêng | Số lượng chính xác | Số lượng mẫu riêng của mẫu khách duyệt, phục vụ mẫu riêng và khách duyệt đúng bản; được ghi bởi kinh doanh cùng sản xuất/kiểm chất lượng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `quyet_dinh_cua_khach` | Quyết định của khách | Phân loại có danh sách đóng | Quyết định của khách của mẫu khách duyệt, phục vụ mẫu riêng và khách duyệt đúng bản; được ghi bởi kinh doanh cùng sản xuất/kiểm chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: cho_xu_ly; da_duyet; da_tu_choi. | Sự kiện hoặc quyết định được ghi nhận | — |
| `thoi_diem_quyet_dinh` | Thời điểm quyết định | Thời điểm có múi giờ | Thời điểm quyết định của mẫu khách duyệt, phục vụ mẫu riêng và khách duyệt đúng bản; được ghi bởi kinh doanh cùng sản xuất/kiểm chất lượng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `chung_cu` | Chứng cứ | Văn bản | Chứng cứ của mẫu khách duyệt, phục vụ mẫu riêng và khách duyệt đúng bản; được ghi bởi kinh doanh cùng sản xuất/kiểm chất lượng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong mẫu khách duyệt. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_dong_don_hang` | Mã dòng đơn hàng | Mã UUID | Liên kết tới kinh_doanh.dong_bao_gia_va_don_hang; mã dòng đơn hàng xác định đúng vai trò hoặc nguồn trong mẫu khách duyệt. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.dong_bao_gia_va_don_hang |
| `ma_lenh_san_xuat_mau` | Mã lệnh sản xuất mẫu | Mã UUID | Liên kết tới san_xuat.lenh_san_xuat; mã lệnh sản xuất mẫu xác định đúng vai trò hoặc nguồn trong mẫu khách duyệt. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.lenh_san_xuat |
| `ma_phieu_kiem_chat_luong` | Mã phiếu kiểm chất lượng | Mã UUID | Liên kết tới chat_luong.phieu_kiem_tra_chat_luong; mã phiếu kiểm chất lượng xác định đúng vai trò hoặc nguồn trong mẫu khách duyệt. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | chat_luong.phieu_kiem_tra_chat_luong |
| `ma_can_cu_dai_dien_khach` | Mã căn cứ đại diện khách | Mã UUID | Liên kết tới dung_chung.can_cu_dai_dien; mã căn cứ đại diện khách xác định đúng vai trò hoặc nguồn trong mẫu khách duyệt. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.can_cu_dai_dien |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Mẫu tách lệnh/phiếu và lượng bán. Quan hệ quay vòng tạo qua nháp trong giao dịch nguyên tử, bắt buộc đủ FK khi duyệt; duyệt nội bộ không thay khách.

**Yêu cầu:** FR09, FR10.

### D034 Hồ sơ thay đổi và xử lý thương mại

**Tên bảng:** `kinh_doanh.ho_so_thay_doi_va_xu_ly_thuong_mai`. **Phụ trách:** Kinh doanh giữ việc.

**Mục đích:** Đổi/hủy, phản ánh, trả/thu hồi và phương án thương mại.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của hồ sơ thay đổi và xử lý thương mại, phục vụ đổi/hủy, phản ánh, trả/thu hồi và phương án thương mại; được ghi bởi kinh doanh giữ việc theo hồ sơ nguồn của bảng. Giá trị cho phép: thay_doi; huy; tra_hang; khieu_nai; thu_hoi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_bi_anh_huong` | Số lượng bị ảnh hưởng | Số lượng chính xác | Số lượng bị ảnh hưởng của hồ sơ thay đổi và xử lý thương mại, phục vụ đổi/hủy, phản ánh, trả/thu hồi và phương án thương mại; được ghi bởi kinh doanh giữ việc theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `phuong_an_xu_ly` | Phương án xử lý | Phân loại có danh sách đóng | Phương án xử lý của hồ sơ thay đổi và xử lý thương mại, phục vụ đổi/hủy, phản ánh, trả/thu hồi và phương án thương mại; được ghi bởi kinh doanh giữ việc theo hồ sơ nguồn của bảng. Giá trị cho phép: cho_xu_ly; giam_ban; hoan_tien; giao_bu; tai_xu_ly; huy; loi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_da_bat_dau_tai_luc_danh_gia` | Số lượng đã bắt đầu tại lúc đánh giá | Số lượng chính xác | Số lượng đã bắt đầu tại lúc đánh giá của hồ sơ thay đổi và xử lý thương mại, phục vụ đổi/hủy, phản ánh, trả/thu hồi và phương án thương mại; được ghi bởi kinh doanh giữ việc theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `can_cu_khach_xac_nhan` | Căn cứ khách xác nhận | Văn bản | Căn cứ khách xác nhận của hồ sơ thay đổi và xử lý thương mại, phục vụ đổi/hủy, phản ánh, trả/thu hồi và phương án thương mại; được ghi bởi kinh doanh giữ việc theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ghi_chu_giai_quyet_thuong_mai` | Ghi chú giải quyết thương mại | Văn bản | Ghi chú giải quyết thương mại của hồ sơ thay đổi và xử lý thương mại, phục vụ đổi/hủy, phản ánh, trả/thu hồi và phương án thương mại; được ghi bởi kinh doanh giữ việc theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong hồ sơ thay đổi và xử lý thương mại. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_dong_don_hang_goc` | Mã dòng đơn hàng gốc | Mã UUID | Liên kết tới kinh_doanh.dong_bao_gia_va_don_hang; mã dòng đơn hàng gốc xác định đúng vai trò hoặc nguồn trong hồ sơ thay đổi và xử lý thương mại. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.dong_bao_gia_va_don_hang |
| `ma_dong_don_hang_moi` | Mã dòng đơn hàng mới | Mã UUID | Liên kết tới kinh_doanh.dong_bao_gia_va_don_hang; mã dòng đơn hàng mới xác định đúng vai trò hoặc nguồn trong hồ sơ thay đổi và xử lý thương mại. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.dong_bao_gia_va_don_hang |
| `ma_dong_ghi_ban_goc` | Mã dòng ghi bán gốc | Mã UUID | Liên kết tới tai_chinh.dong_ghi_nhan_ban; mã dòng ghi bán gốc xác định đúng vai trò hoặc nguồn trong hồ sơ thay đổi và xử lý thương mại. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.dong_ghi_nhan_ban |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Liên kết tới dung_chung.de_nghi_va_quyet_dinh_phe_duyet; mã phê duyệt xác định đúng vai trò hoặc nguồn trong hồ sơ thay đổi và xử lý thương mại. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Không mặc định mất cọc; lượng đã làm/chưa làm/đã giao ghi căn cứ theo mốc. Một phương án có phần lượng cụ thể; chưa rõ giữ chờ. Tổng hoàn/giao bù kiểm đúng phạm vi đã duyệt.

**Yêu cầu:** FR10, FR19, FR27.

### D035 Đơn mua hàng

**Tên bảng:** `mua_hang.don_mua_hang`. **Phụ trách:** Mua hàng.

**Mục đích:** Đặt mua theo nhu cầu đã duyệt.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_chung_tu_nha_cung_cap` | Mã chứng từ nhà cung cấp | Văn bản | Mã chứng từ nhà cung cấp của đơn mua hàng, phục vụ đặt mua theo nhu cầu đã duyệt; được ghi bởi mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_cam_ket` | Ngày cam kết | Ngày địa phương | Ngày cam kết của đơn mua hàng, phục vụ đặt mua theo nhu cầu đã duyệt; được ghi bởi mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dieu_kien_thanh_toan` | Điều kiện thanh toán | Văn bản | Điều kiện thanh toán của đơn mua hàng, phục vụ đặt mua theo nhu cầu đã duyệt; được ghi bởi mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ghi_chu_doi_chieu_nguon_cung` | Ghi chú đối chiếu nguồn cung | Văn bản | Ghi chú đối chiếu nguồn cung của đơn mua hàng, phục vụ đặt mua theo nhu cầu đã duyệt; được ghi bởi mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong đơn mua hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_nha_cung_cap` | Mã nhà cung cấp | Mã UUID | Liên kết tới dung_chung.doi_tac; mã nhà cung cấp xác định đúng vai trò hoặc nguồn trong đơn mua hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Không bắt ba báo giá; duyệt đơn mua không có tồn/nợ/tiền; thay giá/lượng tạo bản mới.

**Yêu cầu:** FR14, FR24.

### D036 Dòng đơn mua hàng

**Tên bảng:** `mua_hang.dong_don_mua_hang`. **Phụ trách:** Mua hàng.

**Mục đích:** Lượng đặt, giá và đơn vị mua.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `so_luong_theo_don_vi_nhap` | Số lượng theo đơn vị nhập | Số lượng chính xác | Số lượng theo đơn vị nhập của dòng đơn mua hàng, phục vụ lượng đặt, giá và đơn vị mua; được ghi bởi mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `don_gia_mua` | Đơn giá mua | Số thập phân chính xác | Đơn giá mua của dòng đơn mua hàng, phục vụ lượng đặt, giá và đơn vị mua; được ghi bởi mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien_thoa_thuan` | Số tiền thỏa thuận | Số tiền VND nguyên đồng | Số tiền thỏa thuận của dòng đơn mua hàng, phục vụ lượng đặt, giá và đơn vị mua; được ghi bởi mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_cam_ket` | Ngày cam kết | Ngày địa phương | Ngày cam kết của dòng đơn mua hàng, phục vụ lượng đặt, giá và đơn vị mua; được ghi bởi mua hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_don_hang` | Mã chứng từ đơn hàng | Mã UUID | Liên kết tới mua_hang.don_mua_hang; mã chứng từ đơn hàng xác định đúng vai trò hoặc nguồn trong dòng đơn mua hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | mua_hang.don_mua_hang |
| `ma_mat_hang` | Mã mặt hàng | Mã UUID | Liên kết tới danh_muc.mat_hang; mã mặt hàng xác định đúng vai trò hoặc nguồn trong dòng đơn mua hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.mat_hang |
| `ma_don_vi_nhap` | Mã đơn vị nhập | Mã UUID | Liên kết tới dung_chung.don_vi_tinh; mã đơn vị nhập xác định đúng vai trò hoặc nguồn trong dòng đơn mua hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.don_vi_tinh |
| `ma_quy_doi` | Mã quy đổi | Mã UUID | Liên kết tới danh_muc.quy_doi_don_vi; mã quy đổi xác định đúng vai trò hoặc nguồn trong dòng đơn mua hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.quy_doi_don_vi |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Lượng đặt nhập theo đơn vị thỏa thuận; lượng cơ sở tính từ đúng hệ số quy đổi đã lưu ở lần ký, không giữ cột tổng cơ sở độc lập. Đối chiếu nhận theo dòng và phiên bản; giá mua không tự thành tiền đã chi.

**Yêu cầu:** FR14, FR15, FR24.

### D037 Phân bổ hàng đang về

**Tên bảng:** `mua_hang.phan_bo_hang_dang_ve`. **Phụ trách:** Mua hàng / kho.

**Mục đích:** Dành phần đang về cho đúng nhu cầu.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `so_luong_do_theo_don_vi_co_so` | Số lượng đo theo đơn vị cơ sở | Số lượng chính xác | Số đo thực của hàng bằng đơn vị cơ sở trên dòng xác nhận; nếu được quy đổi từ đơn vị nhập phải dẫn đúng bản quy đổi và phép tính, không tự làm tròn mất hàng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_co_hieu_luc` | Thời điểm có hiệu lực | Thời điểm có múi giờ | Thời điểm người có thẩm quyền quy định nội dung bắt đầu áp dụng, tách với thời điểm hệ thống ghi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_hieu_luc` | Thời điểm kết thúc hiệu lực | Thời điểm có múi giờ | Thời điểm kết thúc hiệu lực của phân bổ hàng đang về, phục vụ dành phần đang về cho đúng nhu cầu; được ghi bởi mua hàng / kho theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_dong_don_mua` | Mã dòng đơn mua | Mã UUID | Liên kết tới mua_hang.dong_don_mua_hang; mã dòng đơn mua xác định đúng vai trò hoặc nguồn trong phân bổ hàng đang về. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | mua_hang.dong_don_mua_hang |
| `ma_yeu_cau_hang` | Mã yêu cầu hàng | Mã UUID | Liên kết tới kho.yeu_cau_hang_va_vat_tu; mã yêu cầu hàng xác định đúng vai trò hoặc nguồn trong phân bổ hàng đang về. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.yeu_cau_hang_va_vat_tu |
| `ma_ban_phan_bo_hang_ve_bi_thay` | Mã bản phân bổ hàng về bị thay | Mã UUID | Liên kết tới mua_hang.phan_bo_hang_dang_ve; mã bản phân bổ hàng về bị thay xác định đúng vai trò hoặc nguồn trong phân bổ hàng đang về. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | mua_hang.phan_bo_hang_dang_ve |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Dành hàng đang về không vượt phần còn của đơn mua và nhu cầu có căn cứ. Mốc bắt đầu/kết thúc do người phụ trách xác nhận; phần hoàn tất tính từ phiếu nhận liên quan, không nạp trạng thái đã đáp ứng.

**Yêu cầu:** FR11, FR14.

### D038 Lô hàng

**Tên bảng:** `kho.lo_hang`. **Phụ trách:** Kho / sản xuất nguồn tạo.

**Mục đích:** Nhận dạng nguồn vật tư/thành phẩm.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của lô hàng, phục vụ nhận dạng nguồn vật tư/thành phẩm; được ghi bởi kho / sản xuất nguồn tạo theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_lo_nha_cung_cap` | Mã lô nhà cung cấp | Văn bản | Mã lô nhà cung cấp của lô hàng, phục vụ nhận dạng nguồn vật tư/thành phẩm; được ghi bởi kho / sản xuất nguồn tạo theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_san_xuat` | Ngày sản xuất | Ngày địa phương | Ngày sản xuất của lô hàng, phục vụ nhận dạng nguồn vật tư/thành phẩm; được ghi bởi kho / sản xuất nguồn tạo theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_het_han` | Ngày hết hạn | Ngày địa phương | Ngày hết hạn của lô hàng, phục vụ nhận dạng nguồn vật tư/thành phẩm; được ghi bởi kho / sản xuất nguồn tạo theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai_nguon_hinh_thanh_lo` | Loại nguồn hình thành lô | Phân loại có danh sách đóng | Loại nguồn hình thành lô của lô hàng, phục vụ nhận dạng nguồn vật tư/thành phẩm; được ghi bởi kho / sản xuất nguồn tạo theo hồ sơ nguồn của bảng. Giá trị cho phép: dau_ky; mua_hang; san_xuat; chua_ro. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_mat_hang` | Mã mặt hàng | Mã UUID | Liên kết tới danh_muc.mat_hang; mã mặt hàng xác định đúng vai trò hoặc nguồn trong lô hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.mat_hang |
| `ma_chung_tu_hinh_thanh_lo` | Mã chứng từ hình thành lô | Mã UUID | Liên kết tới dung_chung.chung_tu; mã chứng từ hình thành lô xác định đúng vai trò hoặc nguồn trong lô hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_lo_san_xuat_nguon` | Mã lô sản xuất nguồn | Mã UUID | Liên kết tới san_xuat.lo_san_xuat; mã lô sản xuất nguồn xác định đúng vai trò hoặc nguồn trong lô hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.lo_san_xuat |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Duy nhất bộ dữ liệu+ma_nghiep_vu; chưa rõ có nhãn, không bịa nguồn. Lô có nhiều phần/vị trí; hạn có thể trống khi chưa xác định.

**Yêu cầu:** FR01, FR15, FR16, FR19.

### D039 Phần lô hàng

**Tên bảng:** `kho.phan_lo_hang`. **Phụ trách:** Kho, kiểm chất lượng giữ chất lượng.

**Mục đích:** Phần đồng nhất chất lượng/quyền sở hữu của một lô.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `tinh_trang_chat_luong` | Tình trạng chất lượng | Phân loại có danh sách đóng | Tình trạng chất lượng của phần lô hàng, phục vụ phần đồng nhất chất lượng/quyền sở hữu của một lô; được ghi bởi kho, kiểm chất lượng giữ chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: cho_xu_ly; dat; loi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `quyen_so_huu` | Quyền sở hữu | Phân loại có danh sách đóng | Quyền sở hữu của phần lô hàng, phục vụ phần đồng nhất chất lượng/quyền sở hữu của một lô; được ghi bởi kho, kiểm chất lượng giữ chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: doanh_nghiep; ben_khac; chua_ro. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `quy_cach_ky_thuat_ban_luu_tai_thoi_diem` | Quy cách kỹ thuật bản lưu tại thời điểm | Nội dung có cấu trúc đóng | Quy cách kỹ thuật bản lưu tại thời điểm của phần lô hàng, phục vụ phần đồng nhất chất lượng/quyền sở hữu của một lô; được ghi bởi kho, kiểm chất lượng giữ chất lượng theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_lo_hang` | Mã lô hàng | Mã UUID | Liên kết tới kho.lo_hang; mã lô hàng xác định đúng vai trò hoặc nguồn trong phần lô hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.lo_hang |
| `ma_phan_lo_cha` | Mã phần lô cha | Mã UUID | Liên kết tới kho.phan_lo_hang; mã phần lô cha xác định đúng vai trò hoặc nguồn trong phần lô hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.phan_lo_hang |
| `ma_phieu_ket_luan_chat_luong` | Mã phiếu kết luận chất lượng | Mã UUID | Liên kết tới chat_luong.phieu_kiem_tra_chat_luong; mã phiếu kết luận chất lượng xác định đúng vai trò hoặc nguồn trong phần lô hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | chat_luong.phieu_kiem_tra_chat_luong |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Không lưu lượng tồn tại đây. Tách phần chỉ bởi vận động cùng giao dịch nguyên tử, không tự sinh lượng. Giữ chất lượng riêng với vị trí/khóa; nhiều khóa cùng phần thì hết mọi khóa mới dùng.

**Yêu cầu:** FR11, FR15, FR17, FR19.

### D040 Phiếu vận động hàng

**Tên bảng:** `kho.phieu_van_dong_hang`. **Phụ trách:** Kho / người xác nhận thực theo nguồn.

**Mục đích:** Phiếu và sự kiện thực vào/ra/chuyển.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của phiếu vận động hàng, phục vụ phiếu và sự kiện thực vào/ra/chuyển; được ghi bởi kho / người xác nhận thực theo nguồn theo hồ sơ nguồn của bảng. Giá trị cho phép: dau_ky; nhan_hang; chuyen_noi_bo; chia_phan_chat_luong; cap_phat; tra_hang; thuc_dung; xuat_giao; tieu_huy; dieu_chinh_kiem_ke. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xac_nhan_thuc_hien` | Trạng thái xác nhận thực hiện | Phân loại có danh sách đóng | Trạng thái xác nhận thực hiện của phiếu vận động hàng, phục vụ phiếu và sự kiện thực vào/ra/chuyển; được ghi bởi kho / người xác nhận thực theo nguồn theo hồ sơ nguồn của bảng. Giá trị cho phép: nhap; da_ghi_so. | Sự kiện hoặc quyết định được ghi nhận | — |
| `thoi_diem_thuc_hien_nghiep_vu` | Thời điểm thực hiện nghiệp vụ | Thời điểm có múi giờ | Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thu_tu_ghi_so` | Thứ tự ghi sổ | Số nguyên | Thứ tự ghi sổ của phiếu vận động hàng, phục vụ phiếu và sự kiện thực vào/ra/chuyển; được ghi bởi kho / người xác nhận thực theo nguồn theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong phiếu vận động hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_bien_nhan_xac_nhan_giao_dich` | Mã biên nhận xác nhận giao dịch | Mã UUID | Liên kết tới truy_cap.bien_nhan_xac_nhan_giao_dich; mã biên nhận xác nhận giao dịch xác định đúng vai trò hoặc nguồn trong phiếu vận động hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | truy_cap.bien_nhan_xac_nhan_giao_dich |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** đã ghi sổ mới tác động lượng. Phiếu xưởng tổ trưởng xác nhận phạm vi sản xuất; kho không tự sửa công/thực dùng. Không ghi lùi trước mốc/biến động liên quan.

**Yêu cầu:** FR05, FR06, FR15, FR16, FR18, FR20, FR21.

### D041 Dòng vận động hàng

**Tên bảng:** `kho.dong_van_dong_hang`. **Phụ trách:** Kho / xác nhận sản xuất đúng phạm vi.

**Mục đích:** Sổ lượng qua hai đầu trách nhiệm.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `so_luong_theo_don_vi_nhap` | Số lượng theo đơn vị nhập | Số lượng chính xác | Số lượng theo đơn vị nhập của dòng vận động hàng, phục vụ sổ lượng qua hai đầu trách nhiệm; được ghi bởi kho / xác nhận sản xuất đúng phạm vi theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_do_theo_don_vi_co_so` | Số lượng đo theo đơn vị cơ sở | Số lượng chính xác | Số đo thực của hàng bằng đơn vị cơ sở trên dòng xác nhận; nếu được quy đổi từ đơn vị nhập phải dẫn đúng bản quy đổi và phép tính, không tự làm tròn mất hàng. | Kết quả đã ghi nhận có căn cứ | — |
| `he_so_quy_doi_tai_lan_ghi_nhan` | Hệ số quy đổi tại lần ghi nhận | Số thập phân chính xác | Hệ số quy đổi tại lần ghi nhận của dòng vận động hàng, phục vụ sổ lượng qua hai đầu trách nhiệm; được ghi bởi kho / xác nhận sản xuất đúng phạm vi theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `ly_do` | Lý do | Văn bản | Lý do của dòng vận động hàng, phục vụ sổ lượng qua hai đầu trách nhiệm; được ghi bởi kho / xác nhận sản xuất đúng phạm vi theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phieu_van_dong_hang` | Mã phiếu vận động hàng | Mã UUID | Liên kết tới kho.phieu_van_dong_hang; mã phiếu vận động hàng xác định đúng vai trò hoặc nguồn trong dòng vận động hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.phieu_van_dong_hang |
| `ma_phan_lo_nguon` | Mã phần lô nguồn | Mã UUID | Liên kết tới kho.phan_lo_hang; mã phần lô nguồn xác định đúng vai trò hoặc nguồn trong dòng vận động hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.phan_lo_hang |
| `ma_phan_lo_dich` | Mã phần lô đích | Mã UUID | Liên kết tới kho.phan_lo_hang; mã phần lô đích xác định đúng vai trò hoặc nguồn trong dòng vận động hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.phan_lo_hang |
| `ma_vi_tri_nguon` | Mã vị trí nguồn | Mã UUID | Liên kết tới dung_chung.vi_tri_giu_hang; mã vị trí nguồn xác định đúng vai trò hoặc nguồn trong dòng vận động hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.vi_tri_giu_hang |
| `ma_vi_tri_dich` | Mã vị trí đích | Mã UUID | Liên kết tới dung_chung.vi_tri_giu_hang; mã vị trí đích xác định đúng vai trò hoặc nguồn trong dòng vận động hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.vi_tri_giu_hang |
| `ma_don_vi_nhap` | Mã đơn vị nhập | Mã UUID | Liên kết tới dung_chung.don_vi_tinh; mã đơn vị nhập xác định đúng vai trò hoặc nguồn trong dòng vận động hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.don_vi_tinh |
| `ma_quy_doi` | Mã quy đổi | Mã UUID | Liên kết tới danh_muc.quy_doi_don_vi; mã quy đổi xác định đúng vai trò hoặc nguồn trong dòng vận động hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.quy_doi_don_vi |
| `ma_dong_nghiep_vu_goc` | Mã dòng nghiệp vụ gốc | Mã UUID | Liên kết tới kho.dong_van_dong_hang; mã dòng nghiệp vụ gốc xác định đúng vai trò hoặc nguồn trong dòng vận động hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.dong_van_dong_hang |
| `ma_yeu_cau_hang` | Mã yêu cầu hàng | Mã UUID | Liên kết tới kho.yeu_cau_hang_va_vat_tu; mã yêu cầu hàng xác định đúng vai trò hoặc nguồn trong dòng vận động hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.yeu_cau_hang_va_vat_tu |
| `ma_chung_tu_phuong_an_xu_ly` | Mã chứng từ phương án xử lý | Mã UUID | Liên kết tới dung_chung.chung_tu; mã chứng từ phương án xử lý xác định đúng vai trò hoặc nguồn trong dòng vận động hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Đầu vào/đầu ra có thể trống chỉ cho nhập ngoài/tiêu dùng/xuất ngoài hợp lệ; cặp portion/location cùng null. Chuyển nội bộ đủ hai đầu, lượng>0, không mất lượng. Nhận trả hợp lệ không vượt gốc; thừa/không rõ nguồn nhận cách ly với case. Đầu xuất bán phải đạt/doanh nghiệp/không khóa/còn lượng.

**Yêu cầu:** FR01, FR05, FR06, FR15, FR16, FR18, FR20, FR21, FR27.

### D042 Yêu cầu hàng và vật tư

**Tên bảng:** `kho.yeu_cau_hang_va_vat_tu`. **Phụ trách:** Kinh doanh / sản xuất lập; kho đối chiếu.

**Mục đích:** Nhu cầu hàng/vật tư không tự mất khi khóa lô.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `muc_dich` | Mục đích | Phân loại có danh sách đóng | Mục đích của yêu cầu hàng và vật tư, phục vụ nhu cầu hàng/vật tư không tự mất khi khóa lô; được ghi bởi kinh doanh / sản xuất lập; kho đối chiếu theo hồ sơ nguồn của bảng. Giá trị cho phép: ghi_ban; san_xuat; nhu_cau_tuong_lai_da_duyet; giao_bu. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_can_theo_yeu_cau` | Số lượng cần theo yêu cầu | Số lượng chính xác | Lượng được người giữ nguồn yêu cầu, có dòng đơn/lệnh hoặc nhu cầu tương lai đã duyệt; không cài một nguồn giả chỉ để làm phép tính thiếu. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_can_dap_ung` | Ngày cần đáp ứng | Ngày địa phương | Ngày cần đáp ứng của yêu cầu hàng và vật tư, phục vụ nhu cầu hàng/vật tư không tự mất khi khóa lô; được ghi bởi kinh doanh / sản xuất lập; kho đối chiếu theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: dang_mo; da_chot; da_huy. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_dong_nguon_nghiep_vu` | Mã dòng nguồn nghiệp vụ | Mã UUID | Liên kết tới dung_chung.dong_chung_tu; mã dòng nguồn nghiệp vụ xác định đúng vai trò hoặc nguồn trong yêu cầu hàng và vật tư. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.dong_chung_tu |
| `ma_mat_hang` | Mã mặt hàng | Mã UUID | Liên kết tới danh_muc.mat_hang; mã mặt hàng xác định đúng vai trò hoặc nguồn trong yêu cầu hàng và vật tư. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.mat_hang |
| `ma_don_vi` | Mã đơn vị | Mã UUID | Liên kết tới dung_chung.don_vi_tinh; mã đơn vị xác định đúng vai trò hoặc nguồn trong yêu cầu hàng và vật tư. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.don_vi_tinh |
| `ma_yeu_cau_hang_bi_thay` | Mã yêu cầu hàng bị thay | Mã UUID | Liên kết tới kho.yeu_cau_hang_va_vat_tu; mã yêu cầu hàng bị thay xác định đúng vai trò hoặc nguồn trong yêu cầu hàng và vật tư. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.yeu_cau_hang_va_vat_tu |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Mỗi yêu cầu phải trỏ chứng từ và dòng nguồn đúng bản. Nhu cầu mua tương lai cần chứng từ riêng được duyệt; mã OTHER-001 trong bộ kiểm cũ chưa kèm hồ sơ duyệt đầy đủ nên không được nạp như nhu cầu hợp lệ. Đổi yêu cầu có bản thay; không xóa sự kiện giữ hay giao cũ.

**Yêu cầu:** FR11, FR12, FR14, FR16, FR20.

### D043 Sự kiện giữ hàng

**Tên bảng:** `kho.su_kien_giu_hang`. **Phụ trách:** Kho.

**Mục đích:** Lịch sử giữ, dùng, giải phóng và mất hiệu lực.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của sự kiện giữ hàng, phục vụ lịch sử giữ, dùng, giải phóng và mất hiệu lực; được ghi bởi kho theo hồ sơ nguồn của bảng. Giá trị cho phép: giu_nguon; thuc_dung; giai_phong; mat_hieu_luc_giu. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_do_theo_don_vi_co_so` | Số lượng đo theo đơn vị cơ sở | Số lượng chính xác | Số đo thực của hàng bằng đơn vị cơ sở trên dòng xác nhận; nếu được quy đổi từ đơn vị nhập phải dẫn đúng bản quy đổi và phép tính, không tự làm tròn mất hàng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_thuc_hien_nghiep_vu` | Thời điểm thực hiện nghiệp vụ | Thời điểm có múi giờ | Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ly_do` | Lý do | Văn bản | Lý do của sự kiện giữ hàng, phục vụ lịch sử giữ, dùng, giải phóng và mất hiệu lực; được ghi bởi kho theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_yeu_cau_hang` | Mã yêu cầu hàng | Mã UUID | Liên kết tới kho.yeu_cau_hang_va_vat_tu; mã yêu cầu hàng xác định đúng vai trò hoặc nguồn trong sự kiện giữ hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.yeu_cau_hang_va_vat_tu |
| `ma_phan_lo` | Mã phần lô | Mã UUID | Liên kết tới kho.phan_lo_hang; mã phần lô xác định đúng vai trò hoặc nguồn trong sự kiện giữ hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.phan_lo_hang |
| `ma_vi_tri` | Mã vị trí | Mã UUID | Liên kết tới dung_chung.vi_tri_giu_hang; mã vị trí xác định đúng vai trò hoặc nguồn trong sự kiện giữ hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.vi_tri_giu_hang |
| `ma_su_kien_giu_goc` | Mã sự kiện giữ gốc | Mã UUID | Liên kết tới kho.su_kien_giu_hang; mã sự kiện giữ gốc xác định đúng vai trò hoặc nguồn trong sự kiện giữ hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.su_kien_giu_hang |
| `ma_dong_van_dong_hang` | Mã dòng vận động hàng | Mã UUID | Liên kết tới kho.dong_van_dong_hang; mã dòng vận động hàng xác định đúng vai trò hoặc nguồn trong sự kiện giữ hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.dong_van_dong_hang |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Liên kết tới dung_chung.de_nghi_va_quyet_dinh_phe_duyet; mã phê duyệt xác định đúng vai trò hoặc nguồn trong sự kiện giữ hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |

**Ràng buộc nghiệp vụ:** reserve_event có thể trống ở lần giữ đầu, các lần sau trỏ lần giữ gốc. Giữ không đổi tồn; tổng thực dùng/giải phóng/mất hiệu lực giữ không vượt phần giữ; khóa/đếm thiếu cùng giao dịch nguyên tử mất hiệu lực giữ và tạo việc thiếu.

**Yêu cầu:** FR05, FR11, FR17, FR20, FR21.

### D044 Biên bản kiểm kê

**Tên bảng:** `kho.bien_ban_kiem_ke`. **Phụ trách:** Kho, người đếm/đối chiếu khác nhau.

**Mục đích:** Mốc và phạm vi kiểm kê.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `thoi_diem_moc_doi_chieu` | Thời điểm mốc đối chiếu | Thời điểm có múi giờ | Thời điểm mốc đối chiếu của biên bản kiểm kê, phục vụ mốc và phạm vi kiểm kê; được ghi bởi kho, người đếm/đối chiếu khác nhau theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `pham_vi` | Phạm vi | Văn bản | Phạm vi của biên bản kiểm kê, phục vụ mốc và phạm vi kiểm kê; được ghi bởi kho, người đếm/đối chiếu khác nhau theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: dang_dem; da_ra_soat; da_duyet; da_ghi_so. | Sự kiện hoặc quyết định được ghi nhận | — |
| `thoi_diem_bat_dau_ngung_giao_dich_kiem_ke` | Thời điểm bắt đầu ngừng giao dịch kiểm kê | Thời điểm có múi giờ | Thời điểm bắt đầu ngừng giao dịch kiểm kê của biên bản kiểm kê, phục vụ mốc và phạm vi kiểm kê; được ghi bởi kho, người đếm/đối chiếu khác nhau theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_ngung_giao_dich_kiem_ke` | Thời điểm kết thúc ngừng giao dịch kiểm kê | Thời điểm có múi giờ | Thời điểm kết thúc ngừng giao dịch kiểm kê của biên bản kiểm kê, phục vụ mốc và phạm vi kiểm kê; được ghi bởi kho, người đếm/đối chiếu khác nhau theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong biên bản kiểm kê. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_nhan_vien_dem_thuc` | Mã nhân viên đếm thực | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên đếm thực xác định đúng vai trò hoặc nguồn trong biên bản kiểm kê. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_nhan_vien_doi_chieu` | Mã nhân viên đối chiếu | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên đối chiếu xác định đúng vai trò hoặc nguồn trong biên bản kiểm kê. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Đóng giao dịch phần đếm hoặc ghi đối chiếu giữa hai mốc; duyệt không tự điều chỉnh.

**Yêu cầu:** FR06, FR20.

### D045 Dòng kiểm kê

**Tên bảng:** `kho.dong_kiem_ke`. **Phụ trách:** Kho.

**Mục đích:** Đếm thực theo lô/vị trí/điều kiện.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `so_luong_dem_thuc` | Số lượng đếm thực | Số lượng chính xác | Số lượng đếm thực của dòng kiểm kê, phục vụ đếm thực theo lô/vị trí/điều kiện; được ghi bởi kho theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_so_tai_moc_kiem_ke` | Số lượng sổ tại mốc kiểm kê | Số lượng chính xác | Ảnh chụp số sổ dựng từ các vận động đã xác nhận tới mốc/thu_tu kiểm kê; chỉ đối chiếu với đếm thực, không là đầu vào mới cho tồn. | Kết quả đã ghi nhận có căn cứ | — |
| `ly_do` | Lý do | Văn bản | Lý do của dòng kiểm kê, phục vụ đếm thực theo lô/vị trí/điều kiện; được ghi bởi kho theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_bien_ban_kiem_ke` | Mã biên bản kiểm kê | Mã UUID | Liên kết tới kho.bien_ban_kiem_ke; mã biên bản kiểm kê xác định đúng vai trò hoặc nguồn trong dòng kiểm kê. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.bien_ban_kiem_ke |
| `ma_phan_lo` | Mã phần lô | Mã UUID | Liên kết tới kho.phan_lo_hang; mã phần lô xác định đúng vai trò hoặc nguồn trong dòng kiểm kê. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.phan_lo_hang |
| `ma_vi_tri` | Mã vị trí | Mã UUID | Liên kết tới dung_chung.vi_tri_giu_hang; mã vị trí xác định đúng vai trò hoặc nguồn trong dòng kiểm kê. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.vi_tri_giu_hang |
| `ma_dong_dieu_chinh` | Mã dòng điều chỉnh | Mã UUID | Liên kết tới kho.dong_van_dong_hang; mã dòng điều chỉnh xác định đúng vai trò hoặc nguồn trong dòng kiểm kê. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.dong_van_dong_hang |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Book bản lưu tại mốc có cutoff/thu_tu, chênh tính ra; điều chỉnh có nguồn, không sửa book để khớp.

**Yêu cầu:** FR20.

### D046 Phiên bản định mức sản xuất

**Tên bảng:** `san_xuat.phien_ban_dinh_muc_san_xuat`. **Phụ trách:** Sản xuất.

**Mục đích:** Một phiên bản định mức/công đoạn.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của phiên bản định mức sản xuất, phục vụ một phiên bản định mức/công đoạn; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_phien_ban` | Số phiên bản | Số nguyên | Số phiên bản của phiên bản định mức sản xuất, phục vụ một phiên bản định mức/công đoạn; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_chuan_lam_can_cu_dinh_muc` | Số lượng chuẩn làm căn cứ định mức | Số lượng chính xác | Số lượng chuẩn làm căn cứ định mức của phiên bản định mức sản xuất, phục vụ một phiên bản định mức/công đoạn; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ty_le_dat_du_kien` | Tỷ lệ đạt dự kiến | Tỷ lệ từ 0 đến 1 | Tỷ lệ dự kiến do sản xuất khai báo trong bản định mức được duyệt; dùng lập kế hoạch, tuyệt đối không sinh kết quả kiểm chất lượng thực tế. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_hieu_luc` | Thời điểm bắt đầu hiệu lực | Ngày địa phương | Thời điểm bắt đầu hiệu lực của phiên bản định mức sản xuất, phục vụ một phiên bản định mức/công đoạn; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_hieu_luc` | Thời điểm kết thúc hiệu lực | Ngày địa phương | Thời điểm kết thúc hiệu lực của phiên bản định mức sản xuất, phục vụ một phiên bản định mức/công đoạn; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong phiên bản định mức sản xuất. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_mat_hang_dau_ra` | Mã mặt hàng đầu ra | Mã UUID | Liên kết tới danh_muc.mat_hang; mã mặt hàng đầu ra xác định đúng vai trò hoặc nguồn trong phiên bản định mức sản xuất. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.mat_hang |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Liên kết tới dung_chung.phien_ban_chinh_sach; mã phiên bản chính sách xác định đúng vai trò hoặc nguồn trong phiên bản định mức sản xuất. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Bản đã dùng bất biến, tỷ lệ chỉ kế hoạch; cùng mã không chồng hiệu lực.

**Yêu cầu:** FR12, FR13, FR16.

### D047 Dòng định mức vật tư

**Tên bảng:** `san_xuat.dong_dinh_muc_vat_tu`. **Phụ trách:** Sản xuất.

**Mục đích:** Vật tư và công đoạn tiêu dùng theo định mức sản xuất.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `luong_vat_tu_theo_dinh_muc` | Lượng vật tư theo định mức | Số lượng chính xác | Lượng vật tư theo định mức của dòng định mức vật tư, phục vụ vật tư và công đoạn tiêu dùng theo bom; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_cong_doan` | Mã công đoạn | Văn bản | Mã công đoạn của dòng định mức vật tư, phục vụ vật tư và công đoạn tiêu dùng theo bom; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thu_tu` | Thứ tự | Số nguyên | Thứ tự của dòng định mức vật tư, phục vụ vật tư và công đoạn tiêu dùng theo bom; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_dinh_muc` | Mã chứng từ định mức | Mã UUID | Liên kết tới san_xuat.phien_ban_dinh_muc_san_xuat; mã chứng từ định mức xác định đúng vai trò hoặc nguồn trong dòng định mức vật tư. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.phien_ban_dinh_muc_san_xuat |
| `ma_mat_hang` | Mã mặt hàng | Mã UUID | Liên kết tới danh_muc.mat_hang; mã mặt hàng xác định đúng vai trò hoặc nguồn trong dòng định mức vật tư. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.mat_hang |
| `ma_don_vi` | Mã đơn vị | Mã UUID | Liên kết tới dung_chung.don_vi_tinh; mã đơn vị xác định đúng vai trò hoặc nguồn trong dòng định mức vật tư. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.don_vi_tinh |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Qty>0, đúng dai_luong, không cộng dự phòng hai lần.

**Yêu cầu:** FR12, FR16.

### D048 Nguồn lực sản xuất

**Tên bảng:** `san_xuat.nguon_luc_san_xuat`. **Phụ trách:** Sản xuất.

**Mục đích:** Nguồn tạo hình/hoàn thiện/chỗ dưỡng hộ.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của nguồn lực sản xuất, phục vụ nguồn tạo hình/hoàn thiện/chỗ dưỡng hộ; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của nguồn lực sản xuất, phục vụ nguồn tạo hình/hoàn thiện/chỗ dưỡng hộ; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. Giá trị cho phép: may; vi_tri_thao_tac; cho_duong_ho. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `suc_chua_theo_luong` | Sức chứa theo lượng | Số lượng chính xác | Sức chứa theo lượng của nguồn lực sản xuất, phục vụ nguồn tạo hình/hoàn thiện/chỗ dưỡng hộ; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `nang_luc_thoi_gian_tinh_theo_phut` | Năng lực thời gian tính theo phút | Số nguyên | Năng lực thời gian tính theo phút của nguồn lực sản xuất, phục vụ nguồn tạo hình/hoàn thiện/chỗ dưỡng hộ; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ky_nang_bat_buoc` | Kỹ năng bắt buộc | Văn bản | Kỹ năng bắt buộc của nguồn lực sản xuất, phục vụ nguồn tạo hình/hoàn thiện/chỗ dưỡng hộ; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_vi_tri` | Mã vị trí | Mã UUID | Liên kết tới dung_chung.vi_tri_giu_hang; mã vị trí xác định đúng vai trò hoặc nguồn trong nguồn lực sản xuất. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.vi_tri_giu_hang |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Liên kết tới dung_chung.phien_ban_chinh_sach; mã phiên bản chính sách xác định đúng vai trò hoặc nguồn trong nguồn lực sản xuất. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Một xưởng, nhiều nguồn; chỗ dưỡng hộ 8.000 là giới hạn lượng, khác giờ máy.

**Yêu cầu:** FR12, FR13.

### D049 Lệnh sản xuất

**Tên bảng:** `san_xuat.lenh_san_xuat`. **Phụ trách:** Quản lý sản xuất.

**Mục đích:** Lệnh theo đơn/làm sẵn/mẫu/làm lại.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `muc_dich` | Mục đích | Phân loại có danh sách đóng | Mục đích của lệnh sản xuất, phục vụ lệnh theo đơn/làm sẵn/mẫu/làm lại; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng. Giá trị cho phép: theo_don_khach; lam_san; mau; tai_xu_ly. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_dat_can_dap_ung` | Số lượng đạt cần đáp ứng | Số lượng chính xác | Lượng đạt người đề nghị muốn đáp ứng; lưu ý nhu cầu khai báo khác phần thiếu được tính từ tồn và giữ tại mốc. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_bat_dau_du_kien` | Số lượng bắt đầu dự kiến | Số lượng chính xác | Số lượng bắt đầu do người lập kế hoạch đề nghị trong bản lệnh/lô; có căn cứ đơn hoặc quyết định làm sẵn, không tự lấy ngưỡng tồn ép thành lệnh. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_cam_ket` | Ngày cam kết | Ngày địa phương | Ngày cam kết của lệnh sản xuất, phục vụ lệnh theo đơn/làm sẵn/mẫu/làm lại; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `uu_tien` | Ưu tiên | Số nguyên | Mức ưu tiên được quản lý và giám đốc quyết định có lý do/căn cứ; thứ tự tính từ ngày giao chỉ là đề xuất hiển thị, không tự ghi quyết định. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ly_do_quyet_dinh_uu_tien` | Lý do quyết định ưu tiên | Văn bản | Lý do quyết định ưu tiên của lệnh sản xuất, phục vụ lệnh theo đơn/làm sẵn/mẫu/làm lại; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong lệnh sản xuất. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_chung_tu_dinh_muc` | Mã chứng từ định mức | Mã UUID | Liên kết tới san_xuat.phien_ban_dinh_muc_san_xuat; mã chứng từ định mức xác định đúng vai trò hoặc nguồn trong lệnh sản xuất. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.phien_ban_dinh_muc_san_xuat |
| `ma_dong_don_hang_nguon` | Mã dòng đơn hàng nguồn | Mã UUID | Liên kết tới kinh_doanh.dong_bao_gia_va_don_hang; mã dòng đơn hàng nguồn xác định đúng vai trò hoặc nguồn trong lệnh sản xuất. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.dong_bao_gia_va_don_hang |
| `ma_ho_so_xu_ly_nguon` | Mã hồ sơ xử lý nguồn | Mã UUID | Liên kết tới kinh_doanh.ho_so_thay_doi_va_xu_ly_thuong_mai; mã hồ sơ xử lý nguồn xác định đúng vai trò hoặc nguồn trong lệnh sản xuất. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.ho_so_thay_doi_va_xu_ly_thuong_mai |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Liên kết tới dung_chung.phien_ban_chinh_sach; mã phiên bản chính sách xác định đúng vai trò hoặc nguồn trong lệnh sản xuất. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `ma_chung_tu_quyet_dinh_chot_lenh` | Mã chứng từ quyết định chốt lệnh | Mã UUID | Liên kết tới dung_chung.chung_tu; mã chứng từ quyết định chốt lệnh xác định đúng vai trò hoặc nguồn trong lệnh sản xuất. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Làm sẵn có quyết định sản xuất riêng, không tạo đơn khách giả. Ưu tiên cần người quyết định và lý do. Mẫu/cọc/vật tư đủ trước thực hiện. Tiến độ tính từ công đoạn/kiểm chất lượng; chốt lệnh có chứng từ quyết định riêng sau đối chiếu dở dang/lỗi/chi phí.

**Yêu cầu:** FR09, FR10, FR12, FR13, FR18.

### D050 Lô sản xuất

**Tên bảng:** `san_xuat.lo_san_xuat`. **Phụ trách:** Sản xuất.

**Mục đích:** Một lô thực hiện của lệnh.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của lô sản xuất, phục vụ một lô thực hiện của lệnh; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_bat_dau_du_kien` | Số lượng bắt đầu dự kiến | Số lượng chính xác | Số lượng bắt đầu do người lập kế hoạch đề nghị trong bản lệnh/lô; có căn cứ đơn hoặc quyết định làm sẵn, không tự lấy ngưỡng tồn ép thành lệnh. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_lenh_san_xuat` | Mã lệnh sản xuất | Mã UUID | Liên kết tới san_xuat.lenh_san_xuat; mã lệnh sản xuất xác định đúng vai trò hoặc nguồn trong lô sản xuất. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.lenh_san_xuat |
| `ma_lo_thanh_pham_dau_ra` | Mã lô thành phẩm đầu ra | Mã UUID | Liên kết tới kho.lo_hang; mã lô thành phẩm đầu ra xác định đúng vai trò hoặc nguồn trong lô sản xuất. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.lo_hang |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Kế hoạch là khai báo dự kiến; thực bắt đầu/hoàn thành lấy từ công đoạn, lượng đạt/lỗi lấy từ kiểm chất lượng. Tiến độ tính từ những sự kiện này, không nhập cột trạng thái lô tổng hợp. Lô thành phẩm liên kết đúng lô sản xuất.

**Yêu cầu:** FR12, FR13, FR17, FR19.

### D051 Công đoạn sản xuất

**Tên bảng:** `san_xuat.cong_doan_san_xuat`. **Phụ trách:** Sản xuất.

**Mục đích:** Công đoạn, thời điểm và sản lượng thực.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của công đoạn sản xuất, phục vụ công đoạn, thời điểm và sản lượng thực; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thu_tu` | Thứ tự | Số nguyên | Thứ tự của công đoạn sản xuất, phục vụ công đoạn, thời điểm và sản lượng thực; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_du_kien` | Thời điểm bắt đầu dự kiến | Thời điểm có múi giờ | Thời điểm bắt đầu dự kiến của công đoạn sản xuất, phục vụ công đoạn, thời điểm và sản lượng thực; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_du_kien` | Thời điểm kết thúc dự kiến | Thời điểm có múi giờ | Thời điểm kết thúc dự kiến của công đoạn sản xuất, phục vụ công đoạn, thời điểm và sản lượng thực; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_thuc_te` | Thời điểm bắt đầu thực tế | Thời điểm có múi giờ | Thời điểm bắt đầu thực tế của công đoạn sản xuất, phục vụ công đoạn, thời điểm và sản lượng thực; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_thuc_te` | Thời điểm kết thúc thực tế | Thời điểm có múi giờ | Thời điểm kết thúc thực tế của công đoạn sản xuất, phục vụ công đoạn, thời điểm và sản lượng thực; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_thuc_bat_dau` | Số lượng thực bắt đầu | Số lượng chính xác | Lượng thực đã bắt đầu công đoạn, có thời điểm và xác nhận nguồn. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_thuc_hoan_thanh` | Số lượng thực hoàn thành | Số lượng chính xác | Lượng hoàn thành thực được tổ trưởng ghi và người quản lý xác nhận; không lấy lượng kế hoạch làm thực tế. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_thuc_hien` | Trạng thái thực hiện | Phân loại có danh sách đóng | Trạng thái của sự kiện do người phụ trách xác nhận; không tự nạp đã hoàn tất. Trạng thái tổng hợp từ nhiều sự kiện chỉ tính khi xem. Giá trị cho phép: du_kien; dang_thuc_hien; dang_cho; hoan_thanh. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ly_do` | Lý do | Văn bản | Lý do của công đoạn sản xuất, phục vụ công đoạn, thời điểm và sản lượng thực; được ghi bởi sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong công đoạn sản xuất. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_lo_san_xuat` | Mã lô sản xuất | Mã UUID | Liên kết tới san_xuat.lo_san_xuat; mã lô sản xuất xác định đúng vai trò hoặc nguồn trong công đoạn sản xuất. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.lo_san_xuat |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Liên kết tới dung_chung.phien_ban_chinh_sach; mã phiên bản chính sách xác định đúng vai trò hoặc nguồn trong công đoạn sản xuất. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Bắt đầu/kết thúc và lượng thực có người ghi/xác nhận. Phần chưa hoàn thành tính từ thực bắt đầu trừ thực hoàn thành. Trạng thái thao tác cần mốc/lý do; không tự coi lượng kế hoạch là thực tế. Thời gian chờ sản phẩm không sinh công người.

**Yêu cầu:** FR12, FR13, FR17.

### D052 Lịch và sử dụng nguồn lực

**Tên bảng:** `san_xuat.lich_va_su_dung_nguon_luc`. **Phụ trách:** Quản lý sản xuất.

**Mục đích:** Lịch nguồn lực và giờ máy thực.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của lịch và sử dụng nguồn lực, phục vụ lịch nguồn lực và giờ máy thực; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng. Giá trị cho phép: du_kien; thuc_te. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_khoang` | Thời điểm bắt đầu khoảng | Thời điểm có múi giờ | Thời điểm bắt đầu khoảng của lịch và sử dụng nguồn lực, phục vụ lịch nguồn lực và giờ máy thực; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_khoang` | Thời điểm kết thúc khoảng | Thời điểm có múi giờ | Thời điểm kết thúc khoảng của lịch và sử dụng nguồn lực, phục vụ lịch nguồn lực và giờ máy thực; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_chiem_cho` | Số lượng chiếm chỗ | Số lượng chính xác | Số lượng chiếm chỗ của lịch và sử dụng nguồn lực, phục vụ lịch nguồn lực và giờ máy thực; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: dang_su_dung; da_huy. | Sự kiện hoặc quyết định được ghi nhận | — |
| `muc_dich` | Mục đích | Phân loại có danh sách đóng | Mục đích của lịch và sử dụng nguồn lực, phục vụ lịch nguồn lực và giờ máy thực; được ghi bởi quản lý sản xuất theo hồ sơ nguồn của bảng. Giá trị cho phép: tao_hinh; hoan_thien; duong_ho; chuan_bi_may; bao_tri. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_nguon_luc` | Mã nguồn lực | Mã UUID | Liên kết tới san_xuat.nguon_luc_san_xuat; mã nguồn lực xác định đúng vai trò hoặc nguồn trong lịch và sử dụng nguồn lực. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.nguon_luc_san_xuat |
| `ma_chung_tu_cong_doan` | Mã chứng từ công đoạn | Mã UUID | Liên kết tới san_xuat.cong_doan_san_xuat; mã chứng từ công đoạn xác định đúng vai trò hoặc nguồn trong lịch và sử dụng nguồn lực. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.cong_doan_san_xuat |
| `ma_lich_nguon_luc_bi_thay` | Mã lịch nguồn lực bị thay | Mã UUID | Liên kết tới san_xuat.lich_va_su_dung_nguon_luc; mã lịch nguồn lực bị thay xác định đúng vai trò hoặc nguồn trong lịch và sử dụng nguồn lực. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.lich_va_su_dung_nguon_luc |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Không trùng nguồn độc quyền; nguồn sức chứa cộng occupancy tại mọi khoảng, không vượt 8.000; dự kiến khác thực tế. Bản sửa nối bản trước.

**Yêu cầu:** FR12, FR13, FR26.

### D053 Vật tư thực dùng

**Tên bảng:** `san_xuat.vat_tu_thuc_dung`. **Phụ trách:** Sản xuất xác nhận.

**Mục đích:** Thực dùng/hao hụt theo lô và nguồn cấp.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của vật tư thực dùng, phục vụ thực dùng/hao hụt theo lô và nguồn cấp; được ghi bởi sản xuất xác nhận theo hồ sơ nguồn của bảng. Giá trị cho phép: thuc_dung; hao_hut_san_xuat. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_do_theo_don_vi_co_so` | Số lượng đo theo đơn vị cơ sở | Số lượng chính xác | Số đo thực của hàng bằng đơn vị cơ sở trên dòng xác nhận; nếu được quy đổi từ đơn vị nhập phải dẫn đúng bản quy đổi và phép tính, không tự làm tròn mất hàng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ly_do` | Lý do | Văn bản | Lý do của vật tư thực dùng, phục vụ thực dùng/hao hụt theo lô và nguồn cấp; được ghi bởi sản xuất xác nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_cong_doan` | Mã chứng từ công đoạn | Mã UUID | Liên kết tới san_xuat.cong_doan_san_xuat; mã chứng từ công đoạn xác định đúng vai trò hoặc nguồn trong vật tư thực dùng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.cong_doan_san_xuat |
| `ma_dong_cap_vat_tu_nguon` | Mã dòng cấp vật tư nguồn | Mã UUID | Liên kết tới kho.dong_van_dong_hang; mã dòng cấp vật tư nguồn xác định đúng vai trò hoặc nguồn trong vật tư thực dùng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.dong_van_dong_hang |
| `ma_dong_ghi_thuc_tieu_dung_vat_tu` | Mã dòng ghi thực tiêu dùng vật tư | Mã UUID | Liên kết tới kho.dong_van_dong_hang; mã dòng ghi thực tiêu dùng vật tư xác định đúng vai trò hoặc nguồn trong vật tư thực dùng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.dong_van_dong_hang |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Một thực dùng vận động chỉ gắn một dùng phép. Cấp=đã dùng+hao hụt+đã hoàn+còn tại xưởng; dùng phép không sinh xuất lần hai. Hoàn theo phiếu kho, không thêm bản hoàn độc lập.

**Yêu cầu:** FR13, FR16, FR26.

### D054 Phiếu kiểm tra chất lượng

**Tên bảng:** `chat_luong.phieu_kiem_tra_chat_luong`. **Phụ trách:** Chất lượng.

**Mục đích:** Hồ sơ kiểm tra đúng nguồn/phạm vi.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai_kiem_tra_chat_luong` | Loại kiểm tra chất lượng | Phân loại có danh sách đóng | Loại kiểm tra chất lượng của phiếu kiểm tra chất lượng, phục vụ hồ sơ kiểm tra đúng nguồn/phạm vi; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: dau_vao; trong_san_xuat; thanh_pham; mau; tra_hang; xuat_giao. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_thuc_kiem` | Số lượng thực kiểm | Số lượng chính xác | Lượng đã được thực kiểm hoặc đối chiếu theo phạm vi và phương pháp trong hồ sơ kiểm chất lượng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_ket_luan_dat` | Số lượng kết luận đạt | Số lượng chính xác | Lượng người kiểm tra kết luận đạt trong phạm vi kiểm có căn cứ; không sinh từ tỷ lệ lỗi dự kiến. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_ket_luan_loi` | Số lượng kết luận lỗi | Số lượng chính xác | Lượng được người kiểm tra xác nhận lỗi; nguyên nhân lỗi có thể chồng loại, không cộng các loại lỗi thành lượng mới. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_cho_ket_luan` | Số lượng chờ kết luận | Số lượng chính xác | Lượng người kiểm tra chưa đủ căn cứ kết luận trong phạm vi kiểm; không suy từ kế hoạch thành một kết quả kiểm. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `pham_vi_kiem` | Phạm vi kiểm | Phân loại có danh sách đóng | Phạm vi kiểm của phiếu kiểm tra chất lượng, phục vụ hồ sơ kiểm tra đúng nguồn/phạm vi; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: toan_bo; mau. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `tinh_trang_xac_nhan_ket_luan` | Tình trạng xác nhận kết luận | Phân loại có danh sách đóng | Tình trạng xác nhận kết luận của phiếu kiểm tra chất lượng, phục vụ hồ sơ kiểm tra đúng nguồn/phạm vi; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: cho_xu_ly; da_xac_nhan. | Sự kiện hoặc quyết định được ghi nhận | — |
| `thoi_diem_xac_nhan_ket_luan` | Thời điểm xác nhận kết luận | Thời điểm có múi giờ | Thời điểm xác nhận kết luận của phiếu kiểm tra chất lượng, phục vụ hồ sơ kiểm tra đúng nguồn/phạm vi; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong phiếu kiểm tra chất lượng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_dong_nguon_nghiep_vu` | Mã dòng nguồn nghiệp vụ | Mã UUID | Liên kết tới dung_chung.dong_chung_tu; mã dòng nguồn nghiệp vụ xác định đúng vai trò hoặc nguồn trong phiếu kiểm tra chất lượng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.dong_chung_tu |
| `ma_lo_hang` | Mã lô hàng | Mã UUID | Liên kết tới kho.lo_hang; mã lô hàng xác định đúng vai trò hoặc nguồn trong phiếu kiểm tra chất lượng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.lo_hang |
| `ma_phien_ban_bo_tieu_chi` | Mã phiên bản bộ tiêu chí | Mã UUID | Liên kết tới dung_chung.phien_ban_chinh_sach; mã phiên bản bộ tiêu chí xác định đúng vai trò hoặc nguồn trong phiếu kiểm tra chất lượng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `ma_chung_tu_mau` | Mã chứng từ mẫu | Mã UUID | Liên kết tới kinh_doanh.mau_khach_duyet; mã chứng từ mẫu xác định đúng vai trò hoặc nguồn trong phiếu kiểm tra chất lượng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.mau_khach_duyet |
| `ma_nhan_vien_kiem_chat_luong` | Mã nhân viên kiểm chất lượng | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên kiểm chất lượng xác định đúng vai trò hoặc nguồn trong phiếu kiểm tra chất lượng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Good+lỗi+chờ xử lý đối chiếu nguồn và phạm vi; mẫu chưa có luật không suy rộng. Không ghi đạt từ ty_le_dat_du_kien. Phân phần kho đồng thời qua kho vận động.

**Yêu cầu:** FR09, FR15, FR17, FR27.

### D055 Kết quả từng tiêu chí kiểm tra

**Tên bảng:** `chat_luong.ket_qua_tung_tieu_chi_kiem_tra`. **Phụ trách:** Chất lượng.

**Mục đích:** Số đo/ngoại quan và lỗi theo tiêu chí.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_tieu_chi_kiem` | Mã tiêu chí kiểm | Văn bản | Mã tiêu chí kiểm của kết quả từng tiêu chí kiểm tra, phục vụ số đo/ngoại quan và lỗi theo tiêu chí; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `gia_tri_do_thuc` | Giá trị đo thực | Số thập phân chính xác | Giá trị đo thực của kết quả từng tiêu chí kiểm tra, phục vụ số đo/ngoại quan và lỗi theo tiêu chí; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_don_vi_do` | Mã đơn vị đo | Văn bản | Mã đơn vị đo của kết quả từng tiêu chí kiểm tra, phục vụ số đo/ngoại quan và lỗi theo tiêu chí; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `noi_dung_quan_sat_thuc` | Nội dung quan sát thực | Văn bản | Nội dung quan sát thực của kết quả từng tiêu chí kiểm tra, phục vụ số đo/ngoại quan và lỗi theo tiêu chí; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ket_qua` | Kết quả | Phân loại có danh sách đóng | Kết quả của kết quả từng tiêu chí kiểm tra, phục vụ số đo/ngoại quan và lỗi theo tiêu chí; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: dat; khong_dat; cho_xu_ly. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_bi_anh_huong` | Số lượng bị ảnh hưởng | Số lượng chính xác | Số lượng bị ảnh hưởng của kết quả từng tiêu chí kiểm tra, phục vụ số đo/ngoại quan và lỗi theo tiêu chí; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phieu_kiem_chat_luong` | Mã phiếu kiểm chất lượng | Mã UUID | Liên kết tới chat_luong.phieu_kiem_tra_chat_luong; mã phiếu kiểm chất lượng xác định đúng vai trò hoặc nguồn trong kết quả từng tiêu chí kiểm tra. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | chat_luong.phieu_kiem_tra_chat_luong |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Từ danh sách tiêu chí đóng đúng so_phien_ban; số đo chiều và số viên lỗi khác nhau; lỗi có thể chồng loại, không cộng lỗi theo loại thay lượng lỗi.

**Yêu cầu:** FR17.

### D056 Sự kiện khóa chất lượng

**Tên bảng:** `chat_luong.su_kien_khoa_chat_luong`. **Phụ trách:** Chất lượng.

**Mục đích:** Lịch sử khóa và giải phóng phần lô.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của sự kiện khóa chất lượng, phục vụ lịch sử khóa và giải phóng phần lô; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. Giá trị cho phép: khoa; giai_phong. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ly_do` | Lý do | Văn bản | Lý do của sự kiện khóa chất lượng, phục vụ lịch sử khóa và giải phóng phần lô; được ghi bởi chất lượng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_thuc_hien_nghiep_vu` | Thời điểm thực hiện nghiệp vụ | Thời điểm có múi giờ | Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phan_lo` | Mã phần lô | Mã UUID | Liên kết tới kho.phan_lo_hang; mã phần lô xác định đúng vai trò hoặc nguồn trong sự kiện khóa chất lượng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.phan_lo_hang |
| `ma_su_kien_khoa_goc` | Mã sự kiện khóa gốc | Mã UUID | Liên kết tới chat_luong.su_kien_khoa_chat_luong; mã sự kiện khóa gốc xác định đúng vai trò hoặc nguồn trong sự kiện khóa chất lượng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | chat_luong.su_kien_khoa_chat_luong |
| `ma_phieu_kiem_chat_luong` | Mã phiếu kiểm chất lượng | Mã UUID | Liên kết tới chat_luong.phieu_kiem_tra_chat_luong; mã phiếu kiểm chất lượng xác định đúng vai trò hoặc nguồn trong sự kiện khóa chất lượng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | chat_luong.phieu_kiem_tra_chat_luong |
| `ma_chung_tu_phuong_an_xu_ly` | Mã chứng từ phương án xử lý | Mã UUID | Liên kết tới dung_chung.chung_tu; mã chứng từ phương án xử lý xác định đúng vai trò hoặc nguồn trong sự kiện khóa chất lượng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_nhan_vien_thuc_hien` | Mã nhân viên thực hiện | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên thực hiện xác định đúng vai trò hoặc nguồn trong sự kiện khóa chất lượng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |

**Ràng buộc nghiệp vụ:** Khóa toàn portion; khóa một phần phải split lượng trước. giải phóng trỏ khóa gốc và cần kiểm chất lượng đủ điều kiện; còn khóa khác vẫn khóa. Khóa không giảm tồn nhưng mất hiệu lực giữ giữ hợp lệ.

**Yêu cầu:** FR11, FR17, FR19.

### D057 Phương án xử lý chất lượng

**Tên bảng:** `chat_luong.phuong_an_xu_ly_chat_luong`. **Phụ trách:** Quản lý đề nghị / giám đốc duyệt / thực hiện.

**Mục đích:** Phương án lỗi, làm lại, loại bỏ, thu hồi.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `hanh_dong` | Hành động | Phân loại có danh sách đóng | Hành động của phương án xử lý chất lượng, phục vụ phương án lỗi, làm lại, loại bỏ, thu hồi; được ghi bởi quản lý đề nghị / giám đốc duyệt / thực hiện theo hồ sơ nguồn của bảng. Giá trị cho phép: tai_xu_ly; tieu_huy; tra_nha_cung_cap; thu_hoi; ha_loai. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_duoc_duyet_xu_ly` | Số lượng được duyệt xử lý | Số lượng chính xác | Số lượng được duyệt xử lý của phương án xử lý chất lượng, phục vụ phương án lỗi, làm lại, loại bỏ, thu hồi; được ghi bởi quản lý đề nghị / giám đốc duyệt / thực hiện theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ghi_chu_phuong_an_xu_ly` | Ghi chú phương án xử lý | Văn bản | Ghi chú phương án xử lý của phương án xử lý chất lượng, phục vụ phương án lỗi, làm lại, loại bỏ, thu hồi; được ghi bởi quản lý đề nghị / giám đốc duyệt / thực hiện theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong phương án xử lý chất lượng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_phieu_kiem_chat_luong` | Mã phiếu kiểm chất lượng | Mã UUID | Liên kết tới chat_luong.phieu_kiem_tra_chat_luong; mã phiếu kiểm chất lượng xác định đúng vai trò hoặc nguồn trong phương án xử lý chất lượng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | chat_luong.phieu_kiem_tra_chat_luong |
| `ma_phan_lo` | Mã phần lô | Mã UUID | Liên kết tới kho.phan_lo_hang; mã phần lô xác định đúng vai trò hoặc nguồn trong phương án xử lý chất lượng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.phan_lo_hang |
| `ma_ho_so_xu_ly_thuong_mai` | Mã hồ sơ xử lý thương mại | Mã UUID | Liên kết tới kinh_doanh.ho_so_thay_doi_va_xu_ly_thuong_mai; mã hồ sơ xử lý thương mại xác định đúng vai trò hoặc nguồn trong phương án xử lý chất lượng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.ho_so_thay_doi_va_xu_ly_thuong_mai |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Liên kết tới dung_chung.de_nghi_va_quyet_dinh_phe_duyet; mã phê duyệt xác định đúng vai trò hoặc nguồn trong phương án xử lý chất lượng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Phương án xử lý do kiểm chất lượng đề nghị, có quyết định duyệt theo chứng từ. Lượng thực xử lý lấy từ vận động hàng hoặc công đoạn liên kết đúng phương án; tình trạng thực hiện chỉ tính khi xem. Duyệt tiêu hủy không giảm lượng; thu hồi chưa về không tăng kho.

**Yêu cầu:** FR18, FR19, FR27.

### D058 Đợt giao hàng

**Tên bảng:** `giao_hang.dot_giao_hang`. **Phụ trách:** Giao hàng phối hợp kinh doanh.

**Mục đích:** Một đợt soạn/rời/nhận.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `dia_chi_nhan_tai_luc_giao` | Địa chỉ nhận tại lúc giao | Văn bản | Địa chỉ nhận tại lúc giao của đợt giao hàng, phục vụ một đợt soạn/rời/nhận; được ghi bởi giao hàng phối hợp kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ghi_chu_van_chuyen` | Ghi chú vận chuyển | Văn bản | Ghi chú vận chuyển của đợt giao hàng, phục vụ một đợt soạn/rời/nhận; được ghi bởi giao hàng phối hợp kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_roi_kho` | Thời điểm rời kho | Thời điểm có múi giờ | Thời điểm rời kho của đợt giao hàng, phục vụ một đợt soạn/rời/nhận; được ghi bởi giao hàng phối hợp kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_nhan` | Thời điểm nhận | Thời điểm có múi giờ | Thời điểm nhận của đợt giao hàng, phục vụ một đợt soạn/rời/nhận; được ghi bởi giao hàng phối hợp kinh doanh theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong đợt giao hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_chung_tu_don_hang` | Mã chứng từ đơn hàng | Mã UUID | Liên kết tới kinh_doanh.bao_gia_va_don_hang; mã chứng từ đơn hàng xác định đúng vai trò hoặc nguồn trong đợt giao hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.bao_gia_va_don_hang |
| `ma_ben_nhan` | Mã bên nhận | Mã UUID | Liên kết tới dung_chung.doi_tac; mã bên nhận xác định đúng vai trò hoặc nguồn trong đợt giao hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `ma_ben_van_chuyen` | Mã bên vận chuyển | Mã UUID | Liên kết tới dung_chung.doi_tac; mã bên vận chuyển xác định đúng vai trò hoặc nguồn trong đợt giao hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `ma_can_cu_dai_dien_nhan_hang` | Mã căn cứ đại diện nhận hàng | Mã UUID | Liên kết tới dung_chung.can_cu_dai_dien; mã căn cứ đại diện nhận hàng xác định đúng vai trò hoặc nguồn trong đợt giao hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.can_cu_dai_dien |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Địa chỉ và phương án giao là thỏa thuận. Mốc rời kho/nhận hàng có nguồn phiếu xuất và xác nhận khách; đã giao bao nhiêu, đang giao và tranh chấp dựng từ dòng giao/nhận và hồ sơ xử lý. Không lưu trạng thái giao tổng hợp để ép hoàn thành; khách nhận chưa tự ghi bán.

**Yêu cầu:** FR21.

### D059 Dòng giao hàng

**Tên bảng:** `giao_hang.dong_giao_hang`. **Phụ trách:** Giao hàng / kho ghi thực xuất.

**Mục đích:** Biến thể/lô của đợt giao.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `so_luong_giao_du_kien` | Số lượng giao dự kiến | Số lượng chính xác | Số lượng giao dự kiến của dòng giao hàng, phục vụ biến thể/lô của đợt giao; được ghi bởi giao hàng / kho ghi thực xuất theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_dot_giao` | Mã chứng từ đợt giao | Mã UUID | Liên kết tới giao_hang.dot_giao_hang; mã chứng từ đợt giao xác định đúng vai trò hoặc nguồn trong dòng giao hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | giao_hang.dot_giao_hang |
| `ma_dong_don_hang` | Mã dòng đơn hàng | Mã UUID | Liên kết tới kinh_doanh.dong_bao_gia_va_don_hang; mã dòng đơn hàng xác định đúng vai trò hoặc nguồn trong dòng giao hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.dong_bao_gia_va_don_hang |
| `ma_dong_thuc_xuat_giao_hang` | Mã dòng thực xuất giao hàng | Mã UUID | Liên kết tới kho.dong_van_dong_hang; mã dòng thực xuất giao hàng xác định đúng vai trò hoặc nguồn trong dòng giao hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.dong_van_dong_hang |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Dispatch có thể trống trước rời, một dòng một nguồn portion/lô; nhiều lô nhiều dòng. Phải đúng đơn/so_phien_ban/mặt hàng/bên nhận hàng và còn giao.

**Yêu cầu:** FR19, FR21, FR22, FR27.

### D060 Xác nhận khách nhận hàng

**Tên bảng:** `giao_hang.xac_nhan_khach_nhan_hang`. **Phụ trách:** Giao hàng.

**Mục đích:** Kết quả khách nhận từng phần.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `so_luong_khach_thuc_nhan` | Số lượng khách thực nhận | Số lượng chính xác | Số lượng khách thực nhận của xác nhận khách nhận hàng, phục vụ kết quả khách nhận từng phần; được ghi bởi giao hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_duoc_chap_nhan` | Số lượng được chấp nhận | Số lượng chính xác | Số lượng được chấp nhận của xác nhận khách nhận hàng, phục vụ kết quả khách nhận từng phần; được ghi bởi giao hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_khach_tu_choi` | Số lượng khách từ chối | Số lượng chính xác | Số lượng khách từ chối của xác nhận khách nhận hàng, phục vụ kết quả khách nhận từng phần; được ghi bởi giao hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_hu_hong_duoc_ghi_nhan` | Số lượng hư hỏng được ghi nhận | Số lượng chính xác | Số lượng hư hỏng được ghi nhận của xác nhận khách nhận hàng, phục vụ kết quả khách nhận từng phần; được ghi bởi giao hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_thuc_hien_nghiep_vu` | Thời điểm thực hiện nghiệp vụ | Thời điểm có múi giờ | Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `chung_cu` | Chứng cứ | Văn bản | Chứng cứ của xác nhận khách nhận hàng, phục vụ kết quả khách nhận từng phần; được ghi bởi giao hàng theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_dong_giao_hang` | Mã dòng giao hàng | Mã UUID | Liên kết tới giao_hang.dong_giao_hang; mã dòng giao hàng xác định đúng vai trò hoặc nguồn trong xác nhận khách nhận hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | giao_hang.dong_giao_hang |
| `ma_lien_he_nguoi_nhan_hang` | Mã liên hệ người nhận hàng | Mã UUID | Liên kết tới dung_chung.lien_he_doi_tac; mã liên hệ người nhận hàng xác định đúng vai trò hoặc nguồn trong xác nhận khách nhận hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.lien_he_doi_tac |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |

**Ràng buộc nghiệp vụ:** Tổng nhận không vượt thực xuất chưa ghi nhận; đã chấp nhận+refused=đã nhận, damaged là phân loại trong refused nếu áp dụng, không cộng đôi. Giữ lượng thiếu/đang giao riêng.

**Yêu cầu:** FR21, FR22, FR27.

### D061 Quỹ và tài khoản tiền

**Tên bảng:** `tai_chinh.quy_va_tai_khoan_tien`. **Phụ trách:** Tài chính.

**Mục đích:** Quỹ/tài khoản và số dư tính từ sổ.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của quỹ và tài khoản tiền, phục vụ quỹ/tài khoản và số dư tính từ sổ; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của quỹ và tài khoản tiền, phục vụ quỹ/tài khoản và số dư tính từ sổ; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: tien_mat; ngan_hang. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `tien_te` | Tiền tệ | Phân loại có danh sách đóng | Tiền tệ của quỹ và tài khoản tiền, phục vụ quỹ/tài khoản và số dư tính từ sổ; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: VND. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `dang_su_dung` | Đang sử dụng | Có/không | Đang sử dụng của quỹ và tài khoản tiền, phục vụ quỹ/tài khoản và số dư tính từ sổ; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Không có cột số dư sửa tay; không tự thấu chi.

**Yêu cầu:** FR23, FR24, FR25.

### D062 Đề nghị chi tiền

**Tên bảng:** `tai_chinh.de_nghi_chi_tien`. **Phụ trách:** Kế toán / nhân sự lập; giám đốc duyệt.

**Mục đích:** Được phép chi theo nguồn.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `so_tien_de_nghi` | Số tiền đề nghị | Số tiền VND nguyên đồng | Số tiền đề nghị của đề nghị chi tiền, phục vụ được phép chi theo nguồn; được ghi bởi kế toán / hr lập; giám đốc duyệt theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `muc_dich` | Mục đích | Phân loại có danh sách đóng | Mục đích của đề nghị chi tiền, phục vụ được phép chi theo nguồn; được ghi bởi kế toán / hr lập; giám đốc duyệt theo hồ sơ nguồn của bảng. Giá trị cho phép: nha_cung_cap; ung_truoc; thu_nhap; hoan_tien; chi_phi_ky; chuyen_noi_bo. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ten_nguoi_huong_tai_luc_de_nghi` | Tên người hưởng tại lúc đề nghị | Văn bản | Tên người hưởng tại lúc đề nghị của đề nghị chi tiền, phục vụ được phép chi theo nguồn; được ghi bởi kế toán / hr lập; giám đốc duyệt theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong đề nghị chi tiền. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_doi_tac_huong_tien` | Mã đối tác hưởng tiền | Mã UUID | Liên kết tới dung_chung.doi_tac; mã đối tác hưởng tiền xác định đúng vai trò hoặc nguồn trong đề nghị chi tiền. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `ma_nhan_vien_huong_tien` | Mã nhân viên hưởng tiền | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên hưởng tiền xác định đúng vai trò hoặc nguồn trong đề nghị chi tiền. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_nghia_vu_thanh_toan` | Mã nghĩa vụ thanh toán | Mã UUID | Liên kết tới tai_chinh.nghia_vu_thanh_toan; mã nghĩa vụ thanh toán xác định đúng vai trò hoặc nguồn trong đề nghị chi tiền. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.nghia_vu_thanh_toan |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Liên kết tới dung_chung.de_nghi_va_quyet_dinh_phe_duyet; mã phê duyệt xác định đúng vai trò hoặc nguồn trong đề nghị chi tiền. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `ma_quy_hoac_tai_khoan_dich` | Mã quỹ hoặc tài khoản đích | Mã UUID | Liên kết tới tai_chinh.quy_va_tai_khoan_tien; mã quỹ hoặc tài khoản đích xác định đúng vai trò hoặc nguồn trong đề nghị chi tiền. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.quy_va_tai_khoan_tien |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Số tiền đề nghị có chủ thể và mục đích; duyệt từ quyết định riêng, chưa làm tiền giảm. Phần đã chi/còn chi tính từ biến động tiền được xác nhận, không có trạng thái đã trả nhập tay. Chi không vượt số được duyệt và số dư.

**Yêu cầu:** FR24, FR31.

### D063 Biến động tiền thực

**Tên bảng:** `tai_chinh.bien_dong_tien_thuc`. **Phụ trách:** Người thu/chi xác nhận.

**Mục đích:** Một biến động tiền thực hoặc số đầu.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `chieu_tang_giam` | Chiều tăng giảm | Phân loại có danh sách đóng | Chiều tăng giảm của biến động tiền thực, phục vụ một biến động tiền thực hoặc số đầu; được ghi bởi người thu/chi xác nhận theo hồ sơ nguồn của bảng. Giá trị cho phép: thu_vao; chi_ra; dau_ky. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien` | Số tiền | Số tiền VND nguyên đồng | Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_thuc_hien_nghiep_vu` | Thời điểm thực hiện nghiệp vụ | Thời điểm có múi giờ | Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_doi_chieu_ben_ngoai` | Mã đối chiếu bên ngoài | Văn bản | Mã đối chiếu bên ngoài của biến động tiền thực, phục vụ một biến động tiền thực hoặc số đầu; được ghi bởi người thu/chi xác nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `khoa_chuyen_quy_noi_bo` | Khóa chuyển quỹ nội bộ | Mã UUID | Khóa chuyển quỹ nội bộ của biến động tiền thực, phục vụ một biến động tiền thực hoặc số đầu; được ghi bởi người thu/chi xác nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `pham_vi_xac_dinh_chu_nguon_tien` | Phạm vi xác định chủ nguồn tiền | Phân loại có danh sách đóng | Phạm vi xác định chủ nguồn tiền của biến động tiền thực, phục vụ một biến động tiền thực hoặc số đầu; được ghi bởi người thu/chi xác nhận theo hồ sơ nguồn của bảng. Giá trị cho phép: chua_xac_dinh_chu_the; khach_hang; nha_cung_cap; nhan_vien; noi_bo. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_ghi_so` | Trạng thái ghi sổ | Phân loại có danh sách đóng | Trạng thái ghi sổ của biến động tiền thực, phục vụ một biến động tiền thực hoặc số đầu; được ghi bởi người thu/chi xác nhận theo hồ sơ nguồn của bảng. Giá trị cho phép: nhap; da_ghi_so. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_quy_hoac_tai_khoan_tien` | Mã quỹ hoặc tài khoản tiền | Mã UUID | Liên kết tới tai_chinh.quy_va_tai_khoan_tien; mã quỹ hoặc tài khoản tiền xác định đúng vai trò hoặc nguồn trong biến động tiền thực. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.quy_va_tai_khoan_tien |
| `ma_chung_tu_de_nghi_chi` | Mã chứng từ đề nghị chi | Mã UUID | Liên kết tới tai_chinh.de_nghi_chi_tien; mã chứng từ đề nghị chi xác định đúng vai trò hoặc nguồn trong biến động tiền thực. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.de_nghi_chi_tien |
| `ma_doi_tac` | Mã đối tác | Mã UUID | Liên kết tới dung_chung.doi_tac; mã đối tác xác định đúng vai trò hoặc nguồn trong biến động tiền thực. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `ma_nhan_vien` | Mã nhân viên | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên xác định đúng vai trò hoặc nguồn trong biến động tiền thực. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_can_cu_dai_dien` | Mã căn cứ đại diện | Mã UUID | Liên kết tới dung_chung.can_cu_dai_dien; mã căn cứ đại diện xác định đúng vai trò hoặc nguồn trong biến động tiền thực. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.can_cu_dai_dien |
| `ma_bien_nhan_xac_nhan_giao_dich` | Mã biên nhận xác nhận giao dịch | Mã UUID | Liên kết tới truy_cap.bien_nhan_xac_nhan_giao_dich; mã biên nhận xác nhận giao dịch xác định đúng vai trò hoặc nguồn trong biến động tiền thực. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | truy_cap.bien_nhan_xac_nhan_giao_dich |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |

**Ràng buộc nghiệp vụ:** Amount>0, thực tế chứng cứ; đầu kỳ riêng không doanh thu. Out cần request/duyệt và đủ số dư. Transfer hai đầu cùng khóa/giao dịch nguyên tử. Thu chưa rõ cho party null và không được phân bổ. Chỉ đã ghi sổ có tiền thực; nháp không vào sổ hoặc nguồn phân bổ. ma_doi_tac/ma_nhan_vien ghi bên trả hoặc nhận thực, không đổi thành chủ nghĩa vụ khi trả thay.

**Yêu cầu:** FR05, FR23, FR24, FR25, FR31.

### D064 Nghĩa vụ thanh toán

**Tên bảng:** `tai_chinh.nghia_vu_thanh_toan`. **Phụ trách:** Tài chính.

**Mục đích:** Khoản phải thu/trả/hoàn theo nguồn.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của nghĩa vụ thanh toán, phục vụ khoản phải thu/trả/hoàn theo nguồn; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: phai_thu; phai_tra; phai_hoan_tien; thu_hoi_ung. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien_nghia_vu_goc` | Số tiền nghĩa vụ gốc | Số tiền VND nguyên đồng | Khoản nghĩa vụ được xác lập theo chứng từ gốc đã đối chiếu, không phải số nợ cuối mong muốn. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_den_han_thanh_toan` | Ngày đến hạn thanh toán | Ngày địa phương | Ngày đến hạn thanh toán của nghĩa vụ thanh toán, phục vụ khoản phải thu/trả/hoàn theo nguồn; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ten_nguoi_huong_tai_luc_de_nghi` | Tên người hưởng tại lúc đề nghị | Văn bản | Tên người hưởng tại lúc đề nghị của nghĩa vụ thanh toán, phục vụ khoản phải thu/trả/hoàn theo nguồn; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_dong_nguon_nghiep_vu` | Mã dòng nguồn nghiệp vụ | Mã UUID | Liên kết tới dung_chung.dong_chung_tu; mã dòng nguồn nghiệp vụ xác định đúng vai trò hoặc nguồn trong nghĩa vụ thanh toán. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.dong_chung_tu |
| `ma_doi_tac` | Mã đối tác | Mã UUID | Liên kết tới dung_chung.doi_tac; mã đối tác xác định đúng vai trò hoặc nguồn trong nghĩa vụ thanh toán. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `ma_nhan_vien` | Mã nhân viên | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên xác định đúng vai trò hoặc nguồn trong nghĩa vụ thanh toán. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Một nghĩa vụ có đúng chủ thể, chứng từ nguồn và số tiền gốc đã xác lập. Nợ còn lại tính từ điều chỉnh và sử dụng tiền; tranh chấp có hồ sơ riêng. Nhận đơn mua không tự tạo phải trả; dòng lương chưa duyệt chưa được phép chi.

**Yêu cầu:** FR22, FR24, FR25, FR27, FR31.

### D065 Điều chỉnh nghĩa vụ

**Tên bảng:** `tai_chinh.dieu_chinh_nghia_vu`. **Phụ trách:** Tài chính.

**Mục đích:** Điều chỉnh nghĩa vụ không sửa gốc.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `loai_su_kien_dieu_chinh` | Loại sự kiện điều chỉnh | Phân loại có danh sách đóng | Loại sự kiện điều chỉnh của điều chỉnh nghĩa vụ, phục vụ điều chỉnh nghĩa vụ không sửa gốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: doi_so_tien; doi_han. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `chieu_tang_giam` | Chiều tăng giảm | Phân loại có danh sách đóng | Chiều tăng giảm của điều chỉnh nghĩa vụ, phục vụ điều chỉnh nghĩa vụ không sửa gốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: tang; giam. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien` | Số tiền | Số tiền VND nguyên đồng | Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_thuc_hien_nghiep_vu` | Thời điểm thực hiện nghiệp vụ | Thời điểm có múi giờ | Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ly_do` | Lý do | Văn bản | Lý do của điều chỉnh nghĩa vụ, phục vụ điều chỉnh nghĩa vụ không sửa gốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_den_han_moi` | Ngày đến hạn mới | Ngày địa phương | Ngày đến hạn mới của điều chỉnh nghĩa vụ, phục vụ điều chỉnh nghĩa vụ không sửa gốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_nghia_vu_thanh_toan` | Mã nghĩa vụ thanh toán | Mã UUID | Liên kết tới tai_chinh.nghia_vu_thanh_toan; mã nghĩa vụ thanh toán xác định đúng vai trò hoặc nguồn trong điều chỉnh nghĩa vụ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.nghia_vu_thanh_toan |
| `ma_su_kien_goc` | Mã sự kiện gốc | Mã UUID | Liên kết tới tai_chinh.dieu_chinh_nghia_vu; mã sự kiện gốc xác định đúng vai trò hoặc nguồn trong điều chỉnh nghĩa vụ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.dieu_chinh_nghia_vu |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Liên kết tới dung_chung.de_nghi_va_quyet_dinh_phe_duyet; mã phê duyệt xác định đúng vai trò hoặc nguồn trong điều chỉnh nghĩa vụ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |

**Ràng buộc nghiệp vụ:** Số gốc bất biến, phần điều chỉnh có nguồn bán/đối chiếu/phương án; không giảm quá còn hợp lệ. Chuyển phần đã thu thành nghĩa vụ hoàn phải tái phân loại ứng có căn cứ. Amount_change bắt chieu_tang_giam/so_tien>0; đổi hạn chỉ ngay_den_han_moi, không đổi tiền; due tại mốc dựng từ ngày gốc và sự kiện được duyệt, không sửa gốc.

**Yêu cầu:** FR06, FR24, FR25, FR27, FR30.

### D066 Sự kiện sử dụng nguồn tiền

**Tên bảng:** `tai_chinh.su_kien_su_dung_nguon_tien`. **Phụ trách:** Kế toán.

**Mục đích:** Dùng tiền cho nghĩa vụ hoặc giữ nguồn hoàn.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của sự kiện sử dụng nguồn tiền, phục vụ dùng tiền cho nghĩa vụ hoặc giữ nguồn hoàn; được ghi bởi kế toán theo hồ sơ nguồn của bảng. Giá trị cho phép: su_dung_tien_thanh_toan; dao_su_dung_tien; giu_nguon_hoan; giai_phong_nguon_hoan; thuc_dung_nguon_hoan. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien` | Số tiền | Số tiền VND nguyên đồng | Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_thuc_hien_nghiep_vu` | Thời điểm thực hiện nghiệp vụ | Thời điểm có múi giờ | Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_bien_dong_tien_thuc` | Mã biến động tiền thực | Mã UUID | Liên kết tới tai_chinh.bien_dong_tien_thuc; mã biến động tiền thực xác định đúng vai trò hoặc nguồn trong sự kiện sử dụng nguồn tiền. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.bien_dong_tien_thuc |
| `ma_nghia_vu_thanh_toan` | Mã nghĩa vụ thanh toán | Mã UUID | Liên kết tới tai_chinh.nghia_vu_thanh_toan; mã nghĩa vụ thanh toán xác định đúng vai trò hoặc nguồn trong sự kiện sử dụng nguồn tiền. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.nghia_vu_thanh_toan |
| `ma_su_kien_su_dung_tien_goc` | Mã sự kiện sử dụng tiền gốc | Mã UUID | Liên kết tới tai_chinh.su_kien_su_dung_nguon_tien; mã sự kiện sử dụng tiền gốc xác định đúng vai trò hoặc nguồn trong sự kiện sử dụng nguồn tiền. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.su_kien_su_dung_nguon_tien |
| `ma_bien_dong_tien_thuc_hoan` | Mã biến động tiền thực hoàn | Mã UUID | Liên kết tới tai_chinh.bien_dong_tien_thuc; mã biến động tiền thực hoàn xác định đúng vai trò hoặc nguồn trong sự kiện sử dụng nguồn tiền. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.bien_dong_tien_thuc |
| `ma_can_cu_dai_dien` | Mã căn cứ đại diện | Mã UUID | Liên kết tới dung_chung.can_cu_dai_dien; mã căn cứ đại diện xác định đúng vai trò hoặc nguồn trong sự kiện sử dụng nguồn tiền. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.can_cu_dai_dien |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |

**Ràng buộc nghiệp vụ:** Chỉ sử dụng tiền thanh toán đúng bên/hướng; tiền chưa dùng trừ cả phần bị giữ hoàn. Reverse không thu/chi mới. Consume_refund nối thực chi để phần thu cũ không trở lại khả dụng. Tổng không vượt nguồn/nghĩa vụ. tiền mặt.ma_doi_tac là người trả/nhận thực, obligation.ma_doi_tac là chủ nghĩa vụ; nếu khác bắt authority đúng represented party/agent/nguồn. Nguồn chưa rõ phải có hồ sơ đối chiếu xác định chủ trước sử dụng tiền thanh toán, không sửa tiền thực.

**Yêu cầu:** FR05, FR23, FR24, FR25, FR27, FR31.

### D067 Chứng từ ghi nhận bán

**Tên bảng:** `tai_chinh.chung_tu_ghi_nhan_ban`. **Phụ trách:** Kế toán.

**Mục đích:** Ghi nhận bán hoặc điều chỉnh thương mại.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của chứng từ ghi nhận bán, phục vụ ghi nhận bán hoặc điều chỉnh thương mại; được ghi bởi kế toán theo hồ sơ nguồn của bảng. Giá trị cho phép: ghi_ban; giam_ban; tang_ban. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_thuc_hien_nghiep_vu` | Thời điểm thực hiện nghiệp vụ | Thời điểm có múi giờ | Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `pham_vi_mo_phong_thue` | Phạm vi mô phỏng thuế | Phân loại có danh sách đóng | Phạm vi mô phỏng thuế của chứng từ ghi nhận bán, phục vụ ghi nhận bán hoặc điều chỉnh thương mại; được ghi bởi kế toán theo hồ sơ nguồn của bảng. Giá trị cho phép: chua_mo_phong. | Dữ liệu kỹ thuật | — |
| `trang_thai_thuc_hien` | Trạng thái thực hiện | Phân loại có danh sách đóng | Trạng thái của sự kiện do người phụ trách xác nhận; không tự nạp đã hoàn tất. Trạng thái tổng hợp từ nhiều sự kiện chỉ tính khi xem. Giá trị cho phép: nhap; da_ghi_so. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong chứng từ ghi nhận bán. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_chung_tu_don_hang` | Mã chứng từ đơn hàng | Mã UUID | Liên kết tới kinh_doanh.bao_gia_va_don_hang; mã chứng từ đơn hàng xác định đúng vai trò hoặc nguồn trong chứng từ ghi nhận bán. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.bao_gia_va_don_hang |
| `ma_ho_so_xu_ly_thuong_mai` | Mã hồ sơ xử lý thương mại | Mã UUID | Liên kết tới kinh_doanh.ho_so_thay_doi_va_xu_ly_thuong_mai; mã hồ sơ xử lý thương mại xác định đúng vai trò hoặc nguồn trong chứng từ ghi nhận bán. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.ho_so_thay_doi_va_xu_ly_thuong_mai |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Liên kết tới dung_chung.de_nghi_va_quyet_dinh_phe_duyet; mã phê duyệt xác định đúng vai trò hoặc nguồn trong chứng từ ghi nhận bán. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Sale thường chỉ sau chấp nhận; giảm bán/tăng bán có căn cứ và quyết định; không hóa đơn pháp lý.

**Yêu cầu:** FR22, FR27.

### D068 Dòng ghi nhận bán

**Tên bảng:** `tai_chinh.dong_ghi_nhan_ban`. **Phụ trách:** Kế toán.

**Mục đích:** Doanh thu theo lượng/giá đã chấp nhận.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `so_vien_thoa_thuan` | Số viên thỏa thuận | Số lượng chính xác | Số viên thỏa thuận của dòng ghi nhận bán, phục vụ doanh thu theo lượng/giá đã chấp nhận; được ghi bởi kế toán theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `don_gia_tai_lan_ghi_nhan` | Đơn giá tại lần ghi nhận | Số thập phân chính xác | Đơn giá tại lần ghi nhận của dòng ghi nhận bán, phục vụ doanh thu theo lượng/giá đã chấp nhận; được ghi bởi kế toán theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `so_tien` | Số tiền | Số tiền VND nguyên đồng | Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối. | Kết quả đã ghi nhận có căn cứ | — |
| `tinh_trang_ghi_nhan_gia_von` | Tình trạng ghi nhận giá vốn | Phân loại có danh sách đóng | Tình trạng ghi nhận giá vốn của dòng ghi nhận bán, phục vụ doanh thu theo lượng/giá đã chấp nhận; được ghi bởi kế toán theo hồ sơ nguồn của bảng. Giá trị cho phép: tam_tinh; da_xac_nhan. | Kết quả đã ghi nhận có căn cứ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_ghi_ban` | Mã chứng từ ghi bán | Mã UUID | Liên kết tới tai_chinh.chung_tu_ghi_nhan_ban; mã chứng từ ghi bán xác định đúng vai trò hoặc nguồn trong dòng ghi nhận bán. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.chung_tu_ghi_nhan_ban |
| `ma_dong_xac_nhan_khach_nhan` | Mã dòng xác nhận khách nhận | Mã UUID | Liên kết tới giao_hang.xac_nhan_khach_nhan_hang; mã dòng xác nhận khách nhận xác định đúng vai trò hoặc nguồn trong dòng ghi nhận bán. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | giao_hang.xac_nhan_khach_nhan_hang |
| `ma_dong_ghi_ban_goc` | Mã dòng ghi bán gốc | Mã UUID | Liên kết tới tai_chinh.dong_ghi_nhan_ban; mã dòng ghi bán gốc xác định đúng vai trò hoặc nguồn trong dòng ghi nhận bán. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.dong_ghi_nhan_ban |
| `ma_dong_don_hang` | Mã dòng đơn hàng | Mã UUID | Liên kết tới kinh_doanh.dong_bao_gia_va_don_hang; mã dòng đơn hàng xác định đúng vai trò hoặc nguồn trong dòng ghi nhận bán. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kinh_doanh.dong_bao_gia_va_don_hang |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Bán không vượt đã chấp nhận chưa ghi; giảm bán/tăng bán chỉ gốc đã ghi và phần còn; không xuất kho lần hai. Giá vốn nguồn value_entry, không nhân giá bán.

**Yêu cầu:** FR22, FR26, FR27.

### D069 Đối chiếu nghĩa vụ mua

**Tên bảng:** `tai_chinh.doi_chieu_nghia_vu_mua`. **Phụ trách:** Mua hàng / kế toán đối chiếu.

**Mục đích:** Chứng từ nghĩa vụ và giá trị mua được chấp nhận.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `so_luong_duoc_chap_nhan` | Số lượng được chấp nhận | Số lượng chính xác | Số lượng được chấp nhận của đối chiếu nghĩa vụ mua, phục vụ chứng từ nghĩa vụ và giá trị mua được chấp nhận; được ghi bởi mua hàng / kế toán đối chiếu theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien_doi_chieu_chap_nhan_mua` | Số tiền đối chiếu chấp nhận mua | Số tiền VND nguyên đồng | Số tiền đối chiếu chấp nhận mua của đối chiếu nghĩa vụ mua, phục vụ chứng từ nghĩa vụ và giá trị mua được chấp nhận; được ghi bởi mua hàng / kế toán đối chiếu theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `ma_chung_tu_nha_cung_cap` | Mã chứng từ nhà cung cấp | Văn bản | Mã chứng từ nhà cung cấp của đối chiếu nghĩa vụ mua, phục vụ chứng từ nghĩa vụ và giá trị mua được chấp nhận; được ghi bởi mua hàng / kế toán đối chiếu theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_den_han_thanh_toan` | Ngày đến hạn thanh toán | Ngày địa phương | Ngày đến hạn thanh toán của đối chiếu nghĩa vụ mua, phục vụ chứng từ nghĩa vụ và giá trị mua được chấp nhận; được ghi bởi mua hàng / kế toán đối chiếu theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_thuc_hien` | Trạng thái thực hiện | Phân loại có danh sách đóng | Trạng thái của sự kiện do người phụ trách xác nhận; không tự nạp đã hoàn tất. Trạng thái tổng hợp từ nhiều sự kiện chỉ tính khi xem. Giá trị cho phép: cho_xu_ly; da_xac_nhan; tranh_chap. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_dong_don_mua` | Mã dòng đơn mua | Mã UUID | Liên kết tới mua_hang.dong_don_mua_hang; mã dòng đơn mua xác định đúng vai trò hoặc nguồn trong đối chiếu nghĩa vụ mua. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | mua_hang.dong_don_mua_hang |
| `ma_dong_nhan_hang_mua` | Mã dòng nhận hàng mua | Mã UUID | Liên kết tới kho.dong_van_dong_hang; mã dòng nhận hàng mua xác định đúng vai trò hoặc nguồn trong đối chiếu nghĩa vụ mua. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.dong_van_dong_hang |
| `ma_phieu_kiem_chat_luong` | Mã phiếu kiểm chất lượng | Mã UUID | Liên kết tới chat_luong.phieu_kiem_tra_chat_luong; mã phiếu kiểm chất lượng xác định đúng vai trò hoặc nguồn trong đối chiếu nghĩa vụ mua. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | chat_luong.phieu_kiem_tra_chat_luong |
| `ma_nha_cung_cap` | Mã nhà cung cấp | Mã UUID | Liên kết tới dung_chung.doi_tac; mã nhà cung cấp xác định đúng vai trò hoặc nguồn trong đối chiếu nghĩa vụ mua. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.doi_tac |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Không vượt phần nhận/đạt/chưa đối chiếu; lỗi/thừa chờ riêng; nhà cung cấp reference chống nhập trùng theo nguồn, không giả nhận đạt cả đơn mua.

**Yêu cầu:** FR14, FR15, FR24.

### D070 Dòng đối chiếu quỹ ngân hàng

**Tên bảng:** `tai_chinh.dong_doi_chieu_quy_ngan_hang`. **Phụ trách:** Tài chính.

**Mục đích:** Đối chiếu quỹ/ngân hàng giả lập theo mốc.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `ma_doi_chieu_ben_ngoai` | Mã đối chiếu bên ngoài | Văn bản | Mã đối chiếu bên ngoài của dòng đối chiếu quỹ ngân hàng, phục vụ đối chiếu quỹ/ngân hàng giả lập theo mốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien_thuc_tren_nguon_doi_chieu` | Số tiền thực trên nguồn đối chiếu | Số tiền VND nguyên đồng | Số tiền thực trên nguồn đối chiếu của dòng đối chiếu quỹ ngân hàng, phục vụ đối chiếu quỹ/ngân hàng giả lập theo mốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `chieu_tang_giam` | Chiều tăng giảm | Phân loại có danh sách đóng | Chiều tăng giảm của dòng đối chiếu quỹ ngân hàng, phục vụ đối chiếu quỹ/ngân hàng giả lập theo mốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: thu_vao; chi_ra. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_quan_sat_nguon_doi_chieu` | Thời điểm quan sát nguồn đối chiếu | Thời điểm có múi giờ | Thời điểm quan sát nguồn đối chiếu của dòng đối chiếu quỹ ngân hàng, phục vụ đối chiếu quỹ/ngân hàng giả lập theo mốc; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: chua_doi_chieu; da_doi_chieu; tranh_chap. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_quy_hoac_tai_khoan_tien` | Mã quỹ hoặc tài khoản tiền | Mã UUID | Liên kết tới tai_chinh.quy_va_tai_khoan_tien; mã quỹ hoặc tài khoản tiền xác định đúng vai trò hoặc nguồn trong dòng đối chiếu quỹ ngân hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.quy_va_tai_khoan_tien |
| `ma_bien_dong_tien_thuc` | Mã biến động tiền thực | Mã UUID | Liên kết tới tai_chinh.bien_dong_tien_thuc; mã biến động tiền thực xác định đúng vai trò hoặc nguồn trong dòng đối chiếu quỹ ngân hàng. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.bien_dong_tien_thuc |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Movement có thể trống nếu chưa khớp; không tự sinh tiền từ sao kê. Chênh có hồ sơ xử lý, không sửa số cuối.

**Yêu cầu:** FR23, FR25.

### D071 Nguồn chi phí

**Tên bảng:** `tai_chinh.nguon_chi_phi`. **Phụ trách:** Tài chính; nhân sự cung cấp phần lương.

**Mục đích:** Một nguồn chi phí được đối chiếu.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của nguồn chi phí, phục vụ một nguồn chi phí được đối chiếu; được ghi bởi tài chính; hr cung cấp phần lương theo hồ sơ nguồn của bảng. Giá trị cho phép: vat_tu; nhan_cong; chi_phi_chung; bo_sung; co_the_thu_hoi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien` | Số tiền | Số tiền VND nguyên đồng | Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối. | Kết quả đã ghi nhận có căn cứ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: tam_tinh; da_xac_nhan. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ghi_chu_can_cu_chi_phi` | Ghi chú căn cứ chi phí | Văn bản | Ghi chú căn cứ chi phí của nguồn chi phí, phục vụ một nguồn chi phí được đối chiếu; được ghi bởi tài chính; hr cung cấp phần lương theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_dong_nguon_nghiep_vu` | Mã dòng nguồn nghiệp vụ | Mã UUID | Liên kết tới dung_chung.dong_chung_tu; mã dòng nguồn nghiệp vụ xác định đúng vai trò hoặc nguồn trong nguồn chi phí. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.dong_chung_tu |
| `ma_dong_thu_nhap_nhan_vien` | Mã dòng thu nhập nhân viên | Mã UUID | Liên kết tới nhan_su.dong_thu_nhap_nhan_vien; mã dòng thu nhập nhân viên xác định đúng vai trò hoặc nguồn trong nguồn chi phí. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.dong_thu_nhap_nhan_vien |
| `ma_dong_vat_tu_thuc_dung` | Mã dòng vật tư thực dùng | Mã UUID | Liên kết tới san_xuat.vat_tu_thuc_dung; mã dòng vật tư thực dùng xác định đúng vai trò hoặc nguồn trong nguồn chi phí. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.vat_tu_thuc_dung |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Liên kết tới dung_chung.phien_ban_chinh_sach; mã phiên bản chính sách xác định đúng vai trò hoặc nguồn trong nguồn chi phí. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `ma_nguon_chi_phi_bi_thay` | Mã nguồn chi phí bị thay | Mã UUID | Liên kết tới tai_chinh.nguon_chi_phi; mã nguồn chi phí bị thay xác định đúng vai trò hoặc nguồn trong nguồn chi phí. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.nguon_chi_phi |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Duy nhất nguồn+loại+bản; vật tư/nhân công trỏ đúng loại nguồn, chi phí chung ma_dong_nguon_nghiep_vu chứng từ chi phí chứ không tiền chi. Nguồn thu hồi tách, không cộng trùng phải trả/chi tiền. Cost nguồn đầu vào có dòng riêng; ma_dong_nguon_nghiep_vu có thể trống chỉ với nguồn chi phí chung/bổ sung tự khai có chứng từ và duyệt; vật tư/nhân công phải có nguồn.

**Yêu cầu:** FR18, FR26, FR31.

### D072 Phân bổ chi phí

**Tên bảng:** `tai_chinh.phan_bo_chi_phi`. **Phụ trách:** Tài chính.

**Mục đích:** Phân bổ nguồn đến lô hoặc chi phí khác.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `so_tien` | Số tiền | Số tiền VND nguyên đồng | Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối. | Kết quả đã ghi nhận có căn cứ | — |
| `doi_tuong_chiu_chi_phi` | Đối tượng chịu chi phí | Phân loại có danh sách đóng | Đối tượng chịu chi phí của phân bổ chi phí, phục vụ phân bổ nguồn đến lô hoặc chi phí khác; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: lo_san_xuat; viec_khac_tai_xuong; ngoai_san_xuat; thu_hoi_gia_tri. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_can_cu_phan_bo` | Số lượng căn cứ phân bổ | Số thập phân chính xác | Số lượng căn cứ phân bổ của phân bổ chi phí, phục vụ phân bổ nguồn đến lô hoặc chi phí khác; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: tam_tinh; da_xac_nhan. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_nguon_chi_phi` | Mã nguồn chi phí | Mã UUID | Liên kết tới tai_chinh.nguon_chi_phi; mã nguồn chi phí xác định đúng vai trò hoặc nguồn trong phân bổ chi phí. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.nguon_chi_phi |
| `ma_lo_san_xuat` | Mã lô sản xuất | Mã UUID | Liên kết tới san_xuat.lo_san_xuat; mã lô sản xuất xác định đúng vai trò hoặc nguồn trong phân bổ chi phí. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.lo_san_xuat |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Liên kết tới dung_chung.phien_ban_chinh_sach; mã phiên bản chính sách xác định đúng vai trò hoặc nguồn trong phân bổ chi phí. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `ma_ban_phan_bo_chi_phi_bi_thay` | Mã bản phân bổ chi phí bị thay | Mã UUID | Liên kết tới tai_chinh.phan_bo_chi_phi; mã bản phân bổ chi phí bị thay xác định đúng vai trò hoặc nguồn trong phân bổ chi phí. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.phan_bo_chi_phi |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Batch có thể trống với nguồn khác; bản cũ giữ. Tổng phân bổ đang hiệu lực không vượt nguồn; nguyên liệu/nhân công/chung không cộng lại lúc chi tiền.

**Yêu cầu:** FR18, FR26, FR31.

### D073 Căn cứ phân bổ chi phí

**Tên bảng:** `tai_chinh.can_cu_phan_bo_chi_phi`. **Phụ trách:** Tài chính; sản xuất/nhân sự xác nhận nguồn giờ.

**Mục đích:** Các dòng thực làm/giờ máy/vật tư cho phân bổ.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai_can_cu_phan_bo` | Loại căn cứ phân bổ | Phân loại có danh sách đóng | Loại căn cứ phân bổ của căn cứ phân bổ chi phí, phục vụ các dòng thực làm/giờ máy/vật tư cho phân bổ; được ghi bởi tài chính; sản xuất/hr xác nhận nguồn giờ theo hồ sơ nguồn của bảng. Giá trị cho phép: phut_cong; phut_may; luong_vat_tu. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_luong_can_cu_phan_bo` | Số lượng căn cứ phân bổ | Số thập phân chính xác | Số lượng căn cứ phân bổ của căn cứ phân bổ chi phí, phục vụ các dòng thực làm/giờ máy/vật tư cho phân bổ; được ghi bởi tài chính; sản xuất/hr xác nhận nguồn giờ theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_dong_phan_bo_chi_phi` | Mã dòng phân bổ chi phí | Mã UUID | Liên kết tới tai_chinh.phan_bo_chi_phi; mã dòng phân bổ chi phí xác định đúng vai trò hoặc nguồn trong căn cứ phân bổ chi phí. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.phan_bo_chi_phi |
| `ma_khoang_cong_thuc_te` | Mã khoảng công thực tế | Mã UUID | Liên kết tới nhan_su.khoang_cong_thuc_te; mã khoảng công thực tế xác định đúng vai trò hoặc nguồn trong căn cứ phân bổ chi phí. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.khoang_cong_thuc_te |
| `ma_lich_nguon_luc` | Mã lịch nguồn lực | Mã UUID | Liên kết tới san_xuat.lich_va_su_dung_nguon_luc; mã lịch nguồn lực xác định đúng vai trò hoặc nguồn trong căn cứ phân bổ chi phí. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.lich_va_su_dung_nguon_luc |
| `ma_dong_vat_tu_thuc_dung` | Mã dòng vật tư thực dùng | Mã UUID | Liên kết tới san_xuat.vat_tu_thuc_dung; mã dòng vật tư thực dùng xác định đúng vai trò hoặc nguồn trong căn cứ phân bổ chi phí. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.vat_tu_thuc_dung |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Chính xác một nguồn phù hợp loai; máy phải thực tế; nhân công phải đã xác nhận/trực tiếp. Không lấy giờ người thành giờ máy.

**Yêu cầu:** FR12, FR26, FR29, FR31.

### D074 Bản chốt giá thành

**Tên bảng:** `tai_chinh.ban_chot_gia_thanh`. **Phụ trách:** Tài chính cùng sản xuất đối chiếu.

**Mục đích:** Bản giá thành lô được chốt hoặc tạm tính.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: tam_tinh; da_xac_nhan. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong bản chốt giá thành. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_lo_san_xuat` | Mã lô sản xuất | Mã UUID | Liên kết tới san_xuat.lo_san_xuat; mã lô sản xuất xác định đúng vai trò hoặc nguồn trong bản chốt giá thành. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.lo_san_xuat |
| `ma_phien_ban_chinh_sach_dinh_gia` | Mã phiên bản chính sách định giá | Mã UUID | Liên kết tới dung_chung.phien_ban_chinh_sach; mã phiên bản chính sách định giá xác định đúng vai trò hoặc nguồn trong bản chốt giá thành. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Bản chốt lưu quyết định và danh sách phân bổ/nguồn đúng phiên bản. Tổng giá thành, lượng đạt và danh sách thiếu được tính khi đọc từ nguồn đã liên kết, không có cột tổng nhập tay. Chưa đủ lượng, lỗi và nguồn thì giữ tạm tính.

**Yêu cầu:** FR13, FR18, FR26.

### D075 Biến động giá trị

**Tên bảng:** `tai_chinh.bien_dong_gia_tri`. **Phụ trách:** Tài chính.

**Mục đích:** Sổ giá trị kho/xưởng/đang giao/giá vốn.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `nhom_gia_tri_nguon` | Nhóm giá trị nguồn | Phân loại có danh sách đóng | Nhóm giá trị nguồn của biến động giá trị, phục vụ sổ giá trị kho/xưởng/đang giao/giá vốn; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: nguon_dau_vao; ton_hang; do_dang; dang_giao; gia_von; chi_phi_ky; thu_hoi_gia_tri. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `nhom_gia_tri_dich` | Nhóm giá trị đích | Phân loại có danh sách đóng | Nhóm giá trị đích của biến động giá trị, phục vụ sổ giá trị kho/xưởng/đang giao/giá vốn; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: nguon_dau_vao; ton_hang; do_dang; dang_giao; gia_von; chi_phi_ky; thu_hoi_gia_tri. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien` | Số tiền | Số tiền VND nguyên đồng | Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối. | Kết quả đã ghi nhận có căn cứ | — |
| `thoi_diem_thuc_hien_nghiep_vu` | Thời điểm thực hiện nghiệp vụ | Thời điểm có múi giờ | Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `tinh_trang_xac_nhan_dinh_gia` | Tình trạng xác nhận định giá | Phân loại có danh sách đóng | Tình trạng xác nhận định giá của biến động giá trị, phục vụ sổ giá trị kho/xưởng/đang giao/giá vốn; được ghi bởi tài chính theo hồ sơ nguồn của bảng. Giá trị cho phép: tam_tinh; da_xac_nhan. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `quy_tac_lam_tron_da_ap_dung` | Quy tắc làm tròn đã áp dụng | Văn bản | Quy tắc làm tròn đã áp dụng của biến động giá trị, phục vụ sổ giá trị kho/xưởng/đang giao/giá vốn; được ghi bởi tài chính theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_mat_hang` | Mã mặt hàng | Mã UUID | Liên kết tới danh_muc.mat_hang; mã mặt hàng xác định đúng vai trò hoặc nguồn trong biến động giá trị. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | danh_muc.mat_hang |
| `ma_dong_van_dong_hang` | Mã dòng vận động hàng | Mã UUID | Liên kết tới kho.dong_van_dong_hang; mã dòng vận động hàng xác định đúng vai trò hoặc nguồn trong biến động giá trị. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.dong_van_dong_hang |
| `ma_chung_tu_ban_chot_gia_thanh` | Mã chứng từ bản chốt giá thành | Mã UUID | Liên kết tới tai_chinh.ban_chot_gia_thanh; mã chứng từ bản chốt giá thành xác định đúng vai trò hoặc nguồn trong biến động giá trị. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.ban_chot_gia_thanh |
| `ma_dong_ghi_ban` | Mã dòng ghi bán | Mã UUID | Liên kết tới tai_chinh.dong_ghi_nhan_ban; mã dòng ghi bán xác định đúng vai trò hoặc nguồn trong biến động giá trị. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.dong_ghi_nhan_ban |
| `ma_bien_dong_gia_tri_goc` | Mã biến động giá trị gốc | Mã UUID | Liên kết tới tai_chinh.bien_dong_gia_tri; mã biến động giá trị gốc xác định đúng vai trò hoặc nguồn trong biến động giá trị. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.bien_dong_gia_tri |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |

**Ràng buộc nghiệp vụ:** Hai bucket khác nhau, so_tien>0; mỗi biến động giá trị có đúng nguồn và chỉ ghi một lần theo hanh_dong. Chốt/sửa giá trị không thêm lượng; xuất hết mang giá trị còn. Theo mặt hàng/bộ dữ liệu và bucket, giữ lô vật lý riêng với bình quân.

**Yêu cầu:** FR06, FR15, FR16, FR22, FR26, FR27.

### D076 Nhân viên

**Tên bảng:** `nhan_su.nhan_vien`. **Phụ trách:** Nhân sự.

**Mục đích:** Một hồ sơ người, không bắt có tài khoản.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của nhân viên, phục vụ một hồ sơ người, không bắt có tài khoản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_nguoi_that` | Mã người thật | Mã UUID | Liên kết tới truy_cap.dinh_danh_nguoi; mã người thật xác định đúng vai trò hoặc nguồn trong nhân viên. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | truy_cap.dinh_danh_nguoi |
| `ten` | Tên | Văn bản | Tên của nhân viên, phục vụ một hồ sơ người, không bắt có tài khoản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_vao_lam` | Ngày vào làm | Ngày địa phương | Ngày vào làm của nhân viên, phục vụ một hồ sơ người, không bắt có tài khoản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_nghi_viec` | Ngày nghỉ việc | Ngày địa phương | Ngày nghỉ việc của nhân viên, phục vụ một hồ sơ người, không bắt có tài khoản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Duy nhất(bộ dữ liệu,ma_nghiep_vu/ma_nguoi_that); định danh người ổn định, không tạo người thứ hai để tự duyệt; dữ liệu thật không Git. Dept/lương lịch sử ở employment, không số hiện tại thay quá khứ. Trạng thái tại mốc lấy employment hiệu lực, không cột trạng thái hiện tại thay quá khứ.

**Yêu cầu:** FR01, FR02, FR28, FR31.

### D077 Hồ sơ làm việc theo hiệu lực

**Tên bảng:** `nhan_su.ho_so_lam_viec_theo_hieu_luc`. **Phụ trách:** Nhân sự theo quyết định.

**Mục đích:** Hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `thoi_diem_bat_dau_hieu_luc` | Thời điểm bắt đầu hiệu lực | Ngày địa phương | Thời điểm bắt đầu hiệu lực của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_hieu_luc` | Thời điểm kết thúc hiệu lực | Ngày địa phương | Thời điểm kết thúc hiệu lực của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai_ho_so_hop_dong` | Loại hồ sơ hợp đồng | Văn bản | Loại hồ sơ hợp đồng của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ngay_ket_thuc_hop_dong` | Ngày kết thúc hợp đồng | Ngày địa phương | Ngày kết thúc hợp đồng của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `vi_tri_cong_viec` | Vị trí công việc | Văn bản | Vị trí công việc của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `luong_co_ban` | Lương cơ bản | Số tiền VND nguyên đồng | Lương cơ bản của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `phu_cap_co_dinh` | Phụ cấp cố định | Số tiền VND nguyên đồng | Phụ cấp cố định của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ghi_chu_thu_viec` | Ghi chú thử việc | Văn bản | Ghi chú thử việc của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `tinh_trang_lam_viec` | Tình trạng làm việc | Phân loại có danh sách đóng | Tình trạng làm việc của hồ sơ làm việc theo hiệu lực, phục vụ hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực; được ghi bởi nhân sự theo quyết định theo hồ sơ nguồn của bảng. Giá trị cho phép: chuan_bi_vao_lam; thu_viec; dang_su_dung; tam_ngung_lam; da_nghi_viec. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong hồ sơ làm việc theo hiệu lực. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_nhan_vien` | Mã nhân viên | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên xác định đúng vai trò hoặc nguồn trong hồ sơ làm việc theo hiệu lực. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_bo_phan` | Mã bộ phận | Mã UUID | Liên kết tới dung_chung.bo_phan; mã bộ phận xác định đúng vai trò hoặc nguồn trong hồ sơ làm việc theo hiệu lực. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.bo_phan |
| `ma_nhan_vien_quan_ly` | Mã nhân viên quản lý | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên quản lý xác định đúng vai trò hoặc nguồn trong hồ sơ làm việc theo hiệu lực. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_phien_ban_chinh_sach_thu_nhap` | Mã phiên bản chính sách thu nhập | Mã UUID | Liên kết tới dung_chung.phien_ban_chinh_sach; mã phiên bản chính sách thu nhập xác định đúng vai trò hoặc nguồn trong hồ sơ làm việc theo hiệu lực. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Không chồng khoảng chính một người; thay đổi tạo bản mới đúng mốc; một bộ phận chính, không tăng đầu người do kiêm nhiệm.

**Yêu cầu:** FR28, FR31.

### D078 Hồ sơ kỹ năng và an toàn

**Tên bảng:** `nhan_su.ho_so_ky_nang_va_an_toan`. **Phụ trách:** Nhân sự / quản lý xác nhận.

**Mục đích:** Kỹ năng, hướng dẫn an toàn và sự cố cơ sở.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của hồ sơ kỹ năng và an toàn, phục vụ kỹ năng, hướng dẫn an toàn và sự cố cơ sở; được ghi bởi nhân sự / quản lý xác nhận theo hồ sơ nguồn của bảng. Giá trị cho phép: ky_nang; huan_luyen_an_toan; su_co. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_nghiep_vu` | Mã nghiệp vụ | Văn bản | Mã nghiệp vụ của hồ sơ kỹ năng và an toàn, phục vụ kỹ năng, hướng dẫn an toàn và sự cố cơ sở; được ghi bởi nhân sự / quản lý xác nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_hieu_luc` | Thời điểm bắt đầu hiệu lực | Ngày địa phương | Thời điểm bắt đầu hiệu lực của hồ sơ kỹ năng và an toàn, phục vụ kỹ năng, hướng dẫn an toàn và sự cố cơ sở; được ghi bởi nhân sự / quản lý xác nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_hieu_luc` | Thời điểm kết thúc hiệu lực | Ngày địa phương | Thời điểm kết thúc hiệu lực của hồ sơ kỹ năng và an toàn, phục vụ kỹ năng, hướng dẫn an toàn và sự cố cơ sở; được ghi bởi nhân sự / quản lý xác nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: cho_xu_ly; du_dieu_kien; het_hieu_luc; da_chot. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ghi_chu_anh_huong_cong_viec` | Ghi chú ảnh hưởng công việc | Văn bản | Ghi chú ảnh hưởng công việc của hồ sơ kỹ năng và an toàn, phục vụ kỹ năng, hướng dẫn an toàn và sự cố cơ sở; được ghi bởi nhân sự / quản lý xác nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong hồ sơ kỹ năng và an toàn. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_nhan_vien` | Mã nhân viên | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên xác định đúng vai trò hoặc nguồn trong hồ sơ kỹ năng và an toàn. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Chỉ loại cần cho công đoạn; sự cố không cấp qualification, không tự phạt/khấu trừ; chứng cứ giả lập có nhãn.

**Yêu cầu:** FR12, FR28.

### D079 Bàn giao bảo hộ dụng cụ

**Tên bảng:** `nhan_su.ban_giao_bao_ho_dung_cu`. **Phụ trách:** Nhân sự / kho.

**Mục đích:** Cấp/trả đồ bảo hộ và dụng cụ.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của bàn giao bảo hộ dụng cụ, phục vụ cấp/trả đồ bảo hộ và dụng cụ; được ghi bởi nhân sự / kho theo hồ sơ nguồn của bảng. Giá trị cho phép: cap_phat; tra_hang; thay_the. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_thuc_hien_nghiep_vu` | Thời điểm thực hiện nghiệp vụ | Thời điểm có múi giờ | Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `can_cu_tiep_nhan` | Căn cứ tiếp nhận | Văn bản | Căn cứ tiếp nhận của bàn giao bảo hộ dụng cụ, phục vụ cấp/trả đồ bảo hộ và dụng cụ; được ghi bởi nhân sự / kho theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong bàn giao bảo hộ dụng cụ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_nhan_vien` | Mã nhân viên | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên xác định đúng vai trò hoặc nguồn trong bàn giao bảo hộ dụng cụ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_dong_van_dong_hang` | Mã dòng vận động hàng | Mã UUID | Liên kết tới kho.dong_van_dong_hang; mã dòng vận động hàng xác định đúng vai trò hoặc nguồn trong bàn giao bảo hộ dụng cụ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | kho.dong_van_dong_hang |
| `ma_ban_giao_dung_cu_goc` | Mã bàn giao dụng cụ gốc | Mã UUID | Liên kết tới nhan_su.ban_giao_bao_ho_dung_cu; mã bàn giao dụng cụ gốc xác định đúng vai trò hoặc nguồn trong bàn giao bảo hộ dụng cụ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.ban_giao_bao_ho_dung_cu |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Hàng có kho liên kết phiếu thực đúng một lần; bàn giao không xuất thêm. Không phải hệ tài sản/khấu hao.

**Yêu cầu:** FR16, FR28.

### D080 Ngày và ca làm việc

**Tên bảng:** `nhan_su.ngay_va_ca_lam_viec`. **Phụ trách:** Nhân sự.

**Mục đích:** Ngày làm và các khoảng ca có phiên bản.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ngay_lam_viec` | Ngày làm việc | Ngày địa phương | Ngày làm việc của ngày và ca làm việc, phục vụ ngày làm và các khoảng ca có phiên bản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai_ngay_theo_lich` | Loại ngày theo lịch | Phân loại có danh sách đóng | Loại ngày theo lịch của ngày và ca làm việc, phục vụ ngày làm và các khoảng ca có phiên bản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. Giá trị cho phép: lam_viec; nghi_tuan; ngay_le; ngoai_le. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_ca` | Mã ca | Văn bản | Mã ca của ngày và ca làm việc, phục vụ ngày làm và các khoảng ca có phiên bản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `cac_khoang_lam_viec_trong_ca` | Các khoảng làm việc trong ca | Nội dung có cấu trúc đóng | Các khoảng làm việc trong ca của ngày và ca làm việc, phục vụ ngày làm và các khoảng ca có phiên bản; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Liên kết tới dung_chung.phien_ban_chinh_sach; mã phiên bản chính sách xác định đúng vai trò hoặc nguồn trong ngày và ca làm việc. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Mỗi ngày/ca thuộc đúng bản lịch. Khoảng làm việc không chồng và loại giờ nghỉ; số phút theo lịch tính từ khoảng, không nhập thêm cột tổng. 26 ngày chỉ là giả định bộ kiểm cũ.

**Yêu cầu:** FR12, FR29, FR30, FR31.

### D081 Phân công dự kiến

**Tên bảng:** `nhan_su.phan_cong_du_kien`. **Phụ trách:** Quản lý / nhân sự kiểm.

**Mục đích:** Phân công dự kiến từng người.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `thoi_diem_bat_dau_khoang` | Thời điểm bắt đầu khoảng | Thời điểm có múi giờ | Thời điểm bắt đầu khoảng của phân công dự kiến, phục vụ phân công dự kiến từng người; được ghi bởi quản lý / hr kiểm theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_khoang` | Thời điểm kết thúc khoảng | Thời điểm có múi giờ | Thời điểm kết thúc khoảng của phân công dự kiến, phục vụ phân công dự kiến từng người; được ghi bởi quản lý / hr kiểm theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `muc_dich` | Mục đích | Phân loại có danh sách đóng | Mục đích của phân công dự kiến, phục vụ phân công dự kiến từng người; được ghi bởi quản lý / hr kiểm theo hồ sơ nguồn của bảng. Giá trị cho phép: lam_viec; chuan_bi_may; dao_tao; bao_tri; khac_co_ly_do. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: du_kien; da_huy. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong phân công dự kiến. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_nhan_vien` | Mã nhân viên | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên xác định đúng vai trò hoặc nguồn trong phân công dự kiến. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_ngay_va_ca_lam_viec` | Mã ngày và ca làm việc | Mã UUID | Liên kết tới nhan_su.ngay_va_ca_lam_viec; mã ngày và ca làm việc xác định đúng vai trò hoặc nguồn trong phân công dự kiến. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.ngay_va_ca_lam_viec |
| `ma_chung_tu_cong_doan` | Mã chứng từ công đoạn | Mã UUID | Liên kết tới san_xuat.cong_doan_san_xuat; mã chứng từ công đoạn xác định đúng vai trò hoặc nguồn trong phân công dự kiến. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.cong_doan_san_xuat |
| `ma_phan_cong_du_kien_bi_thay` | Mã phân công dự kiến bị thay | Mã UUID | Liên kết tới nhan_su.phan_cong_du_kien; mã phân công dự kiến bị thay xác định đúng vai trò hoặc nguồn trong phân công dự kiến. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.phan_cong_du_kien |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Operation có thể trống nếu không SX; không trùng người/nghỉ; đủ qualification và người dang_su_dung; dự kiến không làm công thực.

**Yêu cầu:** FR12, FR28, FR29, FR30.

### D082 Bản công người ngày ca

**Tên bảng:** `nhan_su.ban_cong_nguoi_ngay_ca`. **Phụ trách:** Tổ trưởng ghi / quản lý xác nhận / nhân sự chốt.

**Mục đích:** Một bản công người/ngày/ca.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `so_phien_ban_chung_tu` | Số phiên bản chứng từ | Số nguyên | Số phiên bản chứng từ của bản công người ngày ca, phục vụ một bản công người/ngày/ca; được ghi bởi tổ trưởng ghi / quản lý xác nhận / hr chốt theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: nhap; cho_xu_ly; da_xac_nhan; da_chot. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ma_nguon_nhap_du_lieu` | Mã nguồn nhập dữ liệu | Văn bản | Mã nguồn nhập dữ liệu của bản công người ngày ca, phục vụ một bản công người/ngày/ca; được ghi bởi tổ trưởng ghi / quản lý xác nhận / hr chốt theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ly_do` | Lý do | Văn bản | Lý do của bản công người ngày ca, phục vụ một bản công người/ngày/ca; được ghi bởi tổ trưởng ghi / quản lý xác nhận / hr chốt theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong bản công người ngày ca. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_nhan_vien` | Mã nhân viên | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên xác định đúng vai trò hoặc nguồn trong bản công người ngày ca. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_ngay_va_ca_lam_viec` | Mã ngày và ca làm việc | Mã UUID | Liên kết tới nhan_su.ngay_va_ca_lam_viec; mã ngày và ca làm việc xác định đúng vai trò hoặc nguồn trong bản công người ngày ca. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.ngay_va_ca_lam_viec |
| `ma_ban_cong_bi_thay` | Mã bản công bị thay | Mã UUID | Liên kết tới nhan_su.ban_cong_nguoi_ngay_ca; mã bản công bị thay xác định đúng vai trò hoặc nguồn trong bản công người ngày ca. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.ban_cong_nguoi_ngay_ca |
| `ma_nhan_vien_xac_nhan` | Mã nhân viên xác nhận | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên xác nhận xác định đúng vai trò hoặc nguồn trong bản công người ngày ca. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_ky` | Mã kỳ | Mã UUID | Liên kết tới dung_chung.ky_nghiep_vu; mã kỳ xác định đúng vai trò hoặc nguồn trong bản công người ngày ca. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.ky_nghiep_vu |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Duy nhất người/ngày/ca/bản; chỉ một bản hiện hành có hiệu lực. Thiếu nguồn giữ chờ xử lý; sửa sau chốt thêm bản điều chỉnh, không xóa công cũ.

**Yêu cầu:** FR05, FR29, FR30, FR31.

### D083 Khoảng công thực tế

**Tên bảng:** `nhan_su.khoang_cong_thuc_te`. **Phụ trách:** Tổ trưởng / quản lý xác nhận.

**Mục đích:** Khoảng thực làm/nghỉ/chờ và trực tiếp theo người.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `thoi_diem_bat_dau_khoang` | Thời điểm bắt đầu khoảng | Thời điểm có múi giờ | Thời điểm bắt đầu khoảng của khoảng công thực tế, phục vụ khoảng thực làm/nghỉ/chờ và trực tiếp theo người; được ghi bởi tổ trưởng / quản lý xác nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_khoang` | Thời điểm kết thúc khoảng | Thời điểm có múi giờ | Thời điểm kết thúc khoảng của khoảng công thực tế, phục vụ khoảng thực làm/nghỉ/chờ và trực tiếp theo người; được ghi bởi tổ trưởng / quản lý xác nhận theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của khoảng công thực tế, phục vụ khoảng thực làm/nghỉ/chờ và trực tiếp theo người; được ghi bởi tổ trưởng / quản lý xác nhận theo hồ sơ nguồn của bảng. Giá trị cho phép: truc_tiep; ho_tro; dang_cho; dao_tao; cong_tac; nghi_huong_luong; nghi_khong_luong; chua_xac_minh; lam_them. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `can_cu_huong_luong` | Căn cứ hưởng lương | Phân loại có danh sách đóng | Căn cứ hưởng lương của khoảng công thực tế, phục vụ khoảng thực làm/nghỉ/chờ và trực tiếp theo người; được ghi bởi tổ trưởng / quản lý xác nhận theo hồ sơ nguồn của bảng. Giá trị cho phép: huong_luong; khong_huong_luong; cho_chinh_sach. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: cho_xu_ly; da_xac_nhan. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_ban_cong` | Mã chứng từ bản công | Mã UUID | Liên kết tới nhan_su.ban_cong_nguoi_ngay_ca; mã chứng từ bản công xác định đúng vai trò hoặc nguồn trong khoảng công thực tế. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.ban_cong_nguoi_ngay_ca |
| `ma_chung_tu_cong_doan` | Mã chứng từ công đoạn | Mã UUID | Liên kết tới san_xuat.cong_doan_san_xuat; mã chứng từ công đoạn xác định đúng vai trò hoặc nguồn trong khoảng công thực tế. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | san_xuat.cong_doan_san_xuat |
| `ma_chung_tu_de_nghi_nghi` | Mã chứng từ đề nghị nghỉ | Mã UUID | Liên kết tới nhan_su.de_nghi_nghi; mã chứng từ đề nghị nghỉ xác định đúng vai trò hoặc nguồn trong khoảng công thực tế. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.de_nghi_nghi |
| `ma_quyet_dinh_duyet_lam_them` | Mã quyết định duyệt làm thêm | Mã UUID | Liên kết tới dung_chung.de_nghi_va_quyet_dinh_phe_duyet; mã quyết định duyệt làm thêm xác định đúng vai trò hoặc nguồn trong khoảng công thực tế. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Một khoảng một loại; trực tiếp bắt operation, nghỉ bắt nguồn phép nếu thuộc phép; không trùng người/khoảng/bản hiện hành, không trưa. Thời gian chờ sản phẩm khác chờ có mặt của người.

**Yêu cầu:** FR12, FR26, FR29, FR30, FR31.

### D084 Đề nghị nghỉ

**Tên bảng:** `nhan_su.de_nghi_nghi`. **Phụ trách:** Quản lý duyệt / nhân sự kiểm.

**Mục đích:** Đề nghị nghỉ và bàn giao.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai_nghi` | Loại nghỉ | Phân loại có danh sách đóng | Loại nghỉ của đề nghị nghỉ, phục vụ đề nghị nghỉ và bàn giao; được ghi bởi quản lý duyệt / hr kiểm theo hồ sơ nguồn của bảng. Giá trị cho phép: phep_nam_huong_luong; khong_huong_luong; nghi_om; khac_co_ly_do. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_bat_dau_khoang` | Thời điểm bắt đầu khoảng | Thời điểm có múi giờ | Thời điểm bắt đầu khoảng của đề nghị nghỉ, phục vụ đề nghị nghỉ và bàn giao; được ghi bởi quản lý duyệt / hr kiểm theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_ket_thuc_khoang` | Thời điểm kết thúc khoảng | Thời điểm có múi giờ | Thời điểm kết thúc khoảng của đề nghị nghỉ, phục vụ đề nghị nghỉ và bàn giao; được ghi bởi quản lý duyệt / hr kiểm theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: da_de_nghi; da_duyet; da_huy; da_dung. | Sự kiện hoặc quyết định được ghi nhận | — |
| `ly_do` | Lý do | Văn bản | Lý do của đề nghị nghỉ, phục vụ đề nghị nghỉ và bàn giao; được ghi bởi quản lý duyệt / hr kiểm theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong đề nghị nghỉ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_nhan_vien` | Mã nhân viên | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên xác định đúng vai trò hoặc nguồn trong đề nghị nghỉ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_nhan_vien_lam_thay` | Mã nhân viên làm thay | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên làm thay xác định đúng vai trò hoặc nguồn trong đề nghị nghỉ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Liên kết tới dung_chung.phien_ban_chinh_sach; mã phiên bản chính sách xác định đúng vai trò hoặc nguồn trong đề nghị nghỉ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Liên kết tới dung_chung.de_nghi_va_quyet_dinh_phe_duyet; mã phê duyệt xác định đúng vai trò hoặc nguồn trong đề nghị nghỉ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Người đề nghị ghi khoảng nghỉ và loại nghỉ. Phút trong lịch tính từ giao của khoảng nghỉ với ca, không giữ tổng sửa tay. Duyệt giữ phép; công thực đã xác nhận mới chuyển sang dùng phép. Hủy/chỉnh có sự kiện căn cứ.

**Yêu cầu:** FR12, FR30.

### D085 Sự kiện phép

**Tên bảng:** `nhan_su.su_kien_phep`. **Phụ trách:** Nhân sự.

**Mục đích:** Sổ phép đầu/phát sinh/giữ/dùng/điều chỉnh.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của sự kiện phép, phục vụ sổ phép đầu/phát sinh/giữ/dùng/điều chỉnh; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. Giá trị cho phép: dau_ky; phat_sinh_phep; giu_nguon; giai_phong; dung_phep; dieu_chinh_tang; dieu_chinh_giam. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_phut_phat_sinh` | Số phút phát sinh | Số nguyên | Số phút phát sinh của sự kiện phép, phục vụ sổ phép đầu/phát sinh/giữ/dùng/điều chỉnh; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_thuc_hien_nghiep_vu` | Thời điểm thực hiện nghiệp vụ | Thời điểm có múi giờ | Thời điểm sự việc thực xảy ra được người chịu trách nhiệm ghi nhận; không tự coi lúc duyệt là lúc thực hiện. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_nhan_vien` | Mã nhân viên | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên xác định đúng vai trò hoặc nguồn trong sự kiện phép. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_chung_tu_de_nghi_nghi` | Mã chứng từ đề nghị nghỉ | Mã UUID | Liên kết tới nhan_su.de_nghi_nghi; mã chứng từ đề nghị nghỉ xác định đúng vai trò hoặc nguồn trong sự kiện phép. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.de_nghi_nghi |
| `ma_su_kien_giu_goc` | Mã sự kiện giữ gốc | Mã UUID | Liên kết tới nhan_su.su_kien_phep; mã sự kiện giữ gốc xác định đúng vai trò hoặc nguồn trong sự kiện phép. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.su_kien_phep |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Liên kết tới dung_chung.de_nghi_va_quyet_dinh_phe_duyet; mã phê duyệt xác định đúng vai trò hoặc nguồn trong sự kiện phép. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `thoi_diem_he_thong_ghi_nhan` | Thời điểm hệ thống ghi nhận | Thời điểm có múi giờ | Thời điểm hệ thống ghi sự kiện, phục vụ lịch sử và đối chiếu thông tin đã biết tại mốc. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |

**Ràng buộc nghiệp vụ:** Minutes>0; dùng phép giảm phần giữ nguồn còn và quỹ phép cùng giao dịch nguyên tử, không trừ đôi; xem mốc từ sổ, không cập nhật số dư tay.

**Yêu cầu:** FR06, FR30.

### D086 Kỳ tính thu nhập

**Tên bảng:** `nhan_su.ky_tinh_thu_nhap`. **Phụ trách:** Nhân sự lập / tài chính kiểm.

**Mục đích:** Kỳ và phiên bản bảng thu nhập.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `so_phien_ban_chung_tu` | Số phiên bản chứng từ | Số nguyên | Số phiên bản chứng từ của kỳ tính thu nhập, phục vụ kỳ và phiên bản bảng thu nhập; được ghi bởi nhân sự lập / tài chính kiểm theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `gioi_han_mo_phong` | Giới hạn mô phỏng | Phân loại có danh sách đóng | Giới hạn mô phỏng của kỳ tính thu nhập, phục vụ kỳ và phiên bản bảng thu nhập; được ghi bởi nhân sự lập / tài chính kiểm theo hồ sơ nguồn của bảng. Giá trị cho phép: chua_mo_phong_khoan_bat_buoc. | Dữ liệu kỹ thuật | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_phien_ban_chung_tu` | Mã phiên bản chứng từ | Mã UUID | Liên kết tới dung_chung.chung_tu; mã phiên bản chứng từ xác định đúng vai trò hoặc nguồn trong kỳ tính thu nhập. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_ky` | Mã kỳ | Mã UUID | Liên kết tới dung_chung.ky_nghiep_vu; mã kỳ xác định đúng vai trò hoặc nguồn trong kỳ tính thu nhập. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.ky_nghiep_vu |
| `ma_chung_tu_chot_cong` | Mã chứng từ chốt công | Mã UUID | Liên kết tới dung_chung.chung_tu; mã chứng từ chốt công xác định đúng vai trò hoặc nguồn trong kỳ tính thu nhập. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.chung_tu |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Liên kết tới dung_chung.phien_ban_chinh_sach; mã phiên bản chính sách xác định đúng vai trò hoặc nguồn trong kỳ tính thu nhập. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `ma_ky_tinh_thu_nhap_bi_thay` | Mã kỳ tính thu nhập bị thay | Mã UUID | Liên kết tới nhan_su.ky_tinh_thu_nhap; mã kỳ tính thu nhập bị thay xác định đúng vai trò hoặc nguồn trong kỳ tính thu nhập. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.ky_tinh_thu_nhap |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Kỳ tính cố định kỳ công và bản chính sách. Duyệt thuộc từng dòng và quyết định; tình trạng duyệt toàn kỳ tính từ các nguồn đó, không có cột cho phép một thao tác hợp thức hóa mọi dòng. Chốt kỳ theo chứng từ và kỳ nghiệp vụ.

**Yêu cầu:** FR06, FR30, FR31.

### D087 Dòng thu nhập nhân viên

**Tên bảng:** `nhan_su.dong_thu_nhap_nhan_vien`. **Phụ trách:** Nhân sự / tài chính kiểm tra / người duyệt đủ quyền.

**Mục đích:** Thu nhập một người, duyệt từng dòng.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: tam_tinh; da_kiem_tra; cho_kiem_tra_doc_lap; da_duyet. | Sự kiện hoặc quyết định được ghi nhận | — |
| `pham_vi_mo_phong_khoan_bat_buoc` | Phạm vi mô phỏng khoản bắt buộc | Phân loại có danh sách đóng | Phạm vi mô phỏng khoản bắt buộc của dòng thu nhập nhân viên, phục vụ thu nhập một người, duyệt từng dòng; được ghi bởi nhân sự / tài chính kiểm tra / người duyệt đủ quyền theo hồ sơ nguồn của bảng. Giá trị cho phép: chua_mo_phong. | Dữ liệu kỹ thuật | — |
| `phep_tinh_ban_luu_tai_thoi_diem` | Phép tính bản lưu tại thời điểm | Nội dung có cấu trúc đóng | Phép tính bản lưu tại thời điểm của dòng thu nhập nhân viên, phục vụ thu nhập một người, duyệt từng dòng; được ghi bởi nhân sự / tài chính kiểm tra / người duyệt đủ quyền theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_ky_tinh_thu_nhap` | Mã chứng từ kỳ tính thu nhập | Mã UUID | Liên kết tới nhan_su.ky_tinh_thu_nhap; mã chứng từ kỳ tính thu nhập xác định đúng vai trò hoặc nguồn trong dòng thu nhập nhân viên. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.ky_tinh_thu_nhap |
| `ma_nhan_vien` | Mã nhân viên | Mã UUID | Liên kết tới nhan_su.nhan_vien; mã nhân viên xác định đúng vai trò hoặc nguồn trong dòng thu nhập nhân viên. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.nhan_vien |
| `ma_ho_so_lam_viec_theo_hieu_luc` | Mã hồ sơ làm việc theo hiệu lực | Mã UUID | Liên kết tới nhan_su.ho_so_lam_viec_theo_hieu_luc; mã hồ sơ làm việc theo hiệu lực xác định đúng vai trò hoặc nguồn trong dòng thu nhập nhân viên. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.ho_so_lam_viec_theo_hieu_luc |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Liên kết tới dung_chung.de_nghi_va_quyet_dinh_phe_duyet; mã phê duyệt xác định đúng vai trò hoặc nguồn trong dòng thu nhập nhân viên. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `ma_dong_thu_nhap_goc` | Mã dòng thu nhập gốc | Mã UUID | Liên kết tới nhan_su.dong_thu_nhap_nhan_vien; mã dòng thu nhập gốc xác định đúng vai trò hoặc nguồn trong dòng thu nhập nhân viên. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.dong_thu_nhap_nhan_vien |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Một dòng cho mỗi người và kỳ/bản. Thu nhập tính từ từng khoản có căn cứ; bản lưu phép tính nối nguồn công/chính sách đúng phiên bản. Dòng giám đốc cần người kiểm tra độc lập. Đã trả/ứng/còn trả tính từ tiền thực và phân bổ, không nhập số cuối; chưa mô phỏng khấu trừ bắt buộc.

**Yêu cầu:** FR06, FR24, FR26, FR30, FR31.

### D088 Khoản thu nhập có căn cứ

**Tên bảng:** `nhan_su.khoan_thu_nhap_co_can_cu`. **Phụ trách:** Nhân sự.

**Mục đích:** Từng khoản lương/phụ cấp/chênh có căn cứ.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `loai` | Loại | Phân loại có danh sách đóng | Loại của khoản thu nhập có căn cứ, phục vụ từng khoản lương/phụ cấp/chênh có căn cứ; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. Giá trị cho phép: luong_thoi_gian; phu_cap_co_dinh; thuong_da_duyet; lam_them; dieu_chinh. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `chieu_tang_giam` | Chiều tăng giảm | Phân loại có danh sách đóng | Chiều tăng giảm của khoản thu nhập có căn cứ, phục vụ từng khoản lương/phụ cấp/chênh có căn cứ; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. Giá trị cho phép: tang; giam. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `so_tien` | Số tiền | Số tiền VND nguyên đồng | Khoản tiền ghi trong chứng từ/sự kiện của bảng; phải có nguồn và người xác nhận. Nếu là kết quả tính đã ghi nhận phải có phiên bản và căn cứ, không nhập để ép số dư cuối. | Kết quả đã ghi nhận có căn cứ | — |
| `so_phut_duoc_lay_lam_can_cu` | Số phút được lấy làm căn cứ | Số nguyên | Số phút được lấy làm căn cứ của khoản thu nhập có căn cứ, phục vụ từng khoản lương/phụ cấp/chênh có căn cứ; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `don_gia_tinh_tai_lan_xac_nhan` | Đơn giá tính tại lần xác nhận | Số thập phân chính xác | Đơn giá tính tại lần xác nhận của khoản thu nhập có căn cứ, phục vụ từng khoản lương/phụ cấp/chênh có căn cứ; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Kết quả đã ghi nhận có căn cứ | — |
| `ly_do` | Lý do | Văn bản | Lý do của khoản thu nhập có căn cứ, phục vụ từng khoản lương/phụ cấp/chênh có căn cứ; được ghi bởi nhân sự theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_dong_thu_nhap_nhan_vien` | Mã dòng thu nhập nhân viên | Mã UUID | Liên kết tới nhan_su.dong_thu_nhap_nhan_vien; mã dòng thu nhập nhân viên xác định đúng vai trò hoặc nguồn trong khoản thu nhập có căn cứ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | nhan_su.dong_thu_nhap_nhan_vien |
| `ma_phien_ban_chinh_sach` | Mã phiên bản chính sách | Mã UUID | Liên kết tới dung_chung.phien_ban_chinh_sach; mã phiên bản chính sách xác định đúng vai trò hoặc nguồn trong khoản thu nhập có căn cứ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.phien_ban_chinh_sach |
| `ma_phe_duyet` | Mã phê duyệt | Mã UUID | Liên kết tới dung_chung.de_nghi_va_quyet_dinh_phe_duyet; mã phê duyệt xác định đúng vai trò hoặc nguồn trong khoản thu nhập có căn cứ. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | dung_chung.de_nghi_va_quyet_dinh_phe_duyet |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Chỉ khoản đã dùng/chính sách có nguồn; không tự tiền phạt/khấu trừ pháp lý. Tổng thành thu nhập income đúng dấu; ứng không là component giảm chi phí.

**Yêu cầu:** FR26, FR30, FR31.

### D089 Phiên đăng nhập

**Tên bảng:** `truy_cap.phien_dang_nhap`. **Phụ trách:** Hệ thống xác thực.

**Mục đích:** Phiên đăng nhập có hạn và thu hồi.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ban_bam_ma_phien_dang_nhap` | Bản băm mã phiên đăng nhập | Văn bản | Bản băm mã phiên đăng nhập của phiên đăng nhập, phục vụ phiên đăng nhập có hạn và thu hồi; được ghi bởi hệ thống xác thực theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `thoi_diem_cap_phien` | Thời điểm cấp phiên | Thời điểm có múi giờ | Thời điểm cấp phiên của phiên đăng nhập, phục vụ phiên đăng nhập có hạn và thu hồi; được ghi bởi hệ thống xác thực theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `thoi_diem_het_hieu_luc` | Thời điểm hết hiệu lực | Thời điểm có múi giờ | Thời điểm hết hiệu lực của phiên đăng nhập, phục vụ phiên đăng nhập có hạn và thu hồi; được ghi bởi hệ thống xác thực theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `thoi_diem_thu_hoi_quyen` | Thời điểm thu hồi quyền | Thời điểm có múi giờ | Thời điểm thu hồi quyền của phiên đăng nhập, phục vụ phiên đăng nhập có hạn và thu hồi; được ghi bởi hệ thống xác thực theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `so_phien_ban_quyen_khi_cap_phien` | Số phiên bản quyền khi cấp phiên | Số nguyên | Số phiên bản quyền khi cấp phiên của phiên đăng nhập, phục vụ phiên đăng nhập có hạn và thu hồi; được ghi bởi hệ thống xác thực theo hồ sơ nguồn của bảng. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan` | Mã tài khoản | Mã UUID | Liên kết tới truy_cap.tai_khoan_dang_nhap; mã tài khoản xác định đúng vai trò hoặc nguồn trong phiên đăng nhập. Mã phải tồn tại, đúng bản và phạm vi. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Chỉ lưu băm mã phiên; kiểm tài khoản dang_su_dung/so_phien_ban_quyen_xac_thuc và hết hạn mỗi lần; nghỉ việc hoặc đổi quyền thu hồi phiên liên quan. Không log mã phiên.

**Yêu cầu:** FR02, FR28.

### D090 Nguồn của bản chốt giá thành

**Tên bảng:** `tai_chinh.nguon_cua_ban_chot_gia_thanh`. **Phụ trách:** Tài chính.

**Mục đích:** Chốt đúng các phân bổ nguồn của một bản giá thành.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | dung_chung.dong_chung_tu |
| `ma_bo_du_lieu` | Mã bộ dữ liệu | Mã UUID | Bộ cơ sở hoặc nhánh mô phỏng chứa hồ sơ; không cộng nhánh thử vào báo cáo cơ sở. | Dữ liệu kỹ thuật | dung_chung.bo_du_lieu_mo_phong |
| `ma_chung_tu_ban_chot_gia_thanh` | Mã chứng từ bản chốt giá thành | Mã UUID | Liên kết tới tai_chinh.ban_chot_gia_thanh; mã chứng từ bản chốt giá thành xác định đúng vai trò hoặc nguồn trong nguồn của bản chốt giá thành. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.ban_chot_gia_thanh |
| `ma_dong_phan_bo_chi_phi` | Mã dòng phân bổ chi phí | Mã UUID | Liên kết tới tai_chinh.phan_bo_chi_phi; mã dòng phân bổ chi phí xác định đúng vai trò hoặc nguồn trong nguồn của bản chốt giá thành. Mã phải tồn tại, đúng bản và phạm vi. | Thông tin khai báo hoặc sự kiện nghiệp vụ | tai_chinh.phan_bo_chi_phi |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Mỗi dòng chỉ nối bản chốt với đúng bản phân bổ. Số tiền đọc từ phân bổ đó, không sao sang một cột tiền thứ hai. Bản sau có thể dùng nguồn chưa đổi, không phân bổ lại tiền.

**Yêu cầu:** FR06, FR13, FR26.

### D091 Định danh người

**Tên bảng:** `truy_cap.dinh_danh_nguoi`. **Phụ trách:** Quản trị định danh phối hợp nhân sự.

**Mục đích:** Người thật ổn định qua tài khoản và các bộ mô phỏng.

| Trường | Nhãn | Kiểu | Ý nghĩa và căn cứ | Phân loại | Liên kết |
| --- | --- | --- | --- | --- | --- |
| `ma_dinh_danh` | Mã định danh | Mã UUID | Mã ổn định của bản ghi; dòng nghiệp vụ dùng chính mã dòng chứng từ nếu có liên kết tương ứng. | Dữ liệu kỹ thuật | — |
| `ma_dinh_danh_nguoi` | Mã định danh người | Văn bản | Mã định danh người của định danh người, phục vụ người thật ổn định qua tài khoản và các bộ mô phỏng; được ghi bởi quản trị định danh phối hợp hr theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `ten_hien_thi` | Tên hiển thị | Văn bản | Tên hiển thị của định danh người, phục vụ người thật ổn định qua tài khoản và các bộ mô phỏng; được ghi bởi quản trị định danh phối hợp hr theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `trang_thai_xu_ly` | Trạng thái xử lý | Phân loại có danh sách đóng | Trạng thái của hồ sơ/sự kiện được ghi theo thao tác và lịch sử; không mặc định duyệt hoặc chốt. Giá trị cho phép: dang_su_dung; ngung_su_dung. | Sự kiện hoặc quyết định được ghi nhận | — |
| `gia_lap` | Giả lập | Có/không | Giả lập của định danh người, phục vụ người thật ổn định qua tài khoản và các bộ mô phỏng; được ghi bởi quản trị định danh phối hợp hr theo hồ sơ nguồn của bảng. | Thông tin khai báo hoặc sự kiện nghiệp vụ | — |
| `thoi_diem_tao` | Thời điểm tạo | Thời điểm có múi giờ | Thời điểm hệ thống tạo bản ghi từ thao tác; không thay ngày xảy ra nghiệp vụ hoặc ngày có hiệu lực. | Dữ liệu kỹ thuật | — |
| `ma_tai_khoan_thuc_hien` | Mã tài khoản thực hiện | Mã UUID | Tài khoản thực hiện thao tác được lấy từ ngữ cảnh đăng nhập tin cậy; không cho người dùng tự chọn người thực hiện. | Dữ liệu kỹ thuật | truy_cap.tai_khoan_dang_nhap |
| `so_phien_ban_ghi_dong_thoi` | Số phiên bản ghi đồng thời | Số nguyên | Số tăng khi sửa nháp để phát hiện hai người ghi trên cùng bản cũ; không thay số phiên bản chứng từ. | Dữ liệu kỹ thuật | — |

**Ràng buộc nghiệp vụ:** Định danh toàn hệ thống; duy nhất ma_dinh_danh_nguoi có kiểm căn cứ, không tự thêm người trùng để duyệt cho mình. Một person có nhiều tài khoản/hồ sơ mô phỏng nhưng vẫn cùng người.

**Yêu cầu:** FR02, FR03, FR28, FR33.
