# Rà soát và tối ưu cơ sở dữ liệu Nasaki — B29

Yêu cầu: đủ việc cho một công ty, một xưởng, một kho, 50 nhân sự; ít người vận hành, giảm nhập lại và độ phức tạp. Đây là phương án kỹ thuật sau rà soát toàn bộ thiết kế, chưa lập trình hoặc tạo DB. Không thay mô tả giả lập thành thực tế Nasaki.

## Kết quả thay đổi

| Nội dung | B28 | B29 | Ý nghĩa |
| --- | ---: | ---: | --- |
| Bảng | 91 | 74 | Gộp 17 bảng vào nơi sở hữu phù hợp |
| Trường trực tiếp | 1.139 | 931 | Giảm ròng 208 trường; bỏ thông tin trùng và giữ phân loại cần thiết, không xóa dữ kiện thực |
| Quan hệ trực tiếp | 487 | 402 | Ít đầu và liên kết trung gian; vẫn kiểm loại đích |
| Yêu cầu/màn hình/tiêu chí | 33/22/56 | 33/22/56 | Giữ phạm vi đã thống nhất, không dùng số bảng làm số màn hình |

74 là kết quả của lần rà soát này, không là con số tối ưu tuyệt đối. Cố ép còn 20–30 bằng cách nhét đơn/kho/tiền/công vào một bảng hoặc JSON sẽ khiến ràng buộc, quyền và truy nguồn khó hơn. Các bảng chi tiết không tạo công việc nhập riêng. Chưa có đo thời gian thao tác hoặc hiệu năng trên phần mềm để định lượng lợi ích.

## Các phần đã gộp

| Phần trước đây tách | Cách lưu hiện hành | Điều phải giữ |
| --- | --- | --- |
| Sản phẩm và mặt hàng | Nhóm mẫu và biến thể cùng danh mục | Nhóm không có giao dịch lượng; mã gọi khác chỉ một đích |
| Lịch sử tiếp nhận và bàn giao dụng cụ | Cùng trao đổi/bàn giao, có loại | Giao việc, khách trao đổi, dụng cụ có điều kiện khác nhau; không xuất kho lần hai |
| Tư vấn số viên và dòng thương mại | Cùng dòng theo giai đoạn | Tư vấn chưa chốt không thành đơn; báo giá/đơn tạo bản mới nối gốc |
| Phân bổ hàng đang về, giữ tồn, khóa QC | Cùng sổ sự kiện hàng theo loại | Đang về không là tồn; người kho không được bỏ khóa QC |
| Đầu phiếu kho, kiểm kê, ghi bán, công người-ngày, chốt giá thành | Dùng đầu Chứng từ chung | Một loại/bản; trường riêng theo loại; mã/người lập/bản chỉ lưu một lần |
| Vật tư thực dùng | Dòng vận động kho có nguồn công đoạn/cấp | Cấp chưa là tiêu dùng; thực dùng/hao hụt/hoàn kiểm riêng |
| Hồ sơ xử lý QC và thương mại | Cùng bảng hồ sơ, hai loại riêng | Khi cần cả hai vẫn có hai hồ sơ/quyết định liên kết, quyền QC không đọc tiền |
| Dòng giao và khách thực nhận | Cùng bảng với dòng kế hoạch và con nhận thực | Nhận nhiều lần, phần từ chối, ghi bán đúng phần; không xuất lại |
| Nghĩa vụ và điều chỉnh | Cùng sổ gốc/điều chỉnh | Không nhân gốc nợ; đổi hạn không là tiền; sử dụng tiền chỉ vào gốc |
| Lịch người và lịch nguồn lực | Cùng lịch theo đối tượng | Công người thực vẫn riêng; giờ máy không thành giờ công |
| Kỳ thu nhập | Kỳ nghiệp vụ loại thu nhập, bản/căn cứ riêng | Kỳ kho/công/lương độc lập; không tự chốt theo lịch |

