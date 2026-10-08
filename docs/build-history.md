# Lịch sử kiểm tra dự án Mini ERP

Kho chưa có ứng dụng ERP, cấu hình build hoặc CI ứng dụng. Các bản ghi dưới đây chỉ kiểm tra tài liệu và bộ dữ liệu nghiệp vụ giả lập; không chứng minh phần mềm chạy, dữ liệu được lưu trong ứng dụng hoặc phân quyền/đồng thời đã hoạt động.

## Ngày 08 tháng 10 năm 2026 kiểm tra bộ dữ liệu demo V1

- Thời điểm ghi nhận: 09:45 ngày 08/10/2026, Asia/Bangkok; ngày mô phỏng nghiệp vụ trong bộ là tháng 09/2026, không phải thời điểm chạy kiểm tra.
- Nền Git: `6b5c0ef` trên `main`; kiểm tra các tệp mới/chỉnh sửa chưa commit của vòng B25. Commit chứa bản ghi này sẽ định danh phiên bản tài liệu và dữ liệu đã kiểm; không lấy commit cũ làm bằng chứng cho tệp mới.
- Lệnh đối chiếu: `python scripts/verify-demo-data.py`.
- Kết quả cuối: mã thoát 0; 7.020 điều kiện dữ liệu đạt. Có 50 người, 1.300 dòng công, 76 khoảng trực tiếp, 61 biến động kho và 24 nhánh ngoại lệ có đầu vào/kết quả. Đối chiếu kho cuối 6.403.101 VND, ngân hàng 686.700.000, doanh thu 196.000.000 và giá vốn 63.591.066.
- Phạm vi: danh mục/nguồn; cơ cấu/quản lý/công và nguồn lương; trùng giờ người/máy, lịch chờ/chỗ giữ; vật tư/BOM/QC/xử lý; cấp và lấy theo lô; giá trị bình quân/làm tròn/bảo toàn nguồn; bán/thu/phân bổ/chi; kết quả cuối và phép tính ngoại lệ. Điều kiện trong fixture không thay thử nghiệm hành động trên ứng dụng.
- Kiểm tra khả năng phát hiện sai: tạo bảy bản sao tạm, lần lượt thêm phiếu kho trùng; phân bổ cọc vượt 1 đồng; sửa số ngân hàng mong đợi 1 đồng; sửa QC vượt lượng đầu 1 viên; bỏ một nhân sự; thêm khoảng công trùng; sửa lương E023 1 đồng. Cả bảy đều bị từ chối ở điều kiện tương ứng; tệp gốc không thay đổi. Đây là kiểm tra công cụ đối chiếu và tính nhất quán dữ liệu, không phải bảy test ERP.
- Kiểm tra tài liệu: `git diff --check` và đối chiếu đường dẫn Markdown cục bộ, tiêu chí có mã đủ A01–A32/X01–X24; rà soát số trong các bảng với tệp nguồn.
- Giới hạn: chưa build/test ERP; chưa kiểm quyền, đồng thời, mất kết nối, lưu/mở lại trong ứng dụng; chưa có sổ giao dịch thực hiện toàn bộ các nhánh riêng, các nhánh có dữ liệu đầu vào/kết quả để dựng khi phát triển. Chính sách/dung sai/giá/lịch mới là đề xuất demo; không xác minh nội bộ Nasaki hoặc kế toán/thuế/lương pháp lý.

Khi có mã ứng dụng, thêm lần kiểm tra riêng với commit/trạng thái mã, lệnh thực chạy, kết quả và lỗi còn tồn tại. Không đổi các kiểm tra dữ liệu trên thành kết luận build ứng dụng thành công.

## Ngày 08 tháng 10 năm 2026 kiểm tra yêu cầu và prototype màn hình

