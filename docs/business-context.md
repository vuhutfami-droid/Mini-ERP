# Hồ sơ nghiệp vụ demo ERP Nasaki

Hồ sơ này lưu bối cảnh, quyết định nghiệp vụ và các điểm cần khảo sát để xây dựng demo ERP phục vụ tư vấn cho Nasaki. Demo phải chạy được, lưu các giao dịch và tạo kết quả kiểm chứng được. Hiện đã xác định phạm vi tổng quát và mô hình doanh nghiệp; chưa hoàn thành khảo sát quy trình, chưa thiết kế tính năng hoặc chọn công nghệ.

Chủ dự án cung cấp nhu cầu và xác nhận nghiệp vụ; Codex phụ trách phân tích, hệ thống hóa và thực hiện phần kỹ thuật được giao. Lịch sử trao đổi và nguồn website đã tiếp nhận nằm trong [README](../README.md). Hồ sơ này là bản tổng hợp hiện hành, không thay thế nhật ký.

Ngày cập nhật: 08/10/2026, múi giờ Asia/Bangkok.

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
| B19 | Anh không có đủ thông tin chuyên môn sản xuất của Nasaki và giao Codex đề xuất mô hình cho mục đích minh họa. | Yêu cầu ngày 04/10/2026; các phương án/số liệu bên dưới là giả lập, không phải dữ kiện thực tế hay yêu cầu triển khai ngay. Demo vẫn phải chạy thật và tạo kết quả theo B01. |
| B20 | Anh đồng ý cụ thể hóa chín nhóm nghiệp vụ kho đã rà soát trước khi chuyển sang phần khác. | “đồng ý, cụ thể hóa đi”; phê duyệt việc xây dựng phương án chi tiết, không tự coi là đã duyệt từng tham số mới hoặc yêu cầu lập trình ngay. |
| B21 | Tiếp tục nghiệp vụ tiếp theo; các nội dung kế toán chưa cần đào sâu ở thời điểm này. | Yêu cầu ngày 04/10/2026; tạm hoãn đào sâu, không loại tài chính khỏi phạm vi hoặc coi các đề xuất đã được duyệt toàn bộ. |
| B22 | Rà soát lại nhân sự cho phù hợp Nasaki, không áp dụng toàn bộ nghiệp vụ doanh nghiệp lớn chỉ vì yêu cầu kiểm tra còn thiếu. | Yêu cầu ngày 04/10/2026; giữ tổ chức tinh gọn và mô hình demo, không xác nhận cơ cấu nhân sự thực tế hoặc phê duyệt mọi đề xuất bổ sung. |
| B23 | Anh giao Codex tự lập đề xuất cho hoạt động tiếp theo rồi anh duyệt. | “đồng ý, em tự tạo đề xuất đi sau đó anh sẽ duyệt”, ngày 08/10/2026; cho phép chuẩn bị phương án trách nhiệm/bàn giao cùng điểm chất lượng và kịch bản, chưa duyệt nội dung hoặc yêu cầu lập trình. |
| B24 | Anh duyệt phương án trách nhiệm, phê duyệt, bàn giao, điểm kiểm soát chất lượng và kịch bản liên hoàn trong tài liệu ngày 08/10/2026. | “duyệt, bước tiếp theo là gì?”, ngày 08/10/2026; áp dụng cho demo, không xác nhận quy trình thực tế Nasaki, mọi đề xuất cũ hoặc giao lập trình. |

Các mã B01–B24 giúp tham chiếu quyết định khi bổ sung quy trình và tiêu chí nghiệm thu; không phải mã tính năng hoặc danh sách công việc lập trình.

## Quy mô và tổ chức

**Quy ước đã xác nhận (B18):** “CEO” và “giám đốc” đứng riêng chỉ cùng một người, không tách thành hai người phê duyệt trong cùng quy trình. “Giám đốc” kèm chức năng, ví dụ “giám đốc sản xuất”, chỉ người khác. Chưa có căn cứ đồng nhất “quản lý sản xuất” với “giám đốc sản xuất”; cũng chưa xác nhận doanh nghiệp có đủ các chức danh giám đốc chức năng. Quy ước này không tự bổ sung thẩm quyền hoặc xác nhận các quy trình đang ở trạng thái đề xuất.

Quy mô demo một kho thay thế đề xuất trước đây về kho vật tư và kho thành phẩm riêng. Không tạo thêm kho dưới danh nghĩa diễn giải đề xuất cũ.

**Đề xuất của Codex:** Trong cùng một kho, có thể phân biệt vật tư, thành phẩm, hàng chờ kiểm tra và hàng lỗi bằng khu vực hoặc trạng thái hàng. Đề xuất này giữ nguyên một kho; cách bố trí và quy tắc sử dụng còn cần anh xác nhận qua nghiệp vụ.

**Đề xuất của Codex:** Khảo sát trách nhiệm theo vai trò quản lý, kinh doanh, mua hàng, kho, kế hoạch/sản xuất, chất lượng, tài chính/kế toán và nhân sự. Một người có thể kiêm nhiệm nhiều vai trò trong mô hình tinh gọn. Đã có phương án phân bổ 50 người tại [nghiệp vụ nhân sự](hr-workflows.md), chưa phải cơ cấu thật hoặc quyết định duyệt từng chi tiết. Quyền truy cập và thẩm quyền cụ thể vẫn cần hoàn thiện.

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

## Kế hoạch và sản xuất — mô hình demo đề xuất

**Nguồn và trạng thái:** Anh giao Codex đề xuất vì thiếu thông tin chuyên môn (B19). Toàn bộ công đoạn, định mức, năng lực, thời gian, tỷ lệ và trách nhiệm được bổ sung trong mục này là mô hình giả lập cho ERP, chưa được anh duyệt từng chi tiết; không phải quy trình, công thức, tiêu chuẩn hay năng lực thực tế của Nasaki. Không sử dụng làm hướng dẫn sản xuất vật lý. Không yêu cầu anh trả lời lại sáu câu chuyên môn cũ để tiếp tục phân tích demo.

### P01 — Công đoạn và kết quả bàn giao

