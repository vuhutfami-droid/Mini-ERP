# Quy trình kho cho demo ERP Nasaki

Tài liệu này cụ thể hóa chín nhóm RK01–RK09 đã rà soát trong [hồ sơ nghiệp vụ](business-context.md). Anh đồng ý giao Codex cụ thể hóa ngày 04/10/2026; các quy tắc chi tiết dưới đây là phương án Codex đề xuất cho demo, không phải quy trình thực tế của Nasaki và chưa được anh duyệt riêng từng tham số. Mục tiêu là đủ rõ để chuyển thành yêu cầu và kiểm chứng về sau, chưa phải yêu cầu lập trình ngay.

Giữ mô hình 1 công ty, 1 xưởng, 1 kho, có ngói và Terrazzo; sản phẩm quản lý theo viên. CEO và giám đốc đứng riêng là cùng người. Đây là tài liệu nghiệp vụ, không phải hướng dẫn sản xuất vật lý, thiết kế màn hình hoặc cơ sở dữ liệu. Lịch sử trao đổi nằm trong [README](../README.md).

## Phạm vi và trách nhiệm

Kho vật lý là nơi giữ hàng; khu vực và trạng thái chỉ phân loại hàng trong cùng kho, không tạo kho mới. Lượng đang trên công đoạn thuộc sản xuất, hàng đã rời kho thuộc theo dõi giao hàng, không cộng vào lượng đang nằm trong kho. Quyền sở hữu được xác định bằng chứng từ nguồn, không suy ra chỉ từ vị trí.

Trong demo cơ sở, hàng đạt, thuộc doanh nghiệp, chưa hết hạn nếu có và không bị khóa là lượng được phép dùng. Gọi lượng này là **tồn đạt được phép dùng**; khả dụng bằng lượng đó trừ lượng đã dành. Hàng chờ kiểm tra, lỗi hoặc bị khóa không được giữ mới hoặc xuất bình thường. Tổng tồn vật lý gồm cả các phần chưa được phép dùng đang ở kho; không cộng lượng đã dành thêm lần nữa vào tổng tồn.

| Công việc đề xuất | Người thực hiện và điều kiện |
| --- | --- |
| Lập danh mục và phiếu kho | Kho lập; người phụ trách nghiệp vụ kiểm tra; danh mục mới/đổi quy cách quan trọng do giám đốc duyệt. |
| Nhập, xuất, chuyển vị trí thông thường | Kho xác nhận đúng lượng thực tế trên nguồn đã được duyệt; không cần giám đốc duyệt lại mọi lần giao từng phần. |
| Yêu cầu giữ hàng | Kinh doanh cho đơn bán, quản lý sản xuất cho lệnh; kho xác nhận phân bổ theo nguồn và lượng còn được dùng. |
| Kiểm tra, khóa và giải phóng chất lượng | Người kiểm tra chất lượng ghi kết quả và khóa ngay khi có nghi vấn; chỉ bỏ khóa sau đánh giá đạt và xử lý được phê duyệt nếu có. |
| Hủy/chuyển lượng giữ giữa các nhu cầu | Người phụ trách đơn/lệnh đề nghị; giám đốc duyệt thay đổi ưu tiên hoặc hủy nguồn; kho thực hiện giải phóng/chuyển đúng phạm vi. |
| Xuất mẫu, dùng nội bộ, tiêu hủy, chênh lệch kiểm kê | Kho lập, bộ phận liên quan xác nhận mục đích/đánh giá; giám đốc duyệt, kho xác nhận thực hiện. |
| Đối chiếu giá trị và nghĩa vụ tiền | Kế toán nhận chứng từ kho, không sửa lượng kho để làm khớp số tiền. |

Vai trò có thể kiêm nhiệm, không tự tăng số nhân sự. Các việc điều chỉnh tồn, tiêu hủy và xử lý ngoại lệ cần người duyệt khác người lập trong bộ dữ liệu demo. Quyền xem và quyền xác nhận được tách; không phải ai xem báo cáo cũng được sửa chứng từ.

## Danh mục hàng vị trí và đơn vị

