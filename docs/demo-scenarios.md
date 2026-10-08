# Kịch bản nghiệp vụ và kết quả đối chiếu demo Nasaki

Các tình huống dưới đây dùng [quy tắc V1](demo-business-rules.md) và [dữ liệu giả lập](demo-data/baseline.json). Ngày, người, chứng từ và kết quả là dữ liệu demo. S01 và S02 cùng một bộ cơ sở, dùng chung tồn vật tư, tháng công và tiền; các nhánh còn lại phải mở bản sao đúng mốc để không làm sai báo cáo cơ sở. Kết quả là chuẩn cần kiểm chứng khi xây phần mềm, chưa phải kết quả ứng dụng đã chạy.

## S01 Đơn ngói từ báo giá đến giao và thu tiền

E002 giữ SO-N-001: đại lý CUSTOMER-N đặt 10.000 FP04-GREY-D1, PAYER-N trả thay có PAY-ON-BEHALF-N, RECEIVER-N nhận cho công trình. Giá gốc 20.000, giảm 10% được E001 duyệt thành 18.000/viên; tổng 180 triệu chưa mô phỏng thuế. Điều kiện cọc 60 triệu trước sản xuất; hạn trả từng đợt 15 ngày sau chấp nhận. Khách đã xác nhận phiên bản giá/điều kiện; E013 đánh giá vật tư và lịch trước hứa giao.

| Mốc giả lập | Người thực hiện và nguồn | Kết quả cần đối chiếu |
| --- | --- | --- |
| 01/09 | E009 xác nhận OPEN-20260901 sau QC/tài chính/E001 | 3.000 ngói đạt trị giá 18 triệu; CEM 1.500 kg, 300 đã dành OTHER-001, còn 1.200 khả dụng. Không phát sinh doanh thu hoặc mua mới. |
| 02/09 | E002 lập, E013 kiểm tra, E001 duyệt SO-N-001; khách xác nhận | Đơn đúng giá/lượng/ngày, giữ 3.000 ngói, còn cần 7.000 đạt; chưa xuất/chưa ghi bán. |
| 03/09 | E046 đối chiếu BANK-CASH-N1 và ghi nhận 60 triệu | Ngân hàng 560 triệu; ứng trước N 60 triệu, doanh thu/phải thu 0. E044 xác nhận điều kiện cọc đủ. |
| 04/09 | E007 lập PO-CEM-N được E001 duyệt; E009 nhận 14 bao; E041 QC | Thực nhận 700 kg; trước QC chờ, sau đạt CEM 2.200 tổng, 300 dành khác, 1.900 dùng cho N, vẫn thiếu 500 cho cả tám lô. |
| 05/09 | Nhận 10 bao, QC đạt; E044 đối chiếu AP-N; E001 duyệt MO-N-001 | CEM 2.700, dành 2.400 cho N và 300 cho OTHER-001, khả dụng mới 0. AP-N 2,4 triệu hạn 20/09; chưa tự chi. Lệnh 8.000 bắt đầu, không 7.000 bắt đầu. |
| 07–10/09 | E009 cấp theo từng lô; E014 ghi thực tế; E013 xác nhận công | Cấp N tổng CEM 2.400, SAND 7.200, COAT 120 kg, WATER 960 lít. Không lấy 300 CEM dành khác; không nhân tỷ lệ lỗi vào định mức lần hai. |
| 11–15/09 | E041 QC từng lô, E001 duyệt xử lý, E014 thực tiêu hủy; E009 nhập đạt | Tám lô × 980 = 7.840 đạt; 160 lỗi đã thực xử lý ở xưởng, không thành hàng bán. Cộng tồn cũ 3.000 có 10.840; giữ 7.000 mới cho đơn, 840 dư. |
| 16/09 trước khách nhận | E009 thực xuất DEL-N-01 6.000; E011 theo dõi đang giao | Kho còn 4.840, đã dành còn 4.000, khả dụng 840. Giá trị kho 29,04 triệu; đang giao 36 triệu. Doanh thu vẫn 0 nếu chưa chấp nhận/ghi bán. |
| 16/09 sau khách nhận | RECEIVER-N chấp nhận; E044 ghi SALE-N1 108 triệu, phân bổ cọc 60 | Phải thu đợt 1 là 48 triệu, không 120; ứng còn 0, giá vốn 36 triệu, đơn chưa giao 4.000. |
| 16/09 thu tiếp | E046 ghi CASH-N2 30 triệu; E044 phân bổ SALE-N1 | Phải thu 18 triệu, doanh thu vẫn 108; không xuất kho lần hai. |
| 17/09 | Xuất DEL-N-02 4.000; khách chấp nhận; E044 ghi SALE-N2 72 triệu | Tồn 840, giữ đơn 0; doanh thu lũy kế 180 triệu; phải thu 18 + 72 = 90; giao đủ nhưng chưa thu đủ. |
| 18/09 | E046 ghi CASH-N3 90 triệu; E044 phân bổ 18 cho SALE-N1, 72 cho SALE-N2 | N hết phải thu/ứng chưa dùng; tổng thu 180 triệu; cả giao và tiền hoàn tất. |
| 19/09 | Chi PAY-SUP-N được E001 duyệt, E046 thực trả 1 triệu | AP-N còn 1,4 triệu; không tăng vật tư, không cộng chi phí N thêm 1 triệu. |
| Chốt nguồn công/chi phí | E047/E045 đối chiếu công/lương; E044 tập hợp chi phí, E001 duyệt nguồn đủ điều kiện | Vật tư 30,04 + công 12 + chung 5 = 47,04 triệu; 7.840 đạt → 6.000/viên. Trước nguồn đủ chỉ tạm tính. |

