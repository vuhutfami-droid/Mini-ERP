# Trách nhiệm nhập liệu — mô hình tinh gọn B29

74 bảng lưu trữ không phải 74 công việc nhập. Người dùng nhập và xác nhận qua công việc; hệ thống ghi các đầu/dòng/liên kết một lần trong cùng giao dịch. [Quy trình giảm thao tác](optimization-review.md), [từ điển](data-dictionary.md), [CSV đầy đủ](input-responsibility.csv). Mô hình chưa có phần mềm vận hành.

## Khai báo nền hoặc khi thay đổi: 25 bảng

| Mã | Bảng | Người phụ trách | Đầu vào và thao tác |
| --- | --- | --- | --- |
| T001 | Doanh nghiệp — `dung_chung.doanh_nghiep` | Dùng chung | Khai báo tên doanh nghiệp, múi giờ, tiền tệ và chế độ mô phỏng; quản trị xác nhận. |
| T002 | Bộ phận — `dung_chung.bo_phan` | Nhân sự | Khai báo bộ phận và quan hệ trong công ty; nhân sự cập nhật khi tổ chức thay đổi. |
| T003 | Vị trí giữ hàng — `dung_chung.vi_tri_giu_hang` | Kho / sản xuất / giao hàng | Khai báo các vị trí giữ hàng, thuộc kho/xưởng/đang giao; không nhập số tồn tại đây. |
| T004 | Đơn vị tính — `dung_chung.don_vi_tinh` | Dùng chung | Khai báo đơn vị, đại lượng và độ chính xác; không tự đặt đơn vị thiếu khi ghi phiếu. |
| T013 | Phiên bản chính sách — `dung_chung.phien_ban_chinh_sach` | Bộ phận phụ trách chính sách | Người phụ trách khai báo tham số, đơn vị, căn cứ, hiệu lực; người có quyền duyệt. Không nạp chính sách mẫu như chính sách thật. |
| T015 | Tài khoản đăng nhập — `truy_cap.tai_khoan_dang_nhap` | Quản trị truy cập theo quyết định | Quản trị chọn đúng người, tên đăng nhập và điều kiện kích hoạt; hệ thống xử lý thông tin xác thực/bản băm. |
| T016 | Vai trò công việc — `truy_cap.vai_tro_cong_viec` | Quản trị truy cập | Quản trị định nghĩa vai trò công việc khi thiết lập; không tạo vai trò mới cho mỗi nhân viên. |
| T017 | Quyền thao tác — `truy_cap.quyen_thao_tac` | Quản trị truy cập | Quản trị cấu hình quyền/hành động/phạm vi theo thiết kế và quyết định; không cần nhân viên nhập mỗi lần sử dụng. |
| T018 | Cấp vai trò — `truy_cap.cap_vai_tro` | Quản trị truy cập theo quyết định | Quản trị cấp/thu hồi vai trò đúng người/phạm vi/hiệu lực theo quyết định; hệ thống ghi lịch sử. |
| T019 | Ủy quyền — `truy_cap.uy_quyen` | Giám đốc / người có thẩm quyền | Người có thẩm quyền khai báo người nhận, phạm vi, hạn và giới hạn ủy quyền khi phát sinh; không bắt mọi người có ủy quyền. |
| T021 | Mặt hàng và nhóm mẫu — `danh_muc.mat_hang` | Kinh doanh / sản xuất; Kho cùng bộ phận sử dụng | Khai báo nhóm mẫu ngói/Terrazzo, mã và tên khi mở danh mục hoặc thêm sản phẩm. Khai báo vật tư hoặc biến thể màu/quy cách/đơn vị; không nhập tồn hoặc tự kết luận chất lượng ở danh mục. Nhóm mẫu không giao dịch lượng; biến thể màu/quy cách ngói và Terrazzo theo viên, vật tư theo đơn vị cơ sở riêng. |
| T022 | Mã gọi khác — `danh_muc.ma_goi_khac` | Kinh doanh / kho | Khai báo mã cũ/mã trên website và đích chuẩn đã kiểm; chỉ cần khi có mã gọi khác. |
| T023 | Quy đổi đơn vị — `danh_muc.quy_doi_don_vi` | Kho / mua hàng | Khai báo hệ số quy đổi theo đúng mặt hàng và căn cứ; hệ thống tính lượng cơ sở theo bản đã duyệt. |
| T024 | Đối tác — `dung_chung.doi_tac` | Kinh doanh / mua hàng | Khai báo đối tác và vai trò mua/bán/trả/nhận; thêm đối tác mới khi thực phát sinh. |
| T025 | Liên hệ đối tác — `dung_chung.lien_he_doi_tac` | Bộ phận phụ trách đối tác | Khai báo người liên hệ, kênh và địa chỉ theo đối tác; có thể dùng chung hồ sơ đã có. |
| T026 | Căn cứ đại diện — `dung_chung.can_cu_dai_dien` | Kinh doanh / tài chính | Cung cấp căn cứ đại diện/trả thay, phạm vi và hiệu lực khi có đại diện; không tự tạo giấy ủy quyền. |
| T040 | Phiên bản định mức sản xuất — `san_xuat.phien_ban_dinh_muc_san_xuat` | Sản xuất | Sản xuất khai báo định mức, hiệu lực, lượng chuẩn và tỷ lệ dự kiến; duyệt trước dùng, không sinh QC thực. |
| T041 | Dòng định mức vật tư — `san_xuat.dong_dinh_muc_vat_tu` | Sản xuất | Khai báo vật tư, lượng định mức, đơn vị và công đoạn trong bản định mức; không nhập lại mỗi lần chạy lệnh. |
| T042 | Nguồn lực sản xuất — `san_xuat.nguon_luc_san_xuat` | Sản xuất | Khai báo máy/vị trí/chỗ dưỡng hộ, năng lực và kỹ năng cần theo căn cứ. |
| T051 | Quỹ và tài khoản tiền — `tai_chinh.quy_va_tai_khoan_tien` | Tài chính | Tài chính khai báo quỹ/tài khoản, loại và tiền tệ; số dư từ biên bản đầu kỳ và sổ tiền, không nhập tại danh mục quỹ. |
| T063 | Nhân viên — `nhan_su.nhan_vien` | Nhân sự | Nhân sự khai báo nhân viên và định danh đúng người; không cần mọi người có tài khoản. |
| T064 | Hồ sơ làm việc theo hiệu lực — `nhan_su.ho_so_lam_viec_theo_hieu_luc` | Nhân sự theo quyết định | Nhân sự khai báo hợp đồng, bộ phận/quản lý, mức lương/phụ cấp, hiệu lực theo quyết định; thay đổi có bản mới. |
| T065 | Hồ sơ kỹ năng và an toàn — `nhan_su.ho_so_ky_nang_va_an_toan` | Nhân sự / quản lý xác nhận | Nhân sự/quản lý ghi kỹ năng, an toàn/sự cố và căn cứ khi cần; không bắt đủ mọi loại hồ sơ cho tất cả 50 người. |
| T066 | Ngày và ca làm việc — `nhan_su.ngay_va_ca_lam_viec` | Nhân sự | Nhân sự khai báo/duyệt ca, khoảng làm và ngày ngoại lệ; có thể tạo nhiều ngày từ lịch mẫu đã xác nhận, không tạo công thực. |
| T074 | Định danh người — `truy_cap.dinh_danh_nguoi` | Quản trị định danh phối hợp nhân sự | Nhân sự/quản trị khai báo hoặc nối định danh người có căn cứ, tránh trùng người qua tài khoản/bộ. Mã UUID do hệ thống cấp không thay kiểm đúng người. |

