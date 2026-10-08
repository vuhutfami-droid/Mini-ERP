# Yêu cầu chức năng ERP demo Nasaki

Theo B26 ngày 08/10/2026, chuyển [bộ quy tắc](demo-business-rules.md) và [kịch bản](demo-scenarios.md) thành yêu cầu có thể phát triển và nghiệm thu. Thiết kế dùng bộ mẫu V1 làm căn cứ minh họa; việc anh giao chuyển bước không tự xác nhận từng giá/lịch/dung sai/chính sách là thực tế Nasaki. Mọi lựa chọn đó tiếp tục có thể điều chỉnh. Giữ bảy phân hệ, một công ty/xưởng/kho và 50 nhân sự; kế toán chuyên sâu vẫn để sau.

Đọc [thiết kế màn hình](screen-design.md), [tiêu chí nghiệm thu](demo-acceptance.md) và [ma trận truy vết](design/traceability.csv). FR là yêu cầu chức năng, SC là loại màn hình; các tab/biểu mẫu dùng chung nằm trong loại màn hình, không tạo phân hệ hoặc cấp duyệt mới. Mỗi FR dưới đây có người dùng, sự kiện/đầu vào, hành vi/điều kiện, kết quả và nguồn nghiệm thu. Đây là đặc tả đề xuất, chưa là ứng dụng ERP đã triển khai.

## Nguyên tắc dùng chung

Mỗi hành động thay đổi chứng từ cần mã nguồn/phiên bản, người thật/đúng quyền, thời điểm thực và ghi nhận, trạng thái và căn cứ. Lưu nháp chưa ghi sổ; duyệt chỉ cho phép, xác nhận thực mới làm thay đổi dữ liệu thích hợp. Số liệu báo cáo tính từ giao dịch đã lưu theo mốc; không sử dụng expected trong fixture làm kết quả cố định. Nút bị ngăn phải cho người có quyền biết điều kiện thiếu và người xử lý, tránh chỉ hiện “không thành công”.

Tiền, lượng, giờ được kiểm lại ngay lúc xác nhận, không dùng số đã mở trên màn hình làm căn cứ duy nhất. Toàn bộ các cập nhật liên quan đến một hành động phải cùng thành công hoặc giữ nguyên; nhập lại cùng nguồn chỉ trả kết quả cũ. Các yêu cầu này phải có kiểm thử ứng dụng sau này, prototype bố cục không chứng minh đã đáp ứng.

## Danh sách yêu cầu chức năng

### FR01 Danh mục và số dư đầu

- **Người dùng:** Kho, HR, tài chính; giám đốc duyệt.
- **Sự kiện và đầu vào:** Mã sản phẩm/biến thể/mã khác, đơn vị/quy đổi, đối tác, 50 người; mốc/lô/tiền đầu.
- **Hành vi và điều kiện:** Kiểm trùng, đơn vị, hiệu lực và nguồn; xác lập một lần, nhận mã cũ đúng sản phẩm; hàng chưa đánh giá giữ chờ.
- **Kết quả:** Danh mục và số dư có phiên bản, không tạo mua/bán/sản lượng từ số dư đầu.
- **Màn hình:** SC03 SC04 SC17 SC22. **Nghiệm thu:** A01 A02 A04.

### FR02 Phiên làm việc và quyền

- **Người dùng:** Tất cả vai trò; E048 quản trị.
- **Sự kiện và đầu vào:** Đăng nhập, người thật/vai trò/phạm vi, phiên bản quyền.
- **Hành vi và điều kiện:** Kiểm quyền xem/lập/duyệt/xác nhận/điều chỉnh/xuất ở mọi truy cập; không dựa vào ẩn nút; ngừng quyền người nghỉ theo hiệu lực.
- **Kết quả:** Chỉ dữ liệu đúng phạm vi; từ chối an toàn, log không lộ lương; quản trị không tự cấp quyền cho mình.
- **Màn hình:** SC01 SC22. **Nghiệm thu:** X21 X22.

### FR03 Phê duyệt và ủy quyền

