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
| B09 | Có nhận màu hoặc quy cách riêng cho khách. | Anh trả lời câu 6; duyệt mẫu đã được xác nhận tại B17, số lượng tối thiểu, giá và thời gian còn mở. |
| B10 | Tiếp tục đào sâu nghiệp vụ trước khi đi vào tính năng; dữ liệu nghiệp vụ phải được hệ thống hóa và lưu để dùng khi phát triển. | Yêu cầu mới nhất của anh. |
| B11 | Có khách đại lý, nhà thầu, chủ công trình, khách lẻ và xuất khẩu; bên đặt, bên trả tiền và bên nhận hàng có thể khác nhau. | Anh trả lời vòng khảo sát bán hàng; chưa chốt trách nhiệm pháp lý, xuất hóa đơn và phân bổ thanh toán. |
| B12 | Tiếp nhận qua email, điện thoại, website và liên hệ cá nhân; khách có thể đưa quy cách/số lượng hoặc diện tích cần tư vấn tính số viên. | Anh xác nhận; người tiếp nhận, công thức tính và người xác nhận kết quả chưa rõ. |
| B13 | Chiết khấu tùy đơn và trường hợp; chính sách có thể thay đổi theo tham số. Giám đốc quyết định giá và giảm giá. | Chưa xác nhận bảng giá gốc, tham số cụ thể, công thức, ngưỡng hoặc thời hạn báo giá. |
| B14 | Giám đốc thường quyết định việc chốt đơn. | Không suy ra mọi đơn đều phải duyệt hoặc đã xác định điều kiện cọc/ký và người bàn giao. |
| B15 | Quản lý sản xuất kiểm tra hàng có sẵn và khả năng sản xuất trước khi cam kết ngày giao. | Anh xác nhận; cách kiểm tra, thời gian vận chuyển và cách xác nhận ngày giao còn mở. |
| B16 | Quản lý sản xuất và CEO (giám đốc) quyết định ưu tiên khi nhiều đơn cùng cần hàng mà không đủ. | Chưa chốt tiêu chí ưu tiên; cách gọi CEO/giám đốc đã xác nhận tại B18. |
| B17 | Có làm mẫu cho khách duyệt trước khi sản xuất hàng loạt đối với màu/quy cách riêng. | Anh xác nhận; hình thức duyệt và tiêu chuẩn so sánh với mẫu chưa rõ. |
| B18 | “CEO” và “giám đốc” không kèm chức năng là cùng một người. Khi ghi “giám đốc” kèm chức năng, như “giám đốc sản xuất”, đó là người khác. | Anh xác nhận quy ước cách gọi; không tự suy ra các chức danh chức năng đều đã tồn tại hoặc có quyền cụ thể. |

Các mã B01–B18 giúp tham chiếu quyết định khi bổ sung quy trình và tiêu chí nghiệm thu; không phải mã tính năng hoặc danh sách công việc lập trình.

## Quy mô và tổ chức

**Quy ước đã xác nhận (B18):** “CEO” và “giám đốc” đứng riêng chỉ cùng một người, không tách thành hai người phê duyệt trong cùng quy trình. “Giám đốc” kèm chức năng, ví dụ “giám đốc sản xuất”, chỉ người khác. Chưa có căn cứ đồng nhất “quản lý sản xuất” với “giám đốc sản xuất”; cũng chưa xác nhận doanh nghiệp có đủ các chức danh giám đốc chức năng. Quy ước này không tự bổ sung thẩm quyền hoặc xác nhận các quy trình đang ở trạng thái đề xuất.

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

## Tiếp nhận nhu cầu và chốt đơn — kết quả khảo sát

Nguồn: sáu câu trả lời của anh ngày 04/10/2026, được lưu trong README. Đây là mô tả anh cung cấp, chưa được khảo sát độc lập tại Nasaki.

Đã xác nhận nhóm khách, các bên có thể khác nhau, kênh tiếp nhận, hai kiểu đầu vào tư vấn, thẩm quyền về giá/chốt đơn, kiểm tra khả năng giao, quyết định ưu tiên và việc duyệt mẫu (B11–B17). Chưa đủ căn cứ để coi luồng bán hàng đã hoàn chỉnh.

Các điểm bàn giao còn cần làm rõ:

- Người tiếp nhận và chịu trách nhiệm theo đơn; người có quyền đại diện khách xác nhận mẫu hoặc yêu cầu đổi/hủy. Người trả tiền hay nhận hàng không tự động có quyền thay đổi đơn.
- Khi tính số viên từ diện tích, cần thông số sản phẩm, điều kiện công trình, phụ kiện và phần dự phòng nào; ai kiểm tra, ai xác nhận kết quả.
- Bảng giá gốc và tham số điều chỉnh; thuế, vận chuyển, thời hạn báo giá và cách giữ giá đã được khách chấp nhận khi chính sách mới thay đổi.
- Điều kiện để đơn được chấp nhận và được phép mua vật tư/sản xuất: xác nhận khách, duyệt giám đốc, cọc hoặc điều kiện tín dụng; chưa tự đặt mức cọc hay yêu cầu chữ ký.
- Người bàn giao đơn; nội dung bàn giao; tiêu chí ưu tiên và cách xử lý thay đổi ngày giao. CEO và giám đốc đứng riêng đã được xác nhận là cùng người (B18), không còn là câu hỏi mở.
- Hình thức duyệt mẫu, dung sai/tiêu chuẩn đối chiếu và cách xử lý khi sản phẩm không đúng mẫu đã duyệt.

## Đề xuất xử lý đổi hoặc hủy đơn đặt riêng

**Trạng thái: Đề xuất của Codex theo yêu cầu của anh; chưa được anh duyệt và không phải quy trình thực tế Nasaki đã được xác nhận.** Áp dụng khi khách đổi mẫu, màu, quy cách, số lượng hoặc hủy toàn bộ/một phần. Trường hợp doanh nghiệp làm sai mẫu hoặc giao hàng lỗi phải được tách khỏi việc khách đổi ý.

### Nguyên tắc và bàn giao đề xuất

1. Trước sản xuất hàng loạt, giữ bản yêu cầu và mẫu khách đã duyệt, kèm người duyệt, ngày duyệt và tiêu chuẩn đối chiếu được hai bên thống nhất. Đây là cơ sở xác định thay đổi; không sửa đè mất bản cũ.
2. Người phụ trách kinh doanh tiếp nhận yêu cầu đổi/hủy, xác minh người yêu cầu có quyền đại diện khách, ghi lý do và phần số lượng bị ảnh hưởng. Quản lý sản xuất đánh giá và quyết định cách tạm dừng an toàn phần bị ảnh hưởng nếu cần; không tự dừng toàn bộ các đơn khác.
3. Sản xuất xác định số lượng chưa làm, đang làm, đã hoàn thành và đã giao; kho/mua hàng đánh giá vật tư đã cam kết, khả năng trả, tái sử dụng hoặc bán lại. Kế toán tổng hợp chi phí có chứng cứ và khoản đã thu.
4. Giám đốc duyệt phương án thương mại: tiếp tục theo yêu cầu mới, làm lại, giảm/hủy số lượng hoặc phương án khác; thống nhất với khách chi phí, xử lý hàng/vật tư, tiền đã thu và ngày giao mới. Vai trò này là đề xuất, không suy ra từ B14 rằng thẩm quyền đổi/hủy thực tế đã được xác nhận.
5. Chỉ triển khai phương án thay đổi sau khi có phê duyệt nội bộ và xác nhận của khách. Nếu chưa thống nhất, giữ lịch sử đơn và trạng thái chờ xử lý đối với phần bị ảnh hưởng; không tự coi đơn đã hủy, tự khấu trừ tiền hoặc tự tiếp tục sản xuất phần đang tranh chấp.
6. Nếu màu/quy cách thay đổi ảnh hưởng mẫu, làm và duyệt mẫu mới trước khi sản xuất hàng loạt phần thay đổi. Cập nhật kế hoạch vật tư, sản xuất, giao hàng và thông báo các bên bị ảnh hưởng.

### Xử lý theo thời điểm đề xuất

| Thời điểm nhận yêu cầu | Hướng xử lý | Chi phí và hàng cần xem xét |
| --- | --- | --- |
| Chưa duyệt mẫu, chưa cam kết vật tư riêng | Điều chỉnh yêu cầu, báo giá/ngày giao; làm mẫu mới nếu cần. | Chi phí mẫu/tư vấn chỉ thu theo thỏa thuận; không tự đặt phí hủy. |
| Đã duyệt mẫu, đã chuẩn bị hoặc đặt vật tư, chưa sản xuất hàng loạt | Kiểm tra khả năng dừng mua, trả hoặc dùng lại vật tư; xác nhận yêu cầu mới. | Chi phí thực tế không thu hồi được sau khi xét trả, tái sử dụng và các nghĩa vụ đã cam kết. |
| Đang sản xuất | Dừng an toàn phần bị ảnh hưởng nếu phù hợp; tách phần chưa làm, đang làm và đã làm; đánh giá khả năng sửa hoặc tiếp tục. | Vật tư và công đã dùng, chi phí sửa, hàng có thể thu hồi; cập nhật tiến độ sau khi duyệt. |
| Đã hoàn thành, chưa giao | Giữ riêng để đánh giá chất lượng và phương án sửa, bán lại hoặc xử lý khác; không tự đưa hàng riêng thành hàng chuẩn. | Chi phí hoàn thành, giá trị có thể thu hồi và chi phí xử lý thêm; phân loại hàng cần được chấp thuận. |
| Đã giao một phần hoặc toàn bộ | Xử lý riêng phần chưa giao; phần đã giao theo quy trình trả hàng/khiếu nại và thỏa thuận. | Không xóa giao dịch giao hàng hoặc khoản đã thu; kiểm tra hàng trả và đối chiếu nghĩa vụ thanh toán. |

