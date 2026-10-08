# Bảng nào cần người dùng nhập liệu?

Giải thích thiết kế hiện hành B27/B28 theo câu hỏi ngày 08/10/2026; chưa có phần mềm hoặc màn hình nhập liệu vận hành. Không thay cơ sở dữ liệu hay chốt chính sách mới.

**Người dùng nhập qua công việc và màn hình, không mở 91 bảng để nhập.** Một thao tác có thể ghi nhiều bảng. Cần tách “hệ thống tạo dòng dữ liệu” với “hệ thống tự tạo dữ kiện/quyết định”: việc thứ nhất cần thiết, việc thứ hai không được phép khi thiếu nguồn hoặc thẩm quyền.

| Nhóm | Số bảng | Người dùng cần làm gì? |
| --- | --- | --- |
| Khai báo nền hoặc khi thay đổi | 26 | Cung cấp/chọn thông tin danh mục, hồ sơ, chính sách và quyền; không nhập lại mỗi ngày |
| Có đầu vào nghiệp vụ cần người cung cấp | 46 | Nhập/chọn dữ kiện, căn cứ hoặc quyết định theo giao dịch; nhiều trường còn lại được lấy từ nguồn/tính tự động |
| Dựng từ nguồn, người có quyền kiểm/chọn/xác nhận | 10 | Không nhập lại số tổng; vẫn có thao tác chọn phạm vi hoặc kiểm/xác nhận. Một số loại sự kiện cần nguồn khai báo riêng |
| Hệ thống tự ghi, không nhập tay bảng này | 9 | Dữ liệu kỹ thuật/liên kết hoặc sổ giá trị phát sinh từ nguồn và thao tác hợp lệ |

**“Bắt buộc” là bắt buộc khi có công việc tương ứng.** Không buộc công ty điền mọi bảng: chưa có khách trả thay không cần căn cứ trả thay; chưa có ủy quyền không cần tạo ủy quyền; chưa có đổi/trả không phải tạo hồ sơ đổi/trả. Chứng cứ bắt buộc theo nghiệp vụ, không buộc mọi phiếu đính kèm hình thức cho đủ dữ liệu.

Phân loại là theo cách hình thành chính, không nói mọi trường của một bảng đều nhập tay. Trong mọi bảng, mã định danh, người thao tác từ phiên, thời điểm hệ thống ghi, số phiên bản chống ghi đồng thời và bản băm do hệ thống quản lý. Người dùng không được nhập trực tiếp tồn cuối, nợ còn, tiến độ tổng hợp, tổng thu nhập hoặc tổng giá thành.

## Danh sách đủ 91 bảng

[CSV để lọc theo bảng/nhóm](input-responsibility.csv). Mã D001–D091 và tên khớp [từ điển](data-dictionary.md); không thêm/bớt bảng. Các dòng chi tiết được nhập ngay trong biểu mẫu chứng từ tương ứng, không thành màn hình nhập riêng.

### Khai báo nền hoặc khi thay đổi — 26 bảng