| Bước | Ngói — giả lập | Terrazzo — giả lập | Kết quả cần ghi nhận |
| --- | --- | --- | --- |
| 1 | Chuẩn bị vật tư, khuôn và mẫu/màu | Chuẩn bị vật tư, khuôn và phối màu | Phiên bản yêu cầu, vật tư sẵn sàng và người phụ trách. |
| 2 | Phối trộn, tạo hình | Phối trộn, ép tạo hình | Lô sản xuất, lượng bắt đầu và lượng vật tư thực dùng. |
| 3 | Chờ dưỡng hộ | Chờ dưỡng hộ | Lượng đang làm và thời điểm đủ điều kiện sang bước sau; chưa là hàng được giao. |
| 4 | Sơn/phủ bề mặt | Mài, hoàn thiện bề mặt | Lượng hoàn thiện, thời gian/công và vật tư dùng thêm. |
| 5 | Kiểm tra hình dạng, màu, ngoại quan | Kiểm tra kích thước, màu, ngoại quan/bề mặt | Lượng đạt, chờ xử lý, loại bỏ và lý do. Không giả lập chứng nhận chất lượng thật. |
| 6 | Đóng gói, nhập thành phẩm đạt | Đóng gói, nhập thành phẩm đạt | Phiếu nhập và lô nguồn, lượng được phép phân bổ/giao. |

Không mô phỏng thuê ngoài trong tình huống sản xuất cơ sở này. Đây chỉ là giả định của luồng minh họa, không loại bỏ khả năng bổ sung tình huống thuê ngoài hoặc giảm phạm vi bảy nhóm B04.

### P02 — Vật liệu và định mức minh họa

Nhóm vật tư giả lập: ngói dùng xi măng, cát/cốt liệu, nước và vật liệu phủ màu; Terrazzo dùng xi măng, cát, hạt đá trang trí, bột màu và nước. Vật tư khô/phủ quản lý kg, nước quản lý lít, sản phẩm và bán thành phẩm quản lý viên. Khi mua bằng bao/tấn, lưu quy đổi cụ thể theo vật tư; không cộng trực tiếp kg với lít hoặc coi một bao luôn cùng khối lượng.

**Các hệ số sau chỉ là dữ liệu tính toán giả lập, không phải công thức sản xuất:**

| Vật tư | Một lô ngói bắt đầu 1.000 viên | Một lô Terrazzo bắt đầu 500 viên |
| --- | ---: | ---: |
| Xi măng | 300 kg | 150 kg |
| Cát/cốt liệu | 900 kg | 200 kg |
| Hạt đá trang trí | Không dùng trong công thức giả lập này | 400 kg |
| Vật liệu phủ màu | 15 kg | Không dùng trong công thức giả lập này |
| Bột màu | Không dùng trong công thức giả lập này | 5 kg |
| Nước | 120 lít | 100 lít |

Giữ phiên bản định mức theo sản phẩm/màu/quy cách; kế hoạch dùng bản được chọn tại lúc duyệt, không đổi ngược lô cũ khi sửa định mức. So sánh lượng kế hoạch với lượng cấp/thực dùng/hoàn trả. Hệ số định mức trên tính theo lượng bắt đầu: nếu đã tăng lượng bắt đầu để dự phòng hàng lỗi thì không cộng tỷ lệ lỗi lần nữa vào cùng nhu cầu vật tư. Hao hụt vật tư và tỷ lệ thành phẩm lỗi là hai khái niệm khác nhau.

### P03 — Lô, năng lực và thời gian minh họa

Đề xuất một ca 8 giờ, hai luồng công việc trong cùng một xưởng; không tạo thêm công ty, xưởng hoặc kho. Lô cơ sở ngói 1.000 viên, Terrazzo 500 viên. Một lô chỉ có một mẫu/màu/quy cách và có thể phân bổ cho nhiều đơn phù hợp; lưu lượng phân bổ cho từng đơn để tránh tính hai lần. Cho phép một lô cuối nhỏ hơn nếu cần, nhưng ví dụ bên dưới dùng lô đầy.

Thông số lập kế hoạch giả lập: mỗi luồng tạo hình tối đa hai lô đầy/ca; một lô có một ngày làm việc chuẩn bị/tạo hình, ba ngày làm việc chờ, một ngày làm việc hoàn thiện/kiểm tra. Đây là thời gian rút gọn của mô hình ERP, không phải hướng dẫn dưỡng hộ vật liệu. Không suy ra công suất từ con số website công bố. Có thể dùng các ngày làm việc mô phỏng để trình diễn, nhưng mỗi thay đổi trạng thái phải có bản ghi và thời điểm, không tự làm biến mất thời gian chờ.

Đổi mẫu/màu giả lập cần nửa ca chuẩn bị, làm giảm năng lực khả dụng của ca đó. Thời gian năm ngày trên chỉ là thời gian cơ sở cho một lô khi không phải xếp hàng; nhiều lô, thiếu vật tư hoặc đổi mẫu/màu có thể làm đơn lâu hơn. Kế hoạch phải xét lịch công đoạn và tránh xếp trùng máy/nhân sự dùng chung; thông số từng nguồn lực sẽ được cụ thể hóa khi lập dữ liệu demo, không hứa ngày giao chỉ bằng phép cộng năm ngày.

### P04 — Quyết định sản xuất và ưu tiên đề xuất

- Hàng tiêu chuẩn: quản lý sản xuất đề nghị làm bù khi tồn đạt chưa dành cho khách cộng lượng dự kiến đạt từ lô đang làm xuống dưới mức tối thiểu theo sản phẩm; làm bù tới mức mục tiêu. Hai ngưỡng là tham số demo, không áp dụng chung một số cho mọi mặt hàng.
- Hàng theo đơn: kinh doanh bàn giao yêu cầu đã được giám đốc duyệt; hàng đặt riêng phải có mẫu khách duyệt theo B17. Đề xuất demo cơ sở không bắt buộc cọc cho mọi đơn; điều kiện cọc/tín dụng được ghi theo thỏa thuận từng đơn và phải đủ nếu đơn có điều kiện này.
- Quản lý sản xuất kiểm tra vật tư, khuôn, nguồn lực và thời gian; lập kế hoạch/lệnh, giám đốc duyệt trước khi khởi động trong mô hình demo đề xuất. Thiếu vật tư chuyển nhu cầu sang mua hàng, không ghi nhận xuất kho âm để giả lập đã đủ.
- Ưu tiên đề xuất: đơn có ngày giao đã cam kết sớm hơn trước; trường hợp ngang nhau xét thứ tự xác nhận. Quản lý sản xuất phối hợp giám đốc điều chỉnh khi cần, ghi lý do và tác động tới các đơn khác. Gom mẫu/màu để tiết kiệm thời gian chỉ khi không phá cam kết hoặc đã có quyết định xử lý.

### P05 — Chất lượng, hàng lỗi và chi phí đề xuất

Tỷ lệ lỗi dùng để dự kiến: ngói 2%, Terrazzo 3%; tỷ lệ đạt tương ứng 98% và 97%. Đây là tham số giả lập, không phải tỷ lệ lỗi Nasaki hoặc kết quả chắc chắn. Lượng thực tế phải nhập từ kết quả sản xuất/kiểm tra, không tự sinh thành phẩm đạt theo tỷ lệ kế hoạch.

