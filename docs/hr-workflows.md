# Nhân sự ca làm chấm công và lương cho demo ERP Nasaki

Tài liệu đề xuất cách quản lý 50 nhân sự, bố trí công việc, xác nhận công, nghỉ phép và lương để nối với sản xuất. Theo yêu cầu ngày 04/10/2026, tiếp tục phân tích nghiệp vụ và chưa đào sâu kế toán. Cơ cấu, quy tắc, trách nhiệm và số liệu mới dưới đây là đề xuất giả lập, chưa được anh duyệt từng chi tiết; không phải chính sách nhân sự thực tế của Nasaki hoặc tư vấn áp dụng pháp luật lao động.

Giữ mô hình một công ty, một xưởng, một kho. CEO và giám đốc là cùng người; không tự tạo giám đốc chức năng. Đọc cùng [hồ sơ nghiệp vụ](business-context.md), [giao hàng và tài chính](delivery-finance-workflows.md) và [README](../README.md). Đây là phân tích, chưa thiết kế màn hình, dữ liệu kỹ thuật hoặc triển khai ứng dụng.

## Cơ cấu 50 người đề xuất

Mỗi người có một bộ phận chính tại một thời điểm. Kiêm nhiệm thêm trách nhiệm không làm tăng số người hoặc tự cấp quyền truy cập. 50 nhân sự không đồng nghĩa 50 người sử dụng đồng thời.

| Bộ phận chính giả lập | Số người | Trách nhiệm đề xuất |
| --- | ---: | --- |
| Giám đốc | 1 | Quyết định nhân sự, chính sách và duyệt lương. |
| Kinh doanh | 5 | Tiếp nhận, tư vấn, đơn hàng và chăm sóc khách. |
| Mua hàng | 2 | Nguồn cung và tiến độ mua. |
| Kho và giao hàng | 4 | Quản lý một kho, soạn và giao hàng. |
| Sản xuất | 28 | Gồm 1 quản lý, 2 tổ trưởng và 25 người thực hiện công đoạn. |
| Chất lượng | 3 | Kiểm tra, xác nhận và phối hợp xử lý lỗi. |
| Tài chính | 3 | Thu chi, công nợ và kiểm tra bảng lương. |
| Nhân sự và hành chính | 4 | Hồ sơ, công, phép, đào tạo và hỗ trợ hành chính. |

Tổng 50. Chưa lập đủ danh sách người hoặc định biên từng công đoạn. Người có năng lực có thể kiêm bảo trì, nhưng lịch bảo trì phải giữ phần thời gian đó; không mặc định sản xuất có 28 người trực tiếp tạo sản phẩm trong mọi ca. Cơ cấu này không chứng minh công suất hoặc bảo đảm lịch giao của Nasaki.

## Hồ sơ và vòng đời nhân sự

Quản lý bộ phận đề nghị tuyển/bổ sung người, nhân sự xác nhận nhu cầu và giám đốc duyệt. Đề xuất demo dùng một hồ sơ tuyển đơn giản: vị trí, lý do, ứng viên giả lập, kết quả và ngày dự kiến nhận việc; chưa cần quy trình tuyển dụng nhiều vòng.

Khi tiếp nhận, nhân sự ghi mã người, bộ phận, quản lý trực tiếp, ngày vào, trạng thái, hợp đồng/thời hạn, vị trí, kỹ năng, đào tạo an toàn và chính sách lương có ngày hiệu lực. Trạng thái đề xuất gồm chuẩn bị nhận việc, thử việc, đang làm, tạm nghỉ và đã nghỉ việc. Điều chuyển, đổi lương hoặc đổi quản lý giữ lịch sử theo ngày hiệu lực, không đổi ngược chứng từ cũ.

Quản lý chỉ phân công người đủ điều kiện cho công việc cần kỹ năng/an toàn. Đào tạo chưa hoàn tất hoặc chứng nhận hết hạn nếu công việc yêu cầu phải được cảnh báo và chặn phân công theo điều kiện đã định; không tự tạo chứng nhận thật. Tai nạn/sự cố ghi thời điểm, người phụ trách xử lý và ảnh hưởng lịch, không tự quy lỗi hay trừ lương.