## Có dữ kiện nghiệp vụ cần nhập/xác nhận: 34 bảng

| Mã | Bảng | Người phụ trách | Đầu vào và thao tác |
| --- | --- | --- | --- |
| T005 | Chứng từ — `dung_chung.chung_tu` | Bộ phận giữ chứng từ; Kho / người xác nhận thực theo nguồn; Kho, người đếm/đối chiếu khác nhau; Kế toán; Tài chính cùng sản xuất đối chiếu; Tổ trưởng ghi / quản lý xác nhận / nhân sự chốt | Trong phiếu kho/kiểm kê/ghi bán/chốt giá thành/công, nhập hoặc xác nhận dữ kiện thực của đúng loại ngay tại biểu mẫu đó. Hệ thống tạo mã/bản/đầu chung một lần; không có bước mở Chứng từ để nhập lại. Hệ thống tạo đầu chứng từ/bản từ màn hình nghiệp vụ; người dùng không lập thêm đầu chứng từ chung lần nữa. Kho/người có quyền ghi loại nghiệp vụ, nơi giữ, thời điểm thực, nguồn và xác nhận nhận/xuất/chuyển; một số phiếu được chuẩn bị từ yêu cầu đã có. Người kiểm kê chọn phạm vi, mốc và cách ngừng/đối chiếu giao dịch; người có quyền kiểm/duyệt trước điều chỉnh. Kế toán chọn phần khách đã chấp nhận/căn cứ tăng giảm và xác nhận ghi bán; nguồn có sẵn nhưng không tự bán chỉ từ phiếu xuất. Hệ thống tập hợp nguồn theo lô/bản; tài chính và sản xuất đối chiếu, người có quyền xác nhận chốt. Không nhập tổng giá thành; thiếu nguồn tạm tính. Tổ trưởng/nhân sự mở hoặc nhận danh sách người/ngày/ca, bổ sung nguồn và xác nhận công. Đầu bản có thể tự chuẩn bị, thiếu dữ kiện giữ chờ. |
| T008 | Đề nghị và quyết định phê duyệt — `dung_chung.de_nghi_va_quyet_dinh_phe_duyet` | Theo bảng thẩm quyền B24 | Người có quyền gửi đề nghị, kiểm tra, duyệt/từ chối, ghi lý do và phạm vi. Hệ thống ghi mã người/mốc; không tự duyệt. |
| T009 | Trao đổi và bàn giao — `dung_chung.trao_doi_va_ban_giao` | Người giao và người nhận; Kinh doanh; Nhân sự / kho | Người giao chọn việc/người nhận/hạn/phạm vi; người nhận xác nhận nhận hoặc phản hồi thiếu. Việc do quy trình tạo vẫn không được tự coi đã nhận. Ghi kênh, nội dung và mốc từng lần tiếp nhận thực; không tự tạo lần liên hệ giả. Ghi/xác nhận người nhận, dụng cụ, mốc và căn cứ bàn giao/trả; hàng kho nối phiếu thực một lần. |
| T010 | Chứng cứ đính kèm — `dung_chung.chung_cu_dinh_kem` | Bộ phận của nguồn | Người dùng tải/chọn chứng cứ thật và mô tả; hệ thống ghi vị trí lưu, bản băm, loại tệp/dung lượng. |
| T027 | Nhu cầu khách hàng — `kinh_doanh.nhu_cau_khach_hang` | Kinh doanh | Kinh doanh ghi khách, nhu cầu và công trình/điều kiện còn thiếu; chưa đủ không tự thành đơn. |
| T028 | Báo giá và đơn hàng — `kinh_doanh.bao_gia_va_don_hang` | Kinh doanh | Kinh doanh chọn khách/bên trả/bên nhận, điều kiện cọc/thanh toán/giao và căn cứ khách đồng ý; giám đốc duyệt theo quyền. |
| T029 | Dòng tư vấn, báo giá và đơn hàng — `kinh_doanh.dong_tu_van_bao_gia_va_don_hang` | Kinh doanh / sản xuất kiểm; Kinh doanh | Nhập diện tích, quy cách/viên trên mét vuông, dự phòng có căn cứ; khách xác nhận số viên riêng. Số ước tính do hệ thống tính. Nhập/chọn mặt hàng, lượng, giá/chiết khấu đề nghị và quy cách thỏa thuận ngay trên đơn; tổng do hệ thống tính/đối chiếu. |
| T030 | Mẫu khách duyệt — `kinh_doanh.mau_khach_duyet` | Kinh doanh cùng sản xuất/kiểm chất lượng | Ghi mẫu khách xem, quyết định khách và chứng cứ đúng bản; duyệt nội bộ không thay khách. |
| T031 | Hồ sơ xử lý thương mại và chất lượng — `kinh_doanh.ho_so_xu_ly` | Kinh doanh giữ việc; Quản lý đề nghị / giám đốc duyệt / thực hiện | Ghi yêu cầu đổi/hủy/trả/khiếu nại, phần ảnh hưởng và phương án có xác nhận; không tự mất cọc hoặc hoàn tiền. QC đề nghị phương án, lượng/phạm vi và lý do; người có quyền duyệt xử lý. Hệ thống lấy lượng đã thực xử lý từ nguồn, không nhập tổng hoàn thành. |
| T032 | Đơn mua hàng — `mua_hang.don_mua_hang` | Mua hàng | Mua hàng chọn nhà cung cấp, nhu cầu, ngày giao và điều kiện mua; duyệt chưa tạo tồn/nợ/tiền. |
| T033 | Dòng đơn mua hàng — `mua_hang.dong_don_mua_hang` | Mua hàng | Nhập/chọn vật tư, lượng, đơn vị và giá mua ngay trên đơn mua; quy đổi cơ sở tính từ bản hệ số. |
| T034 | Lô hàng — `kho.lo_hang` | Kho / sản xuất nguồn tạo | Kho nhập/chọn mã lô nhà cung cấp, ngày/hạn và nguồn nhận khi có thông tin. Lô sản xuất có thể tự cấp mã từ lô sản xuất nguồn; không bắt nhập trùng. |
| T036 | Dòng vận động hàng — `kho.dong_van_dong_hang` | Kho / xác nhận sản xuất đúng phạm vi; Sản xuất xác nhận | Chọn lô/vị trí, nhập lượng thực và dòng nguồn ngay trong phiếu kho; lượng đề nghị có sẵn không thay lượng thực chưa xác nhận. Ghi/xác nhận lượng vật tư thực dùng/hao hụt và nguồn cấp trong thao tác thực dùng; hệ thống nối dòng vận động cùng lần, không nhập hay xuất lần hai. |
| T037 | Yêu cầu hàng và vật tư — `kho.yeu_cau_hang_va_vat_tu` | Kinh doanh / sản xuất lập; kho đối chiếu | Yêu cầu từ đơn/lệnh được hệ thống dựng và đối chiếu. Riêng nhu cầu tương lai cần người lập khai báo lượng/ngày/căn cứ và duyệt; không tạo nhu cầu phụ để ép số thiếu. |
| T039 | Dòng kiểm kê — `kho.dong_kiem_ke` | Kho | Nhập lượng đếm thực và lý do theo lô/vị trí; lượng sổ tại mốc và chênh do hệ thống tính. |
| T043 | Lệnh sản xuất — `san_xuat.lenh_san_xuat` | Quản lý sản xuất | Quản lý chọn nguồn đơn/làm sẵn/mẫu/làm lại, kế hoạch lượng/ngày và ưu tiên có lý do; lượng gợi ý phải được xác nhận trước tạo lệnh. |
| T044 | Lô sản xuất — `san_xuat.lo_san_xuat` | Sản xuất | Chọn/tổ chức các lô kế hoạch, lượng dự kiến và nguồn định mức trong lệnh; hệ thống có thể đề xuất cách chia nhưng không tự bắt đầu sản xuất. |
| T045 | Công đoạn sản xuất — `san_xuat.cong_doan_san_xuat` | Sản xuất | Tổ trưởng ghi mốc, lượng thực bắt đầu/hoàn thành và lý do chờ; quản lý xác nhận. Không sao lượng kế hoạch thành thực tế. |
| T046 | Lịch người và nguồn lực — `san_xuat.lich_nguoi_va_nguon_luc` | Quản lý sản xuất; Quản lý / nhân sự kiểm | Quản lý chọn lịch/nguồn lực/phạm vi; người thực ghi hoặc xác nhận khoảng sử dụng và lượng chiếm chỗ thực. Lịch dự kiến không thay giờ máy thực. Quản lý chọn người/ca/công đoạn và mốc dự kiến; hệ thống kiểm kỹ năng, nghỉ/trùng nhưng không tự biến phân công thành công thực. |
| T047 | Phiếu kiểm tra chất lượng — `chat_luong.phieu_kiem_tra_chat_luong` | Chất lượng | QC ghi phạm vi/phương pháp, lượng thực kiểm và kết luận đạt/lỗi/chờ có căn cứ; không tính số đạt từ định mức. |
| T048 | Kết quả từng tiêu chí kiểm tra — `chat_luong.ket_qua_tung_tieu_chi_kiem_tra` | Chất lượng | QC nhập số đo/quan sát và kết quả theo tiêu chí trong phiếu kiểm; mẫu kiểm chưa đủ luật không tự suy rộng. |
| T049 | Đợt giao hàng — `giao_hang.dot_giao_hang` | Giao hàng phối hợp kinh doanh | Chọn đơn, bên nhận, địa chỉ, vận chuyển và đợt giao; rời/nhận thực cần căn cứ riêng. |
| T050 | Dòng giao và nhận hàng — `giao_hang.dong_giao_va_nhan_hang` | Giao hàng / kho ghi thực xuất; Giao hàng | Chọn dòng đơn, mặt hàng và lượng dự kiến trong đợt giao; nguồn lô/xuất thực nối từ phiếu kho, không nhập phiếu xuất lần hai. Giao hàng ghi lượng khách nhận/chấp nhận/từ chối/hư hỏng, người nhận và chứng cứ thực; hệ thống đối chiếu phần đã xuất. |
| T052 | Đề nghị chi tiền — `tai_chinh.de_nghi_chi_tien` | Kế toán / nhân sự lập; giám đốc duyệt | Kế toán/nhân sự ghi người hưởng, mục đích, số đề nghị và căn cứ; giám đốc duyệt theo quyền. |
| T053 | Biến động tiền thực — `tai_chinh.bien_dong_tien_thuc` | Người thu/chi xác nhận | Người thu/chi ghi số tiền thực, bên thực trả/nhận, mốc, quỹ và chứng cứ; đề nghị chi hoặc sao kê không tự thành tiền đã thực thu/chi. |
| T055 | Sự kiện sử dụng nguồn tiền — `tai_chinh.su_kien_su_dung_nguon_tien` | Kế toán | Kế toán chọn nguồn tiền, khoản được thanh toán, lượng tiền dùng/đảo/giữ hoàn và căn cứ; hệ thống tính phần còn, không tạo thu/chi mới. |
| T056 | Dòng ghi nhận bán — `tai_chinh.dong_ghi_nhan_ban` | Kế toán | Chọn/xác nhận phần lượng, giá và nguồn chấp nhận ngay trong chứng từ bán; hệ thống đối chiếu không vượt gốc và tính tiền, không xuất lần hai. |
| T057 | Đối chiếu nghĩa vụ mua — `tai_chinh.doi_chieu_nghia_vu_mua` | Mua hàng / kế toán đối chiếu | Mua hàng/kế toán nhập/chọn chứng từ nhà cung cấp, giá trị/hạn và xác nhận phần mua được chấp nhận; không tự phải trả toàn đơn mua. |
| T058 | Dòng đối chiếu quỹ ngân hàng — `tai_chinh.dong_doi_chieu_quy_ngan_hang` | Tài chính | Nhập hoặc lấy từ tệp sao kê/biên bản quỹ số tiền, chiều, mốc và mã đối chiếu; người phụ trách xác nhận khớp. Sao kê không tự sinh giao dịch tiền. |
| T059 | Nguồn chi phí — `tai_chinh.nguon_chi_phi` | Tài chính; nhân sự cung cấp phần lương | Vật tư/nhân công được dựng từ thực dùng/công/thu nhập đã xác nhận. Chi phí chung/bổ sung cần người nhập số tiền/căn cứ chứng từ riêng; không lấy tiền chi hoặc tổng muốn đạt thay nguồn chi phí. |
| T060 | Phân bổ chi phí — `tai_chinh.phan_bo_chi_phi` | Tài chính | Phân bổ theo chính sách và căn cứ đã có do hệ thống tính; tài chính chọn phạm vi/nguồn và kiểm xác nhận. Phân bổ đặc biệt cần số đề nghị/lý do/quyết định, không cho sửa tổng để ép giá thành. |
| T067 | Khoảng công thực tế — `nhan_su.khoang_cong_thuc_te` | Tổ trưởng / quản lý xác nhận | Ghi hoặc tiếp nhận nguồn rồi xác nhận khoảng thực làm/nghỉ/chờ, loại công và công đoạn. Phút tính từ mốc, không tự đủ công từ lịch. |
| T068 | Đề nghị nghỉ — `nhan_su.de_nghi_nghi` | Quản lý duyệt / nhân sự kiểm | Người đề nghị khai báo loại/khoảng nghỉ, lý do và bàn giao; người có quyền duyệt, nhân sự kiểm phép. |
| T071 | Khoản thu nhập có căn cứ — `nhan_su.khoan_thu_nhap_co_can_cu` | Nhân sự | Lương thời gian/phụ cấp sinh từ nguồn đã xác nhận. Thưởng, làm thêm, chênh điều chỉnh cần người cung cấp đề nghị/căn cứ và duyệt; không nhập lại tổng lương hoặc tự khoản phạt. |

