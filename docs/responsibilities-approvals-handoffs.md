# Đề xuất trách nhiệm phê duyệt và bàn giao cho demo ERP Nasaki

**Bản đề xuất ngày 08/10/2026, chờ anh duyệt.** Anh giao Codex tự lập phương án sau khi thống nhất hướng tiếp theo là nối trách nhiệm, rà soát chất lượng và chuẩn bị kịch bản liên hoàn. Tài liệu này xác định ai giữ việc, ai quyết định và dữ liệu nào phải bàn giao; bổ sung các điểm kiểm soát chất lượng và kịch bản để đánh giá phương án. Chưa phải yêu cầu lập trình, chưa là quy trình thực tế Nasaki hoặc xác nhận mọi đề xuất cũ đã được duyệt.

Giữ một công ty, một xưởng, một kho, 50 người, ngói và Terrazzo, đủ bảy nhóm nghiệp vụ. Không tạo thêm phòng ban, hội đồng hoặc giám đốc chức năng. CEO/giám đốc là một người. Kế toán chuyên sâu giữ để sau. Đọc cùng [hồ sơ nghiệp vụ](business-context.md), [kho](warehouse-workflows.md), [giao hàng và tài chính](delivery-finance-workflows.md), [nhân sự](hr-workflows.md) và [README](../README.md).

## Nguyên tắc trách nhiệm

Mỗi đơn, lệnh, lần mua hoặc ngoại lệ có một người chịu trách nhiệm theo dõi tới khi đóng việc. Người này có thể cần nhiều bộ phận phối hợp; không tự nhận toàn bộ quyền quyết định của các bộ phận đó. Kinh doanh giữ đầu mối đơn khách, quản lý sản xuất giữ lệnh, mua hàng giữ đơn mua, chất lượng giữ việc lỗi/khóa lô, nhân sự giữ kỳ công và bảng lương; tài chính giữ việc đối chiếu tiền/công nợ. Mỗi đợt giao có người theo dõi kết quả nhận.

Phân biệt bốn việc: lập đề nghị, kiểm tra căn cứ, quyết định cho phép và xác nhận đã thực hiện. Chỉ việc cần quyết định mới có bước duyệt. Duyệt không tự ghi hàng đã xuất, tiền đã chi, khách đã nhận hoặc công đã làm. Xác nhận thực tế vẫn phải kiểm tra điều kiện tại thời điểm thực hiện.

Một người được kiêm nhiệm nhiều vai trò, nhưng không tự duyệt yêu cầu chi/ứng/hoàn cho mình, điều chỉnh tồn, tiêu hủy hoặc thay đổi quyền của mình. Bộ dữ liệu demo bố trí người kiểm tra/duyệt khác người lập cho các việc này; không dùng hai tài khoản của cùng một người để giả lập phân tách. Trường hợp giám đốc là đối tượng khoản chi hoặc công của chính mình cần người phụ trách độc lập kiểm tra căn cứ và ghi rõ ngoại lệ, không tự động thông qua; chưa có người đủ quyền/căn cứ thì giữ chờ xử lý. Không tạo CEO thứ hai.

## Bảng phân công và thẩm quyền đề xuất

Tất cả thẩm quyền bổ sung trong bảng là đề xuất cho demo. Thẩm quyền giá và kiểm tra khả năng giao đã có căn cứ B13–B16; việc đưa một vòng duyệt giám đốc cho mọi đơn trong demo cơ sở là lựa chọn đề xuất, không suy ra từ chữ “thường” trong B14.