Áp dụng cho RK01. Kho lập danh mục gồm loại vật tư/thành phẩm, mã chính, tên gọi khác, mẫu, màu, quy cách, đơn vị cơ sở, quy đổi đóng gói, yêu cầu lô và hạn dùng nếu có. Giám đốc duyệt trước khi dùng danh mục mới. Tên/mã nguồn từ website không phải bằng chứng hai màu hoặc hai kích thước thay thế được nhau.

- Đề xuất mã kho `KHO-01`, khu vật tư `VT-01`, thành phẩm `TP-01`, chờ kiểm tra/xử lý `CC-01`, hàng lỗi/chờ trả `HL-01`. Đây là mã giả lập của một kho; vị trí và chất lượng là hai thông tin khác nhau.
- Đề xuất dùng `FP-04` làm mã tham chiếu ngói phẳng và giữ `FP - 04` là tên mã khác; mỗi màu/quy cách dùng biến thể riêng. Đây là lựa chọn chuẩn hóa cho demo, không khẳng định mã nội bộ Nasaki.
- Viên chỉ nhận số nguyên; kg/lít nhận tối đa ba chữ số thập phân trong demo. Quy đổi ví dụ xi măng 1 bao = 50 kg chỉ áp dụng cho loại xi măng đã định nghĩa tại M03. Phiếu lưu cả đơn vị nhập và lượng cơ sở; không sửa tỷ lệ cũ khi đổi đóng gói mới.
- Một lô nguồn có thể nằm ở nhiều khu vực hoặc nhiều trạng thái; tổng các phần phải bằng lượng còn lại của lô. Mã lô nội bộ không được trùng; lưu mã lô nhà cung cấp riêng vì hai nhà cung cấp có thể dùng cùng mã.

Kết quả hoàn tất là danh mục được duyệt có đủ thông tin để phân biệt hàng và tính lượng. Mỗi dòng giao dịch dùng số lượng dương; phiếu điều chỉnh chỉ rõ tăng/giảm, không nhập số âm để lách điều kiện xuất. Thiếu quy đổi, sai độ chính xác hoặc dùng 1,5 viên thì chưa cho xác nhận phiếu; không tự làm tròn mất lượng. Hàng ngừng kinh doanh vẫn giữ lịch sử và được xử lý tồn, không xóa danh mục đã phát sinh giao dịch.

## Xác lập tồn ban đầu

Áp dụng cho RK02. Kho đếm tại một mốc bắt đầu, lập phiếu tồn đầu theo hàng/biến thể, lô, khu vực, trạng thái, lượng và căn cứ nguồn. Lô cũ không rõ được ghi bằng mã lô mở đầu riêng có nhãn không rõ nguồn, không bịa nhà cung cấp hoặc ngày sản xuất.

Kế toán kiểm tra căn cứ giá trị ban đầu; người kiểm tra chất lượng xác nhận phần được dùng; giám đốc duyệt. Kho xác nhận phiếu một lần trước giao dịch vận hành. Hàng chưa đánh giá để chờ kiểm tra; lượng đã dành chỉ được tạo từ đơn/lệnh nguồn rõ ràng, không nhập một con số giữ hàng không có căn cứ.

Tồn đầu không tạo đơn mua, doanh thu hoặc sản lượng mới. Phát hiện sai trước vận hành thì sửa nháp; sau xác nhận thì lập điều chỉnh được duyệt, không nạp lại toàn bộ tồn đầu. Chưa có giá trị được xác minh thì không báo giá vốn/lợi nhuận là đã đúng; việc kiểm tra lượng vẫn có thể tiếp tục.

## Nhập xuất và hàng đang giao

Áp dụng cho RK03 và K02. Điều kiện nguồn phải rõ: nhập mua có đơn/phiếu giao; nhập sản xuất có lệnh/lô và kết quả kiểm tra; xuất sản xuất có lệnh; xuất khách có đơn, người nhận và điều kiện giao được đáp ứng. Nguồn chưa sẵn sàng thì ghi nhận nhu cầu hoặc nháp, không giả lập đã giao/đã cấp.

