# Giao hàng và tài chính cho demo ERP Nasaki

Tài liệu này đề xuất quy trình giao hàng, thu chi, công nợ, giá thành và báo cáo quản trị nối với [hồ sơ nghiệp vụ](business-context.md) và [quy trình kho](warehouse-workflows.md). Anh yêu cầu chuyển sang nghiệp vụ tiếp theo ngày 04/10/2026. Các quy tắc và số liệu bổ sung là giả lập cho demo, chưa được anh duyệt riêng từng chi tiết và không phải hiện trạng hoặc chính sách kế toán pháp định của Nasaki.

Demo phải lưu giao dịch và tạo kết quả tính được. Đây là phân tích nghiệp vụ, chưa triển khai ứng dụng. Giữ một công ty, một xưởng, một kho, cả ngói và Terrazzo, phạm vi đủ bảy nhóm nghiệp vụ. CEO/giám đốc là cùng người; người đặt, trả tiền và nhận hàng có thể khác nhau như đã xác nhận. Lịch sử trao đổi tiếp tục lưu tại [README](../README.md).

## Các sự kiện phải tách biệt

| Sự kiện | Ý nghĩa trong mô hình đề xuất |
| --- | --- |
| Giám đốc duyệt đơn | Xác nhận cam kết thương mại; chưa tự phát sinh doanh thu, thu tiền hoặc xuất kho. |
| Nhận cọc hoặc ứng trước | Có tiền thực nhận, gắn khách/đơn; chưa tự ghi doanh thu hoặc coi khách đã nhận hàng. |
| Hàng rời kho | Kho giảm lượng tại kho, giao hàng theo dõi đang giao; giá trị hàng chuyển sang đang giao, chưa tự ghi giá vốn bán. |
| Khách nhận và chấp nhận hàng | Có xác nhận lượng thực nhận/được chấp nhận; đề xuất dùng làm điều kiện ghi nhận giá trị bán trong tình huống demo cơ sở. |
| Kế toán xác nhận chứng từ bán | Ghi doanh thu và phải thu đúng phần đủ điều kiện, đồng thời ghi giá vốn; không xuất kho thêm lần nữa. |
| Nhận và phân bổ tiền | Tiền thực nhận làm tăng quỹ/tài khoản; phân bổ tới nghĩa vụ cụ thể làm giảm phải thu, không ghi doanh thu lần hai. |

Điều kiện ghi doanh thu ở trên là lựa chọn minh họa, không kết luận cách ghi nhận hợp đồng thật, hóa đơn pháp lý hoặc chuyển quyền sở hữu. Các hợp đồng đặc biệt/xuất khẩu cần được phân tích riêng; không tự áp dụng quy tắc này cho mọi điều kiện giao nhận.

## Chuẩn bị và xác nhận giao hàng

Kinh doanh lập yêu cầu giao dựa trên đơn đã duyệt: biến thể, số lượng còn phải giao, người nhận, địa điểm, ngày và điều kiện thanh toán theo thỏa thuận. Quản lý sản xuất/kho xác nhận hàng đạt được phép dùng và lượng đã dành; kế toán xác nhận điều kiện cọc/hạn mức nếu đơn có điều kiện này. Không tự yêu cầu mọi đơn phải trả đủ trước giao.

1. Người phụ trách giao hàng lập từng đợt giao, cách vận chuyển, người/đơn vị vận chuyển, lượng và phí do bên nào chịu. Kiểm tra người nhận đúng thỏa thuận dù khác người đặt/trả tiền.
2. Kho soạn đúng lô/biến thể, ghi lượng bàn giao; hàng chưa rời kho chưa giảm tồn. Kho xác nhận thực xuất theo quy trình kho; số đã xuất và số khách đã nhận được theo dõi riêng.
3. Người giao ghi lượng thực nhận, phần được chấp nhận, thiếu/vỡ/từ chối, thời điểm và căn cứ xác nhận khách. Đề xuất demo dùng biên bản/ghi nhận xác nhận và tệp chứng cứ nếu có, không tự sinh chữ ký hoặc xác nhận khách giả như thật.
4. Kinh doanh kiểm tra kết quả; phần chấp nhận bàn giao kế toán để ghi nhận bán. Phần không được chấp nhận giữ trạng thái tranh chấp/đang giao cần xử lý, không tự coi toàn bộ phiếu xuất là đã hoàn thành.
5. Giám đốc duyệt phương án giao bù, nhận trả, giảm/hủy phần bán hoặc bồi thường sau đánh giá của kinh doanh, giao hàng và chất lượng. Giao bù vẫn cần yêu cầu được duyệt và phiếu xuất mới; không sửa phiếu cũ thành như chưa có thiếu/vỡ.