| Việc | Người lập hoặc giữ việc | Người kiểm tra | Người quyết định hoặc xác nhận |
| --- | --- | --- | --- |
| Báo giá, giá/chiết khấu và chốt đơn | Kinh doanh phụ trách đơn | Quản lý sản xuất kiểm tra khả năng giao; tài chính kiểm tra điều kiện tiền nếu có | Giám đốc duyệt giá và đơn cơ sở; kinh doanh lưu xác nhận khách. |
| Duyệt mẫu hàng đặt riêng | Kinh doanh theo dõi, sản xuất chuẩn bị mẫu | Chất lượng đối chiếu yêu cầu và bản mẫu | Đại diện khách có quyền xác nhận mẫu; duyệt nội bộ không thay khách duyệt. |
| Lệnh sản xuất, làm bù hàng sẵn | Quản lý sản xuất | Kho kiểm tra vật tư; quản lý kiểm tra người/máy và mẫu nếu có | Giám đốc duyệt lệnh; quản lý tổ chức thực hiện trong phạm vi đã duyệt. |
| Phân công tổ, đổi lịch nội bộ | Quản lý sản xuất/tổ trưởng theo nhiệm vụ | Nhân sự kiểm tra lịch nghỉ; quản lý kiểm tra kỹ năng và trùng nguồn lực | Quản lý sản xuất xác nhận trong lệnh/lịch được phép; giám đốc quyết khi đổi ưu tiên/cam kết hoặc tăng chi chưa duyệt. |
| Đơn mua, sửa giá/lượng/điều kiện mua | Mua hàng từ nhu cầu sản xuất/kho | Kho/sản xuất kiểm tra lượng thiếu; tài chính kiểm tra điều kiện mua khi cần | Giám đốc duyệt; không duyệt lại toàn đơn chỉ vì nhà cung cấp giao từng phần đúng thỏa thuận. |
| Nhận hàng, cấp/hoàn vật tư, nhập thành phẩm, xuất từng đợt | Kho | Nguồn duyệt, lượng thực tế và kết quả chất lượng | Kho xác nhận thực tế đủ điều kiện; không trình giám đốc lại từng phiếu thông thường. |
| Giữ hàng hoặc giải phóng theo nguồn | Kinh doanh hoặc quản lý sản xuất đề nghị | Kho kiểm tra nguồn, lô và khả dụng | Kho xác nhận trong nguồn đã duyệt; chuyển ưu tiên/hủy nguồn cần giám đốc duyệt, không tự lấy hàng của đơn khác. |
| Kiểm tra đạt, khóa hoặc bỏ khóa lô | Người phụ trách chất lượng | Căn cứ kiểm tra, mẫu và phần lượng liên quan | Chất lượng khóa ngay khi nghi vấn; chỉ chất lượng giải phóng sau đạt và đủ điều kiện xử lý. |
| Làm lại, trả, tiêu hủy hoặc thu hồi | Quản lý sản xuất/chất lượng/mua hàng/kinh doanh tùy nguồn | Chất lượng đánh giá; kho đối chiếu lượng; tài chính đánh giá tiền nếu có | Giám đốc duyệt phương án xử lý; bộ phận liên quan xác nhận thực hiện và chất lượng kiểm tra lại khi cần. |
| Giao khách theo cam kết | Kinh doanh lập đợt; giao hàng theo dõi | Kho kiểm tra hàng; tài chính đối chiếu điều kiện tiền của đơn | Không duyệt lại đơn khi giao đúng điều kiện; người giao lưu căn cứ khách nhận, kinh doanh kiểm tra kết quả. |
| Đổi/hủy đơn, trả bán, giảm giá, giao bù, hoàn tiền | Kinh doanh giữ việc | Sản xuất/kho/chất lượng/tài chính đối chiếu phần đã thực hiện | Giám đốc duyệt phương án; khách xác nhận phần thương mại cần thống nhất; thực hoàn do người chi xác nhận. |
| Thu tiền, ghi nhận bán và phân bổ công nợ | Tài chính theo chứng từ nguồn | Đợt chấp nhận, người trả thay nếu có và tiền thực nhận | Tài chính xác nhận đúng phạm vi; giám đốc duyệt điều chỉnh/ngoại lệ, không duyệt lại khoản thu thông thường. |
| Chi tiền, trả nhà cung cấp, ứng hoặc trả lương | Tài chính lập/kiểm tra; nhân sự lập bảng lương | Chứng từ và phần còn được trả; người kiểm tra khác nếu lập cho mình | Giám đốc duyệt khoản chi/bảng lương; người phụ trách quỹ/ngân hàng xác nhận thực trả. Không tính việc duyệt đơn mua là đã duyệt mọi khoản chi. |
| Công và phép thông thường | Nhân viên/tổ trưởng đề nghị hoặc ghi thay | Quản lý xác nhận công; nhân sự đối chiếu chính sách và phép | Quản lý trực tiếp duyệt phép trong chính sách; nhân sự chốt công sau xác nhận. Ngoại lệ/làm thêm do giám đốc duyệt theo điều kiện đã lưu. |
| Điều chỉnh tồn, kiểm kê, đảo chứng từ hoặc sửa kỳ đã chốt | Bộ phận giữ chứng từ lập | Bộ phận đối chiếu và các nguồn phụ thuộc | Giám đốc duyệt; người có nhiệm vụ xác nhận điều chỉnh sau xử lý phụ thuộc, không sửa đè lịch sử. |
| Danh mục/quy cách quan trọng, chính sách và quyền truy cập | Người phụ trách nghiệp vụ đề nghị | Bộ phận sử dụng kiểm tra ảnh hưởng | Giám đốc duyệt; người được giao quản trị áp dụng. Quyền quản trị không tự thành quyền xem mọi lương hoặc sửa dữ liệu nghiệp vụ. |