Khi nghỉ việc: giám đốc duyệt ngày kết thúc, nhân sự phối hợp bàn giao công việc, hàng/tài sản, khoản ứng và quyền truy cập. Chỉ ngừng quyền theo ngày thực tế có hiệu lực; không xóa hồ sơ, công, lương hoặc giao dịch lịch sử. Quyết toán quyền lợi còn lại cần căn cứ; không tự cấn tiền tài sản mất vào lương. Quy trình tuyển, an toàn và nghỉ việc ở đây là mức cơ sở, không thay thủ tục pháp lý thật.

## Lịch làm và phân công

Đề xuất ca ngày gồm 08:00–12:00 và 13:00–17:00, tổng 8 giờ làm, không tính giờ nghỉ trưa. Lịch công ty khai báo ngày làm, nghỉ tuần, nghỉ lễ và ngoại lệ; số ngày chuẩn lấy từ lịch từng tháng, không luôn cố định 26. Lưu thời gian vận hành theo Asia/Ho_Chi_Minh; ca qua đêm nếu bổ sung phải có đủ ngày bắt đầu/kết thúc, không dùng giờ ra nhỏ hơn giờ vào để tính âm.

Quản lý bộ phận lập lịch; quản lý sản xuất phân công người/tổ theo công đoạn, lệnh, kỹ năng và nguồn lực. Nhân sự kiểm tra trùng lịch, nghỉ đã duyệt và thời gian khả dụng. Lịch dự kiến chưa là công thực tế; đổi lịch có lý do và báo người bị ảnh hưởng. Một người không được xếp hai công việc đồng thời hoặc vừa nghỉ vừa làm cùng khoảng.

Năng lực người và năng lực máy là hai giới hạn riêng. Không lấy 8 giờ của một người thành 8 giờ máy hoặc lấy thời gian chờ dưỡng hộ thành giờ làm của cả tổ. Nếu thiếu người, quản lý sản xuất đổi lịch/đề nghị điều động và đánh giá tác động giao hàng, không tự tăng năng suất.

Làm thêm cần đề nghị, sự đồng ý của người lao động và duyệt theo thẩm quyền đề xuất của giám đốc. Lưu mục đích, ngày, loại ngày/giờ, giờ dự kiến và giờ thực được xác nhận riêng. Thời gian ở lại sau ca không tự được tính làm thêm. Hệ số, cơ sở tính và giới hạn phải được xác lập phù hợp chính sách/pháp luật trước khi dùng thật; không tự suy ra một mức chung cho ngày thường, ngày nghỉ, lễ hoặc ban đêm. Ví dụ cơ sở bên dưới không có làm thêm.

## Chấm công và xác nhận công

Đề xuất demo nhập công thủ công hoặc nhập bảng mẫu, không bắt buộc máy chấm công, sinh trắc học hay định vị. Mỗi bản ghi có người, ngày/ca, khoảng vào/ra, nghỉ, loại công và nguồn. Lưu dữ liệu gốc; nhập lại cùng nguồn không tạo công thứ hai. Hồ sơ chỉ có một đầu vào/ra bị thiếu phải chờ bổ sung, không tự tính đủ ca hoặc tự coi vắng cả ngày.

Luồng đề xuất: người lao động/tổ trưởng ghi hoặc đề nghị bổ sung → quản lý xác nhận thời gian thực tế → nhân sự đối chiếu lịch, phép và ngoại lệ → chốt công tháng. Người lao động có thể đề nghị sửa và xem căn cứ, nhưng không tự duyệt công của mình. Nếu người duyệt cũng là đối tượng, chuyển lên giám đốc hoặc người được phân quyền phù hợp; ngoại lệ giám đốc phải có nhân sự kiểm tra và dấu vết, không giả tạo một CEO thứ hai.