Giữ riêng kết quả từng tiêu chí QC, từng khoản thu nhập và quyền thao tác: có nhiều dòng/nguồn cần đối chiếu và khóa ngoại. Chúng nằm ngay trong biểu mẫu cha, không ép dùng JSON để báo giảm thêm bảng. Giữ tiền thực, nghĩa vụ, sử dụng tiền, chi phí và giá trị riêng vì là sự kiện khác nhau. Giữ công thực, đề nghị nghỉ và phép riêng để không biến đề nghị thành ngày nghỉ thực. Không bỏ định danh/quyền/nhật ký để giảm số lượng.

## Cách vận hành ít người

Đề xuất sáu đầu mối công việc, có thể kiêm nhiệm theo năng lực thực: giám đốc; kinh doanh kiêm mua hàng; kho; quản lý sản xuất; người QC; tài chính kiêm nhân sự. Đây là đề xuất tổ chức demo, không xác nhận Nasaki có đúng sáu người vận hành và không bắt sáu tài khoản. Một người có thể nhiều vai, nhưng tự duyệt quyền lợi của mình/điều chỉnh kho/tiêu hủy vẫn bị chặn theo B24; dòng thu nhập giám đốc cần người kiểm độc lập được giao quyền. 50 nhân viên không phải 50 người phải đăng nhập.

| Công việc | Người cung cấp dữ kiện mới | Dữ kiện lấy lại từ nguồn | Chỉ xác nhận khi cần |
| --- | --- | --- | --- |
| Tiếp nhận, tư vấn, báo giá/đơn | Kinh doanh: yêu cầu, thỏa thuận và phản hồi khách | Đối tác, mẫu, chính sách, dòng tư vấn | Giám đốc duyệt phần thương mại theo B24 |
| Mua nguyên liệu | Mua hàng: nhà cung cấp, giá, hạn giao | Yêu cầu vật tư đã xác nhận | Duyệt mua theo B24; kho nhận thực độc lập |
| Nhận/xuất/chuyển kho | Kho: lượng/mốc thực, nguồn/vị trí | Dòng mua/đơn/cấp, quy cách và mã lô | Thông thường kho xác nhận; điều chỉnh/tiêu hủy theo quyền |
| Lập và thực hiện sản xuất | Quản lý xưởng: lịch, lượng thực, thực dùng/hao hụt | Đơn, định mức, phần lô cấp, lịch nguồn lực | Xác nhận công đoạn; vật tư không nhập lại vào sổ chi phí |
| Kiểm tra chất lượng | QC: số đo, quan sát, lượng/kết luận | Nguồn nhận/công đoạn, bộ tiêu chí | Xác nhận kiểm và khóa; xử lý cần duyệt theo B24 |
| Giao từng đợt và nhận hàng | Kho/giao: xuất thực; kinh doanh: chứng cứ nhận | Đơn, nguồn kho và chuyến đã có | Phần khách chấp nhận là căn cứ bán, chưa nhận giữ chờ |
| Thu/chi và đối chiếu | Tài chính: tiền/mốc/chứng cứ thực | Khách/đơn/đề nghị/nghĩa vụ | Không nhập lại nợ; đối chiếu và duyệt theo B24 |
| Công/nghỉ của 50 người | Đầu mối HR/xưởng: nguồn công, ngoại lệ/nghỉ | Hồ sơ và lịch có hiệu lực | Nhập khẩu theo lô có kiểm nguồn; không mặc định đủ công |
| Thu nhập tháng | HR/tài chính: khoản đặc biệt có căn cứ | Công/chính sách đã chốt | Kiểm cả bảng theo ngoại lệ nhưng giữ trách nhiệm từng dòng |
| Giá thành và báo cáo | Người phụ trách: lựa chọn chính sách/căn cứ cần thiết | Thực dùng/công/máy/chi phí hợp lệ | Thiếu nguồn hiển thị tạm tính; không nhập tổng để ép kết quả |

Không thêm bước xin giám đốc cho mỗi nhận/xuất/thu tiền thông thường. Không bắt tạo ủy quyền, mẫu riêng, trả hàng, kiểm kê hoặc sự cố khi chưa phát sinh. Bàn giao rõ người/phạm vi, có thể xử lý theo nhóm công việc nhưng không tự nhận thay. Gợi ý không là quyết định: không tự mua, giữ, duyệt, kết luận đạt hoặc trả lương.