Để thống nhất P05 với quy trình kho, đề xuất quản lý sản xuất là người đánh giá/điều phối làm lại hoặc loại bỏ; phương án xử lý chính thức theo hàng/lô có xuất chuyển, tiêu hủy, chi phí hoặc ảnh hưởng cam kết phải có giám đốc duyệt như bảng. Đây là làm rõ đề xuất chờ duyệt, chưa tự thay thẩm quyền được xác nhận. Không tự đặt hạn mức tiền để ủy quyền mua/chi; khi có nhu cầu mới đề xuất riêng.

## Bàn giao giữa các bộ phận

Mỗi lần bàn giao lưu nguồn và phiên bản, phần việc/lượng, người giao, người nhận, ngày cần, điều kiện còn thiếu và thời điểm tiếp nhận. Người nhận xác nhận đủ hoặc trả lại với lý do; gửi yêu cầu chưa đồng nghĩa bên nhận đã bắt đầu. Lượng có thể bàn giao từng phần; phần còn thiếu vẫn ở danh sách chờ với người giữ việc rõ ràng. Không nhập lại cùng thông tin thành một đơn hoặc lệnh khác chỉ để chuyển bộ phận.

| Điểm bàn giao | Nội dung tối thiểu | Điều kiện để bước sau thực hiện |
| --- | --- | --- |
| Kinh doanh → sản xuất/kho | Đơn, biến thể/số viên, giá/điều kiện đã duyệt, ngày giao, bên nhận, yêu cầu/mẫu và người khách duyệt | Đơn đúng phiên bản; điều kiện mẫu/cọc nếu áp dụng đã đủ; quản lý đánh giá khả năng đáp ứng trước cam kết. |
| Sản xuất/kho → mua hàng | Lệnh hoặc nhu cầu bù, lượng đạt khả dụng, phần đã dành, đang về đúng nhu cầu và phần thiếu, ngày cần | Nhu cầu thiếu có căn cứ, không dùng cùng tồn/đang về cho hai lệnh. |
| Mua hàng → kho/chất lượng/tài chính | Đơn mua duyệt, từng lần giao, đơn vị/quy đổi, lô nguồn và chứng từ | Kho ghi thực nhận; chất lượng phân loại; tài chính đối chiếu nghĩa vụ riêng. Thiếu/chờ kiểm tra không giả là nhận đạt. |
| Kho → sản xuất | Lệnh, lô vật tư đạt, lượng thực cấp và phần chưa cấp | Đúng nguồn và được phép dùng; người nhận xác nhận, sản xuất giữ lượng đang dùng/dư/hao hụt để đối chiếu. |
| Sản xuất → chất lượng/kho | Lệnh/lô, bản mẫu, lượng hoàn thành/chờ/lỗi, vật tư thực dùng/hoàn và công thực tế | Chất lượng xác nhận phần đạt; kho chỉ nhập đúng lượng đủ điều kiện, phần chưa kiểm tra không tự đạt. |
| Nhân sự/tổ trưởng → sản xuất/tài chính | Người/tổ theo ngày, giờ trực tiếp theo lệnh, công/nghỉ/chờ, bản công và nguồn chi phí được duyệt | Không trùng giờ; chưa đủ nguồn lương/chi phí thì giá thành còn tạm tính, không ép đủ 240 giờ từ số kế hoạch. |
| Kho → giao hàng → kinh doanh/tài chính | Lô/lượng thực xuất, bên vận chuyển/nhận, kết quả từng đợt chấp nhận/thiếu/vỡ/từ chối và chứng cứ | Rời kho chỉ thành đang giao; ghi nhận bán theo phần đủ điều kiện của mô hình cơ sở, không theo lượng dự kiến. |
| Chất lượng/kinh doanh → xử lý ngoại lệ | Lô, nguồn, phần còn ở đâu, đơn bị ảnh hưởng, đánh giá và phương án đề nghị | Có người giữ việc và quyết định phù hợp; nhận trả, giao bù hoặc hoàn tiền là các bước riêng. |

