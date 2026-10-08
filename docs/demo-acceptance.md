# Tiêu chí nghiệm thu nghiệp vụ demo ERP Nasaki

Tiêu chí này kiểm tra [quy tắc](demo-business-rules.md), [kịch bản](demo-scenarios.md) và [bộ dữ liệu](demo-data/baseline.json). **Đây là yêu cầu đề xuất để kiểm thử phần mềm sau này; chưa có ứng dụng để nghiệm thu.** Đối chiếu tệp dữ liệu hiện tại chỉ chứng minh tính nhất quán bộ mẫu. Quyền, thao tác đồng thời, lưu sau mở lại và chống ghi trùng phải được thử trên ứng dụng thật khi phát triển.

Mỗi lần kiểm ghi phiên bản bộ mẫu/mã ứng dụng, người/vai trò, mốc và thao tác đầu vào, kết quả thực tế, chứng từ nguồn, đạt/không đạt và lỗi còn lại. Không chỉ nhìn báo cáo cuối; kiểm trạng thái trung gian và hành động bị từ chối. Kết quả khớp số nhưng sai nguồn/người/quyền vẫn không đạt.

## Dữ liệu bắt buộc theo loại hồ sơ

Các trường dưới đây là nội dung nghiệp vụ phải có, chưa phải thiết kế bảng dữ liệu. Những bản ghi tổng trong fixture là kết quả mô phỏng; khi xây ứng dụng phải tạo đủ bước/hồ sơ sau.

| Hồ sơ | Nội dung tối thiểu | Điều kiện không được bỏ qua |
| --- | --- | --- |
| Danh mục/biến thể | Mã duy nhất, sản phẩm cha, mã khác, mẫu/màu/quy cách, đơn vị/độ chính xác, hiệu lực | Không nhập trùng mã, không gộp màu; bản đã dùng giữ lịch sử. |
| Đối tác | Nhóm, bên mua/chủ nghĩa vụ, người được xác nhận/đổi, bên trả/nhận, địa điểm và căn cứ đại diện | Trả thay không tự cấp quyền đổi đơn hoặc chuyển chủ nợ. |
| Báo giá/đơn | Chủ việc, kênh, phiên bản, dòng lượng/giá/giảm, thuế/phí được mô phỏng hay chưa, cọc/hạn/ngày, xác nhận khách và duyệt | Không ghi nhận bán từ đơn, không áp giá mới ngược bản đã chấp nhận. |
| Mẫu | Yêu cầu và mẫu phiên bản, lệnh mẫu, kết quả QC, lượng giữ/giao mẫu, đại diện khách/căn cứ duyệt | Mẫu không thu tiền không tự là bán; giám đốc không ký thay khách. |
| Lệnh/lô | Theo đơn/làm sẵn, BOM/lịch phiên bản, lượng bắt đầu/đạt/lỗi/chờ, người/nguồn lực, vật tư/công, quyết định xử lý | Không lấy tỷ lệ dự kiến sinh kết quả thực; đóng phải hết chờ và đủ nguồn chi phí. |
| Phiếu kho/giữ | Nguồn, lô, vị trí/trạng thái, lượng và quy đổi, sở hữu/điều kiện dùng, người thực hiện, thời điểm và lần xác nhận | Nháp/duyệt chưa làm tồn đổi; xuất kiểm tra lại khả dụng ngay lúc thực hiện. |
| QC/khóa/xử lý | Tiêu chí/mẫu phiên bản, phạm vi/lượng kiểm, số đo nếu có, đạt/lỗi/chờ và nguyên nhân, người kết luận, phương án/biên bản thực xử lý | Giữ nhận dạng/chất lượng riêng; khóa không tự tiêu hủy; mở khóa đúng quyền. |
| Mua/nhận/đối chiếu | Nhu cầu thiếu, nguồn cung, giá/đơn vị/quy đổi, lịch từng đợt, thực nhận/QC, chứng từ nghĩa vụ và hạn | Đơn mua không tự có tồn/nợ; tiền trả không nhập/cấp vật tư lần nữa. |
| Giao/bán | Lô/phiếu xuất, bên nhận/vận chuyển, thực rời/nhận/chấp nhận/từ chối, căn cứ, lượng đã ghi bán và giá vốn | Tổng ghi bán không vượt phần chấp nhận chưa được ghi trước; giữ phần tranh chấp. |
| Thu/chi/phân bổ | Tiền thực/số dư, bên trả/nhận, quỹ/tài khoản, nguồn nghĩa vụ, phần còn lại, người lập/duyệt/xác nhận | Không dùng cùng tiền/nợ hai lần; chuyển nội bộ không thành doanh thu/chi phí. |
| Công/phép/lương | Người/ngày/ca/khoảng, loại công/nguồn, người nhập/đối chiếu, phép đầu/giữ/dùng, chính sách hiệu lực, phiên bản công/lương, ứng và thực chi | Phân biệt làm/được hưởng lương/trực tiếp; chưa mô phỏng bắt buộc thì không gọi thực lĩnh. |
| Bàn giao/điều chỉnh | Nguồn và phiên bản, người giao/nhận/chủ việc, phần lượng/còn thiếu, ngày cần/tiếp nhận, bản cũ/mới, lý do, quyết định | Không mất nguồn/đổi bản âm thầm; chưa nhận không thành đã bắt đầu. |

