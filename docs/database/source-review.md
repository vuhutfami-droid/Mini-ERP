# Rà soát dữ liệu nguồn — B28

Theo yêu cầu ngày 08/10/2026: tên bảng/trường bằng tiếng Việt, có mô tả rõ; dữ liệu phải có nguồn, không cài sẵn để hoàn thành chức năng hoặc dẫn quyết định. Đây là rà soát thiết kế và bộ mẫu, chưa tạo cơ sở dữ liệu hoặc lập trình.

## Kết luận để anh xem

Dữ liệu nguồn là **điều đã được ghi nhận với căn cứ**: khách đặt bao nhiêu, đơn giá đã thống nhất, kho thực nhận/xuất bao nhiêu, người kiểm đo và kết luận thế nào, nhân viên thực làm lúc nào, tiền thực thu/chi ra sao. Quyết định của giám đốc cũng là nguồn khi có nội dung, phạm vi, thời điểm và người quyết định. Một số hoặc nhãn “đã duyệt” được điền sẵn để chạy minh họa chưa đáp ứng điều này.

Hiện chưa có bộ chứng từ nội bộ Nasaki đủ để xác nhận là nguồn thực. Website cung cấp thông tin công bố về doanh nghiệp/sản phẩm; 50 nhân viên, công, lương, giao dịch, định mức và kết quả kiểm mẫu đều giả lập. Không đổi nhãn để biến giả lập thành thực tế. Bộ mẫu cũ được giữ cho lịch sử và kiểm phép tính, **chặn nạp trực tiếp** theo [chính sách](../demo-data/source-policy.json).

Thiết kế đã tách dữ kiện, quyết định/tham số, kết quả tính và thông tin kỹ thuật. [Từ điển](data-dictionary.md) và [danh sách từng trường](fields.csv) là nguồn tên hiện hành; [kiểm kê mẫu](source-review.csv) rà 481 đường dẫn/cột của cả năm tệp cũ. Các tên tiếng Anh chỉ còn trong cột chỉ vị trí cũ để anh đối chiếu, không là tên cơ sở dữ liệu hiện hành.

## Rà soát theo từng bộ

| Bộ đang có | Đã rà | Điểm cần xử lý | Cách sử dụng sau rà soát |
| --- | --- | --- | --- |
| baseline.json | Tất cả đường dẫn có giá trị: danh mục, đơn, mua, lô, QC, kho, tiền, lương, số mong đợi | Trộn dữ kiện giả lập với tổng tính sẵn và mã xác nhận chưa có hồ sơ đầy đủ | Chỉ đọc lịch sử/kiểm phép tính; không nạp cả tệp vào sổ nguồn |
| employees.csv | Tất cả cột và 50 dòng | Nhân viên, kỹ năng, lương, phép đầu đều giả lập; thiếu hồ sơ hiệu lực và căn cứ chính sách | Làm đề bài mô phỏng; khi chuẩn bị nguồn tạo hồ sơ theo hiệu lực và xác nhận riêng |
| attendance.csv | Tất cả cột và 1.300 dòng | Công được sinh theo lịch/tình huống; mã người xác nhận không kèm nguồn công thực độc lập | Không lấy lịch dự kiến làm công thực, không mặc định đủ ca hoặc đã chốt |
| labor-intervals.csv | Tất cả cột và 76 khoảng | Mốc giả lập; số phút là phép trừ hai mốc, phân bổ được dựng cho bộ kiểm | Chỉ kiểm khoảng/thời lượng; muốn ghi công cần nguồn người/ngày/công đoạn và xác nhận |
| scenario-cases.json | Tất cả trường có giá trị ở 24 nhánh | Điều kiện giả định và kết quả mong đợi của nhánh thử | Tách khỏi sổ; kết quả phải do thao tác trên nguồn của nhánh tạo ra |

Không sửa số mẫu chỉ để số cuối đẹp hơn. Mã kiểm toàn vẹn trong chính sách xác định đúng tệp đã rà. Nếu thay bộ mẫu phải rà lại, không tiếp tục dùng kết luận cho bản đã đổi.

## Những sai lệch cụ thể đã xử lý trong thiết kế