### Nguyên tắc chi phí đề xuất

Không mặc định mất toàn bộ cọc, thu toàn bộ giá bán hoặc áp dụng một tỷ lệ phạt cho mọi trường hợp. Phân biệt chi phí đã phát sinh, cam kết không hủy được, giá trị có thể thu hồi và khoản cuối cùng hai bên thỏa thuận; tránh tính cùng một chi phí hai lần. Cách xử lý tiền cọc, hoàn tiền hoặc công nợ phải dựa trên điều khoản đã thống nhất và kết quả được phê duyệt, không coi bảng chi phí là quyền tự động khấu trừ.

Nếu doanh nghiệp làm sai mẫu đã duyệt, phải xem xét trách nhiệm khắc phục của doanh nghiệp; không tự chuyển chi phí lỗi đó sang khách dưới tên phí đổi/hủy. Nếu khách thay đổi yêu cầu với hàng đang đúng mẫu, thương lượng phần chi phí bị ảnh hưởng theo thời điểm và khả năng thu hồi. Mức cọc, phí mẫu, thời hạn phản hồi, điều kiện hủy và dung sai vẫn cần được thống nhất.

### Thông tin nghiệp vụ cần lưu

Yêu cầu/mẫu và từng lần duyệt; các bên đặt/trả tiền/nhận hàng và người có quyền xác nhận; thời điểm, lý do và lượng thay đổi; tiến độ thực tế; vật tư, chi phí và giá trị thu hồi; phương án xử lý, người duyệt và xác nhận khách; tiền đã thu và cách quyết toán; cam kết giao cũ/mới; kết quả thực hiện. Đây là nội dung hồ sơ nghiệp vụ, chưa phải thiết kế cơ sở dữ liệu hoặc màn hình.

## Câu hỏi vòng tiếp theo về kế hoạch và sản xuất

Anh có thể trả lời riêng cho ngói và Terrazzo, theo cách thực tế anh biết. Nếu chưa biết, ghi "chưa rõ, em đề xuất"; ví dụ trong câu hỏi không phải xác nhận về quy trình Nasaki.

1. **Công đoạn:** Từ vật liệu đến thành phẩm, ngói và Terrazzo lần lượt trải qua những bước nào? Có công đoạn thuê ngoài không?
2. **Vật liệu và công thức:** Mỗi nhóm dùng những vật liệu chính nào, đo bằng đơn vị gì? Có công thức cho một mẻ hoặc một số lượng viên không; mẫu/màu riêng có làm đổi công thức không?
3. **Mẻ/lô sản xuất:** Thường làm bao nhiêu viên mỗi mẻ/lô? Một mẻ có phục vụ nhiều đơn không? Khi đổi mẫu hoặc màu, phải đổi khuôn, vệ sinh hay dừng máy bao lâu?
4. **Quyết định làm hàng và ưu tiên:** Ai đề nghị/duyệt sản xuất hàng sẵn, dựa vào tồn tối thiểu hay dự báo nào? Khi thiếu năng lực, quản lý sản xuất và CEO ưu tiên theo ngày đã hứa, mức khẩn, giá trị đơn hay nguyên tắc khác?
5. **Thời gian và năng lực:** Có bước chờ khô/dưỡng hộ hoặc chờ khác trước khi giao không? Xưởng làm mấy ca, năng suất ước lượng thế nào; máy hoặc công đoạn nào thường khiến cả luồng phải chờ?
6. **Chất lượng và hoàn tất:** Kiểm tra ở bước nào, ai xác nhận hàng được nhập thành phẩm/giao khách? Hàng không đạt được làm lại, hạ loại hay bỏ; lượng đạt/lỗi được ghi thế nào?

## Các điểm còn mở

- Mẫu, màu, kích thước và quan hệ biến thể; mã chuẩn của sản phẩm có nhiều cách viết.
- Điều kiện nhận đơn và cho phép thực hiện, người bàn giao, tham số giá, cam kết ngày giao và tiêu chí ưu tiên.
- Người đại diện khách, cách duyệt mẫu và tiêu chuẩn đối chiếu; duyệt hoặc chỉnh đề xuất đổi/hủy đơn đặt riêng, điều kiện cọc và quyết toán.
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