1. Khi nhận hàng mua, kho đếm thực nhận, lập phiếu theo từng đợt và đưa vào chờ kiểm tra. Xác nhận nhận làm tăng tồn vật lý, chưa tăng lượng được dùng. Chất lượng xác nhận từng phần đạt/lỗi; phần đạt mới chuyển sang được dùng. Nhập thành phẩm đã có kết quả chất lượng tại P05 chỉ ghi một lần, không nhập lần nữa khi kế toán ghi giá trị.
2. Khi soạn hàng giao, kho chọn đúng biến thể/lô, giữ và chuyển tới vị trí chờ xuất nếu cần. Hàng vẫn ở kho, tổng tồn chưa giảm. Xác nhận hàng thực rời kho mới giảm tồn vật lý và lượng được dùng, đồng thời giảm phần giữ tương ứng; giao từng phần không đóng cả đơn.
3. Phiếu xuất bàn giao lượng, lô, người nhận/vận chuyển và thời điểm cho giao hàng. Trạng thái đang giao tách khỏi khách đã nhận; chỉ bộ phận giao hàng ghi kết quả nhận. Khách từ chối không tự cộng lại tồn; hàng thực quay về kho mới lập nhận trả.
4. Cấp vật tư cho sản xuất giảm tồn kho và chuyển trách nhiệm tới lệnh; không tự coi toàn bộ lượng cấp là đã tiêu hao. Phiếu hoàn trả và ghi nhận thực dùng của sản xuất phải được đối chiếu.
5. Chuyển vị trí trong kho ghi vị trí nguồn/đích và lượng; không tạo thêm tồn, không tự đổi chất lượng. Hàng bên khác gửi hoặc hàng sai chưa xác định nguồn được theo dõi cách ly, không đưa vào lượng doanh nghiệp được phép bán; ký gửi không thuộc tình huống cơ sở.

Giao thừa, thiếu, sai loại hoặc mất/vỡ khi vận chuyển phải lưu thực tế và chờ phương án có duyệt. Không sửa phiếu xuất gốc thành một lượng khác để che tình huống; trách nhiệm, doanh thu và bồi thường bàn giao giao hàng/tài chính phân tích sau.

## Giữ giải phóng và chuyển phân bổ

Áp dụng cho RK04. Kinh doanh/quản lý sản xuất đề nghị số lượng theo nguồn đã duyệt; kho chọn các lô được phép dùng và xác nhận. Mỗi phần giữ liên kết đúng đơn/lệnh, lượng, lô và thời điểm. Đơn dự kiến chưa chốt không chiếm tồn lâu dài trong demo cơ sở.

- Chỉ giữ đủ khi lượng khả dụng đáp ứng toàn bộ yêu cầu của lần xác nhận. Nếu thiếu, báo lượng có thể giữ và phần thiếu; người phụ trách chọn giữ một phần bằng yêu cầu riêng hoặc chờ bổ sung, không âm thầm chấp nhận thiếu.
- Khi xuất từ phần đã giữ, giảm tồn và lượng giữ cùng một lần; phần chưa xuất vẫn giữ cho đúng nguồn. Xuất nhu cầu khác không được lấy lượng đã dành cho nguồn này.
- Đơn/lệnh giảm hoặc hủy đã được duyệt thì kho giải phóng phần chưa xuất không còn cần. Không giải phóng phần đã xuất, không cộng tồn vật lý; hàng đã xuất cần quy trình nhận trả hoặc điều chỉnh phù hợp.
- Chuyển ưu tiên giữa hai nguồn cần giám đốc duyệt, ghi lý do và ảnh hưởng cam kết; giải phóng nguồn cũ và giữ nguồn mới được kiểm tra cùng nhau. Đơn mới vẫn phải đúng biến thể, không tự thay hàng riêng thành hàng chuẩn.
- Khi lô bị khóa hoặc đếm thiếu, ngừng cho xuất phần nghi vấn ngay và đánh dấu các đơn/lệnh liên quan bị thiếu. Phần giữ trên lượng không được dùng chuyển thành nhu cầu chưa được đáp ứng, không tiếp tục tính là giữ hợp lệ. Kho phối hợp sản xuất/kinh doanh và giám đốc phân bổ lại theo ưu tiên P04; không giữ vượt lượng được dùng.