### Lịch tám lô và giờ công có căn cứ

| Lô | Tạo hình | Ba ngày làm việc chờ | Hoàn thiện và QC | Ca trong ngày | Đạt / lỗi | Giờ trực tiếp |
| --- | --- | --- | --- | --- | ---: | ---: |
| N-01, N-02 | 07/09 | 08, 09, 10/09 | 11/09 | N-01 sáng; N-02 chiều | Mỗi lô 980 / 20 | Mỗi lô 30 |
| N-03, N-04 | 08/09 | 09, 10, 11/09 | 12/09 | N-03 sáng; N-04 chiều | Mỗi lô 980 / 20 | Mỗi lô 30 |
| N-05, N-06 | 09/09 | 10, 11, 12/09 | 14/09 | N-05 sáng; N-06 chiều | Mỗi lô 980 / 20 | Mỗi lô 30 |
| N-07, N-08 | 10/09 | 11, 12, 14/09 | 15/09 | N-07 sáng; N-08 chiều | Mỗi lô 980 / 20 | Mỗi lô 30 |

Mỗi công đoạn/lô ngói: E016–E019 cùng làm 3 giờ 45 phút, tổng 15 giờ người; tạo hình và hoàn thiện có 30 giờ/lô, tám lô 240 giờ. Máy chạy tổng 16 × 3,75 = 60 giờ, không 240 giờ. Mỗi người có 7,5 giờ trực tiếp vào tám ngày này, còn 0,5 giờ/ngày hỗ trợ; không trùng hai lô hoặc giờ nghỉ trưa. Chỗ giữ tăng 2.000 mỗi ngày tạo hình, cao nhất 8.000; hoàn thiện giải phóng đúng phần thực xong, không tự coi ba ngày chờ thành giờ công. Các ngày khác có công hỗ trợ/việc khác, không tự gán hết tháng vào N.

Nguồn cấp CEM theo lô: N-01–N-04 dùng 1.200 OPEN-CEM; N-05–N-06 dùng 600 BUY-CEM-N1; N-07 dùng 100 BUY-CEM-N1 và 200 BUY-CEM-N2; N-08 dùng 300 BUY-CEM-N2. OPEN-CEM còn 300 giữ OTHER-001, đúng nguồn. Vật tư cấp từ ngày tạo hình nhưng lượng chờ/tiêu hao được đối chiếu theo lô; không gán COAT đã cấp thành đã phủ nếu công đoạn chưa làm.

Mỗi lô có QC 1.000 viên ngoại quan, 980 đạt, 10 lỗi màu và 10 vỡ; DSP- tương ứng có E013 lập, E041 kiểm tra, E001 duyệt, E014 thực xử lý trong ngày hoàn thiện. Hồ sơ giả lập ghi từng kết luận; không dùng tỷ lệ 2% tạo kết quả thay QC.

### Lấy lô vật lý và bảo toàn giá trị