Phân biệt đi làm, nghỉ có lương, nghỉ không lương, công tác/đào tạo và vắng chờ xác minh. Đi muộn/về sớm tính theo khoảng thực tế và chính sách đã xác lập, không tự đặt khoản phạt tiền. Công tác không có chấm vào xưởng vẫn có thể được xác nhận bằng nhiệm vụ/căn cứ riêng. Công theo phút, chỉ làm tròn ở bước có quy tắc; không tự làm tròn mọi lần quẹt thành một ca.

Chốt công không đồng nghĩa chốt lương hoặc đã trả tiền. Sau chốt, sửa bằng yêu cầu có lý do, quyền, bản cũ/mới và đánh giá ảnh hưởng lương/chi phí; không âm thầm thay số. Hai người xác nhận cùng bản ghi không làm tăng công. Chưa đủ công phải báo phần thiếu trước khi tính lương, không gán mặc định 0 hoặc 8 giờ.

## Nghỉ phép và vắng mặt

Nhân sự xác lập số dư phép đầu, quyền phát sinh theo chính sách có hiệu lực, số đã dùng và quy tắc chuyển/hết hạn; không chọn tùy ý một số ngày áp dụng cho tất cả nhân viên. Nghỉ lễ, nghỉ ốm và nghỉ phép năm là loại khác nhau, không tự cùng trừ quỹ phép năm.

Người lao động xin loại nghỉ, thời gian và người bàn giao. Quản lý kiểm tra khả năng thay thế; nhân sự kiểm tra điều kiện/số dư; người được giao quyền duyệt quyết định. Đề xuất quản lý duyệt phép thường trong chính sách, giám đốc duyệt ngoại lệ; quyền này là phương án, chưa là thẩm quyền thật đã xác nhận. Nghỉ khẩn có thể bổ sung căn cứ sau với lịch sử xử lý, không tự đánh dấu không phép.

Đơn được duyệt giữ phần phép để không duyệt vượt số dư; khi nghỉ thực tế được chốt, chuyển từ đã giữ sang đã dùng, không trừ hai lần. Hủy phần chưa nghỉ giải phóng phần giữ; phần đã nghỉ cần điều chỉnh có duyệt. Xin nửa ngày theo số giờ trong lịch; không tính ngày nghỉ tuần/lễ vào phép của ngày không phải làm. Người được duyệt nghỉ không được tiếp tục coi là nguồn lực khả dụng của lệnh; bộ phận cần bố trí thay thế.

## Lương tháng và thanh toán

Đề xuất cơ sở dùng lương theo thời gian cho cả văn phòng và sản xuất; có phụ cấp, thưởng được duyệt và làm thêm đủ căn cứ. Sản lượng đạt/lỗi phục vụ đánh giá, không tự nhân số viên thành lương hoặc trừ lương khi có lỗi. Lương theo sản lượng/hoa hồng có thể phân tích tiếp nếu cần, chưa thay cách tính cơ sở.

Nhân sự lập bảng từ công đã chốt và chính sách lương có hiệu lực. Người phụ trách tài chính kiểm tra trùng kỳ/người, phụ cấp, ứng và căn cứ; giám đốc duyệt; người phụ trách chi xác nhận thực trả theo luồng thu chi đã có. Nhân viên nhận phiếu cá nhân và có thể đề nghị đối chiếu. Bảng lương nháp/đã duyệt chưa làm giảm tiền; trả từng phần giữ phần còn phải trả, không xác nhận thanh toán hai lần.

Tách các lượng: thu nhập tính được, các khoản khấu trừ có căn cứ, ứng đã thực nhận/được đối trừ và khoản còn cần chi. Ứng lương không làm tăng chi phí lương; thu hồi ứng không trừ chi phí một lần nữa. Không tự khấu trừ công nợ, phạt lỗi hoặc bồi thường ngoài căn cứ hợp lệ. Bảo hiểm, thuế thu nhập, điều kiện hợp đồng và các quyền lợi bắt buộc vẫn cần xác định trước vận hành thật; anh yêu cầu chưa đào sâu kế toán không đồng nghĩa được bỏ qua nghĩa vụ này hoặc coi bảng đơn giản là bảng lương pháp lý hoàn chỉnh.