Đơn hoàn tất giao khi các lượng cam kết đã được khách chấp nhận hoặc có quyết định giảm/hủy và xử lý ngoại lệ liên quan. Đơn giao đủ nhưng chưa trả đủ vẫn mở trạng thái tài chính; đơn đã trả đủ nhưng chưa giao vẫn mở trạng thái giao hàng.

## Giá bán và giá trị được ghi nhận

Giám đốc quyết định giá/chiết khấu theo thông tin đã xác nhận. Đề xuất lưu bản giá và điều kiện đã duyệt trên đơn; đổi bảng giá không sửa ngược đơn cũ. Kinh doanh lập thay đổi thương mại, giám đốc duyệt và khách xác nhận khi cần trước khi dùng cho phần thay đổi.

Mỗi dòng ghi số viên, giá, chiết khấu cụ thể, thuế nếu có và phí vận chuyển tách riêng. Tổng giảm theo dòng và giảm toàn đơn không được tính cùng khoản hai lần; phần đã ghi nhận giữ bản giá của lần ghi nhận, điều chỉnh sau có chứng từ liên kết.

Kế toán đối chiếu đơn, từng đợt khách chấp nhận và chứng từ để ghi nhận giá trị bán một lần cho đúng lượng. Một đợt chấp nhận có thể được ghi từng phần, nhưng tổng ghi nhận không vượt lượng được chấp nhận và chưa được ghi nhận trước đó. Doanh thu sau điều chỉnh trả/giảm là chỉ tiêu khác tổng giá trị đơn đang cam kết.

## Thu tiền cọc và phân bổ

Người phụ trách quỹ/ngân hàng hoặc kế toán ghi số thực nhận, ngày, tài khoản/quỹ, người chuyển tiền, khách liên quan, chứng từ và nội dung. Có thể kiêm nhiệm trong mô hình tinh gọn, nhưng không ghi tăng tiền chỉ từ giấy đề nghị hoặc ảnh báo chuyển chưa đối chiếu. Giám đốc duyệt điều chỉnh/hoàn tiền và ngoại lệ; thu thông thường theo thỏa thuận không cần tạo hai vòng CEO/giám đốc.

- Trước giao: khoản thực nhận được ghi là ứng trước/cọc cho khách/đơn, không là doanh thu. Điều kiện cọc và xử lý cọc theo thỏa thuận từng đơn, không mặc định mất cọc khi hủy.
- Sau ghi nhận bán: kế toán dùng khoản ứng trước được phép phân bổ để giảm phải thu. Một khoản thu có thể chia cho nhiều nghĩa vụ của đúng khách; mỗi phần có số tiền và nguồn. Tổng phân bổ không vượt số còn chưa dùng của khoản thu hoặc khoản nợ được thanh toán.
- Bên trả khác bên mua: lưu người trả thực tế và căn cứ trả thay, đối chiếu đúng khách/đơn, không tự chuyển nghĩa vụ sang tên người chuyển tiền. Không tự bù chéo giữa hai khách khác nhau.
- Tiền thừa hoặc chưa biết đơn: để chưa phân bổ/ứng trước, chờ đối chiếu; không biến phải thu âm thành khách còn nợ âm trên báo cáo. Khi xác định đúng nguồn mới phân bổ.
- Phân bổ lại cần phiếu điều chỉnh có quyền và lịch sử, không làm tăng/giảm tiền trong ngân hàng lần nữa. Khoản thực thu bị ghi sai cần điều chỉnh riêng, kiểm tra các phân bổ phụ thuộc.

Kế toán đối chiếu tiền với quỹ/sao kê giả lập, không chỉ đối chiếu với tổng doanh thu. Trạng thái tiền đã nhận, khoản đã phân bổ, khoản chưa dùng và khoản phải hoàn là các lượng riêng, không cộng trừ tiền cọc hai lần.

