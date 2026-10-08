# Bộ dữ liệu và quy tắc nghiệp vụ demo ERP Nasaki

Bộ này cụ thể hóa cách vận hành demo một công ty, một xưởng, một kho, 50 nhân sự, có ngói và Terrazzo. Mỗi giao dịch phải có nguồn, người chịu trách nhiệm, điều kiện thực hiện và kết quả đối chiếu. Anh giao xây dựng kỹ bộ này ngày 08/10/2026 theo B25; phương án trách nhiệm đã được duyệt ở B24. **Các tham số mới dưới đây là đề xuất giả lập để anh duyệt, không phải dữ liệu hoặc quy trình thực tế Nasaki.** Đây là nền yêu cầu nghiệp vụ, chưa là ứng dụng đã chạy.

Đọc cùng [hồ sơ nghiệp vụ](business-context.md), [trách nhiệm đã duyệt](responsibilities-approvals-handoffs.md), [kho](warehouse-workflows.md), [giao hàng và tài chính](delivery-finance-workflows.md), [nhân sự](hr-workflows.md). [Kịch bản và kết quả](demo-scenarios.md) xác định thứ tự và số đối chiếu; [tiêu chí nghiệm thu](demo-acceptance.md) xác định điều kiện đạt. Tài liệu này giữ quy tắc; các giá trị cụ thể có nguồn duy nhất trong [dữ liệu mẫu](demo-data/baseline.json) và ba bảng CSV cùng thư mục.

## Phạm vi và trạng thái quyết định

| Nhóm | Căn cứ hiện hành | Cách sử dụng |
| --- | --- | --- |
| Quy mô, bảy nghiệp vụ, hai sản phẩm, viên, sản xuất kết hợp | B01–B10 đã xác nhận | Giữ nguyên; không thêm kho/xưởng hoặc bỏ nhân sự/tài chính. |
| Khách, giá, mẫu và khả năng giao | B11–B18 đã xác nhận | CEO là giám đốc; giám đốc chức năng không tự được tạo. |
| Mô hình minh họa và kế toán chưa đào sâu | B19, B21, B22 | Tự đề xuất dữ liệu chuyên môn giả lập, giữ tổ chức gọn. |
| Trách nhiệm, phê duyệt, chất lượng, bàn giao | B24 đã duyệt | Dùng bảng quyền đã duyệt làm cơ sở; tham số mới vẫn là đề xuất. |
| Thực hiện bộ dữ liệu này kỹ lưỡng | B25 giao thực hiện | Cho phép lập, đối chiếu và lưu bộ mẫu; không tự coi mọi chính sách mới là đã được duyệt. |

Tài chính cơ sở vẫn có thu chi, công nợ, chi phí sản xuất, giá vốn và lãi gộp. Thuế, hóa đơn pháp lý, ngoại tệ, thủ tục xuất khẩu và khấu trừ bắt buộc trong lương để phân tích sau theo yêu cầu; phải hiện là **chưa mô phỏng**, không hiện thuế suất 0% hoặc thực lĩnh pháp lý. Khách xuất khẩu có trong danh mục và tình huống tiếp nhận, chưa có giao dịch xuất khẩu hoàn chỉnh.

## Cấu trúc lưu dữ liệu và cách dùng lại

| Tệp | Nội dung chính | Điều kiện cập nhật |
| --- | --- | --- |
| [baseline.json](demo-data/baseline.json) | Mốc, danh mục, tồn đầu, nguồn lực, lô, chuyển kho, bán, thu/phân bổ, chi, lương tính được và số kiểm chứng | Tăng phiên bản bộ mẫu khi đổi các tham số ảnh hưởng kết quả; cập nhật kịch bản và chạy đối chiếu. |
| [scenario-cases.json](demo-data/scenario-cases.json) | 24 nhánh ngoại lệ X01–X24 có mốc riêng, đầu vào và kết quả mong đợi | Không cộng nhánh vào cơ sở; hành vi ngăn/xác nhận phải kiểm trong ERP khi xây. |
| [employees.csv](demo-data/employees.csv) | 50 người khác nhau, bộ phận, quản lý, vai trò, kỹ năng, lương/phụ cấp và phép đầu | Kiêm nhiệm không thêm người; đổi mức có hiệu lực, không sửa ngược bản đã dùng. |
| [attendance.csv](demo-data/attendance.csv) | 1.300 dòng người/ngày, loại công, phút làm/nghỉ và người nhập/xác nhận | Một người/ngày/ca chỉ có một nguồn chính; điều chỉnh có phiên bản. |
| [labor-intervals.csv](demo-data/labor-intervals.csv) | 76 khoảng làm trực tiếp theo người/lô/công đoạn | Không trùng giờ, không vượt công thực làm; còn thời gian khác phải được giải thích. |
| [verify-demo-data.py](../scripts/verify-demo-data.py) | Đối chiếu dữ liệu trên bằng số lượng, nguồn và phép tính độc lập | Chỉ kiểm tra bộ mẫu, không chứng minh phần mềm hoặc phân quyền đã hoạt động. |

