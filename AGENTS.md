# Hướng dẫn làm việc với Mini-ERP

## Trước khi thao tác

Trước khi chỉnh sửa, chạy build/test hoặc thực hiện thao tác làm thay đổi dự án:

1. Đọc toàn bộ `README.md` để hiểu mục tiêu, nhật ký trao đổi, quyết định đã chốt và những đề xuất chưa được chấp thuận. Đọc tài liệu nghiệp vụ liên quan được README dẫn tới, nếu có.
2. Kiểm tra `git status` và lịch sử commit gần đây; đọc diff của các thay đổi liên quan để hiểu trạng thái mã và bảo toàn thay đổi đang có của người dùng.
3. Tham khảo `docs/build-history.md` nếu đã tồn tại, cùng kết quả build/test hoặc CI gần nhất có thể truy cập được cho phiên bản mã liên quan. Chú ý lỗi chưa giải quyết và các giới hạn kiểm tra. Commit thành công không có nghĩa là build/test thành công.
4. Nếu chưa có lịch sử build hoặc không truy cập được kết quả, nêu rõ điều đó và tiếp tục công việc trong phạm vi đã được yêu cầu; không dựng lại lịch sử hoặc khẳng định đã kiểm tra thành công.

## Sau khi làm việc

- Bổ sung trao đổi, quyết định và kết quả thực tế vào `README.md`, giữ nguyên lịch sử trước đó và phân biệt đề xuất với quyết định đã chốt.
- Khi thực hiện build/test, tạo hoặc bổ sung `docs/build-history.md` với ngày giờ và múi giờ, commit hoặc trạng thái mã được kiểm tra (bao gồm thay đổi chưa commit nếu có), lệnh chạy, kết quả, lỗi còn tồn tại và liên kết CI nếu có. Chỉ cần bản ghi ngắn; không đưa log thô, bí mật hoặc tệp build vào Git.
- Không coi kết quả build của phiên bản cũ là bằng chứng phiên bản hiện tại đã đạt; kiểm tra lại phù hợp với thay đổi và báo rõ phần chưa được xác minh.
