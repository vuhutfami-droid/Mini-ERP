# Dữ liệu nghiệp vụ giả lập Nasaki Demo V1

Bộ này là ảnh chụp giao dịch được xác nhận **trong mô phỏng**, phục vụ phân tích và chuẩn bị dữ liệu khởi tạo sau này. Không có giao dịch thật với Nasaki/ngân hàng/nhân viên. Tham số mới chờ chủ dự án duyệt; chưa phải định dạng nhập của một ERP đã xây dựng.

Đọc [quy tắc](../demo-business-rules.md), [kịch bản](../demo-scenarios.md) và [tiêu chí nghiệm thu](../demo-acceptance.md) trước dùng. Quy mô cố định: một công ty, một xưởng, một kho, 50 người. Mọi tên, lương, ca và chứng từ là giả lập; không có mật khẩu hoặc số tài khoản thật.

## Nội dung và mốc

- `baseline.json`: danh mục, mốc và số dư đầu, hai đơn/ba lần mua nhận/năm khoản thu, nguồn nghĩa vụ, chín lô, QC/xử lý, 61 biến động kho, ba chứng từ bán, sáu phần phân bổ, bốn khoản chi, 50 dòng thu nhập và số mong đợi. Hai PO mua CEM có ba lần nhận; không gọi ba lần nhận là ba đơn mua.
- `scenario-cases.json`: 24 nhánh X01–X24 với mốc khôi phục riêng, đầu vào và kết quả; điều kiện quyền/đồng thời là tiêu chí chờ kiểm trong ứng dụng.
- `employees.csv`: 50 người và cơ cấu/quan hệ quản lý, 17 vai trò tài khoản, kỹ năng, số dư phép, mức lương/phụ cấp.
- `attendance.csv`: 1.300 dòng người/ngày tháng 09/2026 giả lập, 26 ngày làm/208 giờ chuẩn.
- `labor-intervals.csv`: 76 khoảng trực tiếp; ngói 240 giờ, Terrazzo 30 giờ, không bao gồm thời gian sản phẩm chờ.

CSV dùng UTF-8, dấu phẩy, có tên cột; đơn vị phút và VND nằm trong tên cột. JSON lưu lượng/tiền chính xác của chứng từ; `expected` là chuẩn kiểm tra, **không phải số mà ứng dụng được phép lấy làm báo cáo cố định**. Mốc cuối là 05/10/2026 sau một khoản chi lương mẫu. Tệp thể hiện kết quả xác nhận; các hồ sơ nháp/duyệt/nhận chờ QC phải được dựng thành hành động khi lập trình theo tài liệu.

Các nhánh S03–S10 trong tài liệu là tình huống thử độc lập; đầu vào/kết quả kiểm có trong scenario-cases.json, chưa là sổ giao dịch đã thực hiện cho từng nhánh. Tạo bản sao tại mốc mô tả trước thao tác; kết quả chưa đủ chi phí phải giữ tạm tính, không lấy nguồn bộ chính bù sang nhánh. Trước lập trình sẽ ánh xạ cấu trúc này thành dữ liệu ứng dụng và bổ sung chứng từ theo chính sách được duyệt.

## Kiểm tra bộ mẫu

Chạy tại gốc dự án:

```bash
python scripts/verify-demo-data.py
```

Công cụ chỉ dùng thư viện Python chuẩn. Có thể truyền `--directory` tới bản sao của thư mục này để kiểm tra bộ thay đổi; không cần truy cập mạng hoặc bí mật. Nó tính lại công/lương, nguồn chi phí lô, lịch người/máy/chỗ giữ, lượng và giá trị theo từng biến động/lô, nghĩa vụ/thu/phân bổ/chi và số cuối, cùng phép tính ở các nhánh ngoại lệ có số lượng/tiền; dữ liệu không hợp lệ trả lỗi và mã thoát khác 0.

[Lịch sử kiểm tra](../build-history.md) ghi phiên bản được kiểm và giới hạn. Kiểm tra này không thay kiểm thử ERP về lưu dữ liệu, phân quyền, thao tác đồng thời hoặc tích hợp. Chưa có ứng dụng để chạy build/test phần mềm.