## Điều kiện đạt cho bộ cơ sở

| Mã | Mốc hoặc thao tác kiểm | Kết quả bắt buộc |
| --- | --- | --- |
| A01 | Nạp danh mục/người/mốc đầu | Một công ty/xưởng/kho; 50 mã người khác nhau đúng cơ cấu, 17 vai trò tài khoản; mã khác không nhân bản sản phẩm. |
| A02 | Nạp lại cùng bộ/phiếu đầu | Không tăng số người, tiền, tồn hoặc chứng từ lần hai; mốc đầu vẫn đúng nguồn. |
| A03 | Mở lại/chuyển vai trò/chọn mốc cũ | Giao dịch còn lưu, số tại mốc đúng thời điểm; không dùng tồn/giữ hiện tại thay quá khứ. |
| A04 | Nhập 1,5 viên, 0 viên hoặc kg quá ba số thập phân | Không xác nhận; lỗi rõ đơn vị/dòng; không tự làm tròn mất lượng. |
| A05 | Tư vấn 100 m² ngói/50 m² Terrazzo dự phòng 5% | 1.050/329 viên; vẫn cần căn cứ quy cách và khách xác nhận; không tăng BOM thêm tỷ lệ tư vấn. |
| A06 | Duyệt N/cập nhật giá gốc mới | Đơn N giữ 18.000 × 10.000 = 180 triệu; duyệt đơn chưa biến động tồn/doanh thu. |
| A07 | Thu cọc N 60 triệu | Ngân hàng tăng đúng 60, ứng trước 60, doanh thu/phải thu 0. |
| A08 | Nhu cầu CEM N | 2.400 − (1.500 − 300) = 1.200 kg = 24 bao; không mua/cấp trùng 300 đã dành. |
| A09 | Nhận 14 rồi 10 bao | 700/500 kg; trước QC chưa khả dụng; sau lần đầu N còn thiếu 500; sau cả hai tổng 2.700. |
| A10 | Ghi nghĩa vụ/chi PO-N | AP 2,4 triệu có đối chiếu riêng; trả 1 còn 1,4; không nhập kho hoặc tính chi phí lần hai. |
| A11 | Chọn lượng bắt đầu N | Tối thiểu 7.143, lô đầy thành 8.000, dự kiến đạt 7.840/dư 840; không tự giao dư. |
| A12 | Lịch tám lô N | Đúng 07–10 tạo hình, 11/12/14/15 hoàn thiện; ba ngày làm việc chờ; tối đa hai lô/nguồn/ngày, không qua nghỉ Chủ nhật như ngày làm. |
| A13 | Nguồn lực/người/chỗ giữ | Ngói 240 giờ người, 60 giờ máy; T 30 giờ người, 10 giờ máy; không trùng người/máy hoặc chỗ giữ vượt 8.000. |
| A14 | Cấp/thực dùng/hoàn theo lô | Tổng N 2.400/7.200/120 kg và 960 lít; T 150/200/400/5 kg và 100 lít; không âm lô hoặc dùng phần dành khác. |
| A15 | QC N/T | Tổng 8.500 bắt đầu = 8.325 đạt + 175 lỗi thực tiêu hủy; có phạm vi kiểm/QC/DSP, không tự tính kết quả từ 98%/97%. |
| A16 | Chỉ duyệt DSP chưa thực hiện | Lượng lỗi vẫn nằm ở nơi quản lý; tổng vật lý chưa giảm; không báo đã tiêu hủy. |
| A17 | Nhập thành phẩm/ghi giá trị sau | N 7.840 và T 485 nhập mỗi nguồn một lần; ghi chi phí không nhập thêm lượng. |
| A18 | Xuất N đợt 1 trước khách nhận | Kho 4.840, giữ 4.000, khả dụng 840; kho giá trị 29,04 triệu, đang giao 36; chưa ghi doanh thu/giá vốn bán. |
| A19 | Chấp nhận và ghi bán đợt 1/phân bổ cọc | Doanh thu 108, phải thu 48, giá vốn 36 triệu; không xuất lần hai. |
| A20 | Thu 30 rồi bán đợt 2 | Phải thu 18 rồi 90 triệu; doanh thu 108 rồi 180; giao đủ chưa thu đủ. |
| A21 | Thu N 90/phân bổ | 18 vào SALE-N1, 72 vào SALE-N2; hết nợ, tổng thu 180; không cộng tiền hai lần khi phân bổ. |
| A22 | T làm sẵn và mua thêm CEM | Không có đơn khách tại lúc đề nghị lệnh T; mua riêng 150 kg; OTHER-001 giữ 300 nguyên vẹn. |
| A23 | T bán 400/cọc 4/thu 12 | Doanh thu 16 triệu; nợ sau bán 12 rồi 0; kho còn 85. |
| A24 | Chốt giá thành và giá vốn | N 47,04 triệu/7.840 = 6.000; T nguồn 4.354.167, bán 3.591.066, tồn 763.101; bảo toàn giá trị dù đơn giá hiển thị làm tròn. |
| A25 | Tổng báo cáo hai đơn | Doanh thu 196.000.000, giá vốn 63.591.066, lãi gộp 132.408.934; tồn giá trị 6.403.101; không gọi lãi ròng. |
| A26 | Tổng công tháng và E023 | 26 ngày/208 giờ; E023 192 làm/8 hưởng phép/8 không lương; không cộng nghỉ trưa. |
| A27 | Phép E023 duyệt/nghỉ/chốt | 4.800 đầu → giữ 480 → dùng 480, còn 4.320; không lương không trừ thêm. |
| A28 | Nguồn chi phí nhân công | Bảy người 72,8 triệu = N 12 + T 1,5 + khác 59,3; công trực tiếp không trùng/cộng vượt công thực. |
| A29 | Lương E023/ứng/trả | Thu nhập 8 triệu trước bắt buộc; ứng 1 và chi 7 không thành chi 9; không gọi thực lĩnh pháp lý. |
| A30 | Bảng 50 người và trạng thái duyệt | Tổng tính 493,36 triệu, còn chưa trả 485,36; dòng CEO chờ độc lập, không tự ghi cả bảng duyệt/đã trả. |
| A31 | Ngân hàng/tiền mặt cuối | 686,7 triệu / 0; đối chiếu tiền thực, không suy ra từ lãi gộp. |
| A32 | Công nợ và tuổi nợ | Nợ xi măng 1,4 triệu đến hạn 20/09, quá hạn từ 21/09; OH chưa trả 6 triệu riêng; không gộp với phải thu. |