| Mã | Bảng | Người dùng hoặc hệ thống làm gì? |
| --- | --- | --- |
| D001 | Doanh nghiệp — `dung_chung.doanh_nghiep` | Khai báo tên doanh nghiệp, múi giờ, tiền tệ và chế độ mô phỏng; quản trị xác nhận. |
| D002 | Bộ phận — `dung_chung.bo_phan` | Khai báo bộ phận và quan hệ trong công ty; nhân sự cập nhật khi tổ chức thay đổi. |
| D003 | Vị trí giữ hàng — `dung_chung.vi_tri_giu_hang` | Khai báo các vị trí giữ hàng, thuộc kho/xưởng/đang giao; không nhập số tồn tại đây. |
| D004 | Đơn vị tính — `dung_chung.don_vi_tinh` | Khai báo đơn vị, đại lượng và độ chính xác; không tự đặt đơn vị thiếu khi ghi phiếu. |
| D013 | Phiên bản chính sách — `dung_chung.phien_ban_chinh_sach` | Người phụ trách khai báo tham số, đơn vị, căn cứ, hiệu lực; người có quyền duyệt. Không nạp chính sách mẫu như chính sách thật. |
| D015 | Tài khoản đăng nhập — `truy_cap.tai_khoan_dang_nhap` | Quản trị chọn đúng người, tên đăng nhập và điều kiện kích hoạt; hệ thống xử lý thông tin xác thực/bản băm. |
| D016 | Vai trò công việc — `truy_cap.vai_tro_cong_viec` | Quản trị định nghĩa vai trò công việc khi thiết lập; không tạo vai trò mới cho mỗi nhân viên. |
| D017 | Quyền thao tác — `truy_cap.quyen_thao_tac` | Quản trị cấu hình quyền/hành động/phạm vi theo thiết kế và quyết định; không cần nhân viên nhập mỗi lần sử dụng. |
| D018 | Cấp vai trò — `truy_cap.cap_vai_tro` | Quản trị cấp/thu hồi vai trò đúng người/phạm vi/hiệu lực theo quyết định; hệ thống ghi lịch sử. |
| D019 | Ủy quyền — `truy_cap.uy_quyen` | Người có thẩm quyền khai báo người nhận, phạm vi, hạn và giới hạn ủy quyền khi phát sinh; không bắt mọi người có ủy quyền. |
| D021 | Sản phẩm — `danh_muc.san_pham` | Khai báo nhóm mẫu ngói/Terrazzo, mã và tên khi mở danh mục hoặc thêm sản phẩm. |
| D022 | Mặt hàng — `danh_muc.mat_hang` | Khai báo vật tư hoặc biến thể màu/quy cách/đơn vị; không nhập tồn hoặc tự kết luận chất lượng ở danh mục. |
| D023 | Mã gọi khác — `danh_muc.ma_goi_khac` | Khai báo mã cũ/mã trên website và đích chuẩn đã kiểm; chỉ cần khi có mã gọi khác. |
| D024 | Quy đổi đơn vị — `danh_muc.quy_doi_don_vi` | Khai báo hệ số quy đổi theo đúng mặt hàng và căn cứ; hệ thống tính lượng cơ sở theo bản đã duyệt. |
| D025 | Đối tác — `dung_chung.doi_tac` | Khai báo đối tác và vai trò mua/bán/trả/nhận; thêm đối tác mới khi thực phát sinh. |
| D026 | Liên hệ đối tác — `dung_chung.lien_he_doi_tac` | Khai báo người liên hệ, kênh và địa chỉ theo đối tác; có thể dùng chung hồ sơ đã có. |
| D027 | Căn cứ đại diện — `dung_chung.can_cu_dai_dien` | Cung cấp căn cứ đại diện/trả thay, phạm vi và hiệu lực khi có đại diện; không tự tạo giấy ủy quyền. |
| D046 | Phiên bản định mức sản xuất — `san_xuat.phien_ban_dinh_muc_san_xuat` | Sản xuất khai báo định mức, hiệu lực, lượng chuẩn và tỷ lệ dự kiến; duyệt trước dùng, không sinh QC thực. |
| D047 | Dòng định mức vật tư — `san_xuat.dong_dinh_muc_vat_tu` | Khai báo vật tư, lượng định mức, đơn vị và công đoạn trong bản định mức; không nhập lại mỗi lần chạy lệnh. |
| D048 | Nguồn lực sản xuất — `san_xuat.nguon_luc_san_xuat` | Khai báo máy/vị trí/chỗ dưỡng hộ, năng lực và kỹ năng cần theo căn cứ. |
| D061 | Quỹ và tài khoản tiền — `tai_chinh.quy_va_tai_khoan_tien` | Tài chính khai báo quỹ/tài khoản, loại và tiền tệ; số dư từ biên bản đầu kỳ và sổ tiền, không nhập tại danh mục quỹ. |
| D076 | Nhân viên — `nhan_su.nhan_vien` | Nhân sự khai báo nhân viên và định danh đúng người; không cần mọi người có tài khoản. |
| D077 | Hồ sơ làm việc theo hiệu lực — `nhan_su.ho_so_lam_viec_theo_hieu_luc` | Nhân sự khai báo hợp đồng, bộ phận/quản lý, mức lương/phụ cấp, hiệu lực theo quyết định; thay đổi có bản mới. |
| D078 | Hồ sơ kỹ năng và an toàn — `nhan_su.ho_so_ky_nang_va_an_toan` | Nhân sự/quản lý ghi kỹ năng, an toàn/sự cố và căn cứ khi cần; không bắt đủ mọi loại hồ sơ cho tất cả 50 người. |
| D080 | Ngày và ca làm việc — `nhan_su.ngay_va_ca_lam_viec` | Nhân sự khai báo/duyệt ca, khoảng làm và ngày ngoại lệ; có thể tạo nhiều ngày từ lịch mẫu đã xác nhận, không tạo công thực. |
| D091 | Định danh người — `truy_cap.dinh_danh_nguoi` | Nhân sự/quản trị khai báo hoặc nối định danh người có căn cứ, tránh trùng người qua tài khoản/bộ. Mã UUID do hệ thống cấp không thay kiểm đúng người. |