Mốc theo dõi đề xuất: việc thường được bên nhận phản hồi trong một ngày làm việc; sự cố chặn sản xuất/giao hàng được báo cho người giữ việc ngay trong ca. Đây là mục tiêu xử lý demo, không cam kết thời gian hoạt động thật. Chậm thì hiện việc chờ và chuyển người có thẩm quyền xử lý, không tự duyệt khi hết thời gian. Thông báo ở đây là điểm bàn giao nội bộ đề xuất; chưa gửi email/Zalo hoặc liên hệ bên ngoài.

## Chất lượng ở các điểm bàn giao

Đề xuất hồ sơ kiểm tra ngắn theo từng loại vật tư/biến thể, có phiên bản yêu cầu, người kiểm tra, lượng kiểm tra, lượng được kết luận đạt/chờ/lỗi và căn cứ. Ngói đối chiếu đúng mẫu/hình dạng, màu/bề mặt và tình trạng vỡ; Terrazzo đối chiếu quy cách, màu/hạt đá/bề mặt và tình trạng vỡ. Vật tư kiểm tra nhận đúng loại/quy cách, lượng và tình trạng theo đơn/nguồn. Các nội dung này chỉ là khung ERP; tiêu chuẩn kỹ thuật, phép thử và dung sai thật chưa được xác minh.

| Điểm kiểm soát | Người giữ việc | Kết quả bàn giao đề xuất |
| --- | --- | --- |
| Mẫu đặt riêng trước hàng loạt | Kinh doanh cùng sản xuất/chất lượng | Khách có quyền duyệt đúng phiên bản. Khách đổi mẫu thì đánh giá và duyệt lại phần bị ảnh hưởng. |
| Vật tư thực nhận | Kho cùng chất lượng | Lượng đạt được dùng, lượng chờ/lỗi cách ly; mua hàng xử lý với nguồn cung. |
| Trong sản xuất, trước chuyển bước | Tổ trưởng ghi bất thường, chất lượng đánh giá | Phần đạt được chuyển; nghi vấn giữ chờ/khóa theo phạm vi, quản lý ngừng an toàn phần bị ảnh hưởng. |
| Thành phẩm trước nhập/giao | Chất lượng, kho đối chiếu khi soạn | Có kết luận cho đúng lô/biến thể; vỡ hoặc sai phát hiện lúc soạn phải giữ lại, không dựa vào kết quả cũ để xuất. |
| Phản ánh hoặc hàng trả | Kinh doanh nhận, chất lượng giữ việc kiểm tra | Truy lô và các đợt giao, khóa phần còn liên quan ngay; giám đốc duyệt xử lý thương mại/thu hồi, kho ghi hàng thực về. |

Nếu chỉ kiểm tra một mẫu thì không tự ghi cả lô đã kiểm tra từng viên. Phạm vi kết luận cho toàn lô phải có quy tắc lấy mẫu/chấp nhận đã xác lập cho demo; chưa có thì phần chưa đủ căn cứ vẫn chờ. Bản đề xuất này chưa tự chọn tỷ lệ mẫu hoặc dung sai kỹ thuật. Kết quả thực tế quyết định lượng đạt; 2%/3% lỗi kế hoạch không phải kết quả kiểm tra.

Người kiểm tra chất lượng khóa phần nghi vấn ngay không chờ duyệt thương mại. Giám đốc không dùng quyết định giao gấp để bỏ khóa hoặc biến lỗi thành đạt. Chỉ chất lượng bỏ khóa sau đánh giá đạt và đủ điều kiện phương án; làm lại cần kiểm tra lại. Không mặc định dựng phòng thử nghiệm, chứng nhận hoặc quy trình ISO cho demo nhỏ.

## Thay đổi ủy quyền và giới hạn dữ liệu