Đây là dữ liệu giả lập công khai trong Git. Mã nhân sự thay tên thật; không lưu căn cước, số tài khoản, mật khẩu, hồ sơ sức khỏe hoặc bảng lương thật. Khi xây ứng dụng, dữ liệu vận hành nằm trong cơ sở dữ liệu; không biến README thành nơi nhập chứng từ.

Nạp lại cùng phiên bản không nhân đôi dữ liệu. Đề xuất cung cấp hai cách dùng: bắt đầu từ tồn/danh mục để người trình diễn tự thực hiện; hoặc mở ảnh chụp bộ giao dịch đã hoàn thành để xem báo cáo. Không nạp cả giao dịch đã hoàn thành rồi chạy lại như giao dịch mới. Mỗi nhánh ngoại lệ bắt đầu từ bản sao mốc chỉ định; không cộng tất cả nhánh vào kịch bản chính. Việc làm lại bộ demo chỉ được tác động dữ liệu của bộ demo đó, không xóa dữ liệu vận hành khác.

## Mốc thời gian và đơn vị

Bộ mẫu dùng **tháng 09/2026 giả lập**, múi giờ Asia/Ho_Chi_Minh; thời điểm chuẩn bị tài liệu là 08/10/2026. Tồn đầu tại 00:00 ngày 01/09; mốc đối chiếu cuối là 17:00 ngày 05/10 sau một khoản trả lương mẫu. Ngày chứng từ trong bộ này là ngày mô phỏng, không phải bằng chứng Nasaki đã thực hiện.

Lịch giả lập làm thứ Hai đến thứ Bảy, nghỉ Chủ nhật, không thêm ngày nghỉ lễ trong bộ này: 26 ngày × 8 giờ = 208 giờ. Đây là lịch tính demo có chủ ý để nối ví dụ lương cũ, không phải lịch lao động áp dụng thật tại Việt Nam. Ca 08:00–12:00 và 13:00–17:00; nghỉ trưa không thành giờ công. Ngày 01/10, 02/10 và 05/10 chỉ dùng theo dõi nợ/trả lương; không tự phát sinh công tháng 10.

Viên là số nguyên dương; kg/lít tối đa ba chữ số thập phân. Tiền VND ghi nguyên đồng. Tính tỷ lệ/giá bình quân giữ độ chính xác nội bộ; làm tròn nửa lên tại giá trị chứng từ, không nhân đơn giá hiển thị đã làm tròn để mất tiền. Xuất hết lượng còn lại thì mang toàn bộ giá trị còn lại. Bút toán điều chỉnh tăng/giảm phải chỉ rõ hướng, không dùng số âm để lách giới hạn xuất. Không cộng kg với lít, giờ người với giờ máy hoặc đã dành vào tồn thực tế.

## Danh mục sản phẩm và vật tư

Mã sản phẩm là nhóm mẫu; biến thể là mã đủ màu/quy cách để giữ và giao. Mã lô là nguồn lần sản xuất/nhập, không thay mã biến thể. Hai lô cùng biến thể vẫn cần được phép thay thế theo mẫu và chất lượng; không tự gộp hàng riêng với hàng chuẩn.

| Biến thể đề xuất | Tên tham chiếu | Màu và quy cách giả lập | Dùng trong bộ |
| --- | --- | --- | --- |
| FP04-GREY-D1 | Ngói phẳng FP-04 | Xám; quy cách nội bộ N-D1, 10 viên/m² phục vụ tư vấn | Luồng ngói chính. Không tự gán kích thước thật Nasaki. |
| FP04-BROWN-D1 | Ngói phẳng FP-04 | Nâu; N-D1 | Thử ngăn giao sai màu, chưa có tồn. |
| G01-GREY-D1 | Terrazzo G01 | Xám; 400 × 400 mm giả lập, 6,25 viên/m² | Luồng Terrazzo làm sẵn rồi bán. |
| FP04-CUSTOM-D1 | Ngói phẳng đặt riêng | Màu theo mẫu CUSTOM-SAMPLE-V1; N-D1 | Nhánh duyệt mẫu/đổi yêu cầu, chưa có tồn đầu. |

Chọn FP-04, PV-02, FD-02, AD-02 làm mã tham chiếu demo. Giữ FP - 04, FV-02, FĐ-02, AD 02/AD 0211 là mã khác tương ứng theo B07; mã thay thế chỉ trỏ về sản phẩm, không tự xác định màu/quy cách. PV-02, FD-02, AD-02 hiện chỉ có bảng ánh xạ, chưa là biến thể có thể bán trong bộ chính. Tìm mã cũ không được tạo thêm sản phẩm trùng. Không nhập toàn bộ website làm danh mục vận hành chưa đủ thông số.