## Công nợ khách hàng và nhà cung cấp

Đề xuất phải thu khách = nghĩa vụ bán đã xác nhận + điều chỉnh tăng - điều chỉnh giảm - khoản đã phân bổ thanh toán. Khi kết quả là dư có, trình bày khoản ứng trước/phải hoàn riêng; không che bằng cách gộp với nợ của khách khác. Tổng tiền của phần đơn chưa ghi nhận là cam kết thương mại, không tự là nợ phải thu đã phát sinh.

Mỗi nghĩa vụ có hạn trả, căn cứ tính hạn và phần đã thanh toán. Đề xuất tình huống cơ sở hạn trả 15 ngày lịch sau ngày chấp nhận đợt giao, được ghi rõ trên đơn và nghĩa vụ; ngày đến hạn chưa là quá hạn, sang ngày kế tiếp phần chưa thanh toán mới quá hạn. Ngoại lệ được ghi theo từng thỏa thuận. Báo cáo đề xuất chia chưa đến hạn và quá hạn 1–30, 31–60, trên 60 ngày; phân bổ trả tới nghĩa vụ được khách/chứng từ chỉ định, không âm thầm đổi chỉ để làm đẹp nợ quá hạn.

Nhà cung cấp theo M01–M03: mua hàng/kế toán đối chiếu đặt mua, hàng được chấp nhận và chứng từ thanh toán. Nghĩa vụ mua, khoản trả trước, khoản đã trả, khoản điều chỉnh trả hàng và khoản chờ hoàn theo dõi riêng. Đặt đơn mua chưa đồng nghĩa chi tiền; nhận vật tư chưa đồng nghĩa vật tư đã được dùng hoặc toàn bộ chi phí đã vào kết quả bán hàng.

Giám đốc xem nợ, phê duyệt hạn mức/thay đổi hạn/ngoại lệ giao hàng khi cần. Demo cơ sở chưa tự đặt một hạn mức cho mọi khách; báo quá hạn hoặc vượt hạn mức đã cấu hình để xin quyết định, không tự xóa nợ hoặc tự dừng mọi đơn khác của khách.

## Thu chi và đối chiếu quỹ

Đề xuất các nhóm chi vật tư, vận chuyển, lương, chi phí xưởng và quản lý. Kế toán lập đề nghị theo chứng từ nguồn, giám đốc duyệt, người phụ trách quỹ/ngân hàng xác nhận thực trả; phiếu mới duyệt chưa giảm tiền. Chi có thể trả nhiều lần nhưng tổng phân bổ không vượt khoản được trả/nguồn tiền. Khoản ứng trước cho nhà cung cấp/nhân viên chưa tự là chi phí đã hoàn tất; người nhận quyết toán hoặc hoàn ứng có chứng từ.

Chuyển tiền giữa quỹ và tài khoản của cùng công ty có hai đầu liên kết, không ghi doanh thu hoặc chi phí chỉ vì chuyển nội bộ. Đề xuất không xác nhận chi vượt số dư quỹ/tài khoản trong demo cơ sở; tiền vay/thấu chi cần nghiệp vụ được mô tả riêng, không giả tạo số dư âm.

Quỹ/ngân hàng đối chiếu số đầu + thực thu - thực chi với số cuối tại cùng mốc. Các khoản chưa khớp giữ danh sách chờ đối chiếu; sửa bằng chứng từ có duyệt, không sửa số cuối trực tiếp. Chứng từ nháp chưa ảnh hưởng tiền/công nợ; xác nhận lại không tạo khoản thứ hai; các điều chỉnh đã xác nhận giữ dấu vết như phần kho.

## Giá thành sản xuất và giá vốn bán

Đề xuất dùng bình quân sau mỗi lần nhập cho giá trị vật tư/thành phẩm theo từng biến thể trong demo quản trị. Thứ tự lấy lô vật lý vẫn theo quy trình kho, không biến thứ tự lấy lô thành phương pháp giá vốn. Phương pháp này là đề xuất, không phải chế độ kế toán Nasaki được xác nhận.