Chốt lương lưu phiên bản công/chính sách đã dùng. Điều chỉnh sau duyệt phải xác định số đã trả, phần còn lại và chênh lệch cần bổ sung/thu hồi theo căn cứ; không xóa khoản đã chi. Nhận việc/nghỉ việc/đổi lương giữa tháng tính theo thời gian có hiệu lực trong lịch và chính sách, không áp đủ tháng cho mọi trường hợp. Dữ liệu chưa đủ phải hiển thị tạm tính.

## Giờ công nối với sản xuất

Tổ trưởng ghi người, khoảng thời gian, lệnh/lô/công đoạn và mục đích thực làm; quản lý xác nhận. Giờ làm cho các lệnh, đào tạo, bảo trì, chờ việc hoặc việc chung phải đối chiếu tổng thời gian làm thực tế không trùng. Nghỉ có lương là quyền lợi lương, không phải giờ trực tiếp tạo sản phẩm. Mỗi giờ của mỗi người chỉ gán một lần, dù cùng lệnh phục vụ nhiều đơn.

Nguồn chi phí nhân công lấy từ phần chi phí được duyệt của kỳ, có căn cứ đơn giá/cách phân bổ và phiên bản. Phân bổ tới lệnh theo giờ trực tiếp được xác nhận; phần nghỉ, chờ việc hoặc hỗ trợ chung có nơi nhận riêng theo quy tắc quản trị, không tự đẩy hết vào một lệnh. Tổng phân bổ không vượt nguồn chi phí; phần chưa phân bổ phải hiển thị. Chi phí làm thêm nếu có dùng căn cứ riêng, không lấy mọi giờ cùng một đơn giá khi mức chi phí khác nhau. Việc tính giá thành từ nguồn này không tạo thêm lần trả lương hoặc cộng trùng chi phí đã tập hợp. Chưa chốt lương thì chi phí lệnh còn tạm tính.

Ví dụ liên thông giả lập cho tám lô P06: 240 giờ công trực tiếp được xác nhận, đơn giá chi phí phân bổ 50.000 đồng/giờ từ nguồn đã đối chiếu đủ 12.000.000 đồng → 12.000.000 đồng nhân công. Đây chính là khoản nhân công trong ví dụ giá thành trước, không cộng thêm một khoản 12 triệu. 240 là tổng giờ của nhiều người ở các khoảng không trùng, không phải 240 giờ chạy máy hoặc thời gian dưỡng hộ. Chưa tạo bảng phân công/chứng từ đủ 240 giờ; số này là bộ dữ liệu mong đợi cần dựng và kiểm chứng, không chứng minh tiến độ/năng lực. Đơn giá này không suy ra từ nhân viên trong ví dụ lương bên dưới; các nguồn lương/phân bổ cụ thể vẫn cần lập nhất quán khi tạo dữ liệu demo.

## Ví dụ công và lương giả lập

Một nhân viên giả lập có lịch tháng 26 ngày × 8 giờ = 208 giờ; đi làm 24 ngày = 192 giờ, nghỉ phép hưởng lương 1 ngày = 8 giờ và nghỉ không lương 1 ngày = 8 giờ. Không đi muộn, làm thêm hoặc thay đổi mức lương trong tháng. Chính sách minh họa chỉ cho ví dụ này: lương cơ sở 7.800.000 đồng theo 208 giờ, nghỉ có lương tính đủ, không lương không tính; phụ cấp cố định 500.000 đồng, không giảm theo ngày trong ví dụ. Giả sử phép đủ và đã duyệt, phần công còn lại đã xác nhận.