Vật tư CEM, SAND, COAT, STONE, PIGMENT dùng kg; WATER dùng lít. Riêng CEM trong bộ này 1 bao = 50 kg, bản quy đổi V1; không áp dụng cho mọi bao/vật tư. Mua ngói/Terrazzo không quy đổi hộp/pallet vì đơn vị phiên bản đầu là viên; thiếu quy đổi không tự đoán.

Tư vấn từ diện tích: ngói 100 m² × 10 × 1,05 = 1.050 viên; Terrazzo 50 m² × 6,25 × 1,05 = 328,125 → làm tròn lên 329 viên. 5% là dự phòng tư vấn riêng, không phải tỷ lệ lỗi sản xuất. Phụ kiện mái là nhu cầu riêng chưa có công thức tự suy ra. Kinh doanh nhập điều kiện công trình, quản lý sản xuất kiểm tra thông số, khách có quyền xác nhận lượng; không xem diện tích mái bằng diện tích mặt bằng. Chưa đủ thông số thì kết quả là ước tính chờ xác nhận, không tự chốt đơn.

## Khách hàng và điều kiện thương mại

Danh mục có đại lý N, nhà thầu C, chủ công trình P, khách lẻ T và khách xuất khẩu X; có bên trả N khác bên mua, bên nhận N khác hai bên đó. Đây là các tổ chức giả lập. Bên đặt/chủ nghĩa vụ, đại diện được đổi đơn/duyệt mẫu, bên trả thay, người nhận và địa chỉ giao là các trường riêng. Chứng cứ trả thay PAY-ON-BEHALF-N chỉ cho phân bổ đúng đơn N, không cấp quyền đổi đơn cho người trả.

Kênh tiếp nhận gồm điện thoại, email, website, liên hệ cá nhân và giới thiệu; chọn người giữ đơn ngay khi tiếp nhận, không tạo nhiều đơn khi cùng khách hỏi qua nhiều kênh. Ngày phản hồi mục tiêu là một ngày làm việc, không tự duyệt nếu quá hạn. Ghi nhận kênh trong ERP không có nghĩa đã tích hợp email/Zalo/website.

Báo giá đề xuất có hạn 7 ngày lịch; tham số mới chỉ áp dụng báo giá mới. Giám đốc duyệt giá/chiết khấu và đơn cơ sở. Dòng ngói dùng giá gốc 20.000, giảm 10% một lần thành 18.000/viên; Terrazzo 40.000/viên, không giảm. Chưa thu phí giao từ khách, chưa tính thuế. Giảm toàn đơn hoặc vận chuyển mới cần chỉ rõ cơ sở; không giảm trùng một khoản ở dòng và tổng.

Đơn N yêu cầu nhận đủ cọc 60 triệu trước khởi động phần sản xuất, giao 6.000 ngày 16/09 và 4.000 ngày 17/09. Đơn T mua hàng làm sẵn 400 viên, cọc 4 triệu trước giao ngày 22/09. Đây là thỏa thuận từng đơn, không bắt mọi khách cọc cùng tỷ lệ. Xác nhận khách và giám đốc duyệt phải đúng phiên bản. Việc đối chiếu khả năng trước cam kết dùng lịch người/máy/vật tư; nếu ngày về chỉ là dự kiến thì ghi rõ phụ thuộc và theo dõi rủi ro.

Thứ tự ưu tiên: ngày giao đã cam kết sớm hơn, sau đó ngày xác nhận đơn sớm hơn; quản lý sản xuất và giám đốc quyết ngoại lệ có lý do, nêu đơn bị ảnh hưởng. Không tự lấy hàng đã dành cho đơn khác, không hứa lịch chỉ từ năm ngày công đoạn cơ sở. Giao từng phần đúng cam kết không duyệt lại toàn đơn.

## Tồn đầu và phân bổ trong một kho

KHO-01 có VT-01, TP-01, CC-01, HL-01; khu vực không tạo kho thứ hai. Tồn đầu được kho lập, chất lượng xác nhận điều kiện dùng, tài chính đối chiếu giá trị, giám đốc duyệt và kho ghi một lần theo nguồn OPEN-20260901.

| Hàng | Lượng đầu | Giá trị đầu VND | Phần dành ban đầu |
| --- | ---: | ---: | --- |
| Ngói xám FP04-GREY-D1 | 3.000 viên | 18.000.000 | Chưa dành. |
| CEM | 1.500 kg | 3.000.000 | 300 kg dành OTHER-001, nhu cầu vật tư tương lai đã duyệt; chưa cấp/chưa sản xuất. |
| SAND | 7.400 kg | 11.100.000 | Chưa dành. |
| COAT | 120 kg | 14.400.000 | Chưa dành. |
| STONE | 400 kg | 1.200.000 | Chưa dành. |
| PIGMENT | 5 kg | 50.000 | Chưa dành. |
| WATER | 1.060 lít | 44.167 | Chưa dành. |