1. **Kho:** giữ 300 kg theo OTHER-001 chưa có hồ sơ nhu cầu/duyệt đầy đủ. Kho vẫn tính được tình huống ở bộ kiểm cũ, nhưng bộ khởi tạo nguồn phải bổ sung hồ sơ riêng hoặc bỏ khoản giữ; số thiếu sẽ tính lại từ nguồn hợp lệ. Không tự tạo nhu cầu phụ để ra số thiếu 1.200.
2. **Sản xuất/QC:** tỷ lệ đạt dự kiến chỉ phục vụ kế hoạch. Sản lượng thực ghi ở công đoạn, kết quả kiểm ở phiếu QC, tiến độ lô tính từ đó. Không lấy tỷ lệ dự kiến sinh lượng đạt/lỗi hoặc tự kết luận đủ bán.
3. **Giá/đơn:** giá niêm yết và chiết khấu là đề xuất; đơn giá thỏa thuận cần bản khách xác nhận và quyết định theo quyền. Số viên tư vấn được tính từ diện tích/quy cách; số khách chốt là dữ kiện riêng. Không tự chốt đơn từ kết quả tính.
4. **Công/lương:** không tự cho đủ công từ lịch 26 ngày, không lấy tổng thu nhập/còn trả làm đầu vào. Khoản thu nhập nối nguồn công/chính sách/quyết định; tiền đã trả nối tiền thực và phân bổ. Dòng giám đốc vẫn cần kiểm tra độc lập.
5. **Tiền/nợ:** chứng cứ có mỗi mã chưa đủ đối chiếu. Tiền thực phải có người ghi và căn cứ thu/chi; nợ còn lại, đã trả và số dư tính từ sự kiện. Không tạo khoản thu/chi để ép số dư ngân hàng hoặc coi duyệt chi là thực chi.
6. **Giá thành:** bỏ cột tổng, lượng đạt sao chép và tiền sao lần hai ở dòng bản chốt. Bản chốt giữ danh sách nguồn/phân bổ đúng bản; tổng tính khi đọc, thiếu căn cứ giữ tạm tính. Biến động giá trị chính thức vẫn được giữ để truy nguồn định giá, không thay lượng thực.
7. **Duyệt/giao/xử lý:** tiến độ tổng hợp không là cột sửa tay. Phê duyệt có quyết định; giao/nhận/tiêu hủy có sự kiện thực riêng. Không lấy “hoàn thành” cài sẵn để vượt thiếu nguồn.

[21 trường đã bỏ](derived-fields.csv) ghi nguồn và cách tính thay thế. Không bỏ thông tin cần thiết: thỏa thuận đã chốt, kết quả kiểm thực, quyết định xử lý, phân bổ được xác nhận, công thức đã ghi nhận và giá trị chính thức đều được lưu cùng nguồn/bản/mốc.

## Bốn loại dữ liệu được phân nhiệm

| Loại | Ví dụ | Ai tạo/xác nhận | Điều kiện |
| --- | --- | --- | --- |
| Dữ kiện nghiệp vụ | Lượng thực nhận, mốc công, số đo QC, khoản tiền thực | Kho, sản xuất, nhân sự, QC, người thu/chi theo phân nhiệm | Chứng từ/dòng nguồn, chủ thể, đơn vị, mốc thực và người xác nhận; thiếu thì chờ |
| Quyết định và khai báo | Ưu tiên đơn, duyệt giá, định mức, lịch, tiêu chí QC, chính sách lương | Người khai báo và người có quyền duyệt; giám đốc/CEO là một người | Có lý do/căn cứ, bản hiệu lực, phạm vi và lịch sử; đề xuất chưa duyệt không điều khiển giao dịch |
| Kết quả tính/đối chiếu | Tồn khả dụng, còn nợ, thiếu vật tư, tổng giá thành | Hệ thống tính từ đúng nguồn và mốc | Không nhập như nguồn thứ hai; bản chính thức cần lưu thì liên kết tất cả đầu vào và bản phép tính |
| Thông tin kỹ thuật | Mã định danh, thời điểm ghi, phiên, bản băm, khóa chống ghi lặp | Hệ thống ghi từ thao tác/ngữ cảnh xác thực | Dùng toàn vẹn và lịch sử; không thay quyết định hoặc chứng cứ nghiệp vụ |

Bộ dữ liệu giả lập khi dựng sau này vẫn có thể dùng làm đầu vào thử, nhưng phải trình bày như người dùng nhập/xác nhận từng nguồn. Không tự cấp hồ sơ xác nhận chỉ vì bộ kiểm có mã người duyệt. Dữ liệu vận hành thật và nhánh thử phải tách biệt.

## Quy tắc thiết kế cho bước phát triển

- Người dùng nhập dữ kiện/đề nghị; hệ thống kiểm nguồn/quyền/đơn vị/phạm vi và hiển thị phần thiếu. Không tự thêm nguồn, sửa kết quả hoặc giả giấy ủy quyền.
- Quyết định và kết quả kiểm có bản, mốc, người xác nhận và chứng cứ. Tệp chứng cứ cần nội dung thật tương ứng; mã chứng cứ đơn lẻ không chứng minh hồ sơ đã tồn tại.
- Tổng/phần thiếu/trạng thái tổng hợp tính từ sổ; thuật toán có thể gợi ý, nhưng người được giao quyết định xác nhận riêng trước phát sinh đơn mua/lệnh/ưu tiên.
- Tham số có kiểu, đơn vị, phạm vi, nguồn khai báo và hiệu lực. Bản đề xuất hoặc chưa duyệt để chờ; không đặt giá trị mặc định mang nghĩa “đã duyệt/đạt/đủ công/hoàn tất”.
- Sửa nguồn làm kết quả thay đổi tương ứng. Đã xác nhận/chốt thì điều chỉnh bằng bản/sự kiện có liên kết; không sửa trực tiếp số dư hay xóa dấu vết.
- Số mong đợi nằm trong bộ kiểm độc lập. Kiểm phép tính đạt không chứng minh nguồn thật hoặc quyền/luồng nghiệp vụ đã hoạt động.

## Giới hạn

Đã rà tên, mô tả, quan hệ, độ bao phủ yêu cầu và các trường trong bộ kiểm. Chưa xác minh chứng từ Nasaki, chưa tạo bộ khởi tạo nguồn mới, chưa có bộ nạp/SQL/DB hay thử giao dịch thật. [Lịch sử kiểm tra](../build-history.md) ghi phiên bản, lệnh và phạm vi thực đã kiểm.