Người kiểm tra chất lượng ghi kết quả; quản lý sản xuất quyết định phương án làm lại hoặc loại bỏ dựa trên đánh giá chất lượng; kho chỉ nhập lượng được xác nhận đạt. Hàng chờ xử lý/hàng lỗi nằm ở trạng thái hoặc khu vực riêng trong cùng một kho. Làm lại tạo bản ghi riêng, tiêu thụ thêm vật tư/công nếu có và kiểm tra lại; không cộng hàng làm lại hai lần. Đề xuất chưa bán hạ loại trong tình huống cơ sở, nhưng giữ tình huống đó trong danh sách có thể bổ sung.

Giá thành demo sẽ tập hợp vật tư thực dùng, nhân công và chi phí chung được phân bổ theo quy tắc riêng. Với tình huống lỗi thông thường không thu hồi, đề xuất phân bổ chi phí lô cho lượng đạt; chi phí làm lại bổ sung có chứng cứ, không cộng cùng một chi phí hai lần. Các trường hợp lỗi bất thường, giá trị phế liệu hoặc bán hạ loại cần quy tắc riêng khi phân tích tài chính; không dùng mô hình này làm kết luận kế toán pháp định.

### P06 — Tình huống xuyên quy trình và kết quả mong đợi

**Toàn bộ số liệu giả lập; đây là ví dụ có hàng lỗi, không thay thế ví dụ cơ sở không hao hụt trong nhật ký cũ.** Đơn 10.000 viên ngói tiêu chuẩn, cùng mẫu/màu/quy cách; có 3.000 viên đạt chưa dành cho khách khác. Còn cần 7.000 viên đạt.

- Với tỷ lệ đạt dự kiến 98%, lượng bắt đầu tối thiểu là làm tròn lên 7.000 / 0,98 = 7.143 viên. Nếu chọn lô đầy 1.000 viên, lập tám lô, tổng bắt đầu 8.000 viên; quản lý và giám đốc cần nhìn thấy lượng dư dự kiến thay vì coi đó là nhu cầu khách.
- Nhu cầu vật tư theo tám lô: 2.400 kg xi măng, 7.200 kg cát/cốt liệu, 120 kg vật liệu phủ và 960 lít nước. Đối chiếu tồn chưa dành cho việc khác và vật tư về đúng thời điểm; phần thiếu mới chuyển nhu cầu mua.
- Kịch bản giả lập nhập kết quả thực tế: 7.840 viên đạt, 160 viên loại bỏ, không có lượng còn đang làm hoặc chờ xử lý; 7.840 + 160 = 8.000. Phân bổ 7.000 viên mới và 3.000 viên ban đầu cho đơn; 840 viên đạt dư còn trong kho, không tự giao thêm cho khách.
- Giao đủ 10.000 viên: tồn đạt cuối 3.000 + 7.840 - 10.000 = 840 viên. Lượng lỗi 160 không được cộng vào tồn có thể bán. Nếu kết quả thực tế đạt thấp hơn nhu cầu thì phải lập phương án bổ sung hoặc đổi lịch, không báo đủ theo số dự kiến.

Giá trị demo là thấy được nhu cầu vật tư, tiến độ/lượng đang làm, hàng đạt/lỗi, lượng phân bổ cho đơn và tồn cuối từ các giao dịch đã lưu; không dùng số hiển thị cố định. Chưa triển khai hoặc chạy kiểm thử ứng dụng; các phép tính trên là kết quả mong đợi để phát triển và kiểm chứng về sau.

## Kho và mua hàng — mô hình demo đề xuất

**Trạng thái:** Codex đề xuất tiếp nối P01–P06 theo yêu cầu tiếp tục của anh. Các vai trò, quy tắc, giá và ví dụ dưới đây là giả lập để phân tích demo, không phải hiện trạng Nasaki hoặc quyết định đã được anh duyệt từng chi tiết. Giữ nguyên 1 công ty, 1 xưởng, 1 kho; chưa thiết kế màn hình, cơ sở dữ liệu hoặc triển khai ứng dụng.

### K01 — Một kho, phân biệt vị trí và trạng thái

Trong một kho, đề xuất các khu vực vật tư, thành phẩm, chờ kiểm tra/chờ xử lý và hàng lỗi/chờ trả. Khu vực không phải kho mới; trạng thái chất lượng không phải một lượng tồn cộng thêm. Bán thành phẩm đang trên công đoạn thuộc lượng đang sản xuất, không đồng thời cộng vào tồn thành phẩm của kho.

| Khái niệm | Ý nghĩa trong demo |
| --- | --- |
| Tồn thực tế | Hàng đang nằm trong kho, gồm cả hàng chưa được phép dùng/giao. |
| Tồn đạt | Phần tồn thực tế đã được xác nhận chất lượng, không bị khóa xử lý. |
| Đã dành | Phần tồn đạt đã phân bổ cho đơn hoặc lệnh sản xuất; giữ hàng không làm giảm tồn thực tế. |
| Khả dụng | Tồn đạt trừ phần đã dành; đây là phần có thể phân bổ thêm. |
| Đang về | Phần đơn mua chưa nhận đạt, có ngày dự kiến; không phải tồn thực tế hay hàng chắc chắn có thể xuất. |

Hàng lỗi/chờ kiểm tra không nằm trong tồn đạt; không trừ lần nữa khỏi tồn đạt khi tính khả dụng. Một lượng hàng chỉ được giữ cho một nhu cầu tại một thời điểm; khi xuất lượng đã dành, vừa giảm tồn thực tế/đạt vừa giải phóng đúng lượng giữ tương ứng. Khi chỉ hủy phân bổ, tồn thực tế không thay đổi.

### K02 — Giao dịch kho và truy nguồn

- Nhập vật tư từ nhà cung cấp: kho ghi lượng thực nhận theo đơn mua, giữ trạng thái chờ kiểm tra nếu chưa chấp nhận; kiểm tra xác nhận đạt mới cho phép cấp sản xuất.
- Cấp vật tư: xuất theo lệnh sản xuất, vật tư/lô và lượng thực cấp; không cho phép xuất vượt lượng đạt được quyền dùng. Vật tư dư hoàn trả có kiểm tra và phiếu nhập liên kết lệnh; vật tư thực dùng được đối chiếu cấp trừ hoàn trả và các xử lý hao hụt có căn cứ.
- Nhập thành phẩm: liên kết lô sản xuất và kết quả chất lượng; nhập đúng lượng được xác nhận đạt. Hàng làm lại được theo dõi riêng, không nhập cùng một lượng hai lần.
- Xuất giao khách: liên kết đơn, lô và đợt giao; không xuất vượt số còn phải giao hoặc lượng được quyền dùng. Đổi lô được kiểm tra lại mẫu/màu/quy cách, không mặc định hai lô thay thế được nhau.
- Chuyển khu vực/trạng thái trong cùng kho: không làm tăng tổng tồn. Hàng trả từ khách phải qua kiểm tra trước khi trở lại lượng khả dụng.
- Mỗi lần nhập/xuất/giữ/chuyển/điều chỉnh lưu ngày, người thực hiện, chứng từ nguồn, vật tư/sản phẩm, đơn vị, lô, lượng và lý do. Chứng từ đã xác nhận không sửa đè/xóa mất lịch sử; điều chỉnh bằng bản ghi liên kết được duyệt.