Đợt 1 lấy OPEN-FP04-GREY-D1 3.000, N-01/02/03 mỗi 980, N-04 60 → 6.000. Đợt 2 lấy N-04 920, N-05/06/07 mỗi 980, N-08 140 → 4.000. Cuối còn N-08 840. Từng phần giữ theo đơn và giảm khi thực xuất, không lấy cùng lô hai lần vượt lượng.

Giá trị nguồn 18 triệu đầu + 47,04 triệu nhập mới = 65,04 triệu. Sau ghi bán cả hai đợt: 60 triệu giá vốn + 5,04 triệu kho = 65,04 triệu; đang giao cuối 0. Lãi gộp N = 180 − 60 = 120 triệu, chưa trừ chi phí khác. Giá trị lỗi thông thường đã nằm trong nguồn phân bổ cho hàng đạt; không ghi thêm 160 × 6.000 chi phí lần hai.

## S02 Terrazzo làm sẵn rồi bán có nguồn chi phí đầy đủ

S02 nối cùng bộ cơ sở sau N, không lấy vật tư đã dành OTHER-001. E013 lập MO-T-001 làm sẵn một lô 500, E001 duyệt ngày 15/09; thời điểm đó chưa có đơn T. Đề xuất tồn mục tiêu 1.000 không buộc sản xuất đủ 1.000 ngay: lệnh làm thử 500 được duyệt và ghi lý do, phần còn lại chờ đánh giá.

| Mốc | Nguồn và người | Kết quả |
| --- | --- | --- |
| 16/09 trước tạo hình | PO-CEM-T 3 bao được E001 duyệt; E009 nhận, E042 QC đạt | Tăng 150 kg/300.000 đồng; chỉ 150 khả dụng cho T, 300 cũ vẫn dành khác. AP-T ghi riêng hạn 01/10. |
| 16/09 | E009 cấp T-01; E015 ghi; E013 xác nhận | CEM 150, SAND 200, STONE 400, PIGMENT 5 kg, WATER 100 lít. N và T không cấp trùng lượng đầu. |
| 17,18,19/09 | Lô chờ theo lịch | 500 đang làm; chưa là thành phẩm được giao. Chỗ giữ còn đủ, không có giờ trực tiếp chỉ vì đang dưỡng hộ. |
| 21/09 | E020–E022 hoàn thiện; E042 QC; E001 duyệt loại bỏ; E015 thực xử lý | 500 hoàn thành → 485 đạt và 15 lỗi thực tiêu hủy; E009 nhập 485, không 500. |
| 21/09 sau nhập | E003 lập SO-T-001 400 × 40.000, E001 duyệt, khách xác nhận; thu 4 triệu | Bán từ tồn làm sẵn, giữ 400, khả dụng 85; cọc 4 triệu chưa là doanh thu. |
| 22/09 | E009 xuất DEL-T-01; khách chấp nhận, E044 ghi bán/phân bổ | Doanh thu 16 triệu, giá vốn 3.591.066; phải thu 12 triệu sau cọc. Tồn 85 giá trị 763.101. |
| 24/09 | Thu/phân bổ CASH-T2 12 triệu | T hết phải thu, tiền thu đủ 16 triệu. |
| 25/09 | Chi PAY-SUP-T 300.000 | AP-T về 0; không giảm số CEM đã được cấp lần nữa. |

E020–E022 mỗi người làm 5 giờ ngày 16/09 và 5 giờ ngày 21/09: 3 người × 5 giờ × 2 ngày = **30 giờ người**, bằng 1.800 phút; nguồn 50.000/giờ cho 1.500.000 đồng. Máy tạo hình 5 giờ và hoàn thiện 5 giờ, tổng 10 giờ máy. Phần công còn lại hỗ trợ/việc khác, không vào T-01. Lịch một lô không vượt giờ người/máy hoặc chỗ giữ chung.

Vật tư T: CEM 300.000 + SAND 300.000 + STONE 1.200.000 + PIGMENT 50.000 + WATER 4.167 = 1.854.167 đồng. Cộng nhân công 1.500.000 và chi phí chung 1.000.000 thành **4.354.167**; không làm tròn đơn giá trước chia giá trị giữa bán và tồn.

## Kết quả chung của S01 và S02