- Thời điểm: 10:03 ngày 08/10/2026, Asia/Bangkok. Nền Git `96b34ea` trên `main`, gồm các tệp chưa commit của B26; commit chứa bản ghi định danh phiên bản được kiểm tra.
- Đối chiếu bằng Python: 33 FR, 22 SC và đủ A01–A32/X01–X24 trong `docs/design/traceability.csv`; kiểm tra liên kết Markdown cục bộ. Không thay dữ liệu nghiệp vụ V1; không lặp kiểm tra dữ liệu cũ để gọi là kiểm thử ứng dụng mới.
- Cú pháp: trích JavaScript của prototype vào tệp tạm và chạy `node --check /tmp/nasaki-prototype.js`, mã thoát 0.
- Trình duyệt: chạy `python /tmp/check_nasaki_design.py` với Playwright và Chromium cục bộ. Kiểm 22 trang ở 1440×1000 và 390×844; tìm dòng/không kết quả; 18 biểu mẫu nhập/xem điều kiện/đóng Escape/phục hồi focus; ba mốc đơn ngói; chọn góc nhìn; mã trang không có; menu điện thoại. Kết quả mã thoát 0, không lỗi JavaScript hoặc cuộn ngang toàn trang. Xem ảnh tổng quan máy tính và danh sách đơn điện thoại để kiểm bố cục.
- Giới hạn môi trường: Chromium ban đầu không khởi động trong sandbox; chạy kiểm tra cục bộ với quyền bổ sung. Chính sách trình duyệt chặn URL `file://`, nên nạp nội dung HTML trong bộ nhớ bằng `set_content`, không tắt chính sách hoặc truy cập ngoài. Chờ cập nhật menu sau đổi trang trong công cụ kiểm tra trước khi kết luận. Lần kiểm cuối đạt; chưa xác minh cách mở file trên thiết bị của người dùng.
- `git diff --check` kiểm định dạng, gồm các tệp mới sau khi thêm vào index. Không có CI/build ERP, backend hoặc đăng nhập thật. Kiểm prototype chỉ chứng minh bố cục/điều hướng mẫu; chưa chứng minh quyền, tính tiền, lưu chống trùng, đồng thời, giao dịch nguyên tử, sao lưu hay 56 tiêu chí trong ERP thật.

## Ngày 08 tháng 10 năm 2026 rà soát thiết kế cơ sở dữ liệu

- Thời điểm: 10:33 ngày 08/10/2026, Asia/Bangkok. Nền Git `2dac884`, tệp tài liệu B27 chưa commit; commit chứa bản ghi sẽ định danh bộ thiết kế được rà soát.
- Lệnh kiểm cấu trúc tài liệu: `python /tmp/review_nasaki_database.py`. Công cụ tạm đọc từ điển/CSV, không kết nối hoặc tạo DB. Kết quả mã thoát 0: 91 bảng logic khác tên trong 11 nhóm, 394 định nghĩa FK có đích tồn tại/không lặp cùng khóa; mỗi bảng có trường/phụ trách/ràng buộc/FR; ma trận đủ và khớp đúng 33 FR/22 SC/56 tiêu chí với ma trận B26. Kiểm IAM toàn hệ thống tách khỏi workspace và nhân sự trỏ định danh ổn định, quyền vào từng bộ có phạm vi.
- Rà tài liệu các luồng tiền/giữ/QC/giao/giá trị/công/phép/chốt: FK gốc và bản, vai trò, sự kiện/mốc; bổ sung dòng riêng cost source/demand, snapshot nguồn giá thành, phiên thu hồi, lịch sử đổi hạn nợ và trạng thái người theo hiệu lực. Kiểm đường dẫn Markdown cục bộ và `git diff --check` gồm tệp mới khi stage.
- Không thay bộ dữ liệu V1/prototype hoặc dùng số đối chiếu cũ để gọi là DB hoạt động. Không tạo SQL, migration, bảng thật, DB server hoặc mã ERP; chưa kiểm ràng buộc FK/CHECK/RLS trên PostgreSQL, transaction, đồng thời, truy vấn/hiệu năng, backup/restore. Các kiểm tra trên chỉ chứng minh tính nhất quán và độ bao phủ hồ sơ thiết kế; chính sách giả lập và tham số vận hành vẫn là đề xuất.