Đề xuất xuất lô được nhập trước trong số các lô đủ điều kiện và đúng yêu cầu. Hàng có hạn dùng ưu tiên hạn gần hơn; không tự cấp hàng hết hạn. Quy tắc này là thứ tự lấy hàng vật lý, chưa quyết định phương pháp tính giá vốn kế toán.

### K03 — Kiểm kê và chênh lệch

Đề xuất kiểm kê định kỳ hàng tháng và kiểm kê riêng khi có nghi vấn. Kho chốt phạm vi/thời điểm, đếm theo vật tư/sản phẩm, lô, khu vực và trạng thái; trong lúc đếm tạm ngừng giao dịch phần đó hoặc đối chiếu mọi giao dịch phát sinh theo cùng mốc. Người kiểm tra đối chiếu sổ với thực đếm; giám đốc duyệt chênh lệch và lý do trước khi điều chỉnh. Không sửa tồn về con số mong muốn để che mất chênh lệch; kế toán xử lý giá trị theo quy tắc tài chính sẽ phân tích sau.

### Rà soát kho trước khi chuyển sang phân hệ khác

**Yêu cầu:** Anh hỏi nghiệp vụ kho còn thiếu gì trước khi sang phần khác. Đây là kết quả rà soát tài liệu K01–K03 và các điểm nối P01–P06/M01–M03, không phải kiểm tra một ứng dụng đã xây. Các hướng bổ sung là đề xuất, chưa tự trở thành quy tắc được phê duyệt hoặc công việc lập trình được giao.

**Kết luận:** Khung nhập, xuất, giữ hàng, chất lượng, truy lô và kiểm kê đã có; còn thiếu hoặc mới mô tả sơ lược chín nhóm dưới đây. Nên hoàn thiện quy tắc cơ sở cho demo trước khi coi nghiệp vụ kho đủ để triển khai, không cần biến demo thành hệ thống quản lý kho chuyên sâu.

| Mã rà soát | Điểm thiếu/chưa đủ rõ | Hướng bổ sung đề xuất |
| --- | --- | --- |
| RK01 | Danh mục mẫu/màu/quy cách, vị trí và quy đổi mới có định hướng. | Phân biệt biến thể có thể xuất giao, lưu mã tham chiếu thống nhất; địa điểm/khu vực trong một kho; quy đổi bao/hộp/pallet theo từng hàng và phiên bản. Viên là số nguyên; vật tư có độ chính xác theo đơn vị. Không gộp lô hoặc biến thể chỉ vì cùng tên. |
| RK02 | Tồn đầu kỳ mới được giả sử trong ví dụ, chưa có quy trình xác lập. | Ghi nhận một lần tại mốc bắt đầu theo hàng/lô/khu vực/trạng thái, có kiểm tra và duyệt; giữ căn cứ giá trị để bàn giao tài chính. Tồn đầu không giả làm mua mới hoặc nhập sản xuất mới, không chạy lại dữ liệu khởi tạo làm nhân đôi tồn. |
| RK03 | Điểm hàng rời kho, đang vận chuyển, nhận trả và quyền sở hữu chưa rõ. | Tách soạn hàng/chờ xuất với xác nhận hàng thực rời kho; đề xuất ghi giảm tồn tại lúc rời kho, theo dõi đang giao riêng, không coi là khách đã nhận hoặc tự ghi doanh thu. Trả hàng chỉ tăng tồn vật lý khi thực nhận. Hàng bên khác gửi không tự trở thành hàng doanh nghiệp được phép bán; chưa đề xuất thêm kho/ký gửi cho demo cơ sở. |
| RK04 | Có giữ/giải phóng hàng, nhưng chưa đủ vòng đời khi đơn hủy/giảm, lô bị khóa hoặc kiểm kê thiếu. | Liên kết lượng giữ với đúng đơn/lệnh, giải phóng phần không còn cần sau quyết định được duyệt; chuyển phân bổ có lý do và quyền phù hợp. Khi hàng đã dành không còn đạt/không còn đủ, xác định đơn bị ảnh hưởng, gỡ phần không hợp lệ và lập nhu cầu bổ sung; không duy trì phân bổ vượt tồn đạt hoặc âm thầm chuyển sang hàng khác. |
| RK05 | Chưa tách xuất mẫu, kiểm tra tiêu hao, dùng nội bộ, vỡ/mất và tiêu hủy khỏi xuất bán/cấp sản xuất. | Có mục đích, lượng, người nhận, lý do và phê duyệt theo loại; phân biệt chuyển hàng đạt sang hàng lỗi với thực sự tiêu hủy/ra khỏi kho. Hàng vỡ còn nằm trong kho chỉ giảm tồn đạt, chưa giảm tổng tồn vật lý; tiêu hủy thực tế giảm tổng tồn bằng chứng từ riêng. Kho lập, người kiểm tra đánh giá chất lượng khi cần, giám đốc duyệt xử lý. |
| RK06 | Nhận trả khách/nhà cung cấp và hoàn trả vật tư có nhắc, nhưng chưa đủ điều kiện và liên kết. | Liên kết lần giao/cấp gốc, lượng còn được trả và phần đã trả trước đó; nhận trả về chờ kiểm tra, phân loại đạt/làm lại/lỗi. Trả nhà cung cấp cần xác nhận lượng thực xuất và đối chiếu điều chỉnh tài chính riêng; không tự hoàn tiền chỉ vì kho nhận hàng trả. |
| RK07 | Có trạng thái chất lượng và truy lô, chưa có khóa lô/thu hồi khi phát hiện lỗi sau nhập. | Khóa phần còn trong kho, loại khỏi lượng khả dụng, xử lý phân bổ bị ảnh hưởng; truy vật tư nguồn, lệnh, thành phẩm và các đợt đã giao để xác định đối tượng cần thông báo/thu hồi. Kinh doanh/chất lượng phối hợp phương án; chưa sửa lịch sử xuất hoặc tự giả lập hàng đã thu hồi về. |
| RK08 | Có lịch sử và duyệt điều chỉnh, nhưng chưa rõ nháp, xác nhận, ghi lùi ngày, đảo chứng từ và nhiều người thao tác. | Chứng từ nháp chưa thay đổi tồn; xác nhận một lần mới ghi biến động. Bấm lại không tạo giao dịch thứ hai; hai người không cùng giữ/xuất vượt lượng. Sửa chứng từ đã ghi bằng điều chỉnh/đảo có kiểm tra giao dịch liên quan; không đảo nhập nếu hàng đã dùng mà chưa xử lý phụ thuộc. Phân quyền người lập/xác nhận/duyệt; giao dịch lùi ngày phải được kiểm tra, liên kết khóa kỳ tài chính về sau. |
| RK09 | Chưa hệ thống hóa báo cáo, cảnh báo và đối chiếu toàn luồng. | Báo nhập–xuất–tồn theo mốc và từng hàng/lô; tồn đạt/đã dành/khả dụng, hàng chờ/lỗi, tồn lâu ngày, dưới ngưỡng hoặc gần/hết hạn nếu có. Đối chiếu lượng cấp–hoàn–thực dùng, nhận–trả mua, xuất–nhận trả bán và lượng giữ. Giá trị tồn/giá vốn tiếp tục ở tài chính, không khẳng định đã thiết kế phương pháp định giá. |