- **Người dùng:** Người giữ nguồn, giám đốc; người nhận ủy quyền.
- **Sự kiện và đầu vào:** Nguồn/phiên bản, loại quyết định, người lập/kiểm tra, phạm vi/thời hạn/giới hạn.
- **Hành vi và điều kiện:** Kiểm quyết định đúng bản, người thật khác người tự hưởng; không tự duyệt quá hạn, không ủy quyền tiếp; CEO tự hưởng chờ kiểm tra độc lập.
- **Kết quả:** Quyết định và lịch sử, đủ điều kiện đi bước sau; duyệt không tự ghi tồn/tiền/công thực.
- **Màn hình:** SC02 SC22. **Nghiệm thu:** X14 X22 A30.

### FR04 Bàn giao và việc cần xử lý

- **Người dùng:** Đầu mối từng nguồn và bên nhận.
- **Sự kiện và đầu vào:** Nguồn/bản, phần lượng, ngày cần, người giao/nhận, điều kiện thiếu.
- **Hành vi và điều kiện:** Bên nhận nhận/đề nghị bổ sung có lý do; nhận từng phần còn phần thiếu; cảnh báo theo mục tiêu thời gian, không tự nhận/duyệt.
- **Kết quả:** Danh sách việc theo người, nguồn và phần chờ; không nhập lại thành đơn khác.
- **Màn hình:** SC02 SC06 SC10. **Nghiệm thu:** A03 X03.

### FR05 Lưu và xác nhận an toàn

- **Người dùng:** Tất cả người có quyền ghi.
- **Sự kiện và đầu vào:** Nguồn duy nhất, bản đã đọc, hành động, thời điểm.
- **Hành vi và điều kiện:** Lưu nháp không ghi sổ; xác nhận kiểm lại quyền/tồn/phần tiền/công, ghi một lần toàn phần; dữ liệu đã đổi yêu cầu tải lại; mất trả lời đối chiếu trước thử lại.
- **Kết quả:** Giao dịch tồn/tiền/công và trạng thái liên kết nhất quán; mở lại thấy nguồn, không nhân đôi.
- **Màn hình:** SC02 SC09 SC11 SC14 SC18. **Nghiệm thu:** A02 A03 X16 X17 X18 X24.

### FR06 Điều chỉnh và khóa kỳ

- **Người dùng:** Bộ phận giữ chứng từ; giám đốc.
- **Sự kiện và đầu vào:** Chứng từ cũ/bản mới, lý do, phụ thuộc và kỳ.
- **Hành vi và điều kiện:** Không sửa đè/xóa bản xác nhận; kiểm phụ thuộc xuất/cấp/bán/trả/phân bổ; ghi điều chỉnh hiện tại, mở kỳ có quyết định riêng.
- **Kết quả:** Bản cũ/mới và chênh lệch có nguồn, không giả như giao dịch chưa từng xảy ra.
- **Màn hình:** SC02 SC09 SC14 SC19. **Nghiệm thu:** X20 X10.

### FR07 Tiếp nhận và tư vấn

- **Người dùng:** Kinh doanh.
- **Sự kiện và đầu vào:** Kênh, chủ việc, khách/đại diện, mẫu/quy cách, lượng hoặc diện tích.
- **Hành vi và điều kiện:** Ghi nhiều kênh cho cùng nhu cầu; tính viên có tham số/dự phòng/làm tròn lên; thiếu quy cách chờ xác nhận; phụ kiện là nhu cầu riêng; xuất khẩu thiếu điều kiện không tự quy đổi.
- **Kết quả:** Yêu cầu có đầu mối, dự toán lượng cần khách xác nhận; chưa tự thành đơn chắc chắn.
- **Màn hình:** SC04 SC05. **Nghiệm thu:** A05 X15.

### FR08 Báo giá và đơn

- **Người dùng:** Kinh doanh lập; giám đốc duyệt giá/đơn.
- **Sự kiện và đầu vào:** Ba bên mua/trả/nhận, căn cứ đại diện, dòng giá/giảm, cọc/hạn, mẫu/ngày, khách xác nhận.
- **Hành vi và điều kiện:** Tính chiết khấu một lần; đánh giá khả năng trước cam kết; giữ giá/bản đã duyệt, báo giá có hạn; hàng riêng cần mẫu khách; thuế chưa mô phỏng không ghi 0%.
- **Kết quả:** Đơn đúng bản; trạng thái cam kết/giao/tiền tách; còn thiếu điều kiện hiện rõ.
- **Màn hình:** SC05 SC06. **Nghiệm thu:** A06 X01.