| Chỉ tiêu tại mốc 05/10/2026 17:00 | Kết quả mong đợi | Căn cứ |
| --- | ---: | --- |
| Ngói đạt còn tại kho | 840 viên / 5.040.000 đồng | 3.000 + 7.840 − 10.000; còn lô N-08. |
| Terrazzo đạt còn tại kho | 85 viên / 763.101 đồng | 485 − 400; giá trị nguồn 4.354.167 − 3.591.066. |
| CEM tại kho | 300 kg / 600.000 đồng | 1.500 + 700 + 500 + 150 − 2.400 − 150. |
| CEM dành / khả dụng | 300 / 0 kg | OTHER-001 vẫn có hiệu lực, chưa thực hiện. |
| SAND/COAT/STONE/PIGMENT/WATER | 0 | Dùng đúng tổng tồn đầu cho cả hai luồng, không cấp vượt. |
| Đang làm/chờ/lỗi cần xử lý cuối | 0 trong cơ sở | 8.500 bắt đầu → 8.325 đạt + 175 đã thực tiêu hủy. |
| Thành phẩm đang giao cuối | 0 | Cả ba đợt được khách chấp nhận và tài chính ghi bán. |
| Doanh thu / giá vốn / lãi gộp hai đơn | 196.000.000 / 63.591.066 / 132.408.934 đồng | Ngói 180/60/120 triệu; T 16.000.000/3.591.066/12.408.934. |
| Phải thu / ứng trước chưa dùng cuối | 0 / 0 | Thu N 180 triệu và T 16 triệu, phân bổ đúng ba nghĩa vụ. |
| Phải trả xi măng | 1.400.000 đồng | AP-N 2,4 triệu − 1 triệu; AP-T 0,3 triệu trả đủ. |
| Chi phí xưởng đã xác nhận chưa trả | 6.000.000 đồng | Hai nguồn OH đã phân bổ, chưa có thực chi; theo dõi riêng. |
| Thu nhập trước khoản bắt buộc đã tính | 493.360.000 đồng | Đủ 50 người/công/chính sách; dòng CEO 26,5 triệu chưa tự duyệt. |
| Thu nhập trước khoản bắt buộc còn chưa trả | 485.360.000 đồng | Chỉ E023 đã ứng/chi tổng 8 triệu; không gọi toàn bộ là lương đã duyệt/phải trả pháp lý. |
| Ngân hàng cuối / quỹ tiền mặt | 686.700.000 / 0 đồng | 500 triệu + 196 triệu − 1 triệu − 0,3 triệu − ứng 1 triệu − chi E023 7 triệu. |

Giá trị kho cuối 5.040.000 + 763.101 + 600.000 = **6.403.101 đồng**. Nguồn kho đầu 47.794.167 + mua 2.700.000 + nhân công trực tiếp 13.500.000 + chung 6.000.000 = 69.994.167; trừ giá vốn 63.591.066 bằng 6.403.101. Chuyển vật tư tới sản xuất và thành phẩm không cộng giá trị mới ngoài nguồn; không cộng cả chi phí lô lẫn từng thành phần lô thêm lần nữa. Đây là đối chiếu giá trị quản trị trong phạm vi này, không là bảng cân đối kế toán đầy đủ.

Nguồn bảy người E016–E022: 72,8 triệu = trực tiếp N 12 + T 1,5 + hỗ trợ/việc khác 59,3 triệu. Đã tính trong tổng thu nhập tháng; không ghi 13,5 triệu thêm như một khoản trả lương độc lập. Nợ xi măng chưa trả 1,4 triệu quá hạn từ 21/09; ngày 20/09 còn là đến hạn. Nợ khách cuối 0 không chứng minh tại mọi mốc trước đó cũng 0.

### S03 Đơn ngói màu riêng và duyệt mẫu

**Nhánh độc lập từ tồn đầu**, không cộng vào S01/S02. Dùng FP04-CUSTOM-D1, E002 giữ SO-C-001 của CUSTOMER-C, đại diện REP-C có quyền duyệt mẫu theo ủy nhiệm khách giả lập. Khách đặt 100 viên giá 22.000, cọc 600.000 trước hàng loạt; tổng 2,2 triệu. E001 duyệt giá/đơn, E013 đánh giá nguồn lực; mẫu cần duyệt trước lệnh hàng loạt.