**Các điểm giao cần giữ để phân tích sau:** Hàng đang vận chuyển và xác nhận khách nhận thuộc giao hàng; hoàn tiền/công nợ, giá trị tồn và khóa kỳ thuộc tài chính; kiểm tra/thu hồi thuộc chất lượng. Kho phải có dữ liệu và điểm bàn giao tương ứng, không tự quyết thay các phân hệ này. Quyền sở hữu không thể suy ra chỉ từ vị trí vật lý.

**Có thể để sau — khuyến nghị, không phải quyết định giảm phạm vi:** Quét mã vạch/QR, quản lý pallet chuyên sâu, tự tối ưu vị trí/xếp xe, nhiều kho, ký gửi, kho thuê ngoài hoặc tích hợp cân/máy. Chỉ đưa vào khi có giá trị minh họa rõ hoặc anh yêu cầu. Không cần mã riêng cho từng viên; quản lý theo sản phẩm/biến thể và lô đủ cho mô hình hiện tại.

**Tình huống nghiệm thu kho cần bổ sung khi phát triển, chưa chạy phần mềm:**

1. Khởi tạo tồn một lần, mở lại vẫn đúng; không nhân đôi khi nạp lại dữ liệu demo.
2. Tồn đạt 1.000 viên, dành 600: khả dụng 400; xuất 200 từ phần đã dành thì còn đạt 800, dành 400, khả dụng vẫn 400. Hủy phần còn lại chỉ giải phóng 400, không cộng thêm tồn vật lý.
3. Chuyển 50 viên từ đạt sang lỗi khi vẫn ở kho giữ nguyên tổng tồn vật lý nhưng giảm lượng được dùng; chỉ khi tiêu hủy mới giảm tổng tồn.
4. Nhận trả 20 viên tăng tồn vật lý 20 nhưng chưa tăng khả dụng; sau kiểm tra, chỉ lượng đạt mới được phép phân bổ lại, không nhận cùng lần trả hai lần.
5. Hai người cùng muốn giữ 300 viên trong khi khả dụng chỉ 400: tổng giữ mới không vượt 400, phần chưa đủ phải được báo rõ; nhấn xác nhận lại không tạo lần xuất thứ hai.
6. Khóa lô đã phân bổ, kiểm kê thiếu hoặc đảo chứng từ có giao dịch sau phải chỉ ra đơn/lệnh chịu ảnh hưởng và cách xử lý; không chỉ làm báo cáo tồn nhìn có vẻ đúng.

Theo B20, đã cụ thể hóa cả chín nhóm trong [Quy trình kho cho demo ERP Nasaki](warehouse-workflows.md): trách nhiệm, đầu vào, điều kiện, bước thực hiện, thời điểm ảnh hưởng tồn, ngoại lệ, điểm bàn giao và tình huống kiểm chứng. Tài liệu đó là nguồn chi tiết hiện hành của kho; phần rà soát trên giữ căn cứ nhận diện khoảng trống, không phải kết luận còn chưa được cụ thể hóa. Các tham số mới vẫn là đề xuất demo; chưa hoàn tất đối chiếu tài chính/giao hàng hoặc kiểm chứng ứng dụng. Codex phải đọc tài liệu này trước khi thao tác phần kho.

### M01 — Luồng mua hàng và bàn giao đề xuất

| Bước | Người phụ trách đề xuất | Kết quả/điều kiện bàn giao |
| --- | --- | --- |
| Xác định thiếu vật tư | Quản lý sản xuất phối hợp kho | Nhu cầu theo lệnh, lượng đạt được quyền dùng, đơn mua đang về đã phân bổ đúng thời điểm, phần thiếu. Không trừ cùng lượng đang về cho nhiều nhu cầu. |
| Đề nghị mua | Quản lý sản xuất hoặc kho | Vật tư/quy cách, đơn vị, số lượng, ngày cần và nhu cầu nguồn; kho có thể đề nghị bổ sung tới mức tồn mục tiêu. |
| Chọn nhà cung cấp | Người phụ trách mua hàng | So sánh giá, chất lượng, lịch giao, vận chuyển và điều kiện thanh toán; ưu tiên đủ/đúng hạn thay vì chỉ chọn rẻ nhất. |
| Duyệt và đặt mua | Giám đốc duyệt, mua hàng gửi đơn | Đơn mua ghi lượng, giá, đơn vị/quy đổi, lịch giao và điều kiện; thay đổi quan trọng cần duyệt lại. |
| Nhận và kiểm tra | Kho đếm, người kiểm tra chất lượng xác nhận | Phiếu nhận từng đợt, lượng đạt/chờ xử lý/không đạt, lô nhà cung cấp nếu có; lượng được chấp nhận mới đáp ứng nhu cầu sản xuất. |
| Đối chiếu nghĩa vụ thanh toán | Kế toán | Đối chiếu đơn mua, lượng nhận được chấp nhận và hóa đơn/chứng từ yêu cầu thanh toán; ghi nghĩa vụ được xác nhận và hạn trả. |
| Thanh toán | Kế toán lập đề nghị, giám đốc duyệt | Khoản trả có chứng từ và phân bổ rõ; còn phải trả tính từ nghĩa vụ xác nhận trừ khoản đã phân bổ và điều chỉnh được chấp thuận. |