### Có đầu vào nghiệp vụ cần người cung cấp — 46 bảng

| Mã | Bảng | Người dùng hoặc hệ thống làm gì? |
| --- | --- | --- |
| D008 | Đề nghị và quyết định phê duyệt — `dung_chung.de_nghi_va_quyet_dinh_phe_duyet` | Người có quyền gửi đề nghị, kiểm tra, duyệt/từ chối, ghi lý do và phạm vi. Hệ thống ghi mã người/mốc; không tự duyệt. |
| D009 | Bàn giao công việc — `dung_chung.ban_giao_cong_viec` | Người giao chọn việc/người nhận/hạn/phạm vi; người nhận xác nhận nhận hoặc phản hồi thiếu. Việc do quy trình tạo vẫn không được tự coi đã nhận. |
| D010 | Chứng cứ đính kèm — `dung_chung.chung_cu_dinh_kem` | Người dùng tải/chọn chứng cứ thật và mô tả; hệ thống ghi vị trí lưu, bản băm, loại tệp/dung lượng. |
| D028 | Nhu cầu khách hàng — `kinh_doanh.nhu_cau_khach_hang` | Kinh doanh ghi khách, nhu cầu và công trình/điều kiện còn thiếu; chưa đủ không tự thành đơn. |
| D029 | Lần tiếp nhận nhu cầu — `kinh_doanh.lan_tiep_nhan_nhu_cau` | Ghi kênh, nội dung và mốc từng lần tiếp nhận thực; không tự tạo lần liên hệ giả. |
| D030 | Thông số tư vấn — `kinh_doanh.thong_so_tu_van` | Nhập diện tích, quy cách/viên trên mét vuông, dự phòng có căn cứ; khách xác nhận số viên riêng. Số ước tính do hệ thống tính. |
| D031 | Báo giá và đơn hàng — `kinh_doanh.bao_gia_va_don_hang` | Kinh doanh chọn khách/bên trả/bên nhận, điều kiện cọc/thanh toán/giao và căn cứ khách đồng ý; giám đốc duyệt theo quyền. |
| D032 | Dòng báo giá và đơn hàng — `kinh_doanh.dong_bao_gia_va_don_hang` | Nhập/chọn mặt hàng, lượng, giá/chiết khấu đề nghị và quy cách thỏa thuận ngay trên đơn; tổng do hệ thống tính/đối chiếu. |
| D033 | Mẫu khách duyệt — `kinh_doanh.mau_khach_duyet` | Ghi mẫu khách xem, quyết định khách và chứng cứ đúng bản; duyệt nội bộ không thay khách. |
| D034 | Hồ sơ thay đổi và xử lý thương mại — `kinh_doanh.ho_so_thay_doi_va_xu_ly_thuong_mai` | Ghi yêu cầu đổi/hủy/trả/khiếu nại, phần ảnh hưởng và phương án có xác nhận; không tự mất cọc hoặc hoàn tiền. |
| D035 | Đơn mua hàng — `mua_hang.don_mua_hang` | Mua hàng chọn nhà cung cấp, nhu cầu, ngày giao và điều kiện mua; duyệt chưa tạo tồn/nợ/tiền. |
| D036 | Dòng đơn mua hàng — `mua_hang.dong_don_mua_hang` | Nhập/chọn vật tư, lượng, đơn vị và giá mua ngay trên đơn mua; quy đổi cơ sở tính từ bản hệ số. |
| D037 | Phân bổ hàng đang về — `mua_hang.phan_bo_hang_dang_ve` | Người phụ trách chọn nguồn đang về, nhu cầu, lượng dành và mốc; hệ thống kiểm giới hạn, không tự coi đã nhận. |
| D038 | Lô hàng — `kho.lo_hang` | Kho nhập/chọn mã lô nhà cung cấp, ngày/hạn và nguồn nhận khi có thông tin. Lô sản xuất có thể tự cấp mã từ lô sản xuất nguồn; không bắt nhập trùng. |
| D040 | Phiếu vận động hàng — `kho.phieu_van_dong_hang` | Kho/người có quyền ghi loại nghiệp vụ, nơi giữ, thời điểm thực, nguồn và xác nhận nhận/xuất/chuyển; một số phiếu được chuẩn bị từ yêu cầu đã có. |
| D041 | Dòng vận động hàng — `kho.dong_van_dong_hang` | Chọn lô/vị trí, nhập lượng thực và dòng nguồn ngay trong phiếu kho; lượng đề nghị có sẵn không thay lượng thực chưa xác nhận. |
| D042 | Yêu cầu hàng và vật tư — `kho.yeu_cau_hang_va_vat_tu` | Yêu cầu từ đơn/lệnh được hệ thống dựng và đối chiếu. Riêng nhu cầu tương lai cần người lập khai báo lượng/ngày/căn cứ và duyệt; không tạo nhu cầu phụ để ép số thiếu. |
| D044 | Biên bản kiểm kê — `kho.bien_ban_kiem_ke` | Người kiểm kê chọn phạm vi, mốc và cách ngừng/đối chiếu giao dịch; người có quyền kiểm/duyệt trước điều chỉnh. |
| D045 | Dòng kiểm kê — `kho.dong_kiem_ke` | Nhập lượng đếm thực và lý do theo lô/vị trí; lượng sổ tại mốc và chênh do hệ thống tính. |
| D049 | Lệnh sản xuất — `san_xuat.lenh_san_xuat` | Quản lý chọn nguồn đơn/làm sẵn/mẫu/làm lại, kế hoạch lượng/ngày và ưu tiên có lý do; lượng gợi ý phải được xác nhận trước tạo lệnh. |
| D050 | Lô sản xuất — `san_xuat.lo_san_xuat` | Chọn/tổ chức các lô kế hoạch, lượng dự kiến và nguồn định mức trong lệnh; hệ thống có thể đề xuất cách chia nhưng không tự bắt đầu sản xuất. |
| D051 | Công đoạn sản xuất — `san_xuat.cong_doan_san_xuat` | Tổ trưởng ghi mốc, lượng thực bắt đầu/hoàn thành và lý do chờ; quản lý xác nhận. Không sao lượng kế hoạch thành thực tế. |
| D052 | Lịch và sử dụng nguồn lực — `san_xuat.lich_va_su_dung_nguon_luc` | Quản lý chọn lịch/nguồn lực/phạm vi; người thực ghi hoặc xác nhận khoảng sử dụng và lượng chiếm chỗ thực. Lịch dự kiến không thay giờ máy thực. |
| D053 | Vật tư thực dùng — `san_xuat.vat_tu_thuc_dung` | Ghi/xác nhận lượng vật tư thực dùng/hao hụt và nguồn cấp trong thao tác thực dùng; hệ thống nối dòng vận động cùng lần, không nhập hay xuất lần hai. |
| D054 | Phiếu kiểm tra chất lượng — `chat_luong.phieu_kiem_tra_chat_luong` | QC ghi phạm vi/phương pháp, lượng thực kiểm và kết luận đạt/lỗi/chờ có căn cứ; không tính số đạt từ định mức. |
| D055 | Kết quả từng tiêu chí kiểm tra — `chat_luong.ket_qua_tung_tieu_chi_kiem_tra` | QC nhập số đo/quan sát và kết quả theo tiêu chí trong phiếu kiểm; mẫu kiểm chưa đủ luật không tự suy rộng. |
| D057 | Phương án xử lý chất lượng — `chat_luong.phuong_an_xu_ly_chat_luong` | QC đề nghị phương án, lượng/phạm vi và lý do; người có quyền duyệt xử lý. Hệ thống lấy lượng đã thực xử lý từ nguồn, không nhập tổng hoàn thành. |
| D058 | Đợt giao hàng — `giao_hang.dot_giao_hang` | Chọn đơn, bên nhận, địa chỉ, vận chuyển và đợt giao; rời/nhận thực cần căn cứ riêng. |
| D059 | Dòng giao hàng — `giao_hang.dong_giao_hang` | Chọn dòng đơn, mặt hàng và lượng dự kiến trong đợt giao; nguồn lô/xuất thực nối từ phiếu kho, không nhập phiếu xuất lần hai. |
| D060 | Xác nhận khách nhận hàng — `giao_hang.xac_nhan_khach_nhan_hang` | Giao hàng ghi lượng khách nhận/chấp nhận/từ chối/hư hỏng, người nhận và chứng cứ thực; hệ thống đối chiếu phần đã xuất. |
| D062 | Đề nghị chi tiền — `tai_chinh.de_nghi_chi_tien` | Kế toán/nhân sự ghi người hưởng, mục đích, số đề nghị và căn cứ; giám đốc duyệt theo quyền. |
| D063 | Biến động tiền thực — `tai_chinh.bien_dong_tien_thuc` | Người thu/chi ghi số tiền thực, bên thực trả/nhận, mốc, quỹ và chứng cứ; đề nghị chi hoặc sao kê không tự thành tiền đã thực thu/chi. |
| D065 | Điều chỉnh nghĩa vụ — `tai_chinh.dieu_chinh_nghia_vu` | Tài chính ghi điều chỉnh số tiền/hạn và lý do/chứng từ theo thẩm quyền; không sửa khoản gốc hoặc nhập số nợ cuối. |
| D066 | Sự kiện sử dụng nguồn tiền — `tai_chinh.su_kien_su_dung_nguon_tien` | Kế toán chọn nguồn tiền, khoản được thanh toán, lượng tiền dùng/đảo/giữ hoàn và căn cứ; hệ thống tính phần còn, không tạo thu/chi mới. |
| D067 | Chứng từ ghi nhận bán — `tai_chinh.chung_tu_ghi_nhan_ban` | Kế toán chọn phần khách đã chấp nhận/căn cứ tăng giảm và xác nhận ghi bán; nguồn có sẵn nhưng không tự bán chỉ từ phiếu xuất. |
| D068 | Dòng ghi nhận bán — `tai_chinh.dong_ghi_nhan_ban` | Chọn/xác nhận phần lượng, giá và nguồn chấp nhận ngay trong chứng từ bán; hệ thống đối chiếu không vượt gốc và tính tiền, không xuất lần hai. |
| D069 | Đối chiếu nghĩa vụ mua — `tai_chinh.doi_chieu_nghia_vu_mua` | Mua hàng/kế toán nhập/chọn chứng từ nhà cung cấp, giá trị/hạn và xác nhận phần mua được chấp nhận; không tự phải trả toàn đơn mua. |
| D070 | Dòng đối chiếu quỹ ngân hàng — `tai_chinh.dong_doi_chieu_quy_ngan_hang` | Nhập hoặc lấy từ tệp sao kê/biên bản quỹ số tiền, chiều, mốc và mã đối chiếu; người phụ trách xác nhận khớp. Sao kê không tự sinh giao dịch tiền. |
| D071 | Nguồn chi phí — `tai_chinh.nguon_chi_phi` | Vật tư/nhân công được dựng từ thực dùng/công/thu nhập đã xác nhận. Chi phí chung/bổ sung cần người nhập số tiền/căn cứ chứng từ riêng; không lấy tiền chi hoặc tổng muốn đạt thay nguồn chi phí. |
| D072 | Phân bổ chi phí — `tai_chinh.phan_bo_chi_phi` | Phân bổ theo chính sách và căn cứ đã có do hệ thống tính; tài chính chọn phạm vi/nguồn và kiểm xác nhận. Phân bổ đặc biệt cần số đề nghị/lý do/quyết định, không cho sửa tổng để ép giá thành. |
| D079 | Bàn giao bảo hộ dụng cụ — `nhan_su.ban_giao_bao_ho_dung_cu` | Ghi/xác nhận người nhận, dụng cụ, mốc và căn cứ bàn giao/trả; hàng kho nối phiếu thực một lần. |
| D081 | Phân công dự kiến — `nhan_su.phan_cong_du_kien` | Quản lý chọn người/ca/công đoạn và mốc dự kiến; hệ thống kiểm kỹ năng, nghỉ/trùng nhưng không tự biến phân công thành công thực. |
| D082 | Bản công người ngày ca — `nhan_su.ban_cong_nguoi_ngay_ca` | Tổ trưởng/nhân sự mở hoặc nhận danh sách người/ngày/ca, bổ sung nguồn và xác nhận công. Đầu bản có thể tự chuẩn bị, thiếu dữ kiện giữ chờ. |
| D083 | Khoảng công thực tế — `nhan_su.khoang_cong_thuc_te` | Ghi hoặc tiếp nhận nguồn rồi xác nhận khoảng thực làm/nghỉ/chờ, loại công và công đoạn. Phút tính từ mốc, không tự đủ công từ lịch. |
| D084 | Đề nghị nghỉ — `nhan_su.de_nghi_nghi` | Người đề nghị khai báo loại/khoảng nghỉ, lý do và bàn giao; người có quyền duyệt, nhân sự kiểm phép. |
| D088 | Khoản thu nhập có căn cứ — `nhan_su.khoan_thu_nhap_co_can_cu` | Lương thời gian/phụ cấp sinh từ nguồn đã xác nhận. Thưởng, làm thêm, chênh điều chỉnh cần người cung cấp đề nghị/căn cứ và duyệt; không nhập lại tổng lương hoặc tự khoản phạt. |