| Khoản giả lập | Cách tính | Kết quả VND |
| --- | --- | ---: |
| Lương thời gian được tính | 7.800.000 × (192 + 8) / 208 | 7.500.000 |
| Phụ cấp cố định | Theo chính sách giả lập đã chọn | 500.000 |
| Thu nhập trước khấu trừ | Lương thời gian + phụ cấp | 8.000.000 |
| Ứng đã thực nhận và được đối trừ | Một khoản ứng có chứng từ | 1.000.000 |
| Còn cần chi trước các khấu trừ bắt buộc chưa mô phỏng | 8.000.000 − 1.000.000 | 7.000.000 |

7 triệu không được gọi là thực lĩnh pháp lý hoặc số chuyển ngân hàng cuối cùng: ví dụ chưa mô phỏng bảo hiểm, thuế và khoản bắt buộc khác. Nếu dùng tình huống minh họa chi 7 triệu phải ghi rõ đơn giản hóa đó, không dùng trả người thật. Tổng đã ứng 1 triệu cộng chi minh họa 7 triệu là 8 triệu, không báo chi lương 9 triệu. Số giờ có quyền hưởng lương là 200; số giờ trực tiếp cho lệnh không tự là 200 hoặc 192, còn phải có phân công được xác nhận. Nếu có 6 giờ làm lệnh A và 2 giờ hỗ trợ trong một ca 8 giờ, chỉ 6 giờ vào lệnh A, không ghi cả 8 giờ cho lệnh rồi cộng thêm 2 giờ hỗ trợ.

## Quyền dữ liệu và báo cáo

Đề xuất nhân viên chỉ xem hồ sơ/công/phép/phiếu lương của mình; quản lý xem lịch, công và kỹ năng của người thuộc phạm vi phụ trách, không mặc định xem lương; nhân sự được quản lý hồ sơ và công theo nhiệm vụ. Người kiểm tra lương, người thực chi và giám đốc chỉ truy cập phần cần cho vai trò; quyền xuất danh sách/phiếu lương phải kiểm soát riêng. Quản trị kỹ thuật không mặc định được xem toàn bộ lương bằng giao diện nghiệp vụ. Phân quyền kỹ thuật thực tế sẽ thiết kế sau; không cam kết bảo mật dữ liệu khi chưa triển khai/kiểm chứng.

Chỉ dùng mã/tên và tài liệu giả lập khi dựng demo. Không đưa căn cước, tài khoản ngân hàng, hợp đồng, sức khỏe, mật khẩu hoặc bảng lương thật vào Git; nghiệp vụ vận hành sẽ lưu ở nơi được bảo vệ, không trong README. Nghỉ việc ngừng quyền nhưng giữ lịch sử phục vụ đối chiếu. Nhật ký sửa lưu ai/khi nào/lý do, không ghi lộ dữ liệu nhạy cảm vào log công khai.

Báo cáo đề xuất: số người theo trạng thái/bộ phận tại mốc, lịch thiếu/trùng người, hợp đồng sắp hết hạn, đào tạo chưa đủ, công chờ xác minh, phép còn/đã giữ/đã dùng, lương tạm tính/đã duyệt/đã trả/còn trả và giờ/chi phí nhân công theo lệnh. Không xem 50 người là 50 người đang đi làm hôm nay; không dùng số viên mỗi người để kết luận năng suất khi thiếu giờ công và vai trò tương ứng.

## Rà soát mức phù hợp với mô hình Nasaki

Ngày 04/10/2026, anh yêu cầu duyệt lại nhân sự, phải phù hợp Nasaki và không áp dụng toàn bộ nghiệp vụ doanh nghiệp lớn. **Kết luận rà soát:** Hồ sơ, lịch, công, phép, lương/ứng và giờ công sản xuất đã có khung cơ sở. Cần làm rõ sáu điểm dưới đây để sử dụng được ở mô hình xưởng nhỏ; không cần mở thêm phân hệ nhân sự chuyên sâu. Đây là nhận xét và đề xuất sau rà soát, chưa phải quy trình mới được anh duyệt hoặc yêu cầu triển khai.