Đề xuất một vòng duyệt giám đốc cho đơn mua, không tách CEO thành người duyệt thứ hai. Không bắt buộc ba báo giá cho mọi lần mua; nếu mua gấp hoặc chỉ có một nguồn, ghi lý do lựa chọn. Đơn mua có thể giao nhiều đợt và thanh toán nhiều lần; trạng thái nhận hàng và trạng thái trả tiền độc lập.

### M02 — Ngoại lệ và kiểm soát đề xuất

- Thiếu hoặc chậm: đơn mua vẫn còn phần chưa nhận; mua hàng cập nhật dự kiến, sản xuất đánh giá ảnh hưởng ngày giao. Đơn mua đang về không cho phép xuất kho trước khi nhận đạt.
- Sai quy cách/hàng lỗi: tách lượng không đạt, không cấp sản xuất; mua hàng thống nhất đổi, trả hoặc giảm giá với nhà cung cấp, có phê duyệt. Trả hàng không tự xóa hóa đơn hoặc khoản đã trả; kế toán theo dõi điều chỉnh/hoàn tiền riêng.
- Giao thừa: ghi lượng thực tế nhận và giữ chờ xử lý phần vượt; giám đốc quyết nhận bổ sung hay trả lại trước khi đưa vào lượng khả dụng và nghĩa vụ thanh toán.
- Thay vật tư khác: cần đánh giá ảnh hưởng tới mẫu, định mức và chất lượng; không tự coi vật tư có cùng tên là tương đương. Khi ảnh hưởng mẫu khách đã duyệt, quay lại quy trình xác nhận thay đổi.
- Hủy/sửa đơn mua: giữ lịch sử, xét phần đã nhận/đã trả và cam kết còn lại; giải phóng phân bổ và tính lại thiếu hụt. Không coi đơn đã nhận là chưa từng xảy ra.
- Không cộng tồn lần nữa khi kế toán ghi hóa đơn cho lần nhận đã có. Khoản trả trước nhà cung cấp là khoản ứng trước cần đối chiếu, không tự coi là chi phí vật tư đã tiêu hao.

### M03 — Ví dụ liên thông với tám lô ngói P06

**Toàn bộ số liệu và giá giả lập; tình huống cơ sở chưa xét thuế, phí vận chuyển hoặc chiết khấu.** Tám lô cần 2.400 kg xi măng. Kho có 1.500 kg đạt, trong đó 300 kg đã dành cho lệnh khác; không có đơn mua xi măng đang về. Các vật tư khác trong P06 giả sử đủ để tập trung minh họa xi măng.

1. Khả dụng ban đầu: 1.500 - 300 = 1.200 kg. Phần cần mua: 2.400 - 1.200 = 1.200 kg; không dùng 300 kg đã dành cho lệnh khác.
2. Giả lập loại xi măng này mua bằng bao 50 kg: 1.200 / 50 = 24 bao. Đơn giá 100.000 đồng/bao, giá trị đơn mua 2.400.000 đồng. Quy đổi và giá không áp dụng cho mọi loại xi măng/Nasaki.
3. Nhà cung cấp giao hai đợt, 14 bao và 10 bao, đều được kiểm tra chấp nhận: nhận lần lượt 700 và 500 kg. Sau đợt đầu, có 1.900 kg dành được cho tám lô, còn thiếu 500 kg; chưa coi toàn bộ lệnh đã đủ vật tư. Có thể lập phương án làm trước các lô đủ điều kiện nếu các vật tư và nguồn lực khác sẵn sàng.
4. Sau nhận đủ và trước cấp sản xuất, tồn đạt là 2.700 kg; dành 2.400 kg cho tám lô và 300 kg cho lệnh khác, khả dụng thêm bằng 0. Khi cấp đủ 2.400 kg, tồn đạt còn 300 kg, vẫn dành cho lệnh khác. Tồn cuối: 1.500 + 700 + 500 - 2.400 = 300 kg. Không có vật tư hoàn trả hoặc hao hụt thêm trong ví dụ này.
5. Giả sử chứng từ thanh toán cho cả 24 bao đã được đối chiếu và ghi nhận nghĩa vụ 2.400.000 đồng; đã trả và phân bổ 1.000.000 đồng thì còn phải trả 1.400.000 đồng. Không suy ra nghĩa vụ đã xác nhận chỉ từ việc đặt mua hoặc nhận hàng.

Kết quả mong đợi khi xây demo: tính đúng phần thiếu, quy đổi bao/kg, nhận nhiều đợt, bảo toàn hàng đã dành, xuất đúng lượng và đối chiếu còn phải trả. Đây là kiểm tra phép tính nghiệp vụ trên tài liệu, chưa phải kết quả chạy phần mềm.

## Giao hàng và tài chính quản trị đề xuất

Theo yêu cầu chuyển sang nghiệp vụ tiếp theo, đã lưu [Giao hàng và tài chính cho demo ERP Nasaki](delivery-finance-workflows.md) làm nguồn chi tiết cho đợt giao, xác nhận khách nhận, thu/cọc/phân bổ, công nợ hai chiều, thu chi, giá thành, giá vốn và trả/hoàn tiền. Codex cần đọc cùng quy trình kho trước khi thao tác các luồng liên quan.

**Trạng thái:** Các quy tắc và số liệu mới là đề xuất giả lập, không phải kế toán pháp định hoặc hiện trạng Nasaki. Tình huống cơ sở dùng khách chấp nhận hàng và kế toán xác nhận bán làm điều kiện ghi doanh thu, không ghi bán chỉ vì duyệt đơn/cọc/xuất kho. Vật tư/giá trị hàng đang giao được theo dõi riêng; phương pháp bình quân sau nhập đề xuất để tính giá trị, không nhầm với thứ tự lấy lô vật lý.

Ví dụ đơn 10.000 viên, giá 18.000 đồng/viên, cọc 60 triệu: giao/ghi bán 6.000 có doanh thu 108 triệu và phải thu 48 triệu; thu thêm 30 còn phải thu 18; giao/ghi bán 4.000 còn phải thu 90; thu 90 thì hết nợ. Ví dụ giá thành giả lập 47,04 triệu cho 7.840 đạt, giá 6.000/viên; đầu kho 3.000 cùng giá; bán 10.000 có giá vốn 60 triệu, tồn 840 giá trị 5,04 triệu, lãi gộp 120 triệu trước chi phí khác. Không coi đây là giá bán, giá thành hoặc lợi nhuận thực tế Nasaki.