## Dựng từ nguồn cần kiểm/xác nhận: 7 bảng

| Mã | Bảng | Người phụ trách | Đầu vào và thao tác |
| --- | --- | --- | --- |
| T012 | Kỳ nghiệp vụ — `dung_chung.ky_nghiep_vu` | Nhân sự / tài chính / kho theo loại kỳ; Nhân sự lập / tài chính kiểm | Hệ thống lập kỳ theo phạm vi và mốc người có quyền chọn; chốt/mở lại cần quyết định. Không tự chốt vì đến cuối tháng. Nhân sự chọn kỳ/bản công/chính sách, khởi tạo bảng; hệ thống lập kỳ tính, người có quyền kiểm/chốt. Không tự duyệt mọi dòng khi hết tháng. |
| T038 | Sự kiện giữ, khóa và hàng đang về — `kho.su_kien_giu_khoa_va_dang_ve` | Mua hàng / kho; Kho; Chất lượng | Người phụ trách chọn nguồn đang về, nhu cầu, lượng dành và mốc; hệ thống kiểm giới hạn, không tự coi đã nhận. Người có quyền chọn nhu cầu, nguồn/lượng giữ hoặc giải phóng. Hệ thống ghi sự kiện sau xác nhận; dùng/mất hiệu lực từ xuất/khóa/kiểm kê hợp lệ, không nhập lại lịch sử. QC/người có quyền chọn phần lô, lý do và xác nhận khóa/giải phóng đúng điều kiện. Hệ thống ghi sự kiện và ảnh hưởng giữ; không tự giải phóng chỉ vì đủ thời gian. |
| T054 | Nghĩa vụ và điều chỉnh — `tai_chinh.nghia_vu_va_dieu_chinh` | Tài chính | Hệ thống dựng khoản phải thu/trả/hoàn từ ghi bán, mua đã đối chiếu, thu nhập đủ duyệt hoặc phương án hoàn hợp lệ. Chủ thể/hạn/căn cứ được người có quyền xác nhận ở nguồn; không nhập lại số nợ. Tài chính ghi điều chỉnh số tiền/hạn và lý do/chứng từ theo thẩm quyền; không sửa khoản gốc hoặc nhập số nợ cuối. Điều chỉnh tiền/đổi hạn cần người có quyền nhập căn cứ và xác nhận riêng; hệ thống không tự đổi số nợ để khớp báo cáo. |
| T061 | Căn cứ phân bổ chi phí — `tai_chinh.can_cu_phan_bo_chi_phi` | Tài chính; sản xuất/nhân sự xác nhận nguồn giờ | Hệ thống nối từng nguồn phút công/phút máy/lượng vật tư phù hợp với phân bổ được xác nhận; người phụ trách kiểm căn cứ, không nhập lại giờ giả. |
| T069 | Sự kiện phép — `nhan_su.su_kien_phep` | Nhân sự | Hệ thống ghi giữ/dùng/giải phóng theo đề nghị và công đã xác nhận. Phép đầu/phát sinh/điều chỉnh cần khai báo/căn cứ/duyệt ở hồ sơ nguồn; không nhập số phép còn trực tiếp. |
| T070 | Thu nhập nhân viên — `nhan_su.thu_nhap_nhan_vien` | Nhân sự / tài chính kiểm tra / người duyệt đủ quyền | Hệ thống tạo dòng từng người và phép tính từ nguồn công/chính sách/khoản; nhân sự kiểm, người đủ quyền duyệt riêng, giám đốc chờ kiểm độc lập. |
| T073 | Nguồn của bản chốt giá thành — `tai_chinh.nguon_cua_ban_chot_gia_thanh` | Tài chính | Hệ thống cố định liên kết đúng bản nguồn/phân bổ khi người có quyền chốt giá thành; không nhập lại số tiền phân bổ. |