Nguồn giá trị tồn đầu là chứng từ mở đầu giả lập, không ghi doanh thu/sản lượng/mua mới. Giá WATER theo tỷ lệ giá trị/lượng, không ép đơn giá nguyên đồng; tám lần cấp ngói mỗi 120 lít trị giá 5.000, phần 100 lít cuối trị giá 4.167. Do đó vật tư ngói giữ đúng 30.040.000 đồng của ví dụ trước. Nếu đổi giá đầu phải tính lại từ nguồn, không điều chỉnh số kết quả để giữ đẹp.

Tồn vật lý gồm đạt/chờ/lỗi/khóa đang ở kho. Lượng được dùng là hàng đạt, đủ quyền sở hữu/điều kiện, không khóa. Khả dụng = lượng được dùng − lượng đã dành hợp lệ. Hàng đang sản xuất/đang giao không nằm trong kho. Khóa lô làm nhu cầu đang giữ bị thiếu, không âm thầm xóa nhu cầu. Giữ, soạn hoặc chuyển vị trí không tự đổi tổng tồn.

Mua N 24 bao, nhận 14 rồi 10; mua T riêng 3 bao trước lô Terrazzo. Không lấy 300 kg OTHER-001 cho T. Có lô mua riêng; mã nhà cung cấp không thay mã lô nội bộ. Nhận tăng tồn vật lý vào chờ kiểm tra; đạt mới được dùng; chứng từ tài chính không nhập kho lần hai. Các giao dịch nhận trong JSON là kết quả sau hai bước nhận và chất lượng, khi phát triển phải tách hai bước đó như quy trình kho.

Cảnh báo khả dụng: CEM dưới 500 kg; ngói dưới 1.000 viên, mục tiêu 2.000; Terrazzo dưới 500, mục tiêu 1.000. Sau cơ sở ngói còn 840, Terrazzo 85, CEM 0 khả dụng: tạo nhu cầu xem xét bù, không tự mua/sản xuất. Chờ/giữ trên 3 ngày làm việc và tồn trên 30 ngày có danh sách xử lý; không tự giải phóng/tiêu hủy theo tuổi. Bộ cơ sở không khai hạn dùng vật tư vì chưa có căn cứ; chỉ thử hết hạn ở nhánh riêng với ngày giả lập.

## Lệnh sản xuất và nguồn lực

BOM-N-V1 theo 1.000 viên bắt đầu: CEM 300 kg, SAND 900 kg, COAT 15 kg, WATER 120 lít. BOM-T-V1 theo 500: CEM 150, SAND 200, STONE 400, PIGMENT 5 kg, WATER 100 lít. Các lượng là hệ số ERP giả lập, không dùng sản xuất vật lý. Lưu phiên bản trên lệnh; định mức mới không sửa lô cũ.

Dự kiến đạt ngói 98%, Terrazzo 97%. Đơn N thiếu 7.000 đạt; lượng tối thiểu bắt đầu ceil(7.000/0,98) = 7.143; chọn tám lô đầy 1.000 thành 8.000 bắt đầu. Tỷ lệ đã dùng dự phòng lượng bắt đầu nên không tăng vật tư thêm 2% lần nữa. Dư dự kiến phải hiện riêng, không giao thừa cho khách. Kết quả kiểm tra thực tế phải nhập, không sinh 980/485 từ tỷ lệ kế hoạch.

Bốn nguồn lực FORM-N, FINISH-N, FORM-T, FINISH-T trong cùng xưởng; mỗi nguồn tối đa hai lô đầy/ngày, cần người đủ kỹ năng và giờ thực còn rảnh. Chỗ giữ CURING-SHARED tối đa 8.000 viên đang chờ, cả hai nhóm dùng chung. Mỗi lô tạo hình một ngày, chờ ba ngày làm việc sau ngày tạo hình, hoàn thiện/kiểm tra ngày làm việc thứ năm. Ngói đặt hai lô/ngày trong bốn ngày; Terrazzo chỉ khởi động sau giải phóng đủ chỗ. Đây là năng lực demo, không suy ra từ công suất website 5,5 triệu viên/năm.

Đổi mẫu/màu cần nửa ca chuẩn bị, còn tối đa một lô đầy cho nguồn bị đổi trong ngày; tổ được phân công phải có giờ cho chuẩn bị, không vừa tính toàn ca làm lô vừa cộng chuẩn bị. Ca tạo hình ngói có hai khoảng 08:00–11:45 và 13:00–16:45; phần 30 phút/ngày còn lại của mỗi người là hỗ trợ, không tự vào trực tiếp. Terrazzo một lô dùng 08:00–12:00 và 13:00–14:00, phần còn lại hỗ trợ. Chi tiết trong bảng giờ và kịch bản.

