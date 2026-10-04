# Hồ sơ nghiệp vụ demo ERP Nasaki

Hồ sơ này lưu bối cảnh, quyết định nghiệp vụ và các điểm cần khảo sát để xây dựng demo ERP phục vụ tư vấn cho Nasaki. Demo phải chạy được, lưu các giao dịch và tạo kết quả kiểm chứng được. Hiện đã xác định phạm vi tổng quát và mô hình doanh nghiệp; chưa hoàn thành khảo sát quy trình, chưa thiết kế tính năng hoặc chọn công nghệ.

Chủ dự án cung cấp nhu cầu và xác nhận nghiệp vụ; Codex phụ trách phân tích, hệ thống hóa và thực hiện phần kỹ thuật được giao. Lịch sử trao đổi và nguồn website đã tiếp nhận nằm trong [README](../README.md). Hồ sơ này là bản tổng hợp hiện hành, không thay thế nhật ký.

Ngày cập nhật: 04/10/2026, múi giờ Asia/Bangkok.

## Cách phân loại thông tin

- **Anh xác nhận cho demo:** Yêu cầu hoặc mô hình dùng để xây dựng demo; không tự coi là số liệu thực tế của Nasaki.
- **Anh cung cấp về hiện trạng:** Thông tin thực tế theo mô tả của anh; chưa được khảo sát độc lập.
- **Website theo nội dung anh gửi:** Tuyên bố của nguồn công khai, chưa được Codex truy cập hoặc kiểm chứng độc lập.
- **Đề xuất của Codex:** Phương án để thảo luận; chưa tự trở thành quyết định nghiệp vụ.
- **Chưa rõ:** Cần hỏi thêm; không tự điền bằng suy đoán.

## Mục tiêu và hiện trạng

Người xem demo gồm chủ doanh nghiệp và các bộ phận liên quan, bao gồm quản lý sản xuất, kế toán và các bộ phận khác. Anh muốn thể hiện khả năng số hóa, chuyển đổi số tất cả công việc có thể trong doanh nghiệp. Mục tiêu rộng này cần được cụ thể hóa thành kết quả nghiệp vụ và tình huống kiểm chứng ở các vòng khảo sát tiếp theo.

Theo thông tin anh cung cấp, hoạt động hiện tại chủ yếu quản lý thủ công và bằng Excel, phụ thuộc nhiều vào kinh nghiệm; quy trình còn sơ sài, mức độ chuyển đổi số ít. Chưa có số liệu để định lượng thời gian xử lý, tỷ lệ sai sót, tổn thất hoặc xác định ba vấn đề ưu tiên riêng biệt. Không coi các giả thuyết khó khăn trong README là kết luận đã được xác nhận.

## Các quyết định đã xác nhận

| Mã | Nội dung hiện hành | Nguồn và giới hạn |
| --- | --- | --- |
| B01 | Demo phục vụ tư vấn, thực sự chạy và tạo kết quả; chưa phải triển khai vận hành chính thức cho Nasaki. | Anh xác nhận mục đích dự án. |
| B02 | Người xem gồm chủ doanh nghiệp và tất cả các bộ phận liên quan. | Anh trả lời câu khảo sát 1. |
| B03 | Mục tiêu là số hóa, chuyển đổi số tất cả công việc có thể. | Anh xác nhận; chưa có thước đo nghiệm thu chi tiết. |
| B04 | Phạm vi phiên bản đầu gồm kinh doanh, mua hàng, kho, sản xuất, chất lượng, tài chính và nhân sự. | Anh trả lời câu 3; đây là phạm vi nghiệp vụ, chưa xác định độ sâu của từng phần. Không tự chuyển tài chính hoặc nhân sự sang giai đoạn sau. |
| B05 | Mô hình demo có 1 công ty, 1 xưởng, 1 kho, 50 nhân sự; tổ chức tinh gọn. | Anh trả lời câu 4; không suy ra 50 tài khoản hoặc 50 người sử dụng đồng thời. |
| B06 | Có cả ngói và Terrazzo. Đơn vị quản lý sản phẩm là viên. | Anh trả lời câu 5; chưa quy định đơn vị nguyên vật liệu, quy đổi đóng gói hoặc bán hàng theo diện tích. |
| B07 | Các mã khác nhau trên các trang website được hỏi là cùng sản phẩm. | Anh xác nhận; không áp dụng cho mọi sản phẩm hoặc mọi biến thể màu/kích thước chưa khảo sát. |
| B08 | Sản xuất kết hợp: làm sẵn để tồn kho và sản xuất theo đơn. | Anh trả lời câu 6; chưa có quy tắc quyết định sản xuất, ưu tiên hoặc giữ hàng. |
| B09 | Có nhận màu hoặc quy cách riêng cho khách. | Anh trả lời câu 6; chưa rõ duyệt mẫu, số lượng tối thiểu, giá và thời gian thực hiện. |
| B10 | Tiếp tục đào sâu nghiệp vụ trước khi đi vào tính năng; dữ liệu nghiệp vụ phải được hệ thống hóa và lưu để dùng khi phát triển. | Yêu cầu mới nhất của anh. |