## Quy tắc kỹ thuật khi gộp

Mọi dòng có phân loại đóng, đủ nguồn theo loại và cùng bộ dữ liệu. Chứng từ dùng khóa chung với đầu nghiệp vụ; dòng tư vấn/giao/đơn dùng khóa dòng chung. Trường không áp dụng phải trống, nháp có thể thiếu nhưng xác nhận thiếu nguồn bị chặn. FK chỉ kiểm tồn tại chưa đủ: [hợp đồng loại nguồn](source-contracts.csv) yêu cầu đúng loại đích; loại qua đầu phiếu cần nối kiểm cả dòng và đầu. Ràng buộc kiểm tại DB và giao dịch xác nhận, không chỉ ẩn trên giao diện.

Bảng gộp không cho đọc mọi cột: quyền lọc theo loại, bộ và cột. QC đọc phần chất lượng, không tiền/khách thương mại; xưởng không đọc lương cá nhân qua giá thành. Các cột riêng của đầu công/ngày không mở cho vai chỉ kho. Truy vấn/API theo danh sách cột cho phép; quyền DB theo view/cột phù hợp, không cấp đọc toàn bảng chung. Không thêm quyền mặc định do bảng được gộp.

Bản được sử dụng bất biến; điều chỉnh nối nguồn. Tồn/nợ/tiền/công/tổng thu nhập và giá thành tính từ đúng nguồn/mốc, không nhập tay. Cập nhật đồng thời, chống gửi lặp và sự kiện ảnh hưởng liên phân hệ phải cùng giao dịch. Chưa viết SQL, nên các ràng buộc này là yêu cầu thiết kế cần kiểm khi triển khai.

## Đối chiếu đủ 91 bảng trước đây

[CSV lọc theo quyết định](optimization-review.csv); [1.139 trường trước B29 → trường hiện hành](name-mapping.csv). Mã D là lịch sử, mã T là từ điển 74 bảng hiện hành. Không có dữ liệu DB thật cần di chuyển ở giai đoạn này. Các mã bản trước đây độc lập được hợp nhất chỉ khi triển khai mới; nếu có DB thực về sau phải có bước đối chiếu nguồn và kế hoạch di chuyển riêng.