### FR09 Mẫu hàng riêng

- **Người dùng:** Kinh doanh, sản xuất, QC; đại diện khách duyệt.
- **Sự kiện và đầu vào:** Yêu cầu/bản mẫu, lệnh mẫu, kết quả QC, giữ/giao mẫu và căn cứ khách.
- **Hành vi và điều kiện:** Tách mẫu khỏi lượng bán, xác minh khách có quyền; mẫu mới thay đổi phần hàng loạt phải duyệt lại; nội bộ không duyệt thay khách.
- **Kết quả:** Mẫu đúng phiên bản, điều kiện khởi động hàng loạt; thiếu chi phí mẫu giữ tạm tính.
- **Màn hình:** SC07 SC10 SC12. **Nghiệm thu:** X01 X02.

### FR10 Đổi hủy và quyết toán

- **Người dùng:** Kinh doanh giữ việc; sản xuất/kho/mua/tài chính kiểm; giám đốc và khách.
- **Sự kiện và đầu vào:** Bản yêu cầu mới, lượng chưa làm/đang làm/đã đạt/đã giao, vật tư/công/tiền.
- **Hành vi và điều kiện:** Tạm dừng an toàn phần ảnh hưởng; xét thu hồi/tái sử dụng/cam kết; không tự mất cọc/thu phí; bản mới cần quyết định và khách xác nhận.
- **Kết quả:** Cam kết mới và xử lý từng nguồn; còn chưa giao không bằng chưa làm; giữ lịch sử tiền/hàng cũ.
- **Màn hình:** SC06 SC07 SC16. **Nghiệm thu:** X03 X04.

### FR11 Thiếu hụt và giữ hàng

- **Người dùng:** Kinh doanh/sản xuất đề nghị, kho xác nhận.
- **Sự kiện và đầu vào:** Đơn/lệnh, biến thể/lô, đạt/khóa/dành và đang về đúng nhu cầu.
- **Hành vi và điều kiện:** Khả dụng = được dùng trừ đã dành; đang về không là tồn; giữ đủ hoặc yêu cầu riêng phần thiếu; chuyển ưu tiên có giám đốc duyệt, không cùng dùng một lượng.
- **Kết quả:** Giữ theo nguồn/lô không giảm tồn; gỡ phần không hợp lệ khi khóa/thiếu, nhu cầu thiếu vẫn còn.
- **Màn hình:** SC06 SC08 SC10. **Nghiệm thu:** A08 A11 X05 X16 X19.

### FR12 Kế hoạch nguồn lực

- **Người dùng:** Quản lý sản xuất, HR kiểm lịch; giám đốc duyệt cam kết/lệnh.
- **Sự kiện và đầu vào:** Đơn hoặc làm sẵn, BOM/rate/lô, vật tư, lịch máy/người/kỹ năng, chỗ giữ.
- **Hành vi và điều kiện:** Tách lượng đạt cần với bắt đầu; không tăng lỗi hai lần; tính ngày làm/chờ/đổi mẫu, không trùng máy/người hoặc vượt chỗ giữ; thay người phải đủ kỹ năng.
- **Kết quả:** Kế hoạch có căn cứ, ưu tiên và phụ thuộc; thiếu nguồn chờ/đổi lịch có tác động ngày giao.
- **Màn hình:** SC10 SC18. **Nghiệm thu:** A11 A12 A13 A22 X13.

### FR13 Thực hiện lệnh và công đoạn

- **Người dùng:** Tổ trưởng ghi; quản lý xác nhận.
- **Sự kiện và đầu vào:** Lô/bản yêu cầu, vật tư cấp/hoàn/thực dùng, khoảng thực làm, sản lượng/chờ.
- **Hành vi và điều kiện:** Chỉ khởi động khi nguồn duyệt/mẫu/cọc/vật tư đủ; tạo hình/chờ/hoàn thiện riêng; không lấy kế hoạch làm thực tế.
- **Kết quả:** Sản lượng đang làm/hoàn thành truy lô; đóng sau hết chờ/lỗi, nhập đạt và chi phí đủ; làm sẵn không cần đơn khách giả.
- **Màn hình:** SC10 SC11. **Nghiệm thu:** A14 A15 A22 X01 X13.