Sửa giá/lượng/biến thể/ngày cam kết/điều kiện tiền hoặc phạm vi chi đã duyệt phải tạo bản thay đổi, đánh giá phần đã thực hiện, gửi lại đúng người duyệt và nhận xác nhận khách khi cần. Bản cũ không còn dùng cho phần đang đổi. Người giữ việc liệt kê các yêu cầu phụ thuộc; phần bị ảnh hưởng giữ chờ, phần không ảnh hưởng có thể tiếp tục đủ điều kiện. Việc chỉ bổ sung ghi chú không đổi cam kết không tạo một vòng duyệt toàn đơn. Không xóa giao dịch kho/tiền đã phát sinh.

Ủy quyền cần người giao quyền, người nhận, loại việc/nguồn, ngày bắt đầu/kết thúc và giới hạn; quyền xem dữ liệu chỉ mở mức cần cho nhiệm vụ. Không tự chuyển toàn quyền giám đốc cho người có chức danh gần giống, không ủy quyền tiếp nếu chưa được phép. Hết hạn/thu hồi thì không duyệt mới; kết quả duyệt hợp lệ trước đó vẫn lưu, không tự xóa. Không có người đủ quyền thì giữ chờ, không tự bật quyền hoặc suy ra im lặng là đồng ý.

Kinh doanh xem đơn/phần công nợ khách trong phạm vi phụ trách; kho xem lượng/lô và nguồn xuất nhập; sản xuất xem lệnh, vật tư, lịch/người và chi phí tổng hợp được cấp quyền, không tự xem lương cá nhân; chất lượng xem mẫu/lô và phần truy nguồn cần xử lý. Nhân sự quản lý hồ sơ/công, chỉ người được giao làm lương có quyền lương; tài chính và giám đốc xem tiền/chi phí theo nhiệm vụ. Công nhân có thể được tổ trưởng nhập thay và nhận phiếu cá nhân, không bắt buộc tài khoản ERP.

Quyền xem, lập, duyệt, xác nhận, điều chỉnh và xuất dữ liệu được tách theo loại việc/phạm vi. Không có quyền thì không thao tác qua đường khác chỉ vì truy cập được một chứng từ liên quan. Nhật ký giữ người, thời điểm, nguồn và lý do; không ghi bí mật/lương vào nhật ký công khai. Đây là yêu cầu nghiệp vụ chờ thiết kế/kiểm chứng phân quyền, chưa cam kết hệ thống đã bảo mật.

## Kịch bản liên hoàn để đánh giá phương án

Toàn bộ số liệu dưới đây là giả lập kế thừa P06/M03 và tài liệu giao hàng, chưa phải dữ liệu Nasaki hoặc kết quả phần mềm. Đơn ngói tiêu chuẩn 10.000 viên, giá 18.000 đồng/viên, cọc theo thỏa thuận ví dụ 60 triệu; có 3.000 viên đạt chưa dành. Các vật tư khác giả sử đủ; chưa xét thuế, giảm giá hoặc phí vận chuyển. Kịch bản nối trách nhiệm, không chứng minh đủ lịch máy/người hoặc hồ sơ kỹ thuật.