### Dựng từ nguồn, người có quyền kiểm/chọn/xác nhận — 10 bảng

| Mã | Bảng | Người dùng hoặc hệ thống làm gì? |
| --- | --- | --- |
| D012 | Kỳ nghiệp vụ — `dung_chung.ky_nghiep_vu` | Hệ thống lập kỳ theo phạm vi và mốc người có quyền chọn; chốt/mở lại cần quyết định. Không tự chốt vì đến cuối tháng. |
| D043 | Sự kiện giữ hàng — `kho.su_kien_giu_hang` | Người có quyền chọn nhu cầu, nguồn/lượng giữ hoặc giải phóng. Hệ thống ghi sự kiện sau xác nhận; dùng/mất hiệu lực từ xuất/khóa/kiểm kê hợp lệ, không nhập lại lịch sử. |
| D056 | Sự kiện khóa chất lượng — `chat_luong.su_kien_khoa_chat_luong` | QC/người có quyền chọn phần lô, lý do và xác nhận khóa/giải phóng đúng điều kiện. Hệ thống ghi sự kiện và ảnh hưởng giữ; không tự giải phóng chỉ vì đủ thời gian. |
| D064 | Nghĩa vụ thanh toán — `tai_chinh.nghia_vu_thanh_toan` | Hệ thống dựng khoản phải thu/trả/hoàn từ ghi bán, mua đã đối chiếu, thu nhập đủ duyệt hoặc phương án hoàn hợp lệ. Chủ thể/hạn/căn cứ được người có quyền xác nhận ở nguồn; không nhập lại số nợ. |
| D073 | Căn cứ phân bổ chi phí — `tai_chinh.can_cu_phan_bo_chi_phi` | Hệ thống nối từng nguồn phút công/phút máy/lượng vật tư phù hợp với phân bổ được xác nhận; người phụ trách kiểm căn cứ, không nhập lại giờ giả. |
| D074 | Bản chốt giá thành — `tai_chinh.ban_chot_gia_thanh` | Hệ thống tập hợp nguồn theo lô/bản; tài chính và sản xuất đối chiếu, người có quyền xác nhận chốt. Không nhập tổng giá thành; thiếu nguồn tạm tính. |
| D085 | Sự kiện phép — `nhan_su.su_kien_phep` | Hệ thống ghi giữ/dùng/giải phóng theo đề nghị và công đã xác nhận. Phép đầu/phát sinh/điều chỉnh cần khai báo/căn cứ/duyệt ở hồ sơ nguồn; không nhập số phép còn trực tiếp. |
| D086 | Kỳ tính thu nhập — `nhan_su.ky_tinh_thu_nhap` | Nhân sự chọn kỳ/bản công/chính sách, khởi tạo bảng; hệ thống lập kỳ tính, người có quyền kiểm/chốt. Không tự duyệt mọi dòng khi hết tháng. |
| D087 | Dòng thu nhập nhân viên — `nhan_su.dong_thu_nhap_nhan_vien` | Hệ thống tạo dòng từng người và phép tính từ nguồn công/chính sách/khoản; nhân sự kiểm, người đủ quyền duyệt riêng, giám đốc chờ kiểm độc lập. |
| D090 | Nguồn của bản chốt giá thành — `tai_chinh.nguon_cua_ban_chot_gia_thanh` | Hệ thống cố định liên kết đúng bản nguồn/phân bổ khi người có quyền chốt giá thành; không nhập lại số tiền phân bổ. |

