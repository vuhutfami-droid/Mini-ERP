# Phương án sử dụng Mini-ERP trên website

Ngày 09/10/2026, Asia/Bangkok. B34: anh xác nhận chạy trên website, không cài ứng dụng trên máy tính. B35: anh giao Codex đề xuất cho 20 câu khai thác tiếp theo. **Chỉ B34 đã chốt; các lựa chọn dưới đây là đề xuất, chưa triển khai hoặc tự coi đã được anh duyệt.**

## Phương án theo từng câu hỏi

| Mã | Nội dung cần xác định | Đề xuất của Codex | Lý do/giới hạn |
| --- | --- | --- | --- |
| W01 | Nơi truy cập | Truy cập qua Internet từ công ty hoặc ngoài công ty; đăng nhập bắt buộc, HTTPS | Thuận tiện tư vấn và làm việc từ xa; có đường dẫn không đồng nghĩa được đọc dữ liệu |
| W02 | Thiết bị ưu tiên | Máy tính cho nghiệp vụ nhiều cột; điện thoại cho xem việc/duyệt/ghi nhận nhanh; giao diện tự thích ứng màn hình | Phù hợp ít người vận hành, không phải làm thêm ứng dụng cài đặt |
| W03 | Phạm vi điện thoại | Xem tiến độ, việc chờ, duyệt đúng quyền, ghi nhận ngắn, ảnh và tra cứu; bảng nhiều dòng/lương/đối chiếu lớn ưu tiên máy tính | Không ép cả bảng Excel lớn vào màn hình nhỏ; phạm vi điện thoại không tự thêm quyền |
| W04 | Máy dùng chung | Có thể dùng máy/tablet chung, tài khoản người thao tác riêng; tổ trưởng được ghi theo nhóm trong quyền đã cấp | Tách người thực thao tác khỏi nhân viên có nguồn được ghi; không dùng một tài khoản chung cho mọi người |
| W05 | Số người cùng dùng | Mốc kiểm nền ban đầu 5 người thao tác đồng thời như B32; thêm thử 10 phiên để quan sát khi có bản chạy | Là mục tiêu kiểm giả lập, không phải số người thật hoặc giới hạn bán sản phẩm; 50 nhân sự không là 50 tài khoản |
| W06 | Tên miền | Dùng tên miền sản phẩm/thương hiệu của anh, Nasaki là bộ demo; tạm dùng địa chỉ môi trường demo khi triển khai trước khi mua tên miền | Dễ tư vấn đối tác khác; chưa có tên miền được chọn/mua hoặc URL ERP hoạt động |
| W07 | Trang khi mở | Đường dẫn ERP vào đăng nhập; sau đăng nhập mở trang công việc theo quyền | Trang giới thiệu marketing có thể làm sau, không cần để vận hành ERP |
| W08 | Cấp tài khoản | Người được giao quản trị cấp từ danh sách/quyết định; tài khoản dùng thử có hạn và phạm vi riêng; không đăng ký tự do | Gọn, dễ kiểm người nào được dùng bộ nào; quản trị kỹ thuật không mặc định đọc lương |
| W09 | Cách đăng nhập | Tên đăng nhập riêng và mật khẩu; email tùy chọn để liên hệ/khôi phục có xác minh | Không buộc 50 nhân viên có email hoặc tích hợp OTP/SMS từ đầu; tài khoản quên mật khẩu xử lý theo người có quyền nếu chưa có email xác minh |
| W10 | Người ngoài | V1 vận hành nội bộ; người xem demo có tài khoản thử đúng quyền trong bộ giả lập riêng | Chưa mở cổng khách/đại lý hoặc cho xem dữ liệu nội bộ. Cổng đối tác là đề xuất mở rộng cần nhu cầu cụ thể |
| W11 | Trang bắt đầu | Một khung giao diện chung, công việc/chỉ số hiện theo vai trò; giám đốc xem tổng quan và việc chờ; người kiêm nhiệm có bộ lọc vai trò | Không tạo website riêng theo bộ phận. Chỉ số chỉ có khi có nguồn, D01 không hiện doanh thu/lãi giả |
| W12 | Nhiều tab | Cho mở đơn/kho/sản xuất ở nhiều tab; mỗi trang hiện rõ bộ demo và phiên bản, kiểm quyền/bản mới khi lưu | Đổi dữ liệu ở tab khác không được ghi đè im lặng; đổi/thu hồi quyền vẫn áp dụng mọi tab |
| W13 | Cập nhật giữa người dùng | Tự làm mới phần trạng thái/nhắc việc đang xem mỗi 15–30 giây khi trang hoạt động, kèm nút làm mới và thời điểm dữ liệu | Đề xuất nhẹ, chưa cần hạ tầng thời gian thực riêng; không tự thay biểu mẫu đang nhập. Giữ/xuất/chi luôn kiểm dữ liệu mới nhất tại máy chủ |
| W14 | Ảnh/tệp/Excel | Tải ảnh, tài liệu theo nguồn và chụp ảnh bằng trình duyệt nếu thiết bị cho phép; nhập Excel theo mẫu có xem trước/lỗi từng dòng | Phần danh mục có ở D01; nhập công/giao dịch triển khai đúng đợt, không mở bộ nạp mọi bảng. Tệp phải kiểm quyền/loại/kích thước; Excel không tự xác nhận nghiệp vụ |
| W15 | Xuất và in | In/tải PDF cho báo giá, phiếu công việc phù hợp, phiếu cá nhân; Excel cho danh sách/báo cáo cần phân tích | Theo đúng đợt có nguồn. Xuất/tải kiểm quyền như xem; không xuất lương cùng báo cáo chung |
| W16 | Mất Internet | V1 cần mạng để ghi/xác nhận; khi mất mạng báo rõ và dừng xác nhận nghiệp vụ | Không cho giữ hàng/chi tiền/QC ở chế độ offline dễ xung đột. Ghi offline/đồng bộ là mở rộng nếu thực tế cần, không xây mặc định |
| W17 | Giữ dữ liệu đang nhập | Lưu nháp máy chủ khi có mạng, hiển thị đã lưu/chưa lưu và cảnh báo rời trang khi còn thay đổi; sau mất phản hồi đối chiếu trước gửi lại | Không tự xác nhận nguồn từ autosave. Phần chưa gửi có thể mất khi đóng tab/mất điện; không lưu hồ sơ nhạy cảm lâu dài trên trình duyệt dùng chung. Nháp kiểm quyền khi mở lại |
| W18 | Thời gian sử dụng | Có thể truy cập ngoài giờ khi dịch vụ hoạt động; bảo trì có thông báo và kế hoạch | Không biến thành cam kết sẵn sàng 24/7 hoặc hỗ trợ trực 24/7; mức dịch vụ chốt theo môi trường/chi phí |
| W19 | Người thao tác demo | Anh trình diễn luồng chính trước, sau đó người xem tự thử bằng tài khoản và kịch bản được cấp | Tài khoản dùng thử hữu hạn/thu hồi được, không dùng quyền quản trị toàn hệ thống |
| W20 | Nhiều đối tác thử | Mỗi nhóm đối tác có bộ dữ liệu giả lập riêng, được cấp quyền riêng; định danh vận hành ổn định | Tránh sửa ảnh hưởng nhau. Không thêm công ty thật vào mô hình một công ty/bộ và chưa xây sản phẩm đa doanh nghiệp vận hành; khôi phục bộ không mở lại quyền cũ |