### FR14 Mua và theo dõi từng đợt

- **Người dùng:** Mua hàng; giám đốc duyệt.
- **Sự kiện và đầu vào:** Nhu cầu thiếu, nguồn cung, lượng/giá/đơn vị/quy đổi, ngày về/điều kiện.
- **Hành vi và điều kiện:** Không trừ đang về hai nhu cầu, không bắt ba báo giá mọi lần; sửa giá/lượng cần quyết định; nhận thiếu/lỗi/thừa ghi thực và xử lý riêng.
- **Kết quả:** PO và các đợt nhận/thiếu/đối chiếu; duyệt PO chưa có hàng/chi tiền/nợ xác nhận.
- **Màn hình:** SC08 SC09. **Nghiệm thu:** A08 A09 A10 A22 X11 X12.

### FR15 Nhận và hoàn trả kho

- **Người dùng:** Kho; QC; nguồn được duyệt.
- **Sự kiện và đầu vào:** PO/lệnh/phiếu gốc, lô/vị trí/quy đổi, thực nhận, lượng còn được trả.
- **Hành vi và điều kiện:** Nhận mua/trả tăng vật lý vào chờ kiểm tra; đạt mới dùng; nhận SX chỉ phần QC đạt một lần; trả NCC giảm khi thực rời; thiếu nguồn/thừa cách ly.
- **Kết quả:** Phiếu kho và bàn giao QC/tài chính; không tự ghi lại kho khi ghi nghĩa vụ/giá trị.
- **Màn hình:** SC09 SC11 SC12 SC16. **Nghiệm thu:** A09 A17 X07 X09 X11 X12.

### FR16 Cấp và đối chiếu vật tư

- **Người dùng:** Kho, sản xuất.
- **Sự kiện và đầu vào:** Lệnh/lô, vật tư nguồn, lượng cấp/hoàn/thực dùng/hao hụt.
- **Hành vi và điều kiện:** Ngăn âm và sai lô/đơn vị/hết hạn/khóa hoặc lấy hàng đã dành nguồn khác; cấp không tự là tiêu hao hết; hoàn đúng nguồn chưa dùng.
- **Kết quả:** Nhập xuất và lượng đang ở xưởng/thực dùng có nguồn chi phí; bảo toàn lượng.
- **Màn hình:** SC08 SC09 SC11. **Nghiệm thu:** A04 A14 X19.

### FR17 QC và khóa giải phóng

- **Người dùng:** Chất lượng.
- **Sự kiện và đầu vào:** Nguồn vật tư/lô/trả, tiêu chí/mẫu bản, lượng kiểm/đạt/lỗi/chờ, số đo/nguyên nhân.
- **Hành vi và điều kiện:** Đối chiếu lượng hoàn thành; không tự suy rộng mẫu/98%/97%; khóa ngay, chỉ QC giải phóng khi đạt và đủ phương án; kiểm lại khi soạn có lỗi mới.
- **Kết quả:** Kết luận theo phạm vi, phần được dùng và đơn thiếu; không tạo chứng nhận kỹ thuật thật.
- **Màn hình:** SC12 SC13. **Nghiệm thu:** A15 X05 X06.

### FR18 Xử lý lỗi tiêu hủy làm lại

- **Người dùng:** Sản xuất/QC đề nghị; giám đốc duyệt; kho/tổ thực hiện.
- **Sự kiện và đầu vào:** Phần lỗi/chờ, đánh giá, nguồn chi phí, phương án/lượng và biên bản.
- **Hành vi và điều kiện:** Duyệt chưa giảm lượng; thực xử lý đúng nơi đang giữ; làm lại có nguồn bổ sung và QC lại, không cùng lượng ở xưởng/kho; không tự phạt lương.
- **Kết quả:** Lỗi còn/đã xử lý và giá trị đúng căn cứ; không cộng lỗi thông thường lần hai.
- **Màn hình:** SC11 SC12 SC13. **Nghiệm thu:** A15 A16 A24 X02.

