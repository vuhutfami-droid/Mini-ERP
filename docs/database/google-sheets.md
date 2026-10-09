# Bộ Google Sheets theo cấu trúc cơ sở dữ liệu B29

Yêu cầu ngày 09/10/2026: tạo thư mục **Mini ERP** và các Google Sheets đúng cấu trúc đã duyệt. Nguồn là thiết kế B29 tại commit `3e6fc6f`: 74 bảng, 931 trường, 402 quan hệ, 43 điều kiện loại nguồn. Không thay thiết kế, tạo DB/server hoặc lập trình ERP.

[Thư mục Mini ERP](https://drive.google.com/drive/folders/1z-KakfciWnvpaas1hcN8fNPOYi3aHj5S) · [File tổng quan — bắt đầu ở đây](https://docs.google.com/spreadsheets/d/1l32ds-6ReFtPUcZARHTc5Utcb3ediihUi3DI2dr3Lqc/edit?usp=drivesdk) · [Danh sách máy đọc và ánh xạ bảng](google-sheets.json).

## Cách tổ chức

12 file Google Sheets gốc: một file tổng quan, 11 file theo 11 nhóm lưu trữ của thiết kế. Có **74 trang tính dữ liệu** tương ứng đúng 74 bảng và **28 trang tài liệu**, tổng 102 trang tính. Tài liệu không thêm bảng vào cơ sở dữ liệu. Một file phân hệ có `Huong_dan`, `Tu_dien` và các trang tính tên bảng không có tiền tố nhóm; tên đầy đủ được ghi trong danh mục/từ điển.

| File | Nhóm lưu trữ | Bảng dữ liệu |
| --- | --- | ---: |
| [00 - Mini ERP - Tổng quan cấu trúc B29](https://docs.google.com/spreadsheets/d/1l32ds-6ReFtPUcZARHTc5Utcb3ediihUi3DI2dr3Lqc/edit?usp=drivesdk) | `overview` | 0 |
| [01 - Dùng chung - Mini ERP B29](https://docs.google.com/spreadsheets/d/1YWeoHhrVMRcXCPI0wN8ig_2YRhxpY_fnedTitmFCRYY/edit?usp=drivesdk) | `dung_chung` | 17 |
| [02 - Truy cập và phân quyền - Mini ERP B29](https://docs.google.com/spreadsheets/d/1lXsxcC3y9tEE2KRSCHXgjFAlP244ieTJYL7_F_aITf0/edit?usp=drivesdk) | `truy_cap` | 8 |
| [03 - Danh mục - Mini ERP B29](https://docs.google.com/spreadsheets/d/167jzG-c2CIC2rMxLkmTkr9QO8HVdoV9WyHrCSLR-DMc/edit?usp=drivesdk) | `danh_muc` | 3 |
| [04 - Kinh doanh - Mini ERP B29](https://docs.google.com/spreadsheets/d/1y3HQZPXuye-an0MDrQ_JUrkwSEtd95d_fbxzf3u-XPM/edit?usp=drivesdk) | `kinh_doanh` | 5 |
| [05 - Mua hàng - Mini ERP B29](https://docs.google.com/spreadsheets/d/1qRWBg7jnn6hwok-aWz6O9g17LBibQWytUT5Wgjbimmw/edit?usp=drivesdk) | `mua_hang` | 2 |
| [06 - Kho - Mini ERP B29](https://docs.google.com/spreadsheets/d/1n5-6CGTP9GnETnN8tLEU3bpdIOZiKkt4FgZmQUxo7BQ/edit?usp=drivesdk) | `kho` | 6 |
| [07 - Sản xuất - Mini ERP B29](https://docs.google.com/spreadsheets/d/11p6j0PrKWbXyEX78GNBVwSOB-RUwVb5VQcEEdcyTC80/edit?usp=drivesdk) | `san_xuat` | 7 |
| [08 - Chất lượng - Mini ERP B29](https://docs.google.com/spreadsheets/d/10XNoVERDGW2VvD4ugJJOLPlAzWP8W17JT8PENqbOj7Q/edit?usp=drivesdk) | `chat_luong` | 2 |
| [09 - Giao hàng - Mini ERP B29](https://docs.google.com/spreadsheets/d/1CwoK41PDePmZhXYWcThOu4igNFMu1hqn2no2S8D_4aw/edit?usp=drivesdk) | `giao_hang` | 2 |
| [10 - Tài chính - Mini ERP B29](https://docs.google.com/spreadsheets/d/12ad4EFhIo1enOJuNQhHMoVkDSrLVFslDEgoskA-NpMw/edit?usp=drivesdk) | `tai_chinh` | 13 |
| [11 - Nhân sự - Mini ERP B29](https://docs.google.com/spreadsheets/d/13kgfQtiMFrBQ0Jd4Rd3oobP1KhR8WrKZ9U5T6d6NW2o/edit?usp=drivesdk) | `nhan_su` | 9 |

## Cách đọc và sử dụng

- File tổng quan có `Danh_muc_bang` dẫn tới đúng file/trang tính, `Quan_he` giữ 402 liên kết, `Loai_nguon` giữ 43 điều kiện, `Cau_truc_dong` giữ bảy cấu trúc JSON và giới hạn tham số, `Bao_phu` giữ ma trận FR/SC/tiêu chí.
- Mỗi trang dữ liệu: hàng 1 là đúng tên trường và thứ tự trong fields.csv; ghi chú từng cột có nhãn/mô tả/nguồn/đích liên kết. Không thêm cột phụ, số tổng hoặc hàng giải thích vào dữ liệu.
- `Tu_dien` có đủ 931 mô tả theo bảng, gồm kiểu gốc, giá trị đóng, căn cứ, người phụ trách và điều kiện ghi. `Huong_dan` của từng file giữ mục đích, trách nhiệm nhập và ràng buộc đầy đủ theo bảng.
- Có 100 hàng trống sẵn trong mỗi bảng Sheets; đây là chỗ nhập dự kiến, không phải 100 bản ghi nghiệp vụ. Không nạp bộ mẫu B25/B28, không cài dữ liệu đạt QC/đã duyệt/đủ công/tiền hoặc mã nguồn giả.
- 111 cột phân loại có danh sách chọn đóng; 25 cột ngày dùng bộ chọn ngày DATE. Ngày hiển thị `dd/MM/yyyy` theo ngôn ngữ Việt của Google Sheets; khi trao đổi với DB dùng ngày chuẩn `YYYY-MM-DD`. Cột mốc có múi giờ giữ văn bản ISO 8601 để không mất múi giờ. Cột số chính xác giữ văn bản trong mẫu để tránh mất chữ số/làm tròn do Sheets; kiểu số và độ chính xác thực vẫn theo từ điển, mẫu chưa có phép tính ERP.
- Tiêu đề được cố định, có cảnh báo khi sửa hàng tên cột; từ điển có lọc. Cảnh báo không là cơ chế phân quyền DB. Không thay thiết lập chia sẻ hoặc mở công khai file.

## Bằng chứng và giới hạn

Đã đọc lại metadata Drive, tên/ID trang tính, tất cả ô tài liệu đã ghi, hàng tên trường/ghi chú và metadata native table. Đối chiếu đủ 12 file/74 bảng/931 trường và mô tả, 402 liên kết/43 điều kiện, các lựa chọn đúng nguồn, 25 định dạng ngày và không có dòng giao dịch cài sẵn. Kiểm tra định dạng/kiểu qua API; chưa xem render trong trình duyệt vì chưa có công cụ hiển thị Google Sheets được xác thực.

Các Sheets là mẫu lưu trữ cấu trúc và tài liệu. Google Sheets chưa thực thi khóa ngoại, quyền theo dòng/cột, bất biến sau duyệt, giao dịch nguyên tử, chống ghi lặp/đồng thời hoặc logic tính toán ERP. Không coi tạo các file này là xây xong cơ sở dữ liệu vận hành. Git tiếp tục là nguồn thiết kế có phiên bản; sửa cấu trúc Sheets cần đối chiếu lại thiết kế, không tự đồng bộ hoặc tự đổi DB.