### Hệ thống tự ghi, không nhập tay bảng này — 9 bảng

| Mã | Bảng | Người dùng hoặc hệ thống làm gì? |
| --- | --- | --- |
| D005 | Chứng từ — `dung_chung.chung_tu` | Hệ thống tạo đầu chứng từ/bản từ màn hình nghiệp vụ; người dùng không lập thêm đầu chứng từ chung lần nữa. |
| D006 | Dòng chứng từ — `dung_chung.dong_chung_tu` | Hệ thống cấp mã dòng khi người dùng thêm dòng ở đơn/phiếu; không nhập lần hai tại bảng chung. |
| D007 | Liên kết chứng từ — `dung_chung.lien_ket_chung_tu` | Hệ thống ghi quan hệ theo nguồn/bản gốc người dùng chọn hoặc thao tác đổi/đảo/thay; kiểm nguồn và phiên bản. |
| D011 | Nhật ký thao tác — `dung_chung.nhat_ky_thao_tac` | Hệ thống ghi người, mốc và thay đổi từ thao tác thực; không có màn hình nhập hoặc sửa nhật ký. |
| D014 | Bộ dữ liệu mô phỏng — `dung_chung.bo_du_lieu_mo_phong` | Hệ thống tạo bản mô phỏng/nhánh theo lệnh khởi tạo hoặc khôi phục được phép; không tự phát sinh dữ liệu nghiệp vụ thiếu. |
| D020 | Biên nhận xác nhận giao dịch — `truy_cap.bien_nhan_xac_nhan_giao_dich` | Hệ thống ghi biên nhận chống lặp cùng giao dịch đã thành công; không nhập tay kết quả thành công. |
| D039 | Phần lô hàng — `kho.phan_lo_hang` | Hệ thống tạo phần lô theo nguồn nhận/chia phần và kết luận QC được xác nhận; không nhập số tồn hoặc tự tạo kết luận đạt. |
| D075 | Biến động giá trị — `tai_chinh.bien_dong_gia_tri` | Hệ thống ghi chuyển/chênh giá trị theo vận động, nguồn chi phí, giá thành/ghi bán/điều chỉnh đủ căn cứ; người dùng không nhập lại giá trị sổ để ép kết quả. |
| D089 | Phiên đăng nhập — `truy_cap.phien_dang_nhap` | Hệ thống xác thực tạo/thu hồi phiên theo đăng nhập và quyền; không có nhập tay phiên đăng nhập. |