1. Giá trị vật tư nhập có căn cứ giá mua và chi phí mua được phân bổ; thuế được khấu trừ nếu mô phỏng phải tách khỏi giá trị vật tư. Chi phí mua chưa biết giữ trạng thái tạm tính và cần đối chiếu, không báo đã chốt.
2. Cấp vật tư chuyển giá trị tới lệnh, vật tư hoàn trả chuyển giá trị tương ứng lại kho; sản xuất xác nhận thực dùng, hao hụt, lượng đang làm và hoàn tất. Không coi vật tư đã mua hoặc đã cấp đều đã tiêu hao hết.
3. Kế toán tập hợp vật tư thực dùng, nhân công và chi phí chung của lệnh. Đề xuất phân bổ nhân công theo giờ làm cho lệnh và chi phí chung theo giờ nguồn lực sản xuất; nguồn lương, điện/khấu hao và giờ sẽ được cụ thể hóa khi phân tích nhân sự/tài chính sâu hơn. Một khoản lương đã phân bổ vào giá thành không cộng thêm lần nữa vào chi phí cùng kết quả.
4. Theo P05, tình huống lỗi thông thường không thu hồi phân bổ chi phí lô cho lượng đạt; lỗi bất thường, hàng làm lại và giá trị phế liệu có xử lý riêng. Lệnh chưa đủ chi phí hoặc chưa xử lý hết lượng thì giá thành còn tạm tính; khi chốt lưu bản và căn cứ, không tự ghi đè kỳ đã đóng.
5. Nhập thành phẩm chuyển giá trị từ lệnh tới hàng tồn; bình quân của biến thể cập nhật theo tổng giá trị và lượng được định giá. Hàng lỗi/chờ xử lý không tự có cùng giá với hàng đạt; phải giữ căn cứ giá trị chờ xử lý và quyết định giảm giá trị/tiêu hủy riêng, không tự tạo tài sản bằng cách nhân mọi lượng với giá hàng đạt.
6. Khi hàng rời kho, chuyển giá trị đúng lượng tới hàng đang giao. Tình huống cơ sở ghi giá vốn đúng phần khi kế toán xác nhận bán sau khách chấp nhận; phần chưa được chấp nhận còn theo dõi đang giao/tranh chấp, không tự trở thành chi phí bán. Ghi doanh thu/giá vốn không làm xuất lượng kho lần hai.

Lãi gộp quản trị = doanh thu thuần - giá vốn đã ghi nhận. Lãi gộp không phải tiền còn trong ngân hàng hoặc lợi nhuận cuối cùng; còn chi phí bán hàng/quản lý, tài chính, thuế và điều chỉnh khác. Giá thành dự kiến là cơ sở tư vấn, không thay giá thành thực tế đã đối chiếu.

## Trả hàng giảm giá hoàn tiền và giao bù

Kinh doanh nhận yêu cầu, đối chiếu đơn/đợt gốc và phối hợp chất lượng/kho. Giám đốc duyệt phương án: nhận trả/giảm giá, giao thay thế, sửa hàng hoặc từ chối có căn cứ. Phần kho vẫn ghi thực nhận và cách ly trước khi cho dùng; quyết định thương mại và tiền tách khỏi việc cầm hàng về.

- Trả được chấp nhận giảm bán: kế toán lập điều chỉnh liên kết đúng lượng/giá lần bán gốc, không vượt phần còn được điều chỉnh. Giảm doanh thu/nghĩa vụ tương ứng; giá trị hàng quay về theo căn cứ giá vốn gốc và chất lượng, không theo giá bán. Phần lỗi phải đánh giá giảm giá trị/chi phí riêng.
- Khách đã trả đủ: sau điều chỉnh xác định khoản phải hoàn hoặc khoản được giữ làm ứng trước theo thỏa thuận; giám đốc duyệt, xác nhận thực hoàn mới giảm tiền. Chưa thực hoàn thì vẫn còn nghĩa vụ hoàn, không ghi như đã xong.
- Giao bù/thay thế: tạo yêu cầu giao liên kết khi được duyệt, quyết định rõ có thu thêm hay không. Không vừa giảm doanh thu toàn bộ vừa tự ghi doanh thu mới như một bán mới nếu phương án chỉ là thay thế không thu thêm; quy tắc chi phí bảo hành/thay thế cần nguồn và điều kiện riêng.
- Hủy phần chưa giao: cập nhật cam kết và giải phóng giữ hàng; chưa ghi nhận bán thì không đảo một doanh thu chưa có. Cọc và chi phí hàng riêng xử lý theo đề xuất đổi/hủy đã lưu, không tự giữ toàn bộ tiền.