### FR19 Truy lô và thu hồi

- **Người dùng:** QC giữ việc; kho/sản xuất/kinh doanh phối hợp.
- **Sự kiện và đầu vào:** Phản ánh, lô, vật tư cấp, nhập và từng đợt giao.
- **Hành vi và điều kiện:** Chỉ rõ ở kho/đang làm/đang giao/đã giao; phương án thu hồi có giám đốc duyệt; yêu cầu thu hồi chưa là hàng về.
- **Kết quả:** Danh sách đối tượng/lượng bị ảnh hưởng, phần thu được và còn thiếu; không sửa lịch sử giao.
- **Màn hình:** SC13 SC16. **Nghiệm thu:** X05 X06.

### FR20 Kiểm kê xuất khác và cảnh báo

- **Người dùng:** Kho lập, người khác đối chiếu; giám đốc duyệt.
- **Sự kiện và đầu vào:** Phạm vi/mốc đếm, thực đếm, lý do chênh lệch; xuất mẫu/nội bộ/tiêu hủy.
- **Hành vi và điều kiện:** Ngừng hoặc đối chiếu giao dịch phần đếm; duyệt chênh rồi xác nhận điều chỉnh; giữ/vị trí không cộng tồn; cảnh báo không tự mua/giải phóng/tiêu hủy.
- **Kết quả:** Nhập xuất tồn theo mốc, chênh có nguồn, phân bổ bị thiếu được xử lý.
- **Màn hình:** SC08 SC09 SC02. **Nghiệm thu:** A03 A16 X16 X20.

### FR21 Đợt giao và khách nhận

- **Người dùng:** Kinh doanh/kho/giao hàng.
- **Sự kiện và đầu vào:** Đơn/bản, còn giao, lô đủ điều kiện, người nhận/địa chỉ/cọc; lượng thực xuất/nhận/chấp nhận/từ chối.
- **Hành vi và điều kiện:** Soạn chưa xuất; thực rời kho giảm và thành đang giao; nhận từng phần có chứng cứ; vượt lượng còn giao hoặc sai biến thể bị ngăn.
- **Kết quả:** Giao đúng từng đợt và phần tranh chấp; khách nhận không tự ghi bán hoặc thu tiền.
- **Màn hình:** SC06 SC09 SC16. **Nghiệm thu:** A18 A20 A23 X19.

### FR22 Ghi nhận bán và giá vốn

- **Người dùng:** Kế toán.
- **Sự kiện và đầu vào:** Đơn/bản giá, phần khách chấp nhận chưa ghi, giá trị đang giao.
- **Hành vi và điều kiện:** Ghi doanh thu/phải thu/giá vốn đúng phần, không xuất kho lần hai; không ghi bán từ cọc/duyệt đơn/phiếu xuất; tạm tính khi chi phí chưa đủ.
- **Kết quả:** Nghĩa vụ bán có hạn/người mua đúng; hàng đang giao chuyển giá vốn theo phần bán.
- **Màn hình:** SC14 SC16 SC15. **Nghiệm thu:** A19 A20 A23 A24.

### FR23 Thu cọc và phân bổ

- **Người dùng:** Người thu đối chiếu tiền; kế toán phân bổ.
- **Sự kiện và đầu vào:** Quỹ/tài khoản, thực thu/chứng cứ, bên trả/thay, đơn; nghĩa vụ/phần chưa dùng.
- **Hành vi và điều kiện:** Thu tăng tiền một lần, cọc chưa doanh thu; phân bổ đúng khách/nợ/tiền còn lại; thừa/chưa rõ để chưa phân bổ; không bù chéo khách.
- **Kết quả:** Phải thu/ứng trước và dòng tiền riêng, không phân bổ vượt khi đồng thời.
- **Màn hình:** SC14 SC06. **Nghiệm thu:** A07 A19 A21 X17 X23.

### FR24 Chi và nghĩa vụ mua