Không tự hết hạn giữ chỉ vì qua một số ngày: demo dùng quyết định thay đổi/hủy nguồn hoặc người có quyền giải phóng có lý do. Báo cáo vẫn cảnh báo giữ lâu để xử lý, không tự làm mất cam kết với khách.

## Xuất mẫu hàng vỡ mất và tiêu hủy

Áp dụng cho RK05. Xuất mẫu/kiểm tra tiêu hao/dùng nội bộ cần phiếu riêng ghi mục đích, bộ phận/người nhận, hàng/lô, lượng và nguồn yêu cầu. Giám đốc duyệt; kho xác nhận thực cấp. Xuất mẫu có giảm tồn nhưng không tự tạo doanh thu, và mẫu có hoàn trả phải theo phiếu nhận trả liên kết.

Khi phát hiện hàng vỡ/hỏng, kho lập biên bản kèm lượng và lý do; người kiểm tra chất lượng chuyển phần đó sang lỗi/chờ xử lý ngay. Phần còn nằm trong kho giữ nguyên tổng tồn vật lý nhưng không được dùng. Nếu ảnh hưởng hàng đã dành, xử lý thiếu theo phần giữ hàng trên.

Giám đốc duyệt phương án làm lại, trả hoặc tiêu hủy. Kho chỉ xác nhận tiêu hủy khi thực hiện, ghi lượng và chứng cứ/biên bản; lúc này tổng tồn mới giảm. Làm lại chuyển trách nhiệm sang lệnh làm lại, chỉ nhận lại lượng đạt có kết quả; không giữ đồng thời cùng lượng ở kho và ở sản xuất.

Hàng mất thực tế không thể chuyển sang khu hàng lỗi như hàng còn hiện hữu. Kho kiểm kê phần liên quan, lập thiếu/mất có lý do, giám đốc duyệt điều chỉnh giảm; trong lúc xử lý khóa phần nghi vấn không cho xuất. Chi phí, trách nhiệm và bồi thường bàn giao tài chính/nhân sự, không tự trừ lương hoặc tiền khách.

## Nhận trả và trả nhà cung cấp

Áp dụng cho RK06. Mỗi yêu cầu trả phải liên kết chứng từ gốc; lượng được trả theo nguồn không vượt lượng gốc đã thực giao/cấp trừ tổng lượng đã nhận trả trước đó. Hàng quay về nhiều đợt được ghi từng đợt. Trường hợp vật lý nhận thừa hoặc chưa xác định nguồn vẫn phải ghi thực nhận cách ly và lập ngoại lệ, không che mất hàng hoặc tự gán cho một phiếu cũ.

- Khách trả: kinh doanh ghi lý do và đề nghị; giám đốc duyệt phương án thương mại. Kho nhận thực tế vào chờ kiểm tra; không chờ hoàn tất thương lượng mới ghi hàng thực đang ở kho. Chất lượng phân loại đạt/làm lại/lỗi; chỉ phần đạt, không bị khóa và được phép dùng mới trở lại khả dụng. Hàng riêng không tự chuyển thành hàng tiêu chuẩn. Quyết định giao bù/hủy phần bán và hoàn tiền bàn giao kinh doanh/tài chính, không tự thay đổi từ việc nhận trả.
- Sản xuất trả vật tư dư: quản lý sản xuất xác nhận lượng chưa dùng và lệnh gốc; kho nhận/kiểm tra. Tổng hoàn trả không vượt tổng đã cấp cho nguồn trừ lượng đã hoàn, và phải phù hợp lượng thực dùng/hao hụt; không nhận lại lượng đã được ghi tiêu hao mà chưa điều chỉnh có căn cứ.
- Trả nhà cung cấp: mua hàng thống nhất phương án, giám đốc duyệt; kho giữ riêng và xác nhận thực xuất đúng lô/phiếu nhận, trừ lượng đã trả trước. Tổng tồn giảm khi rời kho, không giảm lần nữa khi nhà cung cấp xác nhận hoặc kế toán ghi giảm nghĩa vụ. Hàng đổi về là lần nhận mới liên kết lần trả, qua kiểm tra.