1. Yêu cầu CUSTOM-REQ-V1 ghi màu/mẫu/quy cách, người khách xác nhận. Lệnh mẫu SAMPLE-C-01 được duyệt riêng tạo hai viên; QC xác nhận hai đạt. Mẫu và chi phí tách khỏi 100 viên bán, chưa tự giảm lượng còn giao hoặc ghi doanh thu.
2. Kho giao một mẫu bằng phiếu xuất mẫu được duyệt, giữ một mẫu đối chiếu. Lưu REP-C xác nhận CUSTOM-SAMPLE-V1, ngày và căn cứ mô phỏng. Giám đốc duyệt nội bộ không thay REP-C. Chi phí mẫu còn tạm tính nếu thiếu công/chi phí chung; không tự lấy chi phí hàng loạt để coi mẫu đã được định giá.
3. Sau tiền cọc thực nhận, khách duyệt đúng mẫu và E001 duyệt lệnh, đề xuất lô cuối 120 viên bắt đầu, có lý do lượng dư. BOM giả lập tỷ lệ 120/1.000: CEM 36, SAND 108, COAT 1,8 kg, WATER 14,4 lít; không lấy định mức của màu khác nếu chưa xác nhận bản riêng BOM-C-V1. Bản riêng ở nhánh giữ hệ số giống N chỉ để mô phỏng, không khẳng định màu thật dùng cùng công thức.
4. Lịch nhánh: chuẩn bị đổi màu nửa ca 04/09, tạo hình 07/09, chờ 08–10/09, hoàn thiện 11/09. Ghi giờ chuẩn bị thực tế và nguồn chi phí; không tự áp 50.000/giờ cho mọi người nếu không có nguồn. QC toàn bộ 120 theo bản mẫu: kết quả nhập giả lập 116 đạt, 4 lỗi; xử lý/nhập như cơ sở. Giữ/giao đúng 100, còn 16 hàng riêng, không chuyển thành ngói xám tiêu chuẩn.
5. Khi khách chấp nhận 100 và tài chính ghi bán 2,2 triệu, phân bổ 0,6 triệu → phải thu 1,6 triệu. Thu/phân bổ đủ 1,6 → hết nợ. Mẫu không thu tiền không tạo doanh thu. Giá thành/lãi gộp của nhánh vẫn tạm tính cho tới khi đủ nguồn mẫu/chuẩn bị/hàng loạt; không áp đơn giá 6.000 của ngói chuẩn.

**Điều kiện đạt:** Thử khởi động thiếu REP-C duyệt hoặc cọc mới 500.000 phải giữ chờ, chưa cấp hàng loạt; không được “duyệt thay” bằng E001. Sau đủ điều kiện mới chạy. Kết quả chi phí chưa đầy đủ phải thể hiện tạm tính; đây là một kết quả đúng, không ép mọi đơn có lãi đã chốt.

### S04 Khách đổi hoặc hủy hàng riêng sau chuẩn bị

Bản sao S03 sau đã duyệt mẫu/cọc nhưng trước cấp hàng loạt: khách đổi CUSTOM-REQ-V1 thành V2. E002 xác minh REP-C có quyền; E013 giữ chờ phần liên quan, E007/E009 đối chiếu vật tư đã mua/dành, E044 đối chiếu tiền/chi phí. V1 giữ lịch sử, không dùng tiếp cho phần thay đổi. Làm mẫu V2 và xác nhận lại; giá/ngày/chi phí mới cần E001 duyệt và REP-C đồng ý. Không tự thu phí hủy hoặc mất cọc.

Nhánh sau đã bắt đầu 30 trong 100 viên cam kết: ghi 30 đang làm, 70 chưa làm, chưa giao 100; vật tư/công thực có nguồn riêng. Không gọi 70 là toàn bộ chưa giao hoặc coi 30 đã đạt nếu chưa QC. Phương án quyết toán: chi phí có chứng cứ − giá trị thu hồi/tái sử dụng, trách nhiệm và mức khách chấp nhận; nếu chưa thống nhất giữ 600.000 ứng trước/chờ quyết toán, không tự thành doanh thu. Sau duyệt hủy, giải phóng vật tư chưa cấp đúng phần; vật tư đã cấp/hàng đang làm có phương án riêng, không đảo hàng đã dùng thành chưa dùng.

### S05 Khóa lô đang giữ và truy nơi đã giao

Bản sao S01 sau giao đợt 1, trước đợt 2: N-04 còn 920, toàn bộ đã dành cho SO-N-001; N-04 đã giao 60 cho RECEIVER-N. E041 phát hiện nghi vấn và khóa phần còn 920; tổng kho 4.840 không đổi, lượng được dùng còn 3.920, giữ hợp lệ cho đơn còn 3.080, khả dụng 840; nhu cầu đơn thiếu 920. Không báo đã giữ đủ 4.000.