## Tác động tới D01 và các đợt sau

- D01: nền web theo B34, đăng nhập/quyền, khung giao diện thích ứng, danh mục/người/lịch nền, nguồn/tệp/nháp, nhiều tab/xung đột, bộ demo cô lập và cơ chế trạng thái lưu/lỗi. Lưu nháp tự động chỉ cho loại biểu mẫu phù hợp và đã có điều kiện quyền/nguồn; phải thử mất phản hồi, không tự đóng chứng từ.
- D02–D07: áp dụng khung cho đơn/giao/tiền, mua/kho, sản xuất/QC và công/lương; thêm mẫu in/xuất, nhập theo nguồn phù hợp. Không tự đưa phiếu bán hoặc lương vào D01 chỉ vì muốn xuất PDF.
- Tự làm mới dùng truy vấn nhẹ theo quyền; dừng/giảm khi tab ẩn, giữ dữ liệu nhập. Chống gửi lặp/khóa lượng/phiên bản ở máy chủ là điều kiện nghiệp vụ độc lập với tốc độ tự làm mới.
- Môi trường phát triển và thử riêng trước, sau đó chuẩn bị URL demo có HTTPS/tài khoản. Hosting, tên miền, sao lưu tự động và chi phí sẽ được đề xuất cụ thể khi có bản chạy; chưa mua hoặc đưa hệ thống ra Internet trong lần này. Bản nền D01 có cách mở trong môi trường hiện có, URL công khai không là điều kiện ngầm đã triển khai.
- Những khả năng trợ lý đã mô tả trước đây (truy cập trên điện thoại, lưu tập trung, cập nhật tại máy chủ) là định hướng đề xuất phù hợp web; lời anh chốt trực tiếp ở B34 chỉ là chạy website, không cài máy tính. Các câu W01–W20 cần giữ rõ trạng thái đề xuất trước khi biến thành yêu cầu nghiệm thu.

## Thử nghiệm cần bổ sung khi xây

Mở trên máy tính/điện thoại; thao tác bằng máy chung và thu hồi phiên; quyền tải tệp/xuất; hai tab sửa cùng bản; hết quyền giữa lúc nhập; autosave không xác nhận chứng từ; mất phản hồi trước/sau commit không ghi đôi; mất mạng không báo thành công giả; người thử không đọc/reset bộ khác; dữ liệu nháp không lộ sang người đăng nhập tiếp theo. Kiểm hiệu năng 5 phiên nền và thử 10 phiên có số liệu, không khẳng định khả năng chịu tải từ đề xuất này.

Phương án này không đổi 74 bảng/931 trường/402 FK hoặc phạm vi bảy phân hệ. Nếu triển khai cần thay đổi cấu trúc/chi phí/phạm vi, ghi lý do và đề xuất cụ thể trước, không âm thầm thêm bảng, dịch vụ hoặc tài khoản.