Mỗi phần nhận trả có lượng, tình trạng và kết quả xử lý; giữ chứng từ gốc, không xóa việc đã giao/cấp. Thiếu liên kết hoặc số lượng bất thường phải được giải quyết trước khi cho hàng dùng, không tự phê duyệt do đã cầm hàng về kho.

## Khóa lô truy nguồn và thu hồi

Áp dụng cho RK07. Người kiểm tra chất lượng nhận phản ánh hoặc phát hiện bất thường, ghi lý do, phạm vi, thời điểm và khóa phần bị ảnh hưởng ngay. Khóa không phải tiêu hủy và không làm giảm tổng tồn; loại phần đó khỏi lượng được dùng, xử lý giữ hàng theo quy trình trên.

Kho cùng sản xuất truy phiếu nhận vật tư, các lệnh đã dùng, lô thành phẩm liên quan và từng đợt giao/người nhận. Chỉ rõ phần còn ở kho, đang sản xuất, đang giao và đã giao; không mặc định lô đã dùng xong là không còn rủi ro.

Giám đốc duyệt phương án sau đánh giá chất lượng: kiểm tra lại, làm lại, trả/tiêu hủy hoặc thông báo thu hồi. Kinh doanh/giao hàng liên hệ đối tượng bị ảnh hưởng; hàng chưa quay về chỉ là lượng cần thu hồi, không phải tồn kho. Kho nhận hàng quay về theo quy trình nhận trả; kết quả thu hồi lưu cả phần chưa thu được và lý do.

Chỉ người kiểm tra chất lượng được bỏ khóa sau khi có kết quả đạt và hoàn tất điều kiện của phương án duyệt; kho không tự bỏ khóa để kịp giao. Lưu cả lý do khóa, đánh giá, người duyệt và thời điểm giải phóng.

## Chứng từ quyền và điều chỉnh kiểm kê

Áp dụng cho RK08 và K03. Chứng từ thông thường đi từ nháp tới xác nhận; loại cần duyệt đi từ nháp tới chờ duyệt, được duyệt rồi mới xác nhận thực hiện. Nháp/chờ duyệt/được duyệt chưa tự biến động tồn. Nháp chưa ghi tồn có thể hủy; chứng từ đã xác nhận giữ lịch sử, sửa bằng phiếu điều chỉnh hoặc đảo liên kết.

1. Trước xác nhận, kiểm tra quyền, nguồn, loại hàng/lô, đơn vị, lượng, trạng thái chất lượng và lượng được phép dùng tại chính thời điểm xác nhận. Bấm lại hoặc nhận lại cùng yêu cầu chỉ trả kết quả cũ, không ghi biến động lần hai.
2. Nếu hai người cùng giữ/xuất lượng không đủ, chỉ yêu cầu đáp ứng đầy đủ được xác nhận; yêu cầu còn lại báo tồn mới và lượng thiếu. Không duyệt cả hai dựa trên cùng ảnh chụp tồn cũ.
3. Đề xuất demo cơ sở không cho xác nhận giao dịch mới có thời điểm trước mốc tồn đầu hoặc trước lần biến động đã xác nhận gần nhất của hàng/lô liên quan. Phát hiện sai cũ dùng điều chỉnh hiện tại có tham chiếu ngày thực tế và chứng từ cũ; không tự mở lịch sử để ghi lùi. Quy tắc khóa kỳ tài chính sẽ bổ sung sau, không suy ra kỳ kế toán đã chốt.
4. Kho lập yêu cầu đảo/điều chỉnh; giám đốc duyệt. Phải kiểm tra nhập đã xuất/dùng/giữ, xuất đã được khách nhận/nhận trả, lô đã làm lại và ảnh hưởng các phiếu sau. Chưa xử lý phụ thuộc thì không xác nhận đảo. Đảo xuất chỉ để sửa ghi nhận sai khi hàng thực chưa rời hoặc có căn cứ; hàng thực quay về dùng nhận trả, không đảo để giả như chưa từng giao.
5. Kiểm kê: kho chốt hàng/lô/khu vực và thời điểm, tạm ngừng giao dịch phần đếm, người kiểm tra khác người đếm đối chiếu. Giám đốc duyệt biên bản thiếu/thừa và lý do; kho ghi điều chỉnh theo từng trạng thái. Khi thiếu ảnh hưởng lượng đã dành, xử lý các phân bổ cùng việc điều chỉnh để không còn giữ vượt tồn đạt; kho không tự chọn bỏ cam kết khách.