Thu hồi lô phối hợp quy trình kho/chất lượng; hàng mới yêu cầu thu hồi chưa làm tăng tồn hoặc tự sinh hoàn tiền. Chi phí trách nhiệm của doanh nghiệp/nhà vận chuyển/khách phải được xác định bằng phương án có duyệt, không tự trừ công nợ hoặc lương.

## Ví dụ giao hai đợt và thu ba lần

**Toàn bộ số liệu giả lập, VND, chưa xét thuế, chiết khấu, phí giao thu từ khách, hàng trả hoặc giá xuất khẩu.** Đơn 10.000 viên ngói giá 18.000 đồng/viên, cam kết 180.000.000 đồng, nối P06 có 10.840 viên đạt trước giao và 840 viên dư sau giao đủ. Mỗi đợt trong bảng giả sử khách đã chấp nhận và kế toán đã xác nhận bán; không dùng bảng này như kết quả chỉ từ xuất kho.

| Sự kiện | Doanh thu lũy kế | Tiền đã thực thu lũy kế | Phải thu còn lại | Ứng trước chưa dùng | Viên chưa giao theo cam kết |
| --- | ---: | ---: | ---: | ---: | ---: |
| Duyệt đơn chưa thu chưa giao | 0 | 0 | 0 | 0 | 10.000 |
| Thực nhận cọc 60 triệu | 0 | 60.000.000 | 0 | 60.000.000 | 10.000 |
| Khách nhận 6.000 và ghi bán 108 triệu, phân bổ cọc | 108.000.000 | 60.000.000 | 48.000.000 | 0 | 4.000 |
| Thực nhận thêm 30 triệu, phân bổ đợt đầu | 108.000.000 | 90.000.000 | 18.000.000 | 0 | 4.000 |
| Khách nhận 4.000 và ghi bán 72 triệu | 180.000.000 | 90.000.000 | 90.000.000 | 0 | 0 |
| Thực nhận thêm 90 triệu, phân bổ đủ | 180.000.000 | 180.000.000 | 0 | 0 | 0 |

Sau đợt đầu, 72 triệu giá trị phần chưa giao chưa là phải thu đã ghi nhận; không báo khách đang nợ 120 triệu chỉ từ tổng đơn trừ cọc. Sau đợt hai mới có đầy đủ doanh thu 180 triệu trong tình huống cơ sở. Không gộp khoản phải trả nhà cung cấp M03 để làm giảm phải thu khách.

Ví dụ giá thành cùng lô P06: giả sử có chi phí thực dùng đã đối chiếu gồm vật tư 30.040.000, nhân công 12.000.000, chi phí chung 5.000.000 đồng; tổng 47.040.000 đồng cho 7.840 viên đạt, 160 viên lỗi thông thường không thu hồi, hết lượng đang làm. Giá thành đạt = 6.000 đồng/viên. Đây là bộ chi phí giả lập riêng, không suy ra từ bảng định mức hoặc số tiền đã trả; 4.800.000 đồng xi măng thực dùng theo M03 nếu giá 2.000 đồng/kg là phần nằm trong 30.040.000 vật tư, không cộng lại lần nữa. Các vật tư khác giả sử có chứng từ cho phần còn lại; bộ chứng từ cụ thể chưa được tạo.

Giả sử 3.000 viên đầu kho cùng biến thể có giá trị 18.000.000 đồng, cũng 6.000 đồng/viên. Sau nhập 7.840, tổng đạt 10.840, giá trị 65.040.000; bình quân vẫn 6.000. Khi bán đủ 10.000: giá vốn 60.000.000, tồn đạt 840 có giá trị 5.040.000, lãi gộp 120.000.000. Đây là lãi gộp giả lập chưa trừ phí vận chuyển công ty chịu, chi phí quản lý, tài chính hoặc thuế; không coi 180 triệu đã thu là lãi.