## Ví dụ một lần nhập, nhiều bảng được ghi

Kinh doanh mở đơn, chọn khách và nhập mặt hàng/số viên/điều kiện/giá đề nghị. Thông tin nghiệp vụ vào **Báo giá và đơn hàng / Dòng báo giá và đơn hàng**; hệ thống đồng thời tạo **Chứng từ / Dòng chứng từ**, ghi liên kết tới nguồn được chọn và **Nhật ký thao tác**. Người dùng không nhập thêm ba lần vào các bảng chung đó. Phê duyệt vẫn do người có quyền quyết định trên đúng bản.

Khi nhận hàng, kho nhập/chọn nguồn lô và lượng thực trong phiếu; phần lô và biến động được ghi theo nguồn xác nhận. Nếu chưa có kết luận QC, hệ thống giữ chờ; không tự đánh dấu đạt để nhận hàng xong nhanh. Khi QC kết luận, chuyển phần theo đúng kết quả kiểm, không tạo lượng mới.

Khi tính thu nhập, nhân sự chọn kỳ và các nguồn đã xác nhận. Hệ thống dựng dòng/khoản lương theo chính sách có hiệu lực; thưởng/chênh cần đề nghị có căn cứ. Nhân sự kiểm, người có quyền duyệt; đã trả/còn trả tính từ tiền thực, không nhập lại. Chính sách và công thiếu không tự bù để đủ số mẫu.