Mỗi xác nhận lưu người, thời điểm ghi nhận, thời điểm thực tế, nguồn, lượng trước/sau và lý do nếu ngoại lệ. Lập một chứng từ không đồng nghĩa hoàn tất nghiệp vụ: phiếu tiêu hủy được duyệt nhưng chưa thực hiện không được giảm tồn.

## Báo cáo cảnh báo và bàn giao

Áp dụng cho RK09. Báo cáo số lượng tính từ tồn đầu và các biến động đã xác nhận, không từ nháp hoặc con số nhập tay trên báo cáo. Chọn được mốc báo cáo, hàng/biến thể, lô, khu vực và trạng thái; báo cáo lượng dùng được/đã dành cũng phải theo đúng mốc đã chọn.

| Nội dung | Cách đọc và người xử lý |
| --- | --- |
| Nhập xuất tồn | Kho/kế toán đối chiếu: tồn cuối = tồn đầu + nhận vào - thực xuất + điều chỉnh tăng - điều chỉnh giảm. Chuyển vị trí/chất lượng, giữ/giải phóng không tự đổi tổng tồn. |
| Tồn được dùng và phân bổ | Kinh doanh/sản xuất xem khả dụng, đơn/lệnh đang giữ và phần thiếu; lượng đang về có cột riêng, không cộng vào tồn thực tế. |
| Hàng chờ lỗi khóa hoặc thu hồi | Chất lượng/kho xem số ngày chờ, nguyên nhân và người phụ trách; giám đốc quyết phương án khi cần. |
| Dưới ngưỡng và tồn lâu | Kho/sản xuất đề nghị bù hoặc xử lý; cảnh báo không tự tạo mua, hủy giữ hoặc tiêu hủy. |
| Đối chiếu nguồn | Mua nhận/trả, lệnh cấp/hoàn/thực dùng, đơn xuất/nhận trả và lô nhập/đã phân bổ; chênh lệch phải chỉ ra nguồn và lượng. |

Thông số giả lập ban đầu: xi măng M03 cảnh báo khi khả dụng dưới 500 kg; thành phẩm ngói biến thể minh họa dưới 1.000 viên, Terrazzo dưới 500 viên; giữ hàng/chờ kiểm tra trên 3 ngày làm việc; tồn lâu trên 30 ngày kể từ nhập. Vật tư có hạn cảnh báo khi còn không quá 7 ngày lịch, hết hạn thì không được dùng. Đây là ngưỡng đề xuất theo hàng, có thể chỉnh; không làm sửa lịch sử cảnh báo đã ghi. Các ngưỡng cảnh báo không thay đổi lượng mua của ví dụ M03 vốn chỉ bù nhu cầu tám lô, chưa mua bù mức tồn mục tiêu riêng.

Giá trị tồn, phương pháp giá vốn, thuế và thời điểm doanh thu thuộc tài chính. Kho bàn giao lượng, nguồn, thời điểm, trạng thái và chứng cứ chi phí, không tự chọn phương pháp định giá hoặc đồng nhất ra khỏi kho với chuyển quyền sở hữu. Giao hàng nhận thông tin xuất/đang giao; chất lượng nhận dữ liệu lô và xử lý lỗi; sản xuất nhận lượng cấp/hoàn và vật tư được dùng.

## Tình huống liên hoàn kiểm chứng số lượng

Toàn bộ dữ liệu dưới đây giả lập trên một biến thể ngói, độc lập với ví dụ tám lô P06. Cột đã dành là phần nằm trong lượng được dùng, không cộng thêm vào tổng tồn. Mọi bước cần chứng từ và điều kiện phê duyệt tương ứng ở trên.