Tình huống thêm độc lập sau khi đã giao/thu đủ: khách trả 500 viên, tất cả được kiểm tra đạt và doanh nghiệp chấp nhận giảm bán, không giao bù. Điều chỉnh giá trị bán 9.000.000, doanh thu thuần còn 171.000.000; nghĩa vụ hoàn 9.000.000 được duyệt, sau thực hoàn tiền thu ròng còn 171.000.000. Nhận trả kho một lần: 840 + 500 = 1.340 viên đạt. Theo căn cứ giá vốn gốc 6.000/viên, hoàn giá vốn 3.000.000; giá vốn thuần 57.000.000, tồn giá trị 8.040.000, lãi gộp 114.000.000 trước các chi phí khác. Không áp dụng các số này cho hàng trả lỗi hoặc chỉ giảm giá mà hàng không quay về.

## Báo cáo và kiểm soát cần có

Đề xuất báo đơn chưa giao/đang giao/tranh chấp, tiền ứng trước/chưa phân bổ, công nợ theo nghĩa vụ/hạn trả, quỹ và ngân hàng, chi phí/giá thành lệnh, giá trị hàng ở kho/đang giao và lãi gộp theo đơn/biến thể. Báo dòng tiền từ thực thu/chi tách báo kết quả từ doanh thu/chi phí; chọn được mốc, xem lại chứng từ nguồn và người xác nhận.

Chốt đối chiếu quản trị theo tháng: kế toán đối chiếu kho/sản xuất/giao hàng/quỹ/công nợ và nguồn lương, báo khoản tạm tính/chưa khớp; giám đốc duyệt chốt. Kỳ đã chốt không sửa âm thầm; điều chỉnh hiện tại có tham chiếu nguồn/kỳ cũ, mở lại cần quyết định có duyệt. Mốc bắt đầu cần số dư tiền, phải thu/phải trả/ứng trước và giá trị tồn đầu riêng để không tạo doanh thu/chi phí giả; bộ số dư phải cân với chứng từ nguồn, chưa tự chọn hệ thống tài khoản pháp định.

Các kết quả cần kiểm chứng khi phát triển:

- Duyệt đơn/cọc/xuất kho không tự ghi doanh thu; ghi bán/thu tiền không làm xuất kho thêm hoặc ghi doanh thu lần hai.
- Hai người cùng phân bổ một khoản thu không được dùng vượt phần còn lại; xác nhận lại cùng phiếu không tạo tiền hoặc nợ thứ hai.
- Cọc 60 triệu và bán đợt đầu 108 triệu cho phải thu 48 triệu, không 120 triệu; khoản 30 triệu giảm còn 18 triệu mà không đổi doanh thu.
- Nhận trả kho chưa được chấp nhận thương mại không tự hoàn tiền; hoàn tiền mới được duyệt nhưng chưa thực trả vẫn còn nghĩa vụ.
- Giá trị kho + hàng đang giao + giá vốn và các xử lý chi phí liên quan phải đối chiếu nguồn; không mất giá trị trong khoảng từ xuất kho tới khách chấp nhận.
- Giá thành lệnh không cộng trùng lương/chi phí mua, hàng lỗi kế hoạch và vật tư hao hụt; đơn chưa đủ chi phí phải báo tạm tính thay vì lợi nhuận đã chốt.
- Người không có quyền không xem giá vốn hoặc xác nhận thu/chi; chứng từ thiếu nguồn/sai số dư hoặc kỳ đã chốt không được sửa tự do.

Tài chính cơ sở này chưa là đặc tả đầy đủ kế toán, thuế/hóa đơn, ngoại tệ, xuất khẩu, tài sản cố định, vay và ngân sách. Các nội dung đó vẫn là điểm cần phân tích/đề xuất tiếp, không bị tự loại khỏi phạm vi B04 hoặc nhóm khách xuất khẩu B11. Demo không phát hành hóa đơn hay thực chuyển tiền qua dịch vụ bên ngoài; mọi chứng từ/tài khoản/dữ liệu minh họa phải được ghi rõ giả lập.

Chưa triển khai hoặc chạy build/test ứng dụng; các con số trên là kết quả mong đợi đã được kiểm tra phép tính trên tài liệu. Nghiệp vụ nhân sự sẽ làm rõ nguồn giờ làm và lương để hoàn thiện liên thông giá thành, không yêu cầu anh cung cấp số liệu chuyên môn thật để tiếp tục đề xuất.