| Mã cũ | Bảng trước B29 | Quyết định | Bảng hiện hành |
| --- | --- | --- | --- |
| D001 | `dung_chung.doanh_nghiep` | Giữ | `dung_chung.doanh_nghiep` |
| D002 | `dung_chung.bo_phan` | Giữ | `dung_chung.bo_phan` |
| D003 | `dung_chung.vi_tri_giu_hang` | Giữ | `dung_chung.vi_tri_giu_hang` |
| D004 | `dung_chung.don_vi_tinh` | Giữ | `dung_chung.don_vi_tinh` |
| D005 | `dung_chung.chung_tu` | Giữ | `dung_chung.chung_tu` |
| D006 | `dung_chung.dong_chung_tu` | Giữ | `dung_chung.dong_chung_tu` |
| D007 | `dung_chung.lien_ket_chung_tu` | Giữ | `dung_chung.lien_ket_chung_tu` |
| D008 | `dung_chung.de_nghi_va_quyet_dinh_phe_duyet` | Giữ | `dung_chung.de_nghi_va_quyet_dinh_phe_duyet` |
| D009 | `dung_chung.ban_giao_cong_viec` | Giữ | `dung_chung.trao_doi_va_ban_giao` |
| D010 | `dung_chung.chung_cu_dinh_kem` | Giữ | `dung_chung.chung_cu_dinh_kem` |
| D011 | `dung_chung.nhat_ky_thao_tac` | Giữ | `dung_chung.nhat_ky_thao_tac` |
| D012 | `dung_chung.ky_nghiep_vu` | Giữ | `dung_chung.ky_nghiep_vu` |
| D013 | `dung_chung.phien_ban_chinh_sach` | Giữ | `dung_chung.phien_ban_chinh_sach` |
| D014 | `dung_chung.bo_du_lieu_mo_phong` | Giữ | `dung_chung.bo_du_lieu_mo_phong` |
| D015 | `truy_cap.tai_khoan_dang_nhap` | Giữ | `truy_cap.tai_khoan_dang_nhap` |
| D016 | `truy_cap.vai_tro_cong_viec` | Giữ | `truy_cap.vai_tro_cong_viec` |
| D017 | `truy_cap.quyen_thao_tac` | Giữ | `truy_cap.quyen_thao_tac` |
| D018 | `truy_cap.cap_vai_tro` | Giữ | `truy_cap.cap_vai_tro` |
| D019 | `truy_cap.uy_quyen` | Giữ | `truy_cap.uy_quyen` |
| D020 | `truy_cap.bien_nhan_xac_nhan_giao_dich` | Giữ | `truy_cap.bien_nhan_xac_nhan_giao_dich` |
| D021 | `danh_muc.san_pham` | Gộp | `danh_muc.mat_hang` |
| D022 | `danh_muc.mat_hang` | Giữ | `danh_muc.mat_hang` |
| D023 | `danh_muc.ma_goi_khac` | Giữ | `danh_muc.ma_goi_khac` |
| D024 | `danh_muc.quy_doi_don_vi` | Giữ | `danh_muc.quy_doi_don_vi` |
| D025 | `dung_chung.doi_tac` | Giữ | `dung_chung.doi_tac` |
| D026 | `dung_chung.lien_he_doi_tac` | Giữ | `dung_chung.lien_he_doi_tac` |
| D027 | `dung_chung.can_cu_dai_dien` | Giữ | `dung_chung.can_cu_dai_dien` |
| D028 | `kinh_doanh.nhu_cau_khach_hang` | Giữ và giản lược phần chung | `kinh_doanh.nhu_cau_khach_hang` |
| D029 | `kinh_doanh.lan_tiep_nhan_nhu_cau` | Gộp | `dung_chung.trao_doi_va_ban_giao` |
| D030 | `kinh_doanh.thong_so_tu_van` | Gộp | `kinh_doanh.dong_tu_van_bao_gia_va_don_hang` |
| D031 | `kinh_doanh.bao_gia_va_don_hang` | Giữ và giản lược phần chung | `kinh_doanh.bao_gia_va_don_hang` |
| D032 | `kinh_doanh.dong_bao_gia_va_don_hang` | Giữ và giản lược phần chung | `kinh_doanh.dong_tu_van_bao_gia_va_don_hang` |
| D033 | `kinh_doanh.mau_khach_duyet` | Giữ và giản lược phần chung | `kinh_doanh.mau_khach_duyet` |
| D034 | `kinh_doanh.ho_so_thay_doi_va_xu_ly_thuong_mai` | Giữ và giản lược phần chung | `kinh_doanh.ho_so_xu_ly` |
| D035 | `mua_hang.don_mua_hang` | Giữ và giản lược phần chung | `mua_hang.don_mua_hang` |
| D036 | `mua_hang.dong_don_mua_hang` | Giữ và giản lược phần chung | `mua_hang.dong_don_mua_hang` |
| D037 | `mua_hang.phan_bo_hang_dang_ve` | Gộp | `kho.su_kien_giu_khoa_va_dang_ve` |
| D038 | `kho.lo_hang` | Giữ | `kho.lo_hang` |
| D039 | `kho.phan_lo_hang` | Giữ | `kho.phan_lo_hang` |
| D040 | `kho.phieu_van_dong_hang` | Gộp | `dung_chung.chung_tu` |
| D041 | `kho.dong_van_dong_hang` | Giữ và giản lược phần chung | `kho.dong_van_dong_hang` |
| D042 | `kho.yeu_cau_hang_va_vat_tu` | Giữ và giản lược phần chung | `kho.yeu_cau_hang_va_vat_tu` |
| D043 | `kho.su_kien_giu_hang` | Giữ | `kho.su_kien_giu_khoa_va_dang_ve` |
| D044 | `kho.bien_ban_kiem_ke` | Gộp | `dung_chung.chung_tu` |
| D045 | `kho.dong_kiem_ke` | Giữ và giản lược phần chung | `kho.dong_kiem_ke` |
| D046 | `san_xuat.phien_ban_dinh_muc_san_xuat` | Giữ và giản lược phần chung | `san_xuat.phien_ban_dinh_muc_san_xuat` |
| D047 | `san_xuat.dong_dinh_muc_vat_tu` | Giữ và giản lược phần chung | `san_xuat.dong_dinh_muc_vat_tu` |
| D048 | `san_xuat.nguon_luc_san_xuat` | Giữ | `san_xuat.nguon_luc_san_xuat` |
| D049 | `san_xuat.lenh_san_xuat` | Giữ và giản lược phần chung | `san_xuat.lenh_san_xuat` |
| D050 | `san_xuat.lo_san_xuat` | Giữ | `san_xuat.lo_san_xuat` |
| D051 | `san_xuat.cong_doan_san_xuat` | Giữ và giản lược phần chung | `san_xuat.cong_doan_san_xuat` |
| D052 | `san_xuat.lich_va_su_dung_nguon_luc` | Giữ | `san_xuat.lich_nguoi_va_nguon_luc` |
| D053 | `san_xuat.vat_tu_thuc_dung` | Gộp | `kho.dong_van_dong_hang` |
| D054 | `chat_luong.phieu_kiem_tra_chat_luong` | Giữ và giản lược phần chung | `chat_luong.phieu_kiem_tra_chat_luong` |
| D055 | `chat_luong.ket_qua_tung_tieu_chi_kiem_tra` | Giữ | `chat_luong.ket_qua_tung_tieu_chi_kiem_tra` |
| D056 | `chat_luong.su_kien_khoa_chat_luong` | Gộp | `kho.su_kien_giu_khoa_va_dang_ve` |
| D057 | `chat_luong.phuong_an_xu_ly_chat_luong` | Gộp | `kinh_doanh.ho_so_xu_ly` |
| D058 | `giao_hang.dot_giao_hang` | Giữ và giản lược phần chung | `giao_hang.dot_giao_hang` |
| D059 | `giao_hang.dong_giao_hang` | Giữ và giản lược phần chung | `giao_hang.dong_giao_va_nhan_hang` |
| D060 | `giao_hang.xac_nhan_khach_nhan_hang` | Gộp | `giao_hang.dong_giao_va_nhan_hang` |
| D061 | `tai_chinh.quy_va_tai_khoan_tien` | Giữ | `tai_chinh.quy_va_tai_khoan_tien` |
| D062 | `tai_chinh.de_nghi_chi_tien` | Giữ và giản lược phần chung | `tai_chinh.de_nghi_chi_tien` |
| D063 | `tai_chinh.bien_dong_tien_thuc` | Giữ và giản lược phần chung | `tai_chinh.bien_dong_tien_thuc` |
| D064 | `tai_chinh.nghia_vu_thanh_toan` | Giữ | `tai_chinh.nghia_vu_va_dieu_chinh` |
| D065 | `tai_chinh.dieu_chinh_nghia_vu` | Gộp | `tai_chinh.nghia_vu_va_dieu_chinh` |
| D066 | `tai_chinh.su_kien_su_dung_nguon_tien` | Giữ | `tai_chinh.su_kien_su_dung_nguon_tien` |
| D067 | `tai_chinh.chung_tu_ghi_nhan_ban` | Gộp | `dung_chung.chung_tu` |
| D068 | `tai_chinh.dong_ghi_nhan_ban` | Giữ và giản lược phần chung | `tai_chinh.dong_ghi_nhan_ban` |
| D069 | `tai_chinh.doi_chieu_nghia_vu_mua` | Giữ và giản lược phần chung | `tai_chinh.doi_chieu_nghia_vu_mua` |
| D070 | `tai_chinh.dong_doi_chieu_quy_ngan_hang` | Giữ và giản lược phần chung | `tai_chinh.dong_doi_chieu_quy_ngan_hang` |
| D071 | `tai_chinh.nguon_chi_phi` | Giữ và giản lược phần chung | `tai_chinh.nguon_chi_phi` |
| D072 | `tai_chinh.phan_bo_chi_phi` | Giữ và giản lược phần chung | `tai_chinh.phan_bo_chi_phi` |
| D073 | `tai_chinh.can_cu_phan_bo_chi_phi` | Giữ | `tai_chinh.can_cu_phan_bo_chi_phi` |
| D074 | `tai_chinh.ban_chot_gia_thanh` | Gộp | `dung_chung.chung_tu` |
| D075 | `tai_chinh.bien_dong_gia_tri` | Giữ và giản lược phần chung | `tai_chinh.bien_dong_gia_tri` |
| D076 | `nhan_su.nhan_vien` | Giữ | `nhan_su.nhan_vien` |
| D077 | `nhan_su.ho_so_lam_viec_theo_hieu_luc` | Giữ và giản lược phần chung | `nhan_su.ho_so_lam_viec_theo_hieu_luc` |
| D078 | `nhan_su.ho_so_ky_nang_va_an_toan` | Giữ và giản lược phần chung | `nhan_su.ho_so_ky_nang_va_an_toan` |
| D079 | `nhan_su.ban_giao_bao_ho_dung_cu` | Gộp | `dung_chung.trao_doi_va_ban_giao` |
| D080 | `nhan_su.ngay_va_ca_lam_viec` | Giữ | `nhan_su.ngay_va_ca_lam_viec` |
| D081 | `nhan_su.phan_cong_du_kien` | Gộp | `san_xuat.lich_nguoi_va_nguon_luc` |
| D082 | `nhan_su.ban_cong_nguoi_ngay_ca` | Gộp | `dung_chung.chung_tu` |
| D083 | `nhan_su.khoang_cong_thuc_te` | Giữ | `nhan_su.khoang_cong_thuc_te` |
| D084 | `nhan_su.de_nghi_nghi` | Giữ và giản lược phần chung | `nhan_su.de_nghi_nghi` |
| D085 | `nhan_su.su_kien_phep` | Giữ và giản lược phần chung | `nhan_su.su_kien_phep` |
| D086 | `nhan_su.ky_tinh_thu_nhap` | Gộp | `dung_chung.ky_nghiep_vu` |
| D087 | `nhan_su.dong_thu_nhap_nhan_vien` | Giữ và giản lược phần chung | `nhan_su.thu_nhap_nhan_vien` |
| D088 | `nhan_su.khoan_thu_nhap_co_can_cu` | Giữ | `nhan_su.khoan_thu_nhap_co_can_cu` |
| D089 | `truy_cap.phien_dang_nhap` | Giữ | `truy_cap.phien_dang_nhap` |
| D090 | `tai_chinh.nguon_cua_ban_chot_gia_thanh` | Giữ và giản lược phần chung | `tai_chinh.nguon_cua_ban_chot_gia_thanh` |
| D091 | `truy_cap.dinh_danh_nguoi` | Giữ | `truy_cap.dinh_danh_nguoi` |

## Hồ sơ để phát triển sau này

[Từ điển](data-dictionary.md) và [trường](fields.csv) quy định dữ kiện, người ghi, nguồn và điều kiện; [quan hệ](relationships.csv) và [loại nguồn](source-contracts.csv) quy định liên kết; [trách nhiệm nhập](input-responsibility.md) quy định thao tác; [bao phủ](coverage.csv) giữ FR/SC/tiêu chí; [đối chiếu luồng](workflow-coverage.md) rà các tình huống dễ mất nghĩa sau gộp. [Rà nguồn B28](source-review.md) vẫn giữ hiệu lực: bộ mẫu cũ không được nạp làm sổ nguồn. Kiểm hồ sơ không thay kiểm SQL, quyền, đồng thời, khôi phục và ứng dụng thực.