## Ngày 08 tháng 10 năm 2026 rà soát tên tiếng Việt và dữ liệu nguồn B28

- Thời điểm: 12:16 ngày 08/10/2026, Asia/Ho_Chi_Minh (05:16 UTC). Nền Git `088a529`, gồm thay đổi tài liệu B28 chưa commit; commit chứa bản ghi định danh phiên bản đã kiểm.
- Lệnh: `python /tmp/review_vietnamese_sources.py`, mã thoát 0. Công cụ tạm chỉ đọc tài liệu/CSV/JSON và Git, không tạo hoặc kết nối DB. Đối chiếu 91 bảng trong 11 nhóm, 1.139 trường không trùng tên, tên máy tiếng Việt không dấu và độ dài không vượt 63; mô tả/kiểu/nguồn/phụ trách/điều kiện/ràng buộc đầy đủ; giá trị phân loại và bảy trường JSON có cấu trúc đóng được mô tả.
- Quan hệ/bao phủ: 487 liên kết khớp danh sách trường và có bảng/khóa nguồn; phân vùng bộ và năm bảng định danh toàn hệ thống; ma trận khớp đúng 33 FR/22 SC/56 tiêu chí với B26. Danh sách 21 trường bỏ không còn trong mô hình hiện hành, có nguồn/cách tính thay thế; bảng tên cũ khớp toàn bộ trường hiện hành.
- Nguồn mẫu: liệt kê độc lập mọi đường dẫn JSON có giá trị và cột CSV, khớp 481 vị trí trên năm tệp và số lần xuất hiện. Tất cả bị chặn nạp trực tiếp trong chính sách thiết kế; số mong đợi thuộc bộ kiểm, công sinh theo lịch không được coi công thực. Kiểm mã SHA-256 của năm tệp khớp nội dung trên HEAD trước sửa, chứng minh không thay số mẫu để khớp kết quả.
- Kiểm đường dẫn Markdown cục bộ và `git diff --check`, gồm các tệp mới khi stage. Không chạy lại bộ kiểm phép tính V1 vì năm tệp không đổi; kết quả 7.020 của vòng cũ không được dùng làm bằng chứng nguồn thật hoặc DB vận hành.
- Giới hạn: chỉ kiểm thiết kế/tính nhất quán tài liệu, không build/test ERP hoặc thử SQL/FK/CHECK/RLS/giao dịch/đồng thời/hiệu năng/khôi phục. Chưa có dữ liệu nội bộ Nasaki đủ chứng từ hoặc bộ nguồn khởi tạo mới; chính sách chặn nạp chưa được cưỡng chế bởi bộ nạp phần mềm. Giả lập/đề xuất không trở thành thực tế chỉ từ mã người duyệt hoặc trạng thái cài sẵn.

## Ngày 08 tháng 10 năm 2026 đối chiếu trách nhiệm nhập liệu

- Thời điểm: 12:25 ngày 08/10/2026, Asia/Ho_Chi_Minh. Nền Git `88f3583`, tài liệu giải thích mới chưa commit; commit chứa bản ghi định danh phiên bản được rà.
- Đối chiếu Python đọc CSV/Markdown qua đầu vào chuẩn: mã thoát 0; 91 mã/tên bảng không thiếu hoặc trùng, khớp từ điển và fields.csv; bốn nhóm 26 khai báo nền/46 có đầu vào nghiệp vụ/10 dựng từ nguồn cần kiểm hoặc xác nhận/9 tự ghi. Mỗi bảng có người phụ trách, đầu vào/thao tác và điều kiện phát sinh; CSV và bản đọc khớp; liên kết Markdown cục bộ hợp lệ.
- `git diff --check` và kiểm tệp mới trong index. Chỉ thêm tài liệu diễn giải, liên kết và nhật ký; không thay bảng/trường hoặc năm tệp mẫu. Không chạy build/test ERP, bộ kiểm phép tính hoặc tạo DB; chưa kiểm biểu mẫu, xác nhận, phân quyền và tự ghi trên phần mềm thật.