- **Người dùng:** Kế toán lập/kiểm; giám đốc duyệt; người chi thực hiện.
- **Sự kiện và đầu vào:** PO/nhận đạt/chứng từ, hạn; đề nghị chi/nguồn/quỹ/phần còn trả.
- **Hành vi và điều kiện:** Đối chiếu nghĩa vụ không tự từ PO; chi chỉ khi duyệt đủ và số dư; trả nhiều phần; không tự duyệt khoản mình hưởng.
- **Kết quả:** Thực chi và còn phải trả độc lập với tồn/tiêu hao; chưa trả vẫn mở nghĩa vụ.
- **Màn hình:** SC14 SC09 SC19. **Nghiệm thu:** A10 A29 A31 A32 X22 X23.

### FR25 Công nợ và quỹ theo mốc

- **Người dùng:** Tài chính/giám đốc; kinh doanh phần khách phụ trách.
- **Sự kiện và đầu vào:** Mốc, nghĩa vụ/hạn, ứng/chưa phân bổ, thực thu/chi.
- **Hành vi và điều kiện:** Ngày hạn chưa quá hạn; sau mới tính tuổi, phân nhóm; quỹ đầu + thực thu − thực chi; không gộp khác khách/NCC hoặc che nợ bằng ngân hàng.
- **Kết quả:** Báo phải thu/phải trả/quỹ và nguồn từng số, nợ đến hạn/quá hạn, phần phải hoàn riêng.
- **Màn hình:** SC01 SC14 SC21. **Nghiệm thu:** A03 A31 A32.

### FR26 Giá thành và lãi gộp

- **Người dùng:** Tài chính; quản lý phần tổng hợp được phép.
- **Sự kiện và đầu vào:** Vật tư thực dùng, công/nguồn lương, giờ máy/nguồn chung, lượng đạt/lỗi/WIP.
- **Hành vi và điều kiện:** Không vượt/cộng trùng nguồn; bình quân giữ độ chính xác và làm tròn chứng từ; lỗi thường theo căn cứ, chưa đủ nguồn giữ tạm tính.
- **Kết quả:** Nguồn giá thành → kho/đang giao/giá vốn; báo lãi gộp tách dòng tiền/lãi ròng và lương cá nhân.
- **Màn hình:** SC15 SC21 SC11. **Nghiệm thu:** A24 A25 A28 X02.

### FR27 Trả bán giảm hoàn giao bù

- **Người dùng:** Kinh doanh giữ việc; QC/kho/tài chính; giám đốc duyệt.
- **Sự kiện và đầu vào:** Lần giao/bán, còn được trả/điều chỉnh, thực về và QC, phương án tiền.
- **Hành vi và điều kiện:** Nhận trả tăng vật lý chờ; giảm bán/hoàn giá vốn theo căn cứ gốc, lỗi đánh giá riêng; nghĩa vụ hoàn mở đến thực trả; giao bù đúng phương án không tạo bán mới tùy tiện.
- **Kết quả:** Kho, doanh thu/nợ/phải hoàn và chi độc lập; không vừa hoàn vừa giao bù ngoài phương án.
- **Màn hình:** SC16 SC14 SC12. **Nghiệm thu:** X07 X08 X09.

### FR28 Hồ sơ và vòng đời người

- **Người dùng:** HR; quản lý đề nghị; giám đốc duyệt.
- **Sự kiện và đầu vào:** Người/bộ phận/quản lý/hiệu lực, hợp đồng, kỹ năng/an toàn, nhận/điều chuyển/nghỉ, đồ bảo hộ.
- **Hành vi và điều kiện:** Giữ một bộ phận chính/50 người; kiêm nhiệm không thêm đầu; kiểm kỹ năng, ngừng quyền/phân công đúng hiệu lực; PPE liên kết xuất nội bộ không xuất hai lần.
- **Kết quả:** Hồ sơ và lịch sử, bàn giao; không tự cấn tài sản vào lương; tuyển/thử việc mức cơ sở.
- **Màn hình:** SC17 SC18 SC22. **Nghiệm thu:** A01 X13 X21.

### FR29 Lịch và công thực tế