| Sự kiện | Tồn vật lý | Được dùng | Đã dành | Khả dụng | Chờ kiểm tra hoặc lỗi |
| --- | ---: | ---: | ---: | ---: | ---: |
| Xác nhận tồn đầu 1.000 viên đạt | 1.000 | 1.000 | 0 | 1.000 | 0 |
| Giữ 600 cho một đơn đã duyệt | 1.000 | 1.000 | 600 | 400 | 0 |
| Soạn 200 từ lượng đã giữ | 1.000 | 1.000 | 600 | 400 | 0 |
| Xác nhận 200 thực rời kho | 800 | 800 | 400 | 400 | 0 |
| Hủy phần chưa giao và giải phóng 400 theo quyết định | 800 | 800 | 0 | 800 | 0 |
| Phát hiện 50 vỡ và chuyển lỗi | 800 | 750 | 0 | 750 | 50 |
| Duyệt rồi thực tiêu hủy 50 | 750 | 750 | 0 | 750 | 0 |
| Khách trả thực nhận 20 từ lần giao 200 | 770 | 750 | 0 | 750 | 20 |
| Kiểm tra trả có 15 đạt và 5 lỗi | 770 | 765 | 0 | 765 | 5 |
| Kiểm kê thiếu 2 viên đạt và xác nhận điều chỉnh đã duyệt | 768 | 763 | 0 | 763 | 5 |

Đối chiếu tổng: 1.000 + 20 - 200 - 50 - 2 = 768 viên. Năm viên lỗi còn nằm trong kho, không được bán, chưa tiêu hủy. Quyết toán 20 viên trả và việc có cần giao bù được ghi là quyết định riêng của kinh doanh/tài chính; bảng này không tự tính doanh thu, công nợ hoặc lượng còn phải giao.

## Các trường hợp phải ngăn và kết quả mong đợi

- Chạy lại khởi tạo hoặc xác nhận cùng phiếu: không nhân đôi biến động; mở lại dữ liệu vẫn có cùng số và lịch sử.
- Đặt giữ 600 khi chỉ khả dụng 400: không xác nhận đủ; báo thiếu 200, chỉ giữ một phần khi có yêu cầu mới rõ ràng.
- Hai người cùng giữ 300 khi chỉ còn 400: yêu cầu đầu hợp lệ giữ 300, còn 100; yêu cầu thứ hai giữ đủ 300 bị từ chối và báo thiếu 200. Tổng giữ không vượt 400.
- Xuất 1,5 viên, sai biến thể hoặc xuất bán/cấp sản xuất thông thường từ lô khóa/hết hạn: không xác nhận; lô khác chỉ được chọn khi phù hợp và đủ điều kiện. Xuất trả, làm lại hoặc tiêu hủy hàng bị khóa cần đúng phương án xử lý được duyệt, không áp dụng như xuất bán thông thường.
- Nhận 20 chờ kiểm tra: tăng tồn vật lý 20, không tăng khả dụng; phân loại chỉ 15 đạt thì khả dụng tăng 15, không tăng 20.
- Sau đã nhận trả 20 của lần xuất 200, yêu cầu nhận trả thêm 190 theo cùng nguồn vượt lượng còn 180: không tự xác nhận là trả hợp lệ; lượng thực đã về nếu có phải ghi cách ly và xử lý ngoại lệ.
- Khóa toàn bộ lô đạt 500 đang giữ 300: tổng vật lý không đổi, được dùng/giữ hợp lệ/khả dụng của phần đó về 0; nhu cầu 300 của nguồn được báo chưa đáp ứng, không tự biến mất.
- Tiêu hủy chỉ mới duyệt: tồn vật lý chưa giảm. Đảo nhập đã có xuất tiếp: không thực hiện khi chưa xử lý giao dịch phụ thuộc.
- Xem báo cáo sau khi chuyển vị trí hoặc giữ hàng: tổng tồn không đổi. Xem thời điểm trước giao dịch sau: trả về số tại đúng mốc, không dùng phân bổ hiện tại cho quá khứ.

Các kết quả này là tiêu chí nghiệp vụ trên tài liệu, chưa được kiểm thử trong phần mềm. Kho hiện chưa có mã ứng dụng hoặc lịch sử build/test. Trước phát triển còn cần đối chiếu tài chính/giao hàng, chốt bộ danh mục và dữ liệu demo đầy đủ, rồi chuyển các quy tắc thành yêu cầu triển khai. Không cần anh cung cấp thêm chuyên môn Nasaki để làm các bước đề xuất đó.