Sự phù hợp được đánh giá theo ngành ngói/Terrazzo từ nguồn anh cung cấp và mô hình demo 50 người, một xưởng, sản xuất kết hợp đã xác nhận. Chưa có khảo sát nhân sự nội bộ Nasaki; không khẳng định công ty thật có các tổ, phụ cấp hoặc cách trả lương này.

### Những điểm cần làm rõ ở mức cơ sở

| Điểm rà soát | Vì sao cần cho mô hình xưởng | Đề xuất tinh gọn |
| --- | --- | --- |
| Người lao động không có tài khoản ERP | Chấm công và nhận phiếu lương không nên buộc mọi công nhân dùng phần mềm. Khung trước có tổ trưởng ghi thay nhưng chưa rõ cách đối chiếu. | Tổ trưởng ghi cho người thuộc tổ; quản lý xác nhận, nhân sự tổng hợp. Người lao động xem/đối chiếu bảng hoặc phiếu cá nhân qua người phụ trách nếu không có tài khoản; yêu cầu sửa vẫn lưu nguồn/người đề nghị. Không gửi bảng lương cả tổ cho mọi người. |
| Công theo tổ và người thay thế | Hai luồng ngói/Terrazzo có thể cần điều động, nhưng không mặc định mọi người làm được mọi công đoạn. Khung đã xét kỹ năng/trùng lịch, chưa có cách ghi theo tổ thuận tiện. | Dùng danh sách tổ theo ngày, công đoạn người được phép làm và người thay khi vắng. Tổ trưởng ghi chung khoảng làm/lệnh cho thành viên, tách ngoại lệ người đến muộn, về sớm hoặc đổi việc. Không tự nhân số người dự kiến × ca thành công thực tế. |
| Ngừng việc và hỗ trợ xưởng | Thiếu vật tư, máy hỏng hoặc đổi mẫu có thể khiến người có mặt nhưng chưa trực tiếp làm lệnh. “Chờ việc” đã có nhưng cách xử lý công/lương còn mở. | Ghi số giờ và lý do ngừng/chờ, người xác nhận và việc thay thế nếu có. Tách ngừng việc khỏi nghỉ cá nhân; quyền hưởng lương theo chính sách/căn cứ hợp lệ, không tự coi không lương. Thời gian chờ của sản phẩm chỉ tính công khi thực có người làm việc. |
| Bộ chính sách đủ để chạy ví dụ | Đã có công thức một nhân viên nhưng chưa có chính sách và số dư nhất quán cho cả 50 người. Điều này chặn tính lương demo đáng tin hơn việc thiếu nghiệp vụ mới. | Lập bộ giả lập nhỏ có ngày hiệu lực: lịch kỳ, mức lương, loại nghỉ/quyền phép, phụ cấp/thưởng áp dụng, ngày chốt/trả và người chịu trách nhiệm. Chỉ đưa loại phụ cấp thực dùng trong kịch bản; phân biệt cố định với theo ngày đủ điều kiện. Có làm thêm trong kịch bản mới phải xác định đầy đủ cách tính/giới hạn; không gán hệ số tùy ý. Khoản bắt buộc chưa mô phỏng phải ghi rõ giới hạn, không báo thực lĩnh hoàn chỉnh. |
| An toàn và đồ bảo hộ | Xưởng vật liệu xây dựng cần biết người đã được hướng dẫn và được cấp đồ cần thiết; hồ sơ kỹ năng/an toàn đã có, phần bàn giao đồ chưa rõ. | Chỉ giữ danh sách hướng dẫn an toàn, điều kiện làm công đoạn và cấp/đổi/trả đồ bảo hộ hoặc dụng cụ cần bàn giao. Nếu vật tư nằm trong kho, liên kết xuất dùng nội bộ theo quy trình kho, không ghi xuất hai lần hoặc cộng chi phí lương. Chưa dựng phân hệ y tế, đào tạo trực tuyến hay tài sản đầy đủ. |
| Người duyệt vắng và phản hồi công/lương | Mô hình ít người dễ chờ vì một người giữ việc; đã có đề nghị sửa nhưng chưa rõ người tiếp nhận và thay thế. | Ghi người tiếp nhận phản hồi và người được ủy quyền theo loại việc/thời hạn. Quyền thay thế không tự bao gồm xem lương hoặc sửa kỳ đã chốt; không tự duyệt khoản của mình. Đề nghị chỉ cần nội dung/căn cứ, kết quả và người xử lý, không thêm quy trình khiếu nại nhiều cấp. |