- **Người dùng:** Tổ trưởng/HR ghi; quản lý xác nhận.
- **Sự kiện và đầu vào:** Người/ngày/ca, khoảng/loại công, lệnh/công đoạn, nguồn nhập thay.
- **Hành vi và điều kiện:** Lịch không thành công; nghỉ trưa/thiếu giờ/đi muộn/đào tạo/chờ/OT riêng; không tự đủ ca hoặc phạt; trùng công/lệnh bị ngăn.
- **Kết quả:** Công đúng phạm vi, phần thiếu chờ xác minh; trực tiếp không vượt thực làm, chốt công có bản.
- **Màn hình:** SC18 SC11. **Nghiệm thu:** A13 A26 A28 X13 X18.

### FR30 Phép và phản hồi công

- **Người dùng:** Người lao động qua đầu mối; quản lý/HR.
- **Sự kiện và đầu vào:** Loại nghỉ, giờ theo lịch, số dư/giữ/dùng, người thay; căn cứ sửa.
- **Hành vi và điều kiện:** Phép đủ/đúng quyền mới giữ; thực nghỉ chuyển sang dùng không trừ đôi; không lương không trừ phép; sửa công sau chốt có duyệt/ảnh hưởng lương.
- **Kết quả:** Phép còn đúng, lịch không xếp người nghỉ; điều chỉnh phần đã trả được giữ lịch sử.
- **Màn hình:** SC18 SC19 SC02. **Nghiệm thu:** A27 X10 X13.

### FR31 Lương ứng và thực trả

- **Người dùng:** HR lập; tài chính kiểm; giám đốc duyệt đủ thẩm quyền; người chi.
- **Sự kiện và đầu vào:** Công/policy hiệu lực, thu nhập/phụ cấp, ứng/đã chi/phần còn, phiên bản.
- **Hành vi và điều kiện:** Thu nhập trước bắt buộc tách chưa mô phỏng; không tự khoản khấu trừ, không tự duyệt dòng CEO; chưa chốt thiếu nguồn tạm tính; chi không cộng chi phí lần hai.
- **Kết quả:** Phiếu cá nhân cả người không tài khoản; bảng tính/đã duyệt/đã trả riêng, nguồn công trực tiếp đối chiếu.
- **Màn hình:** SC19 SC20 SC14. **Nghiệm thu:** A28 A29 A30 X10 X21 X22.

### FR32 Báo cáo theo nguồn và mốc

- **Người dùng:** Giám đốc/từng bộ phận đúng quyền.
- **Sự kiện và đầu vào:** Mốc, loại báo, biến thể/lô/đơn/lệnh/người theo phạm vi.
- **Hành vi và điều kiện:** Tổng hợp giao dịch đã ghi, mở xuống nguồn; thiếu/không khớp không báo đã chốt; dữ liệu nhạy cảm và xuất kiểm quyền.
- **Kết quả:** Đơn thiếu/chờ; tồn/khóa; sản lượng, công, tiền/nợ, giá thành/lãi gộp; không dùng số expected làm báo cáo thật.
- **Màn hình:** SC01 SC21. **Nghiệm thu:** A03 A25 A31 A32 X21.

### FR33 Bộ demo và phản hồi giao diện

- **Người dùng:** Người trình diễn được giao quyền.
- **Sự kiện và đầu vào:** Bộ phiên bản, mốc mở đầu/ảnh chụp, nhánh riêng.
- **Hành vi và điều kiện:** Nạp một lần đúng chế độ, khôi phục chỉ bộ demo có quyền/giải thích phạm vi; trạng thái trống/đang tải/lỗi/mất mạng/không quyền giữ dữ liệu đã nhập.
- **Kết quả:** Demo thật sau phát triển lưu được giao dịch; mẫu thiết kế hiện tại chỉ xem bố cục, không giả đã xử lý nghiệp vụ.
- **Màn hình:** SC01 SC22. **Nghiệm thu:** A02 A03 X18 X24.

## Trạng thái và chuyển bước