Thuế/hóa đơn, ngoại tệ/xuất khẩu, tài sản, vay/ngân sách và kế toán đầy đủ chưa hoàn tất phân tích; không tự loại khỏi phạm vi bảy nhóm hoặc nhóm khách xuất khẩu. Cần tiếp tục đề xuất và liên thông nguồn lương/giờ công từ nhân sự; chưa xây ứng dụng.

## Nhân sự và quản trị đề xuất

Theo B21, tiếp tục [nhân sự, ca làm, chấm công và lương](hr-workflows.md), không đào sâu kế toán trong vòng này. Tài liệu là nguồn chi tiết đề xuất, Codex phải đọc trước khi thao tác nhân sự hoặc liên thông giờ/chi phí nhân công. Cơ cấu giả lập: giám đốc 1, kinh doanh 5, mua hàng 2, kho/giao 4, sản xuất 28, chất lượng 3, tài chính 3, nhân sự/hành chính 4; tổng 50 người, kiêm nhiệm không tăng đầu người.

Đề xuất quản lý từ tuyển/tiếp nhận tới điều chuyển/nghỉ việc; lịch và kỹ năng, công thực tế, phép giữ/đã dùng, chốt công/lương, ứng và thực trả, phân quyền dữ liệu cá nhân. Một ca có 8 giờ làm không tính nghỉ trưa; số ngày chuẩn theo lịch kỳ, không mặc định 26 mọi tháng. Nghỉ có lương không là giờ trực tiếp cho lệnh; giờ người khác giờ máy hoặc thời gian dưỡng hộ.

Ví dụ giả lập 26 ngày/208 giờ: đi làm 192 giờ, nghỉ có lương 8, không lương 8; lương cơ sở 7,8 triệu cho thu nhập thời gian 7,5 triệu, cộng phụ cấp cố định 0,5 triệu thành 8 triệu trước khấu trừ. Ứng thực nhận 1 triệu còn cần chi 7 triệu trước các khoản bắt buộc chưa mô phỏng, không gọi là thực lĩnh pháp lý. Ví dụ riêng nối P06: 240 giờ trực tiếp × 50.000 đồng chi phí/giờ = 12 triệu nhân công đã nằm trong giá thành trước, không cộng lại hoặc suy ra từ người trong ví dụ lương.

Các quy tắc/số liệu trên chưa được duyệt từng chi tiết, chưa có bộ chứng từ hoặc kiểm chứng ứng dụng. Chính sách lao động, phép, bảo hiểm/thuế và điều kiện làm thêm cần căn cứ trước vận hành thật; dữ liệu cá nhân thật không lưu Git. Tiếp tục quản trị trách nhiệm/phê duyệt và rà soát chất lượng/toàn luồng trước tính năng.