Các mã B01–B10 giúp tham chiếu quyết định khi bổ sung quy trình và tiêu chí nghiệm thu; không phải mã tính năng hoặc danh sách công việc lập trình.

## Quy mô và tổ chức

Quy mô demo một kho thay thế đề xuất trước đây về kho vật tư và kho thành phẩm riêng. Không tạo thêm kho dưới danh nghĩa diễn giải đề xuất cũ.

**Đề xuất của Codex:** Trong cùng một kho, có thể phân biệt vật tư, thành phẩm, hàng chờ kiểm tra và hàng lỗi bằng khu vực hoặc trạng thái hàng. Đề xuất này giữ nguyên một kho; cách bố trí và quy tắc sử dụng còn cần anh xác nhận qua nghiệp vụ.

**Đề xuất của Codex:** Khảo sát trách nhiệm theo vai trò quản lý, kinh doanh, mua hàng, kho, kế hoạch/sản xuất, chất lượng, tài chính/kế toán và nhân sự. Một người có thể kiêm nhiệm nhiều vai trò trong mô hình tinh gọn. Chưa chốt số phòng ban, phân bổ 50 nhân sự, quyền truy cập hoặc người duyệt.

Năng lực sản xuất ngói 5,5 triệu viên/năm là thông tin website công bố trong nội dung anh gửi. Không dùng công suất này để suy ra năng suất ca, sản lượng thực tế hoặc năng lực của mô hình demo khi chưa có lịch làm việc và quy trình sản xuất.

## Sản phẩm và mã tham chiếu

Ngói và Terrazzo là hai nhóm sản phẩm đã được chọn. Chưa xác định chính xác mẫu, màu, kích thước, tiêu chuẩn chất lượng hoặc danh mục vật tư cho từng nhóm.

| Tên sản phẩm theo nguồn | Các cách ghi mã anh xác nhận là cùng sản phẩm | Việc còn cần làm rõ |
| --- | --- | --- |
| Ngói phẳng trơn vát Nasaki | FV-02 / PV-02 | Chọn mã chính thức để tham chiếu và lưu mã còn lại như tên gọi khác. |
| Ngói phẳng giả đá Nasaki | FD-02 / FĐ-02 | Chọn mã chính thức; làm rõ màu, quy cách nếu ảnh hưởng việc phân biệt hàng. |
| Ngói lợp chính | AD 0211 / AD 02 | Chọn mã chính thức và xác nhận quy cách sản phẩm. |
| Ngói phẳng Nasaki | FP-04 / FP - 04 | Làm thống nhất cách viết mã; không tự tạo hai sản phẩm chỉ do dấu cách. |

Việc cùng sản phẩm không có nghĩa mọi màu, kích thước hoặc lô sản xuất được thay thế cho nhau. Đây là điểm cần khảo sát, chưa phải quy tắc đã chốt. Danh mục sản phẩm từ website trong README chưa được coi là danh mục chuẩn hoàn chỉnh.

## Cách ghi nhận nghiệp vụ

Mỗi quy trình sẽ được ghi đủ các nội dung sau bằng ngôn ngữ nghiệp vụ:

- Mục đích và sự kiện bắt đầu.
- Người thực hiện, người quyết định và bên nhận bàn giao.
- Thông tin/chứng từ đầu vào và điều kiện để bắt đầu.
- Các bước hiện tại, thứ tự và điểm bàn giao giữa bộ phận.
- Kết quả đầu ra, trạng thái công việc và điều kiện hoàn tất.
- Quy tắc quyết định, phê duyệt, thay đổi và xử lý ngoại lệ.
- Khó khăn, ảnh hưởng có căn cứ và cách làm mong muốn.
- Tình huống cụ thể, kết quả mong đợi và nguồn xác nhận.

Phân biệt cách làm hiện tại với cách làm mong muốn. Khi anh chưa biết hiện trạng, Codex có thể đưa ra quy trình demo đề xuất để anh xem xét, nhưng phải ghi rõ trạng thái đề xuất. Không biến mô tả quy trình thành danh sách màn hình hoặc chức năng khi anh chưa yêu cầu bước đó.

## Lộ trình khảo sát nghiệp vụ tiếp theo

| Thứ tự đề xuất | Nhóm nghiệp vụ | Nội dung cần hiểu |
| --- | --- | --- |
| 1 | Tiếp nhận nhu cầu và chốt đơn | Khách hàng, thông tin yêu cầu, xác định giá, đơn tiêu chuẩn/đặt riêng, cam kết và phê duyệt. |
| 2 | Kế hoạch và sản xuất | Cách quyết định làm hàng sẵn/theo đơn; công đoạn riêng cho ngói và Terrazzo, vật tư, định mức, nhân công, năng lực và ưu tiên. |
| 3 | Chất lượng và kho | Điều kiện hàng đạt, hàng lỗi, truy lô, nhập/xuất/kiểm kê và bố trí trong một kho. |
| 4 | Mua hàng | Nhu cầu mua, lựa chọn nhà cung cấp, phê duyệt, nhận hàng và công nợ mua. |
| 5 | Giao hàng và tài chính | Giao từng đợt, trả hàng, thu/chi, đặt cọc, công nợ, giá thành và mức độ kế toán cần mô phỏng. |
| 6 | Nhân sự và quản trị | Cơ cấu 50 nhân sự, ca làm, chấm công, nghỉ phép, cách tính lương, kiêm nhiệm và phân quyền/phê duyệt. |

