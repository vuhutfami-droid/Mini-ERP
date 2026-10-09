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

## Ngày 08 tháng 10 năm 2026 kiểm thiết kế tinh gọn B29

- Thời điểm: 05:56 UTC ngày 08/10/2026 (12:56 Asia/Ho_Chi_Minh). Nền Git `02632e4` trên `main`, gồm tài liệu/công cụ kiểm chưa commit B29; commit chứa bản ghi định danh phiên bản được kiểm.
- Lệnh: `python scripts/verify-database-design.py`, mã thoát 0. Công cụ chỉ đọc CSV/Markdown/JSON và Git, không tạo/kết nối DB. Đối chiếu 74 bảng/931 trường/402 FK trong 11 nhóm; tên, kiểu, mô tả, nguồn, người phụ trách, điều kiện ghi và đích FK; bảy cấu trúc đóng giữ danh mục, không thêm JSON sổ nghiệp vụ. Mỗi bảng có ràng buộc, các tên/khóa liên kết hiện hành thống nhất.
- Rà 91 bảng cũ, 17 kết quả gộp và 1.139 ánh xạ trường khớp đúng tệp B28 trên Git `02632e4`, không thiếu/trùng và giữ kiểu. Có 43 hợp đồng loại nguồn: FK tồn tại chưa đủ, phải đúng phân loại đích; thực dùng/cấp kiểm qua đầu phiếu. Đây là kiểm tính nhất quán đặc tả, chưa cưỡng chế FK/CHECK/quyền trên DB.
- Ma trận khớp đúng 33 FR/22 SC/56 tiêu chí B26. Ma trận nhập 74 bảng gồm 25 khai báo nền, 34 có nhập/xác nhận nghiệp vụ, bảy dựng từ nguồn cần kiểm/xác nhận, tám tự ghi; không là số màn hình hoặc số việc phải làm mỗi ngày. Rà 11 luồng trong workflow-coverage.md bằng nguồn/bản/lượng/tiền/quyền, không ghi các ví dụ vào sổ mẫu.
- Kiểm năm mã SHA-256 mẫu khớp chính sách B28 và cả năm vẫn chặn nạp trực tiếp; 481 vị trí rà nguồn giữ nguyên. Không chạy lại 7.020 phép kiểm mẫu cũ để gọi là kiểm DB mới. Kiểm liên kết Markdown cục bộ và `git diff --check` gồm các tệp mới trong index.
- Giới hạn: chưa SQL/migration/server/bộ nạp/ứng dụng, chưa kiểm thực quyền theo loại/cột, bấm lặp/giao dịch/đồng thời/khôi phục/hiệu năng hoặc đo thời gian thao tác. Bản mẫu giao diện không thay. Cơ cấu đầu mối, chính sách và dữ kiện nội bộ Nasaki chưa khảo sát vẫn là giả lập/đề xuất; thiết kế đủ phạm vi đã đặc tả, không khẳng định đủ mọi tình huống chưa biết.

## Ngày 09 tháng 10 năm 2026 kiểm bộ Google Sheets B30

- Thời điểm: 09/10/2026 14:33 Asia/Bangkok; nền Git `3e6fc6f`, gồm hồ sơ liên kết/nhật ký chưa commit. Thiết kế B29 và bộ mẫu không đổi.
- Kiểm nền: `python scripts/verify-database-design.py`, mã thoát 0, 74 bảng/931 trường/402 FK, đủ phạm vi và nguồn. Chưa chạy build/test ERP.
- Tạo qua Google Drive/Sheets connector; đọc metadata sau tạo, chuyển bằng cha đã xác minh, đọc lại 12 file đều MIME Sheets gốc và đúng thư mục. Không đổi sharing. Đọc lại toàn bộ ô tài liệu đã ghi, 74 hàng tên cột/ghi chú và các hàng nhập trống, metadata 74 native table, kiểu/lựa chọn; các đáp ứng được lưu tạm ngoài Git.
- Đối chiếu: `python /tmp/verify_mini_erp_sheets.py`, mã thoát 0: 12 file/102 trang, 74 bảng dữ liệu/931 cột và mô tả; 402 quan hệ/43 điều kiện nguồn; 111 lựa chọn đóng/25 cột DATE; các ô nghiệp vụ trống; bốn SHA-256 tệp nguồn khớp. Đọc lại DATE xác nhận định dạng dd/MM/yyyy theo locale Việt; custom yyyy-mm-dd không được native table giữ, nên kiểm và hướng dẫn theo định dạng thực tế, nguồn DB vẫn YYYY-MM-DD. Không tạo số liệu để qua đối chiếu.
- Kiểm định dạng/hàng cố định/ghi chú/tables/banding/filter bằng Google API; không có CUA hoặc công cụ render Sheets được xác thực, chưa xác minh hiển thị bằng trình duyệt. `git diff --check` và liên kết tài liệu kiểm ở lần lưu. Không ghi log connector có email người chỉnh sửa vào Git, chỉ lưu URL/ID của các tệp mẫu cấu trúc do yêu cầu này tạo.
- Giới hạn: không SQL/DB/ERP, không FK/giao dịch/quyền theo dòng-cột/đồng thời hoặc phép tính vận hành. Mẫu dùng văn bản cho số chính xác và timestamp có múi giờ, DATE cho ngày và DROPDOWN cho phân loại; tham số thực, nguồn mới và hành vi ERP chưa triển khai. Không dùng kết quả mẫu cũ làm bằng chứng phần mềm.