## Tự ghi từ nguồn hoặc thao tác: 8 bảng

| Mã | Bảng | Người phụ trách | Đầu vào và thao tác |
| --- | --- | --- | --- |
| T006 | Dòng chứng từ — `dung_chung.dong_chung_tu` | Bộ phận giữ chứng từ | Hệ thống cấp mã dòng khi người dùng thêm dòng ở đơn/phiếu; không nhập lần hai tại bảng chung. |
| T007 | Liên kết chứng từ — `dung_chung.lien_ket_chung_tu` | Bộ phận giữ chứng từ | Hệ thống ghi quan hệ theo nguồn/bản gốc người dùng chọn hoặc thao tác đổi/đảo/thay; kiểm nguồn và phiên bản. |
| T011 | Nhật ký thao tác — `dung_chung.nhat_ky_thao_tac` | Hệ thống, giới hạn theo nguồn | Hệ thống ghi người, mốc và thay đổi từ thao tác thực; không có màn hình nhập hoặc sửa nhật ký. |
| T014 | Bộ dữ liệu mô phỏng — `dung_chung.bo_du_lieu_mo_phong` | Quản trị bộ mô phỏng | Hệ thống tạo bản mô phỏng/nhánh theo lệnh khởi tạo hoặc khôi phục được phép; không tự phát sinh dữ liệu nghiệp vụ thiếu. |
| T020 | Biên nhận xác nhận giao dịch — `truy_cap.bien_nhan_xac_nhan_giao_dich` | Hệ thống | Hệ thống ghi biên nhận chống lặp cùng giao dịch đã thành công; không nhập tay kết quả thành công. |
| T035 | Phần lô hàng — `kho.phan_lo_hang` | Kho, kiểm chất lượng giữ chất lượng | Hệ thống tạo phần lô theo nguồn nhận/chia phần và kết luận QC được xác nhận; không nhập số tồn hoặc tự tạo kết luận đạt. |
| T062 | Biến động giá trị — `tai_chinh.bien_dong_gia_tri` | Tài chính | Hệ thống ghi chuyển/chênh giá trị theo vận động, nguồn chi phí, giá thành/ghi bán/điều chỉnh đủ căn cứ; người dùng không nhập lại giá trị sổ để ép kết quả. |
| T072 | Phiên đăng nhập — `truy_cap.phien_dang_nhap` | Hệ thống xác thực | Hệ thống xác thực tạo/thu hồi phiên theo đăng nhập và quyền; không có nhập tay phiên đăng nhập. |