| Nguồn | Trạng thái chính | Điều kiện và sự kiện ghi sổ |
| --- | --- | --- |
| Yêu cầu/báo giá/đơn | Tiếp nhận → dự thảo → chờ duyệt → xác nhận cam kết; có chờ điều kiện/đổi/hủy | Cần khách xác nhận và giám đốc đúng bản; chưa xuất/thu/bán chỉ từ duyệt. Giao và tiền là hai trạng thái phụ riêng. |
| Phiếu kho/chi/xử lý | Nháp → chờ duyệt nếu cần → được phép → xác nhận thực hiện | Kho xác nhận thực vào/ra, người chi xác nhận thực chi; duyệt không đổi lượng/tiền. Có điều chỉnh liên kết, không xóa bản đã ghi. |
| Mua | Dự thảo → duyệt/đặt → nhận từng phần/đủ; tiền riêng | Nhận chờ QC/đạt/lỗi từng phần; nghĩa vụ sau đối chiếu nguồn, không tự từ PO. |
| Lệnh/lô | Dự thảo → chờ duyệt/điều kiện → tạo hình → chờ → hoàn thiện → QC → nhập đạt/xử lý lỗi → đối chiếu/đóng | Công đoạn thực có thời điểm; QC phân phần, không một trạng thái toàn lô đạt khi còn chờ. Chi phí tạm tính/chốt riêng. |
| Giao/bán | Yêu cầu → soạn → thực rời/đang giao → nhận/chấp nhận từng phần → kế toán ghi bán | Phần từ chối còn theo dõi; ghi bán không xuất lần hai. |
| QC/xử lý | Chờ kiểm → kết luận theo phạm vi; khóa/mở khóa; phương án chờ duyệt/duyệt/thực xử lý | Có quyền khóa ngay; giải phóng QC có căn cứ, xử lý lượng chỉ khi thực thực hiện. |
| Công/phép/lương | Công ghi → quản lý xác nhận → HR chốt; phép đề nghị/giữ/dùng; lương nháp/kiểm/duyệt từng dòng/chi từng phần | Không tự đủ công/duyệt dòng CEO; công/lương/chi tách; chính sách thiếu giữ tạm tính. |

Từ chối/đề nghị sửa cần lý do; rút bản chưa thực hiện giữ dấu vết. Nguồn đã thực hiện không dùng nút hủy nháp: phải qua điều chỉnh/đổi hủy/nhận trả đúng loại. Chậm bàn giao hoặc người duyệt vắng không tự đi bước sau.

## Thứ tự phát triển đề xuất

Bốn phần triển khai theo phụ thuộc, không giảm phạm vi phiên bản đầu: (1) danh mục, người/quyền, chứng từ/nhật ký và số dư; (2) đơn–mua–kho–lệnh–QC–giao–tiền chạy xuyên hai nhóm; (3) nhân sự/công/phép/lương và đối chiếu nguồn chi phí trong luồng; (4) ngoại lệ, báo cáo/chốt/điều chỉnh và thử nghiệm ghi trùng/đồng thời/mất kết nối. Ngoại lệ ngăn âm/sai quyền/bỏ QC là điều kiện ngay từ khi xây giao dịch, không chờ phần cuối mới bảo vệ.

Chưa ấn định ngày triển khai, công nghệ, số người đồng thời, thời gian đáp ứng hoặc chi phí hosting. Đề xuất đầu tiên tối ưu máy tính cho dữ liệu nhiều cột, điện thoại dùng ghi nhận/xem việc theo phạm vi; điều kiện vận hành và sao lưu/khôi phục sẽ được cụ thể hóa ở thiết kế kỹ thuật. Không tự chọn thêm tích hợp ngân hàng, hóa đơn thật, Zalo hoặc máy chấm công.

## Căn cứ dữ liệu tinh gọn B29

[Thiết kế hiện hành](database-design.md) và [rà soát vận hành](database/optimization-review.md) thay cấu trúc 91 bảng bằng 74 bảng, giữ phạm vi B26. Biểu mẫu nguồn nối phiếu kế tiếp và chỉ yêu cầu dữ kiện mới; dòng/đầu/liên kết ghi trong cùng thao tác, không mở bảng để nhập lại. Nhập hoặc nhập khẩu công theo nhóm có nguồn/xác nhận, ngoại lệ cần xử lý rõ; không mặc định đủ công. Quyền theo loại/cột của bảng gộp; trạng thái nháp/chờ nguồn/đã xác nhận phải phân biệt. Bản mẫu HTML hiện có vẫn minh họa, chưa thực hiện các hành vi ghi/đọc này.