Theo B22, đã [rà soát mức phù hợp của nhân sự](hr-workflows.md#rà-soát-mức-phù-hợp-với-mô-hình-nasaki). Khung cơ sở đã có; cần làm rõ công nhân không có tài khoản, công theo tổ/người thay, ngừng việc, bộ chính sách mẫu, bàn giao bảo hộ và người duyệt thay/đối chiếu công lương. Các bổ sung là đề xuất, không tự triển khai. Khuyến nghị không tạo phòng ban/cấp duyệt mới, không yêu cầu ghi từng phút, không thêm HR chuyên sâu; bảng 50 người chưa bị thay đổi. Nghĩa vụ an toàn/quyền lợi lao động vẫn giữ điểm kiểm tra, chưa đào sâu kế toán. Chưa có khảo sát nhân sự Nasaki độc lập hoặc kiểm chứng phần mềm.

## Trách nhiệm phê duyệt và bàn giao đã duyệt cho demo

Theo B23, Codex lập [phương án xuyên bộ phận](responsibilities-approvals-handoffs.md) ngày 08/10/2026; anh đã duyệt phương án theo B24. Phạm vi gồm bảng trách nhiệm/thẩm quyền, bàn giao, ủy quyền, quyền dữ liệu, điểm kiểm soát chất lượng và kịch bản ngói P06/M03 cùng nhánh Terrazzo giả lập.

Bốn nhóm đã duyệt: ít cấp quyết định và một đầu mối theo nguồn; kiêm nhiệm/nhập thay có kiểm soát và ủy quyền giới hạn; chất lượng khóa ngay/giải phóng có căn cứ; bàn giao đúng phiên bản/tiếp nhận từng phần và dùng kịch bản chuẩn bị dữ liệu. Không đặt thêm hạn mức tiền, phòng ban hoặc giám đốc chức năng; không cho giám đốc thay kết luận chất lượng để giao hàng khóa. Quản lý sản xuất điều phối xử lý P05, giám đốc duyệt phương án xử lý chính thức theo quy trình kho. Đây là quy tắc cho demo, không xác nhận thẩm quyền thực tế Nasaki hoặc mọi đề xuất cũ.

Bước tiếp theo được Codex đề xuất: cụ thể hóa danh mục và dữ liệu mẫu, người/tài khoản/quyền, lịch/chính sách mẫu, tiêu chí chất lượng giả lập và bộ giao dịch ngói/Terrazzo có kết quả mong đợi, trước khi chuyển sang yêu cầu chức năng và màn hình. Chưa tạo bộ dữ liệu này trong lần ghi nhận phê duyệt. Giữ kế toán chuyên sâu để sau; chưa thiết kế/lập trình hoặc chạy build/test, chưa kết luận phân tích toàn ERP đã hoàn tất.

## Các câu hỏi sản xuất trước đây — chuyển sang đề xuất demo

### Trọng tâm phân tích của vòng này

Chưa có dữ kiện thực tế về công đoạn, vật liệu và năng lực. Theo B19, Codex đã đề xuất P01–P06 ở trên để phân tích demo, không chờ anh cung cấp chuyên môn Nasaki. Không đánh dấu khảo sát thực tế đã hoàn tất; các câu hỏi dưới đây được giữ để tham chiếu khi có thông tin mới, không phải câu hỏi đang chặn dự án.

Từ mô hình sản xuất kết hợp và nhận màu/quy cách riêng đã xác nhận, cần làm rõ ba quan hệ nghiệp vụ:

- **Đơn hàng với hàng có thể giao:** Có hàng trong kho chưa chắc có thể dùng cho đơn nếu sai màu/quy cách, chưa đạt chất lượng hoặc đã dành cho khách khác. Cách giữ hàng và điều kiện hàng được giao còn cần anh xác nhận, chưa phải quy tắc đã chốt.
- **Số lượng cần giao với số lượng cần sản xuất:** Cần phân biệt lượng thành phẩm đạt cần bổ sung với lượng bắt đầu sản xuất; hàng lỗi, làm lại và hao hụt có thể làm hai lượng khác nhau. Chưa tự đặt tỷ lệ hao hụt.
- **Ngày giao với nguồn lực và thời gian chờ:** Cần khảo sát riêng ngói và Terrazzo, cả thời gian làm, thời gian chờ, chuyển mẫu/màu và nguồn lực dùng chung nếu có. Một xưởng không đồng nghĩa chỉ có một dây chuyền hoặc hai nhóm dùng cùng quy trình.

**Tình huống giả lập để trao đổi, chưa được chốt:** Khách cần 10.000 viên một mẫu/màu/quy cách, trong kho có 3.000 viên cùng loại. Nếu cả 3.000 viên đều đạt, được phép giao và chưa dành cho đơn khác thì còn cần bổ sung 7.000 viên đạt. Chưa thể kết luận phải bắt đầu sản xuất đúng 7.000 viên hoặc giao được ngày nào khi chưa biết hao hụt, công đoạn và năng lực. Dùng tình huống này để anh kể ai làm gì từ nhận nhu cầu đến thành phẩm; không coi số liệu là thực tế Nasaki.

Kết quả cần có sau vòng trả lời: mô tả riêng quy trình hai nhóm; điều kiện bắt đầu, người đề nghị/duyệt và bàn giao; vật liệu/công thức; mẻ/lô và quan hệ với đơn; thời gian/năng lực; điều kiện hoàn tất và xử lý lỗi. Chỉ những phần có câu trả lời mới chuyển sang dữ kiện xác nhận.

### Câu hỏi tham chiếu nếu sau này khảo sát thực tế

Anh có thể trả lời riêng cho ngói và Terrazzo, theo cách thực tế anh biết. Nếu chưa biết, ghi "chưa rõ, em đề xuất"; ví dụ trong câu hỏi không phải xác nhận về quy trình Nasaki.

1. **Công đoạn:** Từ vật liệu đến thành phẩm, ngói và Terrazzo lần lượt trải qua những bước nào? Có công đoạn thuê ngoài không?
2. **Vật liệu và công thức:** Mỗi nhóm dùng những vật liệu chính nào, đo bằng đơn vị gì? Có công thức cho một mẻ hoặc một số lượng viên không; mẫu/màu riêng có làm đổi công thức không?
3. **Mẻ/lô sản xuất:** Thường làm bao nhiêu viên mỗi mẻ/lô? Một mẻ có phục vụ nhiều đơn không? Khi đổi mẫu hoặc màu, phải đổi khuôn, vệ sinh hay dừng máy bao lâu?
4. **Quyết định làm hàng và ưu tiên:** Ai đề nghị/duyệt sản xuất hàng sẵn, dựa vào tồn tối thiểu hay dự báo nào? Với hàng theo đơn, điều kiện nào cho phép bắt đầu: đơn đã được duyệt, mẫu đã duyệt, nhận cọc hoặc điều kiện khác? Khi thiếu năng lực, quản lý sản xuất và CEO ưu tiên theo ngày đã hứa, mức khẩn, giá trị đơn hay nguyên tắc khác?
5. **Thời gian và năng lực:** Có bước chờ khô/dưỡng hộ hoặc chờ khác trước khi giao không? Xưởng làm mấy ca, năng suất ước lượng thế nào; máy hoặc công đoạn nào thường khiến cả luồng phải chờ?
6. **Chất lượng và hoàn tất:** Kiểm tra ở bước nào, ai xác nhận hàng được nhập thành phẩm/giao khách? Hàng không đạt được làm lại, hạ loại hay bỏ; lượng đạt/lỗi được ghi thế nào?

## Các điểm còn mở

- Mẫu, màu, kích thước và quan hệ biến thể; mã chuẩn của sản phẩm có nhiều cách viết.
- Điều kiện nhận đơn và cho phép thực hiện, người bàn giao, tham số giá, cam kết ngày giao và tiêu chí ưu tiên.
- Người đại diện khách, cách duyệt mẫu và tiêu chuẩn đối chiếu; duyệt hoặc chỉnh đề xuất đổi/hủy đơn đặt riêng, điều kiện cọc và quyết toán.
- Xem xét/chỉnh mô hình sản xuất giả lập P01–P06; số liệu thực tế chưa có không chặn phân tích demo. Thông số từng nguồn lực và bộ dữ liệu sẽ được Codex đề xuất cụ thể khi phát triển yêu cầu, không yêu cầu anh cung cấp công thức sản xuất thật.
- Xem xét/chỉnh [quy trình kho chi tiết](warehouse-workflows.md) và mô hình mua hàng M01–M03; hoàn thiện danh mục/bộ dữ liệu demo, đối chiếu giao hàng/tài chính và quy tắc giá trị. Chín nhóm RK01–RK09 đã có phương án cụ thể, chưa có kiểm chứng phần mềm.
- Xem xét/chỉnh [giao hàng và tài chính cơ sở](delivery-finance-workflows.md), gồm giao từng đợt, cọc/thu/phân bổ/công nợ, trả/hoàn tiền, giá thành/giá vốn và báo cáo quản trị; chưa được kiểm chứng phần mềm.
- Tài chính chi tiết, kế toán, thuế/hóa đơn, ngoại tệ/xuất khẩu, tài sản, vay và ngân sách giữ để phân tích sau theo B21, không tự loại khỏi phạm vi. Nguồn giờ/chi phí nhân công đã có phương án cơ sở trong nhân sự, cần bộ dữ liệu để đối chiếu.
- Xem xét/chỉnh [nghiệp vụ nhân sự](hr-workflows.md), cụ thể hóa chính sách và dữ liệu mẫu, kiêm nhiệm, quyền/phê duyệt và bàn giao xuyên bộ phận; chưa có kiểm chứng ứng dụng.
- Tình huống thực tế và số liệu thể hiện mức độ ảnh hưởng của khó khăn; các chỉ số để đánh giá chuyển đổi số.
- Bộ dữ liệu demo, mức sử dụng đồng thời, cách đối tác dùng thử, mốc trình diễn và chi phí vận hành.

## Quy tắc duy trì hồ sơ

Khi có câu trả lời mới, cập nhật phần hiện hành của hồ sơ và ghi lại trao đổi trong README. Quyết định mới thay thế đề xuất cũ phải được chỉ rõ, không xóa lịch sử để che mất thay đổi. Chỉ bổ sung quy tắc và kết quả nghiệp vụ có nguồn; các đề xuất giữ nhãn đề xuất đến khi được xác nhận.

Khi đi vào thiết kế và phát triển, dùng các quyết định và quy trình đã xác nhận để lập yêu cầu, tiêu chí nghiệm thu và kiểm tra kết quả. Không coi việc có hồ sơ này là đã hoàn thành phân tích hoặc đủ điều kiện triển khai toàn bộ ERP.