Truy nguồn phải hiện N-04 dùng OPEN-CEM 300, SAND 900, COAT 15 kg, WATER 120 lít; đợt DEL-N-01 đã giao 60. Phần 60 chưa về không cộng lại kho. E013/E002 đánh giá thay thế: 840 khả dụng cùng biến thể chỉ bù được 840, còn thiếu 80; chuyển giữ có quyết định đúng quyền. Không tự lấy hàng khóa để giữ ngày giao. E041 kiểm tra lại đạt và đủ điều kiện phương án mới được bỏ khóa; giám đốc không bỏ khóa bằng duyệt giao gấp.

### S06 Trả bán và hoàn tiền sau đã thu đủ

Bản sao sau S01/S02 hoàn tất, chỉ thay đổi đơn N: khách trả 500 từ DEL-N-02; E001 duyệt nhận trả/giảm bán, không giao bù. E009 thực nhận về CC-01 một lần, trước QC kho ngói tổng 1.340 nhưng được dùng vẫn 840. E041 kiểm tra toàn bộ 500 đạt; E044 điều chỉnh đúng bán gốc 500 × 18.000 = 9 triệu và hoàn giá vốn 3 triệu. Ngói tồn đạt 1.340 trị giá 8,04 triệu, doanh thu thuần N 171, giá vốn N 57, lãi gộp N 114 triệu.

N đã thu đủ nên nghĩa vụ hoàn 9 triệu vẫn mở cho tới E046 thực hoàn sau E001 duyệt. Chỉ mới duyệt hoàn thì ngân hàng cơ sở vẫn 686,7 triệu; sau thực hoàn còn 677,7 triệu. Cả hai đơn doanh thu thuần 187 triệu, giá vốn 60.591.066, lãi gộp 126.408.934. Nhận trả không giảm tiền tự động; không xuất/nhập lần hai khi kế toán điều chỉnh. Nếu 500 trả có lỗi thì không dùng các số định giá hàng đạt này: giá trị chờ/giảm cần phương án riêng.

### S07 Nhân sự phép ứng và sửa công

Dùng E023, người không có tài khoản: E014 ghi thay, người quản lý đúng quyền xác nhận, E047 đối chiếu. Ngày 22/09 nghỉ hưởng lương 480 phút: phép trước 4.800, sau duyệt giữ 480/khả dụng 4.320; sau thực nghỉ giữ 0/đã dùng 480/khả dụng vẫn 4.320. Ngày 23/09 nghỉ không lương không trừ phép. Tháng làm 192 giờ, hưởng lương 200; thu nhập trước khoản bắt buộc 8 triệu, ứng thực nhận 1 triệu rồi chi minh họa 7 triệu còn 0.

Nếu sửa nghỉ không lương thành nghỉ hưởng lương sau chốt: E023 đề nghị có căn cứ, không tự xác nhận; quản lý/HR kiểm tra phép, E001 duyệt ảnh hưởng nguồn lương theo thẩm quyền. Thu nhập tăng 300.000 thành 8,3 triệu, vì 7.800.000/208 × 8 = 300.000; chi cũ 8 triệu giữ nguyên, phát sinh phần bổ sung 300.000 trước khoản bắt buộc nếu phương án đủ căn cứ. Phép tăng dùng thêm 480, còn 3.840; chỉ sau thực chi bổ sung tiền mới giảm. Không sửa bảng cũ thành như đã trả đủ 8,3 triệu.

### S08 Nhận thiếu lỗi thừa hoặc trả vật tư mua

Bản sao trước nhận PO-CEM-N; ghi thực nhận, không sửa đơn để che thiếu.