## Ngoại lệ và thao tác phải bị ngăn

Mỗi dòng là nhánh độc lập; đầu vào số lượng cụ thể trong [S03–S10](demo-scenarios.md) hoặc mốc bên dưới.

| Mã | Điều kiện và thao tác | Kết quả bắt buộc |
| --- | --- | --- |
| X01 | S03 thiếu khách duyệt mẫu/cọc 500.000 chưa đủ 600.000 | Lệnh hàng loạt chờ; không cấp; chỉ rõ thiếu 100.000 hoặc thiếu mẫu, E001 không duyệt thay khách. |
| X02 | S03 mẫu/116 đạt/giao 100 | Mẫu tách lô/phiếu; chỉ 100 ghi bán 2,2 triệu, nợ sau cọc 1,6; 16 hàng riêng không thành hàng chuẩn; thiếu chi phí báo tạm tính. |
| X03 | S04 khách đổi V1 sang V2 | Giữ bản cũ và phần ảnh hưởng chờ; mẫu/giá/lịch bản mới cần xác nhận, tiền cọc chưa tự thành phí hủy. |
| X04 | S04 đã bắt đầu 30, còn 70 chưa làm | Vẫn còn 100 chưa giao; chi phí/thu hồi đánh giá có nguồn; không đảo hàng đã dùng hoặc tự giữ toàn cọc. |
| X05 | S05 khóa N-04 920 đang giữ | Tổng kho 4.840, được dùng 3.920, giữ hợp lệ 3.080, khả dụng 840; đơn thiếu 920, truy 60 đã giao. |
| X06 | S05 CEO duyệt giao từ lô khóa | Từ chối; chỉ QC có kết luận/đủ phương án mới giải phóng; thu hồi chưa về không tăng kho. |
| X07 | S06 thực nhận trả 500 trước QC | Tổng 1.340, dùng được vẫn 840; chưa tự hoàn tiền hoặc coi 500 đã đạt. |
| X08 | S06 QC/giảm bán/duyệt hoàn rồi thực hoàn | N thuần 171/57/114 triệu, tồn 1.340 trị giá 8,04; nghĩa vụ hoàn 9 triệu mở đến thực chi; ngân hàng 677,7 sau hoàn. |
| X09 | Xin nhận trả 190 sau đã nhận 20 từ lần xuất 200 | Không chấp nhận hợp lệ vượt phần còn 180; thực về nếu có phải cách ly, không che lượng. |
| X10 | S07 sửa công sau chốt | Bản cũ và chi cũ giữ; thêm 300.000 thu nhập/còn trả có duyệt; phép còn 3.840; chi bổ sung chưa duyệt/thực hiện chưa giảm tiền. |
| X11 | S08 nhận 700 có 100 lỗi | Chỉ 600 được dùng; N còn thiếu 600; phần lỗi không tự thành nghĩa vụ đã xác nhận/được cấp. |
| X12 | S08 nhận thừa 50 hoặc đợt 2 chậm | Thừa chờ quyết định; chậm chỉ làm phần đủ theo lịch mới; không xuất âm hoặc báo đủ theo đang về. |
| X13 | S09 thiếu E016/chờ máy | Không tự giữ 30 giờ/ngày như đủ bốn người, không dùng người thiếu kỹ năng; chờ máy không tự nghỉ không lương. |
| X14 | Ủy quyền E045 hết 05/09, thử duyệt 06/09 | Từ chối duyệt mới; không mất quyết định cũ; không mở quyền lương/hoàn tiền ngoài phạm vi. |
| X15 | S10 khách xuất khẩu chưa đủ điều kiện | Tiếp nhận/làm rõ được; không tự tỷ giá, thuế, hoàn tất xuất khẩu hoặc chứng từ thật. |
| X16 | Hai người giữ 300 khi chỉ 400 khả dụng | Chỉ một yêu cầu giữ đủ 300 thành công, còn 100; yêu cầu kia báo thiếu 200, không giữ âm. |
| X17 | Hai người phân bổ 60 triệu từ cùng cọc 60 | Tổng phân bổ không vượt 60; một yêu cầu sau phần đã dùng bị từ chối, không tăng tiền/nợ giảm trùng. |
| X18 | Bấm xác nhận lại xuất/thu/công/nhập | Một biến động, kết quả lần trước giữ nguyên; có nguồn/lịch sử, không nhân đôi. |
| X19 | Xuất sai màu, lô khóa/hết hạn giả lập | Không xác nhận; đổi lô chỉ sau kiểm tra phù hợp và lượng thực còn. |
| X20 | Đảo nhập đã có xuất/cấp hoặc sửa kỳ chốt | Không thực hiện khi chưa xử lý phụ thuộc/quyền; dùng điều chỉnh có nguồn/lý do, không sửa đè. |
| X21 | Tổ trưởng xem lương tổ/warehouse xem lương/access admin tự cấp quyền | Từ chối cả xem trực tiếp/xuất/truy qua liên kết; log không lộ lương/secret. |
| X22 | Người lập khoản chi/ứng/hoàn tự hưởng tự duyệt | Từ chối theo người thật; hai tài khoản cùng người không hợp thức hóa; CEO tự hưởng giữ kiểm tra độc lập. |
| X23 | Chi vượt số dư hoặc phân bổ nhầm khách | Không thực chi/phân bổ; tiền chưa rõ giữ chưa phân bổ, không bù chéo khách. |
| X24 | Mất kết nối khi xác nhận rồi gửi lại | Đối chiếu nguồn xác nhận đã có trước thử lại; không ghi giao dịch lần hai; lỗi không để tồn/tiền/công chỉ cập nhật một phần. |

## Điều kiện hoàn thành vòng chuẩn bị và vòng xây dựng

Vòng chuẩn bị đạt khi tệp đọc được, danh mục/nguồn/mốc rõ, đủ 50 người, công/lịch/vật tư/giá trị khớp, kịch bản hai nhóm có trạng thái trung gian và ngoại lệ, đề xuất mới có nhãn riêng. Kiểm tra số liệu bằng chương trình phải chạy từ dữ liệu nguồn, không chỉ so sánh các số kết quả được viết sẵn.

Vòng xây dựng chỉ đạt khi chạy được các hành động với vai trò thật của ứng dụng, lưu/mở lại, chọn mốc, xử lý ghi trùng/đồng thời/lỗi, ngăn hành động sai quyền và báo cáo truy được chứng từ. Bất kỳ lỗi nào gây tồn âm, dùng trùng tiền/công, mất lịch sử, mở lương trái quyền hoặc bỏ QC đều chặn nghiệm thu phần liên quan; không lấy số cuối khớp bù lỗi đó. Thuế/xuất khẩu/lương pháp lý phải thể hiện giới hạn như phạm vi đã ghi.