Quản lý đề nghị lệnh, kho kiểm tra vật tư, nhân sự kiểm tra lịch/kỹ năng, giám đốc duyệt; quản lý tổ chức trong phạm vi duyệt. Đang về không thành đã có; thiếu một loại thì phần chưa đủ điều kiện giữ chờ. Đủ vật tư một số lô có thể làm trước theo phương án rõ, không đánh dấu toàn lệnh đã đủ. Làm sẵn T từ đề nghị tồn mục tiêu được duyệt, không tạo đơn khách giả để được sản xuất.

## Chất lượng và xử lý lượng lỗi

Đề xuất QC-DEMO-V1 kiểm tra **toàn bộ lượng hoàn thành về ngoại quan và nhận dạng** trong bộ này, có người kiểm tra, mẫu/quy cách phiên bản, lượng kiểm và kết luận. Không dùng lấy mẫu để suy rộng cả lô; không giả lập đã kiểm tra cơ lý hay có chứng nhận thật. Mỗi kết luận phải khớp: đạt + lỗi + chờ = lượng hoàn thành được kiểm/đối chiếu; chưa kiểm không được tính đạt.

| Đối tượng | Điều kiện đạt giả lập | Khi không đủ căn cứ |
| --- | --- | --- |
| Vật tư nhận | Đúng mã/quy cách đơn, đếm/cân đủ phần nhận, bao bì/ngoại quan phù hợp yêu cầu mô phỏng | Cách ly phần nghi vấn; không tự kết luận thành phần/chất lượng kỹ thuật. |
| Ngói | Đúng N-D1, đúng màu/mẫu tham chiếu, không vỡ/nứt quan sát được, bề mặt không lỗi theo mẫu demo | Ghi lỗi màu/bề mặt/vỡ hoặc chờ đối chiếu mẫu; không cho giao phần đó. |
| Terrazzo | Đúng 400 × 400 mm giả lập, sai lệch từng chiều không quá ±2 mm theo thước đo mô phỏng; màu/hạt/bề mặt đúng mẫu, không vỡ/nứt quan sát được | Giữ chờ/lỗi, ghi số đo và tiêu chí bị vi phạm. ±2 mm không là tiêu chuẩn thật Nasaki. |
| Hàng riêng | Các điều kiện tương ứng và đúng bản mẫu được đại diện khách duyệt | Thiếu khách duyệt/đổi mẫu thì không khởi động hàng loạt phần bị ảnh hưởng. |
| Soạn giao/nhận trả | Đúng biến thể/lô, không phát sinh vỡ, khóa hoặc điều kiện ngăn dùng | Không dùng kết luận cũ để bỏ qua lỗi mới. |

Trong mỗi lô ngói bộ chính: 1.000 hoàn thành, 980 đạt, 10 lỗi màu và 10 vỡ/nứt. Terrazzo: 500 hoàn thành, 485 đạt, 10 lỗi bề mặt và 5 vỡ/nứt. Đây là kết quả nhập giả lập, không là tỷ lệ tự tính. Chất lượng lập QC; giám đốc duyệt DSP sau đánh giá; ghi thực tiêu hủy tại xưởng 20/lô ngói và 15 Terrazzo sau kiểm tra. Chỉ nhập phần đạt vào TP-01; lỗi giữ trách nhiệm ở xưởng trước thực xử lý, không vừa có ở kho vừa ở xưởng. Sau tiêu hủy hết, không còn lượng đang làm/chờ/lỗi trong cơ sở.

Lỗi thông thường không thu hồi trong cơ sở được phân bổ chi phí tới lượng đạt như P05; biên bản giá trị ghi khoản lỗi đã nằm trong giá thành, không cộng chi phí tiêu hủy cùng giá trị đó lần nữa. Lỗi bất thường, làm lại có chi phí thêm, phế liệu có giá trị hoặc bán hạ loại phải giữ nhánh tạm tính đến khi có phương án, không áp dụng tùy tiện giá hàng đạt.

Chất lượng khóa ngay phần nghi vấn; chỉ chất lượng bỏ khóa có kết quả đạt và đủ điều kiện phương án. Giám đốc quyết thương mại nhưng không biến lỗi thành đạt. Đề nghị thu hồi chỉ tạo danh sách cần thu; hàng thực quay về mới tăng kho.

## Nhân sự công phép và nguồn chi phí

Bảng 50 người giữ cơ cấu đã đề xuất: 1 giám đốc, 5 kinh doanh, 2 mua, 4 kho/giao, 28 sản xuất, 3 chất lượng, 3 tài chính, 4 nhân sự/hành chính. Sản xuất gồm E013 quản lý, E014/E015 tổ trưởng và E016–E040 người thực hiện. Nhóm hành chính không là bốn HR chuyên trách. Có 17 người có vai trò tài khoản nghiệp vụ trong bộ, số còn lại do người phụ trách nhập/đối chiếu; chưa là cam kết 17 người đồng thời.