| Tình huống độc lập | Kết quả cần thấy | Người giữ việc |
| --- | --- | --- |
| Đợt đầu 14 bao nhưng 2 bao lỗi | Thực nhận 700 kg; đạt 600, lỗi 100 cách ly. CEM được dùng 2.100, đã dành khác 300 → còn 1.800 cho N, thiếu 600 so nhu cầu 2.400. Nghĩa vụ cho phần lỗi chưa đủ căn cứ không tự ghi toàn 1,4 triệu. | E007 phối hợp E009/E041/E044. |
| Sau tổng 24 bao lại giao thêm 1 bao | Thực nhận thừa 50 kg vào chờ xử lý; không tăng khả dụng/nghĩa vụ tự động. E001 quyết nhận thêm đúng giá/điều kiện hoặc trả. | E007. |
| Trả 2 bao lỗi thực rời kho | Giảm tồn vật lý 100 một lần; điều chỉnh nghĩa vụ hoặc khoản cần hoàn theo phần đã đối chiếu, không tự giảm chi phí N chưa hề dùng phần lỗi. | E009 xuất, E007/E044 theo dõi. |
| Đợt 2 chậm từ 05 sang 09/09 | Tại mốc trước 09 chỉ có 1.900 cho N; tối đa sáu lô đầy 1.800 kg nếu các vật tư/người/chỗ đủ. Hai lô còn thiếu phải đổi lịch và đánh giá giao; không cấp âm. | E013/E007/E002. |

### S09 Thiếu người chờ máy và ủy quyền

Bản sao trước tạo hình 07/09: E016 nghỉ cả ca. Ba người còn lại mỗi ngày hai lô chỉ tạo 3 × 7,5 = 22,5 giờ người; không ghi 30 giờ như đủ bốn. E023 không có kỹ năng vận hành nên không tự thế chỗ. E013 lập lịch/nhu cầu thay đủ kỹ năng, đánh giá vật tư/máy/ngày giao; nếu chưa có người thì phần bị ảnh hưởng chờ hoặc giảm số lô theo phương án.

Nhánh chờ máy độc lập: E017 ca có 6 giờ trực tiếp và 2 giờ chờ xác nhận; công có mặt 8, trực tiếp 6. Phần chờ không tự bị coi nghỉ không lương; nếu chính sách chưa rõ thu nhập tạm tính. Máy dừng không tự sinh hàng đạt hoặc tăng giờ người trực tiếp.

E001 vắng: có thể lập đề nghị và QC khóa ngay, việc duyệt cần quyền thì chờ. Nhánh ủy quyền giả lập chỉ cho E045 duyệt PO-CEM-N tối đa 2,4 triệu từ 04 đến hết 05/09, cấm ủy quyền tiếp; không cho duyệt hoàn tiền/lương hoặc đọc thêm lương. Ngày 06/09 duyệt mới bị từ chối; quyết định hợp lệ ngày 05 giữ lịch sử. Nếu E045 là người hưởng khoản thì không dùng quyền này tự duyệt.

### S10 Các trạng thái chưa đủ và tiếp nhận khách xuất khẩu

Nhận yêu cầu từ CUSTOMER-X qua email: E002 ghi nhóm xuất khẩu, số viên/mẫu, đại diện khách, nơi giao và đồng tiền dự kiến. Thiếu điều kiện giao/ngoại tệ/thuế/chứng từ thì yêu cầu ở trạng thái cần làm rõ; không tự quy đổi tỷ giá hoặc phát hành chứng từ xuất khẩu. Đây là tình huống tiếp nhận có kết quả thực, không phải xuất khẩu hoàn chỉnh. CUSTOMER-P và CUSTOMER-C có thể là người mua/nhận riêng; tạo nhu cầu không tự tạo tồn/công nợ.

Một đơn không đủ giá/mẫu/cọc/ngày có căn cứ phải hiện rõ điều kiện còn thiếu và người xử lý. Báo cáo lợi nhuận không hiển thị đã chốt khi chi phí còn thiếu. Giao một phần khách chỉ chấp nhận một phần phải giữ phần còn đang giao/tranh chấp; không ghi doanh thu toàn lượng phiếu xuất.

## Cách trình diễn và đánh giá giá trị số hóa

Chọn mốc, người thao tác và nguồn; người trình diễn thực hiện thay đổi rồi mở lại để xem kết quả. Chỉ ra dữ liệu đi tiếp qua bàn giao, không nhập lại đơn ở mỗi bộ phận. Đo bằng việc hoàn thành tình huống và số chứng từ khớp, không tuyên bố giảm bao nhiêu phần trăm thời gian/chi phí khi chưa có dữ liệu trước chuyển đổi số.

Người quản lý thấy đơn còn thiếu gì, tồn dùng được, hàng bị khóa, lệnh đang chờ, công nợ và khoản chưa trả. Tổ trưởng thấy phần mình ghi và điều kiện còn thiếu; kế toán có chứng từ nguồn; người lao động nhận phiếu cá nhân. Các quyết định chậm vẫn có người giữ việc, không biến trạng thái đẹp thành kết quả đúng.