## Bắt buộc ở đâu?

Bắt buộc khi xác nhận một công việc đang thực hiện, không bắt toàn công ty nhập đầy đủ mọi bảng mỗi ngày. Nháp được thiếu, nhưng thiếu nguồn/lượng/mốc/quyền thuộc loại đó thì chưa ghi sổ. Dữ liệu không áp dụng phải trống, không nhập 0 hoặc chọn “đã duyệt” cho đủ.

Nhập lượng khách yêu cầu tại đơn; kho nhập lượng thực nhận/xuất; QC nhập kết quả thực; nhân sự nhập hoặc nhập khẩu công có nguồn; tài chính nhập tiền thực. Đơn/định mức/lịch không tự sinh thực tế. Giữ hàng, nợ, giá trị và kết quả thu nhập được dựng lại từ nguồn; các thao tác xác nhận/điều chỉnh còn trách nhiệm độc lập.

Khác B28: đầu phiếu kho/kiểm kê/bán/công/chốt giá thành thuộc Chứng từ nên bảng chung này có cả dữ kiện nghiệp vụ, không còn được xếp toàn bộ là tự ghi. Những thông tin kỹ thuật trong nó vẫn tự ghi. Bảng 91 dòng cũ là lịch sử trước B29, không còn danh sách hiện hành.