E016–E019 đủ kỹ năng tạo hình/hoàn thiện ngói; E020–E022 đủ kỹ năng Terrazzo; E023–E040 đóng gói/hỗ trợ. Ghi đào tạo an toàn giả lập có hiệu lực; không tự điều E023 thay người vận hành khi chưa có kỹ năng. Nhập thay lưu người nhập; xác nhận do quản lý khác người có công. Công E001 có HR kiểm tra độc lập; các khoản tự hưởng/chưa đủ thẩm quyền giữ chờ theo B24, không tự duyệt vì chức danh.

Mỗi người/ngày có loại công và phút thực làm; ngoại lệ E023 nghỉ hưởng lương 22/09 và không lương 23/09 đã có nguồn riêng. E023 có 192 giờ làm, 8 phép hưởng lương, 8 không lương; người còn lại có 208 giờ làm giả lập. Lịch không tự trở thành công; 1.300 dòng là kết quả xác nhận mô phỏng có nguồn, khi trình diễn phải có bước ghi/xác nhận.

Phép đầu demo mỗi người 4.800 phút = 10 ngày tại mốc; không phát sinh thêm quyền phép trong tháng mô phỏng, không hết hạn/chuyển phép trong bộ này. Đây là số dư mô phỏng riêng, không khẳng định quyền phép năm pháp lý. Duyệt nghỉ giữ 480 phút; thực nghỉ/chốt công chuyển sang đã dùng 480; E023 còn 4.320 phút = 9 ngày, không trừ hai lần. Không lương không trừ phép. Xin/hủy phần chưa nghỉ giải phóng đúng giữ; không xếp người vào giờ nghỉ. Làm thêm không có trong cơ sở; cần chính sách/căn cứ riêng trước tính thu nhập làm thêm.

Lương cơ sở/phụ cấp có trong employees.csv, hiệu lực 01/09. Công thức demo: lương thời gian = lương cơ sở × phút hưởng lương / 12.480; cộng phụ cấp cố định, làm tròn đồng theo quy tắc chung. E016–E022 dùng lương 10,4 triệu và không phụ cấp để nguồn 50.000/giờ có căn cứ; người khác có phụ cấp cố định 500.000. E023: 7,8 triệu × 200/208 + 0,5 triệu = 8 triệu trước khoản bắt buộc; ứng đã chi 1 triệu, chi minh họa 7 triệu ngày 05/10 còn 0 trong mô hình đơn giản. Không gọi 7 triệu là thực lĩnh pháp lý.

Tổng thu nhập trước khoản bắt buộc của 50 người là 493.360.000 đồng. Dòng E001 giữ chờ kiểm tra/quyết định độc lập do chính là giám đốc; chưa tự kết luận bảng tổng đã được duyệt toàn bộ. Các dòng khác có trạng thái duyệt giả lập. Chỉ trả E023 ở kịch bản chính; còn 485.360.000 đồng thu nhập trước khoản bắt buộc chưa trả, trong đó dòng E001 vẫn chờ quyết định. Tách tổng đã tính, đã duyệt và thực trả; không đánh dấu cả 50 người đã trả.

Nguồn nhân công của bảy người E016–E022 là 72,8 triệu thu nhập đã đối chiếu; 1.456 giờ hưởng lương. Ngói 240 giờ = 12 triệu; Terrazzo 30 giờ = 1,5 triệu; 1.186 giờ còn lại = 59,3 triệu là hỗ trợ/việc khác của nhóm, không tự dồn vào hai lệnh. Người khác và phụ cấp không thuộc nguồn trực tiếp này; không suy ra lãi ròng toàn doanh nghiệp chỉ từ lãi gộp hai đơn. Khi kỳ chưa chốt, giá thành còn tạm tính. Nguồn giả lập đã chốt cho bảy người cho phép số đối chiếu giá thành; không cần chi lương xong mới có chi phí, và chi lương không cộng lại vào lệnh.

## Quyền thao tác theo người và phạm vi

Quyền gồm xem, lập, kiểm tra, duyệt, xác nhận thực hiện, điều chỉnh và xuất dữ liệu; cấp vai trò không tự cấp mọi hành động. Các tài khoản trong CSV là mô tả để thiết kế sau, không có mật khẩu mặc định trong Git.