### Những phần nên giữ gọn

- Bảng 50 người ở trên là phân bổ minh họa, không phải yêu cầu lập tám phòng độc lập hoặc tuyển bốn cán bộ HR. Đề xuất nhóm nhân sự/hành chính có một đầu mối phụ trách hồ sơ/công, các vai trò còn lại có thể hỗ trợ hành chính; tài chính kiểm tra lương theo trách nhiệm sẵn có. Chưa đổi các số trong bảng hoặc chốt lại định biên khi chỉ rà soát.
- Tuyển dụng chỉ cần nhu cầu, quyết định nhận và hồ sơ vào làm; thử việc chỉ cần ngày kết thúc, nhận xét và quyết định, không mở hệ thống tuyển dụng nhiều vòng/đánh giá ứng viên tự động.
- Kỹ năng chỉ ghi những công đoạn cần để phân người trong demo, không dựng bộ khung năng lực toàn doanh nghiệp. Công theo phút là độ chính xác tính toán, không yêu cầu ghi từng phút hoặc từng động tác. Ghi theo ca/khoảng công việc và ngoại lệ đã đủ.
- Phép thông thường đề xuất một người có thẩm quyền quyết định sau kiểm tra của nhân sự, không mặc định tất cả phải lên giám đốc. Lương giữ lập/kiểm tra/duyệt/thực trả vì cần kiểm soát tiền, không thêm ban/hội đồng hoặc nhiều cấp giám đốc.
- Lương thời gian là đề xuất cơ sở, không chứng minh Nasaki trả theo thời gian. Chưa có căn cứ bắt buộc thêm lương khoán, hoa hồng, bảng thưởng năng suất hoặc nhiều công thức cho demo hiện tại. Ví dụ phụ cấp cố định 500.000 trước đó vẫn giữ nguyên, không tự chuyển thành tiền ăn theo ngày.

### Những phần chưa cần bổ sung

Đề xuất chưa đưa vào demo hiện tại: đánh giá 360 độ, hệ thống KPI/OKR nhiều tầng, lộ trình chức danh/thăng tiến, quy hoạch kế nhiệm, ngân sách tuyển dụng chuyên sâu, cổng tuyển dụng, quản lý đào tạo trực tuyến, phúc lợi tùy chọn phức tạp, tối ưu ca bằng thuật toán hoặc bắt buộc máy chấm công/sinh trắc học. Đây là khuyến nghị giữ độ sâu phù hợp, không bỏ nhóm nhân sự khỏi phạm vi bảy nhóm đã xác nhận.

Lao động thời vụ/thuê ngoài chưa có dữ kiện xác nhận nên không tự tạo thêm người hoặc luồng thanh toán trong mô hình 50 người. Nếu có tình huống đó sau này, cần phân biệt người do công ty quản lý với dịch vụ bên ngoài, không tự đưa hóa đơn dịch vụ vào lương nhân viên.

An toàn, bảo hiểm và quyền lợi lao động không phải những nghĩa vụ chỉ doanh nghiệp lớn mới cần. Giữ điểm kiểm tra và giới hạn của demo, chưa đào sâu kế toán theo B21; trước vận hành thật phải đối chiếu căn cứ phù hợp.

### Tình huống rà soát bổ sung để dùng khi phát triển