Đây là thứ tự khảo sát đề xuất, không phải thứ tự triển khai hoặc thay đổi phạm vi B04. Các điểm giao giữa nhóm sẽ được làm rõ cùng nhau, không khảo sát từng bộ phận tách rời.

## Câu hỏi vòng tiếp theo về tiếp nhận nhu cầu và chốt đơn

Nhóm này đào sâu quyết định nghiệp vụ. Anh có thể mô tả cách làm hiện tại và cách mong muốn; nếu chưa có thông tin, ghi "chưa rõ" để em đề xuất mô hình demo.

1. **Khách hàng:** Khách thường là đại lý, nhà thầu/chủ dự án, khách lẻ hay khách xuất khẩu? Ai là người đặt, ai thanh toán và ai nhận hàng; có trường hợp ba bên khác nhau không?
2. **Tiếp nhận yêu cầu:** Khách liên hệ qua ai/kênh nào? Để tư vấn và báo giá, người bán cần biết những thông tin gì về sản phẩm, màu, kích thước, số lượng, nơi giao và thời điểm cần hàng? Có trường hợp khách chỉ đưa diện tích mái/sàn để mình tính số viên không?
3. **Xác định giá:** Giá lấy từ bảng giá hay tính riêng theo đơn? Những yếu tố nào làm giá thay đổi như số lượng, loại khách, màu/quy cách riêng hoặc vận chuyển? Ai có quyền quyết định giá và giảm giá?
4. **Chốt đơn:** Khi nào doanh nghiệp coi đơn đã được chấp nhận: khách đồng ý báo giá, ký xác nhận, đặt cọc hay sau người quản lý duyệt? Ai xác nhận và bàn giao đơn cho bộ phận tiếp theo?
5. **Cam kết giao hàng:** Trước khi hứa ngày giao, ai kiểm tra hàng có sẵn, hàng đã dành cho đơn khác, vật tư và khả năng sản xuất? Khi nhiều đơn cùng cần hàng mà không đủ, ưu tiên theo quy tắc nào và ai quyết định?
6. **Đơn đặt riêng:** Màu/quy cách riêng được xác nhận bằng mẫu hay mô tả? Có làm mẫu và duyệt trước khi sản xuất số lượng lớn không? Nếu khách đổi yêu cầu hoặc hủy sau khi đã chuẩn bị/sản xuất, ai quyết định và chi phí xử lý thế nào?

Chưa có câu trả lời cho nhóm này. Các tình huống trong câu hỏi là hướng khảo sát, không phải nghiệp vụ Nasaki đã được xác nhận.

## Các điểm còn mở

- Mẫu, màu, kích thước và quan hệ biến thể; mã chuẩn của sản phẩm có nhiều cách viết.
- Nhóm khách hàng và quy tắc nhận đơn, giá, cam kết giao, đặt riêng, thay đổi và hủy.
- Công đoạn, định mức và đơn vị vật tư; cách tính nhu cầu, hao hụt, năng lực và ưu tiên sản xuất.
- Chất lượng, xử lý hàng lỗi, truy lô; quy tắc giữ hàng và bố trí một kho.
- Mua, nhận/trả hàng; giao nhiều đợt, thanh toán và công nợ.
- Giá thành, kế toán, thuế, ngoại tệ và phạm vi tài chính cụ thể.
- Phân bổ nhân sự, ca/chấm công/nghỉ phép/lương; kiêm nhiệm và quyền/phê duyệt.
- Tình huống thực tế và số liệu thể hiện mức độ ảnh hưởng của khó khăn; các chỉ số để đánh giá chuyển đổi số.
- Bộ dữ liệu demo, mức sử dụng đồng thời, cách đối tác dùng thử, mốc trình diễn và chi phí vận hành.

## Quy tắc duy trì hồ sơ

Khi có câu trả lời mới, cập nhật phần hiện hành của hồ sơ và ghi lại trao đổi trong README. Quyết định mới thay thế đề xuất cũ phải được chỉ rõ, không xóa lịch sử để che mất thay đổi. Chỉ bổ sung quy tắc và kết quả nghiệp vụ có nguồn; các đề xuất giữ nhãn đề xuất đến khi được xác nhận.

Khi đi vào thiết kế và phát triển, dùng các quyết định và quy trình đã xác nhận để lập yêu cầu, tiêu chí nghiệm thu và kiểm tra kết quả. Không coi việc có hồ sơ này là đã hoàn thành phân tích hoặc đủ điều kiện triển khai toàn bộ ERP.