| Người hoặc nhóm | Quyền cần cho demo | Giới hạn bắt buộc |
| --- | --- | --- |
| E001 giám đốc | Duyệt đơn/giá/lệnh/mua/chi/ngoại lệ, xem báo cáo tổng | Không tự duyệt khoản nhạy cảm của mình; không bỏ khóa QC; không sửa giao dịch đã ghi. |
| E002, E003 kinh doanh | Giữ đơn N/T, lập báo giá/giao/đổi trả; xem công nợ khách phụ trách | Không tự duyệt giá; không xác nhận tiền; không xem lương/giá vốn nếu chưa cấp quyền. |
| E007 mua | Lập PO, theo dõi giao và đối chiếu nguồn cung | Không xác nhận tiền chi hoặc QC thay chất lượng. |
| E009, E010 kho | Nhận/cấp/giữ/xuất đúng nguồn, lượng/lô | Không bán hàng khóa, không tự duyệt điều chỉnh/tiêu hủy, không xem lương. |
| E011 giao | Ghi kết quả khách nhận và chứng cứ theo đợt | Không sửa lượng xuất hoặc ghi nhận doanh thu. |
| E013 quản lý sản xuất | Lệnh, khả năng, phân công, xác nhận công; chi phí lệnh tổng hợp được giao | Không tự duyệt lệnh/cam kết mới, không đọc lương cá nhân qua báo cáo chi phí. |
| E014, E015 tổ trưởng | Ghi công thay, khoảng trực tiếp, sản lượng thực theo tổ | Không xác nhận công của mình, không mở lương cả tổ. |
| E041, E042 chất lượng | QC, khóa/giải phóng, truy nguồn | Không quyết hoàn tiền hoặc tự ký khách duyệt mẫu. |
| E044 kế toán | Ghi bán/nghĩa vụ/phân bổ, lập chi, tập hợp giá thành | Không tự thực chi/duyệt chi; quyền lương chỉ phần nhiệm vụ. |
| E045 kiểm tra tài chính | Kiểm tra giá trị/chi/lương/chi phí | Không lấy quyền kiểm tra thành quyền tự duyệt khoản của mình. |
| E046 người thu/chi | Xác nhận tiền thực theo nguồn, đủ số dư | Không tự duyệt chi; chỉ xem khoản lương cần trả, không mở mọi hồ sơ HR. |
| E047 HR và lập lương | Hồ sơ, công, phép; lương trong phạm vi lập bảng | Không tự duyệt/thực chi lương, không thay nguồn công không dấu vết. |
| E048 quản trị truy cập kiêm hành chính | Áp dụng quyền được giám đốc duyệt | Không tự cấp quyền cho mình; không mặc định đọc lương/giá vốn hoặc sửa chứng từ. |
| Người không có tài khoản | Nhận phiếu cá nhân, đề nghị đối chiếu qua đầu mối | Không phát bảng lương toàn tổ; vẫn giữ người yêu cầu/người nhập. |

Số vai trò có tài khoản phải tính từ CSV; thay người không thay tổng 50. Quyền kiểm tra/duyệt phải xét người thật đứng sau tài khoản, không dùng tài khoản thứ hai để tự duyệt. Ủy quyền ghi loại việc, nguồn, thời hạn, giới hạn và quyền xem tối thiểu; quá hạn không duyệt mới, giữ kết quả cũ. Không có người đủ quyền thì chờ, không tự bật quyền. Kiểm chứng sau này phải áp dụng cả thao tác trực tiếp, xuất báo cáo và truy cập qua chứng từ liên quan.

## Tiền công nợ giá thành và đối chiếu

Tồn tiền mở đầu: ngân hàng demo 500 triệu, quỹ tiền mặt 0; phải thu/phải trả/ứng đầu 0. Tồn vật tư/thành phẩm đầu không thành chi phí bán ngay. Ngân hàng và mọi chứng từ là giả lập, không kết nối chuyển tiền ngoài.

Cọc ghi tiền thực nhận và ứng trước, chưa là doanh thu. Xuất kho chuyển sang đang giao, chưa là giá vốn bán. Khách chấp nhận đúng lượng và kế toán xác nhận bán mới ghi doanh thu/giá vốn trong mô hình cơ sở. Phân bổ cọc/thu giảm đúng nghĩa vụ; không tạo doanh thu hoặc lần nhập/xuất thứ hai. Bên trả thay có căn cứ; khoản chưa rõ hoặc thừa để chưa phân bổ, không bù chéo khách.

Hạn trả khách 15 ngày lịch sau ngày chấp nhận; ngày đến hạn chưa quá hạn, ngày sau mới quá hạn. PO-N nghĩa vụ 2,4 triệu đối chiếu 05/09, hạn 20/09, đã trả 1 triệu ngày 19/09 còn 1,4 triệu. PO-T 0,3 triệu đối chiếu 16/09, hạn 01/10, trả đủ 25/09. Chi phí chung xưởng 6 triệu đã đối chiếu chưa thực trả là nghĩa vụ riêng, không gộp vào nợ nhà cung cấp xi măng. Thu/chi xác nhận đủ nguồn và số dư; duyệt chưa làm tăng/giảm tiền.