## Ngày 09 tháng 10 năm 2026 kiểm kế hoạch xây dựng B31

- Thời điểm: 09/10/2026 14:51 Asia/Bangkok; nền Git `ab7b457`, gồm tài liệu/ma trận kế hoạch chưa commit; commit chứa bản ghi là phiên bản được kiểm. Không thay cấu trúc DB hoặc bộ mẫu.
- `python scripts/verify-database-design.py`, mã thoát 0: 74 bảng/931 trường/402 FK, ánh xạ cũ/loại nguồn/phạm vi và mã toàn vẹn mẫu giữ đúng.
- Đối chiếu Python đọc CSV/Markdown qua đầu vào chuẩn, mã thoát 0: đúng 33 FR duy nhất, 22 SC và 56 tiêu chí; màn hình/tiêu chí của từng FR khớp chính xác traceability.csv; đợt bắt đầu không sau đợt hoàn thiện dự kiến, nằm D01–D08; tất cả còn đề xuất/chưa bắt đầu. Liên kết cục bộ của kế hoạch/README/hồ sơ/FR hợp lệ.
- Rà kế hoạch theo phụ thuộc nguồn: QC tồn/nhận trước sử dụng, tiền từ D02, hồ sơ/lịch từ D01 và công thực D04 trước nguồn sản xuất, lương D05 trước chốt giá thành D06; kiểm giao dịch an toàn ngay từng đợt, ngoại lệ liên hoàn D07. Lần kiểm index đầu phát hiện CSV mới dùng CRLF; đã đổi sang LF và kiểm lại `git diff --check`/index đạt.
- Giới hạn: chỉ kiểm kế hoạch/thiết kế/tài liệu; chưa lập trình, SQL/DB/build/test ERP/CI/hosting hoặc đo tiến độ/hiệu năng. Tám đợt và Django/PostgreSQL là đề xuất; không báo đã triển khai hoặc cam kết ngày hoàn thành.

## Ngày 09 tháng 10 năm 2026 kiểm hồ sơ nền B32

- Thời điểm: 09/10/2026 14:58 Asia/Bangkok; nền Git `8413c03`, gồm hồ sơ/phụ lục nhật ký chưa commit. Commit chứa bản ghi định danh tài liệu được kiểm.
- `python scripts/verify-database-design.py`, mã thoát 0: 74 bảng/931 trường/402 FK; mã toàn vẹn nguồn mẫu, ánh xạ và phạm vi B29/B26 giữ nguyên.
- Python đọc CSV/Markdown qua đầu vào chuẩn, mã thoát 0: 14 mã N01–N14 duy nhất/đủ; mọi mã/khoảng bảng thuộc B29, các mã màn hình thuộc B26; liên kết cục bộ README/hồ sơ nền/kế hoạch/hồ sơ nghiệp vụ hợp lệ. Rà phụ thuộc nguồn mở đầu, quyền, khôi phục và phạm vi D01/D02, không đánh dấu FR đã hoàn thành.
- `git diff --check`/kiểm index gồm tệp mới đạt sau stage; chỉ bổ sung hồ sơ/liên kết/nhật ký.
- Giới hạn: chỉ kiểm đặc tả, không tạo DB/mã ERP, không chạy 14 ca nghiệm thu nền/SQL/build/CI, kiểm quyền/giao dịch/backup/hiệu năng thật. Mục tiêu dưới 2 giây/5 phiên và cấu hình thử là đề xuất chưa đo; chưa chọn hosting hoặc cam kết thời gian xây.

## Ngày 09 tháng 10 năm 2026 kiểm bộ câu hỏi B33

- 09/10/2026 15:09 Asia/Bangkok; nền Git `41357f9`, gồm hồ sơ câu hỏi/nhật ký chưa commit. Python đọc Markdown qua đầu vào chuẩn kiểm đúng Q01–Q60 duy nhất/liên tục và liên kết cục bộ đạt; `git diff --check`/index kiểm tệp mới.
- Chỉ kiểm tài liệu. Không thay thiết kế DB hoặc mẫu, không build/test ERP; các câu hỏi chưa được trả lời và không tự thành phạm vi mới.