## Điểm cần giữ rõ khi thiết kế màn hình sau này

- Giữ/giải phóng hàng và khóa/giải phóng chất lượng có hành động của người có quyền và phạm vi cụ thể. Sự kiện chỉ là cách lưu quyết định/thao tác đó, không là một màn hình nhập lịch sử độc lập.
- Chi phí vật tư/công lấy từ nguồn; chi phí chung/bổ sung cần chứng từ và giá trị được người phụ trách cung cấp. Phân bổ và khoản thu nhập có cả phần tính tự động và phần phát sinh cần khai báo; không xếp toàn bộ thành tự động rồi mất căn cứ.
- Phiếu nhận/đơn mua/chấm công/sao kê có thể được chuẩn bị hoặc lấy từ tệp, nhưng người phụ trách vẫn phải đối chiếu và xác nhận sự thật nghiệp vụ. Không coi có dữ liệu nháp là đã nhận hàng/chi tiền/làm đủ công.
- Định danh người/tài khoản/quyền cần khai báo và kiểm ban đầu. Phiên và nhật ký mới là phần hệ thống tự ghi; không nhầm việc hệ thống cấp mã với việc tự quyết định ai có quyền.

Đây là trách nhiệm nhập/ghi theo thiết kế; chưa kiểm hành vi trên ERP thật. Không dùng bộ kiểm giả lập thiếu chứng từ của B28 để tự tạo các dữ kiện/xác nhận trong các bảng trên.