Định giá bình quân sau nhập theo biến thể, nguồn giá trị và số lượng; thứ tự lấy lô vật lý FIFO chỉ trong phần đủ điều kiện. Tồn ngói cũ cùng giá 6.000; mỗi lô mới chi phí 5,88 triệu/980 đạt cũng 6.000 nên bình quân không đổi. Terrazzo 4.354.167/485 giữ tỷ lệ chưa làm tròn; xuất 400 có giá trị 3.591.066, còn 85 trị giá 763.101. Tổng hai giá trị bằng nguồn, không lấy đơn giá hiển thị 8.978 nhân từng phần.

Vật tư ngói 30,04 triệu + nhân công 12 + chung 5 = 47,04 triệu; Terrazzo 1.854.167 + 1.500.000 + 1.000.000 = 4.354.167 đồng. OH-N-SEP và OH-T-SEP là hai nguồn chi phí xưởng giả lập riêng đã đối chiếu, phân bổ lần lượt theo 60 và 10 giờ máy thực trong từng luồng, không lấy 240/30 giờ người làm giờ máy. Mỗi nguồn có người kiểm tra/duyệt và số chưa phân bổ; không cộng cả nguồn chung 6 triệu thêm một lần ngoài hai phần đã phân bổ.

Kho nhận trả không tự giảm doanh thu/hoàn tiền; khách chấp nhận phương án, giám đốc duyệt, tài chính điều chỉnh đúng bán gốc, thực hoàn mới giảm tiền. Hàng trả chờ kiểm tra không tự có giá trị hàng đạt; trường hợp chưa đủ căn cứ giữ giá trị theo dõi chờ xử lý. Lãi gộp là doanh thu thuần trừ giá vốn, không phải lãi ròng hay tiền trong ngân hàng.

## Phiên bản chứng từ và điểm dừng

Mỗi chứng từ có mã duy nhất, loại, phiên bản, nguồn, người giữ việc, người lập/kiểm tra/duyệt/xác nhận theo loại, thời điểm thực tế và ghi nhận, lý do, lượng/tiền và trạng thái. Nhật ký không ghi lộ lương cá nhân hoặc bí mật. Chứng cứ mô phỏng có nhãn giả lập; không tạo chữ ký khách thật hoặc nhận định đã thu tiền thật.

Nháp/chờ duyệt/đã duyệt chưa tự thành thực hiện. Bước được phép ghi nhận chỉ khi kiểm tra lại lượng/quyền/nguồn tại thời điểm đó. Xác nhận lại cùng nguồn trả kết quả cũ, không ghi lần hai. Hai người cùng giữ/xuất/phân bổ phải kiểm tra phần còn lại; không cùng dùng số cũ. Giao dịch trước tồn đầu hoặc trước biến động gần nhất của hàng/lô liên quan không được ghi mới tùy tiện; sửa sai bằng điều chỉnh hiện tại tham chiếu nguồn cũ. Kỳ đã chốt phải có quyền/phiên bản xử lý riêng.

Đổi giá, lượng, màu, quy cách, ngày cam kết, điều kiện tiền hoặc chi phí đã duyệt cần đánh giá phần đã thực hiện, bản mới được giám đốc duyệt và khách xác nhận khi cần; phần bị ảnh hưởng chờ, phần độc lập có thể tiếp tục. Đổi mẫu hàng riêng quay lại khách duyệt mẫu. Ghi chú không đổi cam kết không mở lại duyệt toàn đơn. Không xóa tiền đã thu hoặc hàng đã xuất để giả như hủy chưa từng làm.

Lệnh đóng khi hết lượng đang làm/chờ/lỗi cần xử lý, nhập đạt xong, cấp/hoàn/thực dùng đối chiếu và chi phí đủ chốt. Đơn có trạng thái giao và tiền riêng: giao đủ chưa là thu đủ, trả đủ chưa là đã giao. Kỳ công chốt chưa là lương duyệt, lương duyệt chưa là thực trả. Ngoại lệ giữ người xử lý, nguồn bị ảnh hưởng, số còn thiếu và quyết định cần có.

## Các điểm cần anh duyệt sau khi xem bộ mẫu

Anh có thể điều chỉnh theo mục: lịch 26 ngày giả lập và ca; danh mục/giá/điều kiện cọc; định mức/năng lực/lịch chờ; QC-DEMO-V1 và dung sai Terrazzo; lương/phụ cấp/phép mẫu và nguồn chi phí; cách làm tròn/định giá và tình huống ngoại lệ. Em đề xuất dùng các giá trị này làm chuẩn demo V1 vì đã nối được nguồn và kết quả. Việc duyệt không biến chúng thành chính sách thật Nasaki.

Đủ cơ sở để chuyển các tình huống chính và ngoại lệ thành yêu cầu chức năng sau khi chốt bộ đề xuất. Thiết kế kỹ thuật còn cần điều kiện dùng thử, số người đồng thời, môi trường triển khai, sao lưu và mốc trình diễn; Codex sẽ đề xuất khi đến bước đó. Chưa lập trình trong vòng chuẩn bị này.