1. Kinh doanh lập đơn; quản lý sản xuất xác nhận khả năng trước cam kết; giám đốc duyệt giá/đơn. Tài chính ghi thực nhận cọc 60 triệu riêng, không doanh thu. Với đơn đặt riêng mới cần mẫu khách duyệt; đơn tiêu chuẩn này không tự thêm thủ tục duyệt mẫu khách.
2. Quản lý đề nghị bổ sung 7.000 viên đạt, lập tám lô bắt đầu 8.000 theo P06; giám đốc duyệt lệnh. Kho đối chiếu xi măng cần 2.400 kg, tồn 1.500 trong đó 300 dành việc khác → thiếu 1.200 kg; mua hàng lập mua 24 bao 50 kg, giám đốc duyệt. Nhận 14 rồi 10 bao được kho ghi và chất lượng xác nhận đạt. Kho cấp 2.400, còn 300 đã dành việc khác.
3. Tổ trưởng ghi công theo người/lệnh; quản lý xác nhận, nhân sự đối chiếu. Nguồn 240 giờ × 50.000 = 12 triệu chi phí nhân công là giả lập cần chứng từ đủ, không cộng chi phí này lần hai. Chất lượng ghi 7.840 đạt, 160 lỗi phải xử lý; kho nhập 7.840 đạt. Giám đốc duyệt loại bỏ và chỉ khi thực xử lý mới xác nhận tiêu hủy; lượng 160 không vào kho hàng bán. Cách giữ hàng lỗi tại xưởng và biên bản cần cụ thể hóa cùng dữ liệu, không giả như tất cả đã bị tiêu hủy chỉ vì không đạt.
4. Kinh doanh lập giao 6.000 rồi 4.000; kho xác nhận thực rời, giao hàng ghi khách chấp nhận. Tài chính ghi bán đúng mỗi đợt và phân bổ cọc/thu: bán 108 triệu → phải thu 48; thu 30 → còn 18; bán tiếp 72 → còn 90; thu 90 → hết. Không trình giám đốc lại từng đợt đúng đơn, không ghi doanh thu chỉ từ xuất kho. Tồn đạt cuối 3.000 + 7.840 − 10.000 = 840 viên.
5. Tài chính đối chiếu nguồn chi phí giả lập: vật tư 30,04 + nhân công 12 + chung 5 = 47,04 triệu cho 7.840 đạt, đơn giá 6.000/viên. Đầu kho 3.000 cũng giá 6.000 → giá vốn bán 60 triệu, tồn 5,04 triệu, lãi gộp 120 triệu trước chi phí khác. Nguồn chưa đủ thì báo tạm tính; không coi tiền thu 180 triệu là lợi nhuận. Nghĩa vụ mua xi măng 2,4 triệu đã xác nhận, trả 1 triệu còn phải trả 1,4 triệu, theo dõi riêng nợ khách.

Đề xuất thêm một nhánh Terrazzo ngắn độc lập để không chỉ minh họa ngói: một lô bắt đầu 500 viên, kết quả giả lập 485 đạt và 15 lỗi, đủ điều kiện nhập 485; không lấy tỷ lệ 3% dự kiến tự sinh kết quả. Người kiểm tra đối chiếu đúng biến thể/mẫu, kho chỉ nhập lượng đạt. Nhánh này chưa có đơn bán, giá hay đủ hồ sơ chi phí/lịch; không suy ra lợi nhuận hoặc năng lực. Kịch bản hàng riêng phải bổ sung lần duyệt mẫu riêng khi tạo bộ dữ liệu hoàn chỉnh.

Các nhánh ngoại lệ cần giữ để kiểm chứng: khách đổi mẫu sau duyệt; lô bị khóa trong khi đã giữ hàng; người duyệt vắng; tổ thiếu người/chờ máy; nhận trả nhưng chưa quyết hoàn tiền. Mỗi nhánh phải chỉ ra người giữ việc, bước tạm chờ, quyết định cần có và nguồn bị ảnh hưởng; không tự sửa số để làm kịch bản kết thúc đẹp.

## Những nội dung đề nghị anh duyệt

1. Một người giữ việc cho mỗi nguồn, ít cấp duyệt; giám đốc duyệt cam kết thương mại/mua/sản xuất/chi và ngoại lệ, các xác nhận thường ngày thuộc đúng bộ phận như bảng.
2. Cho phép kiêm nhiệm và người nhập thay, nhưng không tự duyệt việc nhạy cảm của mình; ủy quyền có phạm vi/thời hạn và không tự mở quyền xem lương.
3. Chất lượng được khóa ngay và là bên xác nhận đủ điều kiện giải phóng; quyết định thương mại không thay kết luận đạt.
4. Bàn giao cần bên nhận phản hồi, nguồn đúng phiên bản và phần thiếu được theo dõi; dùng kịch bản liên hoàn trên làm cơ sở chuẩn bị dữ liệu/tiêu chí nghiệm thu sau.

Anh có thể duyệt toàn phương án hoặc chỉnh từng mục; sự đồng ý giao lập đề xuất chưa phải duyệt bốn nội dung này. Bộ dữ liệu người/tài khoản/quyền, danh mục/lịch/chính sách mẫu, tiêu chí chất lượng và chứng từ chi phí vẫn phải cụ thể hóa trước xây dựng. Chưa đào sâu kế toán, chưa có build/test ứng dụng; chỉ đối chiếu tài liệu và phép tính. Lịch sử build chưa tồn tại vì kho chưa có mã ứng dụng. Bản này không kết luận phân tích toàn ERP hoàn tất hoặc cho phép triển khai thực tế.