1. Một công nhân không có tài khoản vẫn có công/phiếu cá nhân và đề nghị đối chiếu được; người nhập thay được ghi rõ, không cấp quyền xem lương cả tổ.
2. Ví dụ giả lập tổ 5 người, 08:00–12:00 làm lệnh A; 4 người làm đủ 4 giờ, người thứ năm vào 10:00 làm 2 giờ: công trực tiếp là 4 × 4 + 2 = 18 giờ, không 20. Công hai giờ còn thiếu của người thứ năm cần phân loại/căn cứ riêng, không tự phạt. Không dùng số 18 này thay tổng 240 giờ ở P06.
3. Ví dụ độc lập một người làm 6 giờ cho lệnh, chờ máy có xác nhận 2 giờ: tổng có mặt/làm và chờ là 8 giờ, trực tiếp lệnh chỉ 6. Chế độ tiền cho phần chờ chưa đủ căn cứ thì lương còn tạm tính, không tự tính mất 2 giờ lương.
4. Cấp đồ bảo hộ có liên kết kho không tạo hai lần xuất; đổi người duyệt chỉ có hiệu lực đúng thời hạn/phạm vi, không mở quyền xem lương ngoài nhiệm vụ.

Đã rà soát trên tài liệu và kiểm tra phép tính ví dụ, chưa kiểm chứng phần mềm hoặc kết luận khảo sát nhân sự thật hoàn tất. Ưu tiên tiếp theo là cụ thể hóa các điểm cơ sở và bộ dữ liệu nhất quán khi được giao; không cần mở rộng thêm nghiệp vụ doanh nghiệp lớn để hoàn thành demo.

## Tình huống cần kiểm chứng khi phát triển

1. Tổng cơ cấu có 50 người riêng biệt; kiêm nhiệm không tăng tổng, điều chuyển đổi cơ cấu theo ngày mà giữ lịch sử.
2. Ca có 8 giờ làm và 1 giờ nghỉ không thành 9 giờ công; thiếu giờ ra phải chờ xác minh; nhập lại không nhân công.
3. Phép giữ/đã dùng không trừ hai lần; hủy phần chưa nghỉ giải phóng đúng lượng; không xếp người đang nghỉ vào lệnh.
4. Một ca 8 giờ có 6 giờ lệnh A và 2 giờ hỗ trợ khớp 8, không cho phân bổ 8 + 2 hoặc hai công việc trùng khoảng.
5. Ví dụ 208 giờ lịch, 192 giờ đi làm và 8 giờ nghỉ hưởng lương cho thu nhập 8 triệu trước khấu trừ; ứng 1 triệu còn 7 triệu trước phần bắt buộc chưa mô phỏng, không coi là bảng lương pháp lý hoàn chỉnh.
6. Duyệt lương không giảm quỹ; thực trả một lần mới giảm tiền; ứng không cộng chi phí lần hai; điều chỉnh kỳ đã chốt giữ bản và khoản đã trả.
7. 240 giờ × 50.000 cho 12 triệu trong P06; tổng phân bổ có nguồn, không nhân đôi nhân công khi tổng hợp đơn/lệnh hoặc lập phiếu chi.
8. Không duyệt công/phép của chính mình theo quyền thông thường; quản lý hoặc nhân viên không được đọc/ xuất lương người khác ngoài phạm vi.
9. Hết hiệu lực làm việc ngừng phân công/quyền theo mốc, không xóa chứng từ cũ; đổi lương giữa kỳ không sửa ngược bản đã chốt.

Đã có nền nghiệp vụ nhân sự để tiếp tục phân tích, chưa coi là hoàn tất toàn bộ nhân sự hoặc toàn ERP. Bộ danh mục người, lịch mẫu, chính sách lương/phép, giờ từng lệnh và quyền chi tiết còn cần cụ thể hóa khi chuẩn bị dữ liệu và yêu cầu phát triển. Không đào sâu kế toán trong vòng này theo yêu cầu của anh; không tự loại tài chính khỏi phạm vi. Chưa chạy build/test ứng dụng; các ví dụ chỉ là phép tính và kết quả mong đợi trên tài liệu. Bước nối tiếp đề xuất là quản trị trách nhiệm, phê duyệt và bàn giao xuyên bộ phận, rà soát chất lượng và các khoảng trống toàn luồng trước khi đi vào tính năng.
