# Kế hoạch xây dựng Mini-ERP cho demo Nasaki

Ngày: 09/10/2026, Asia/Bangkok. **Trạng thái: đề xuất B31, chưa bắt đầu lập trình.** Anh giao lập kế hoạch xây dần tính năng; thứ tự, công nghệ và mốc dưới đây là phương án của Codex, chưa phải lịch triển khai đã duyệt.

## Mục tiêu và điểm xuất phát

Xây một ứng dụng chạy trên trình duyệt, xử lý và lưu giao dịch thật trong môi trường demo. Dữ liệu nghiệp vụ giả lập phải có nguồn và thao tác xác nhận rõ; không coi là dữ liệu nội bộ Nasaki. Giữ mô hình một công ty, một xưởng, một kho, 50 nhân sự và cả ngói/Terrazzo. Phiên bản đầu hoàn chỉnh có đủ kinh doanh, mua hàng, kho, sản xuất, chất lượng, tài chính quản trị và nhân sự.

Đã có thiết kế 74 bảng/931 trường/402 quan hệ, 33 yêu cầu chức năng, 22 loại màn hình và 56 tiêu chí nghiệm thu. Google Sheets đã có cấu trúc trống. Chưa có cơ sở dữ liệu chạy, máy chủ ứng dụng hoặc kiểm thử ERP. Bản HTML chỉ là mẫu bố cục. Vì vậy đợt đầu phải xây nền chạy thật trước khi làm các quy trình.

Không biến 74 bảng thành 74 màn hình nhập liệu. Người dùng làm công việc qua các biểu mẫu đã thiết kế; một lần xác nhận có thể ghi nhiều bảng liên quan. Chỉ lấy lại dữ kiện từ nguồn, không tự duyệt, tự kết luận chất lượng hoặc tự ghi công thực tế.

[Phân tích chi tiết D01 — nền hệ thống](foundation-plan.md) cụ thể hóa cấu trúc, bảy bước triển khai, yêu cầu kỹ thuật, sản phẩm và 14 điều kiện nghiệm thu nền. Đây là đề xuất B32, chưa lập trình.

## Phương án kỹ thuật đề xuất

- Một kho Git, một ứng dụng thống nhất, một cơ sở dữ liệu quan hệ PostgreSQL. Đề xuất Python/Django, giao diện theo mẫu máy chủ và JavaScript ở những thao tác cần thiết; tránh phải vận hành riêng hai ứng dụng giao diện và API ở giai đoạn này. Tách mã theo nghiệp vụ, dùng chung thành phần quyền, chứng từ, lịch sử và tệp đính kèm. Ưu tiên quy ước framework, không dựng thêm nhiều tầng thư mục.
- PostgreSQL là nơi ghi giao dịch chính. Bộ Sheets tiếp tục là tài liệu cấu trúc/tham chiếu, chưa đề xuất đồng bộ hai chiều hoặc dùng làm sổ giao dịch của ERP. Các bảng/trường nghiệp vụ theo tên tiếng Việt của B29; nhãn người dùng có dấu. Thành phần kỹ thuật framework phải được đối chiếu riêng, không âm thầm thay thiết kế hoặc thêm bảng nghiệp vụ.
- Chuyển thiết kế logic thành cấu trúc vật lý có phiên bản; kiểm FK theo bộ dữ liệu, đúng loại nguồn, ràng buộc phiên bản, số chính xác và bảy cấu trúc đóng. Triển khai cấu trúc theo thứ tự phụ thuộc của từng đợt, đối chiếu đủ 74 bảng ở mốc hoàn thiện. Không sinh tất cả màn hình CRUD rồi coi là ERP hoàn thành.
- Ưu tiên máy tính cho danh sách nhiều cột; điện thoại phục vụ ghi nhận và xem công việc theo quyền như thiết kế hiện hành. Tái sử dụng bố cục 22 màn hình, bổ sung lưu/đọc và kiểm lỗi thật thay cho dữ liệu cố định của prototype.
- Tệp chứng cứ lưu riêng, liên kết với nguồn và kiểm quyền khi đọc/tải. Quyền định danh ổn định tách khỏi bộ demo; đăng nhập framework không thay các kiểm soát quyền theo nghiệp vụ, người hưởng lợi, dòng lương hoặc bộ dữ liệu.
- Chạy và kiểm tra trong môi trường phát triển trước. Mốc cuối có phương án demo truy cập riêng, sao lưu cả DB/tệp và khôi phục. Địa chỉ, dịch vụ và chi phí hosting sẽ được xác định khi có bản chạy; kế hoạch này chưa đặt mua dịch vụ hoặc đưa lên vận hành chính thức.

## Tám đợt xây dựng

Các đợt là phần tăng dần của **cùng phiên bản đầu**, không phải tám hệ thống riêng. Bảng nêu đầu ra chính; [ma trận triển khai](design/development-roadmap.csv) chỉ rõ yêu cầu bắt đầu/hoàn thiện ở đợt nào và tiêu chí gốc. Một yêu cầu xuyên phân hệ có thể được xây qua nhiều đợt.

| Đợt | Công việc và phạm vi | Anh xem được gì để đánh giá? | Điều kiện chuyển đợt |
| --- | --- | --- | --- |
| D01 — Nền chạy thật | Tạo ứng dụng/DB, đăng nhập/quyền, danh mục, hồ sơ người có hiệu lực và lịch nguồn lực cơ bản, nguồn/chứng từ/phiên bản/nhật ký; khởi tạo bộ demo mới có nguồn. Chuẩn bị tồn mở đầu đã kiểm và giá trị/tiền mở đầu có căn cứ. | Đăng nhập đúng vai trò, khai báo sản phẩm/đối tác, lưu và mở lại; người không có quyền bị chặn. Anh không cần tự chạy lệnh. | Tạo DB từ đầu được; dữ liệu còn sau khởi động lại; không nạp trực tiếp bộ kiểm cũ; bộ demo không làm thay đổi định danh/quyền toàn hệ thống. |
| D02 — Bán hàng sẵn, giao và thu | Tiếp nhận/tư vấn, báo giá/duyệt/chốt, giữ hàng, soạn/xuất/giao từng đợt, khách chấp nhận, ghi bán/giá vốn hàng mở đầu, thu cọc/thu tiền/phân bổ, nợ và quỹ theo nguồn. Ghi nhận yêu cầu riêng nhưng giữ chờ điều kiện sản xuất. | Một đơn ngói và một đơn Terrazzo từ đặt đến nhận hàng/thu tiền; thấy tồn giảm, còn giao và còn nợ khi mở lại. | Không giữ/xuất vượt lượng; không xuất lần hai khi ghi bán; cọc không tự là doanh thu. Chưa có kiểm năng lực sản xuất thì chưa cho cam kết phần cần làm mới. |
| D03 — Mua và nhận vật tư | Thiếu hụt/đề nghị mua/duyệt đặt, nhận từng đợt, kiểm chất lượng vật tư, nhập đạt/chờ/lỗi, trả nhà cung cấp, đối chiếu nghĩa vụ và chi tiền; nguồn cấp/thực dùng/hoàn vật tư. | Mua bổ sung theo nhu cầu; nhận 2 đợt, chỉ phần đạt được dùng; đối chiếu tiền mua và nghĩa vụ. | Hàng đang về không là tồn dùng được; PO không tự tạo nợ; lượng QC/cấp/hoàn có nguồn, không ghi đôi lượng hoặc tiền. |
| D04 — Sản xuất và chất lượng | Định mức có phiên bản; lập lịch theo vật tư/người/máy; lệnh theo đơn/làm sẵn; công đoạn/thực dùng/giờ người và máy; mẫu khách duyệt; sản lượng, QC từng phần, nhập thành phẩm, khóa/truy lô, làm lại/tiêu hủy đúng quyền. | Đơn thiếu hàng nối qua mua–làm–QC–nhập–giao; mẫu màu riêng chưa duyệt không chạy hàng loạt. Theo dõi cả hai nhóm sản phẩm. | Kế hoạch không tự thành công thực/sản lượng; hàng chưa đạt không giao; số lượng vào/ra/lỗi đối chiếu; chi phí chưa đủ nguồn hiển thị tạm tính. |
| D05 — Nhân sự, công và lương | Hoàn thiện hồ sơ 50 người, lịch/ca/công thực, phép/phản hồi, chính sách hiệu lực, lương/ứng/duyệt/chi từng phần, phiếu cá nhân và thu hồi quyền. Nối nguồn công với sản xuất và nguồn chi với quỹ. | Ghi/nhập công theo nhóm có nguồn, xử lý thiếu công, tính lương, ứng và trả; người kiêm nhiệm không nhập lại cùng dữ kiện. | Không sinh đủ công từ lịch; không cộng chi phí lần hai khi trả lương; dòng CEO phải có kiểm độc lập hợp lệ, thiếu người có quyền thì giữ chờ. |
| D06 — Giá thành và báo cáo | Đối chiếu vật tư thực dùng/chi phí mua, giờ người đã xác nhận, giờ máy/chi phí chung có căn cứ; tính và chốt giá thành/giá vốn/lãi gộp; hoàn thiện báo cáo theo mốc và khóa kỳ cơ sở. | Từ lợi nhuận đơn mở xuống nguồn vật tư, công và chi phí; xem tồn, tiền, nợ, sản lượng và công/lương cùng mốc. | Thiếu nguồn không báo đã chốt; giá vốn hàng sản xuất được đối chiếu và điều chỉnh có lịch sử; số báo cáo khớp sổ nguồn. |
| D07 — Các tình huống liên hoàn | Hoàn thiện đổi/hủy sau chuẩn bị/sản xuất, chi phí và hàng còn; trả/giảm/hoàn tiền/giao bù; thu hồi lô đã giao; kiểm kê/xuất khác; điều chỉnh công/lương/chi phí sau khóa kỳ theo bản liên kết. | Thử khách hủy, hàng lỗi/trả, thiếu kiểm kê và sửa công kỳ đã chốt; xem ai quyết, ai làm, tiền/hàng thay đổi thế nào. | Không xóa nguồn đã thực hiện; không hoàn vượt nghĩa vụ/tiền được phép; không tự giải phóng lô; quyền/duyệt hiện hành áp dụng cho cả điều chỉnh. |
| D08 — Nghiệm thu và trình diễn | Chạy đủ 56 tiêu chí trên ứng dụng/DB; kiểm xuyên cả bảy phân hệ, hai nhóm hàng, ghi đồng thời/mất mạng, quyền nhạy cảm; khôi phục/reset đúng bộ demo và thử sao lưu/khôi phục; hướng dẫn thao tác/trình diễn và báo lỗi còn lại. | Bản demo có cách mở và dùng rõ ràng, các tình huống lặp lại được từ nguồn; danh sách đã đạt/chưa đạt có bằng chứng. | Đủ yêu cầu/tiêu chí, không còn lỗi chặn nghiệp vụ hoặc sai lượng/tiền/quyền. Ghi môi trường và giới hạn đo hiệu năng thực tế; kết quả cũ hoặc mock không thay nghiệm thu. |

## Phụ thuộc cần giữ đúng

Chuỗi chính D01 → D02 → D03 → D04 → D05 → D06 → D07 → D08. Có thể sửa/hoàn thiện màn hình trước trong đợt sau, nhưng không bỏ qua điều kiện nguồn của bước sử dụng.

- Nhân sự không hoàn toàn đứng sau sản xuất: D01 có hồ sơ hiệu lực/lịch nguồn lực; D04 phải ghi công thực và kiểm vắng/đủ điều kiện trước khi xếp người. D05 bổ sung toàn bộ phép/chốt công/lương. Không lấy lịch dự kiến làm giờ công hoặc giá thành.
- Chất lượng có từ tồn mở đầu D01 và nhận vật tư D03; D04 mở rộng kiểm thành phẩm/mẫu/lô. Bảo vệ hàng chờ/lỗi có ngay từ lần đầu cho giữ/xuất/cấp.
- Tài chính có từ D02 để ghi cọc/thu và tiền/nợ; D03 nối nghĩa vụ mua/chi, D05 nối lương. D06 mới hoàn thiện giá thành sản xuất khi đủ nguồn, không chờ cuối mới ghi tiền và không hứa lãi gộp đã chốt trước nguồn nhân công.
- Báo cáo của từng luồng xuất hiện cùng đợt xây luồng đó. D06 nối đầy đủ, D07 bổ sung ảnh hưởng điều chỉnh/hoàn; D08 xác minh toàn hệ thống.
- Ngoại lệ làm sai lượng, tiền hoặc quyền phải được chặn ngay trong D01–D06. D07 dành cho xử lý trọn chuỗi tình huống phức tạp, không phải thời điểm bắt đầu chống âm kho hoặc tự duyệt.

## Cách xây và kiểm từng đợt

1. Đối chiếu FR/SC/tiêu chí và dữ liệu nguồn; ghi điều kiện trước/sau, trạng thái, quyền, tác động lượng/tiền và ngoại lệ trước khi viết tính năng. Không tự đổi chính sách demo quan trọng; đề xuất thay đổi ghi riêng.
2. Làm lát cắt chạy được gồm cấu trúc DB → xử lý nghiệp vụ → biểu mẫu → đọc lại/đối chiếu. Tự chuyển dữ kiện sang phiếu sau nhưng người phụ trách xác nhận thực tế của bước mình.
3. Từ giao dịch đầu tiên: ghi các bảng liên quan trong một giao dịch nguyên tử, chống gửi lặp, kiểm phiên bản/quyền tại lúc ghi, khóa lượng khi cần. Kiểm trực tiếp endpoint/DB, không chỉ ẩn nút. Mỗi loại giao dịch mới có ca thành công, bị từ chối và gửi lặp/đồng thời phù hợp.
4. Kiểm người kiêm nhiệm, người đặt/trả/nhận khác nhau, chia nhiều đợt, quyền dữ liệu nhạy cảm và nguồn đã dùng không bị sửa đè. Kiểm thử trên DB thật cho ràng buộc/lượng/tiền; kiểm trình duyệt cho các bước người dùng, trạng thái lỗi và dữ liệu giữ lại khi mất kết nối.
5. Bàn giao bản chạy được, hướng dẫn ngắn, kết quả kiểm, lỗi/giới hạn và thay đổi phạm vi nếu có. Ghi README/lịch sử build, commit có thể truy vết; chạy kiểm tự động thích hợp từ đầu. Không báo xong chỉ vì có màn hình hoặc commit.

Ở mỗi lần trình diễn, anh đánh giá “công việc có đúng, dễ dùng, dữ liệu có giải thích được không?”. Codex phụ trách triển khai, kiểm kỹ thuật và sửa lỗi; không chuyển việc lựa chọn thư viện/chạy lệnh cho anh. Ghi số bước, số lần nhập lại và tình huống thao tác khó để sửa ngay, không đặt sẵn chỉ tiêu thời gian thao tác khi chưa đo.

## Dữ liệu, phạm vi và dự báo tiến độ

Bộ khởi tạo mới phải tách danh mục giả lập, tham số/căn cứ, nguồn mở đầu và các hành động kịch bản. [Chính sách nguồn](demo-data/source-policy.json) đang chặn nạp trực tiếp cả năm tệp cũ; số expected và công sinh từ lịch chỉ dùng tham chiếu kiểm. OTHER-001 chưa đủ hồ sơ không được tự đưa vào tồn nguồn. Nếu cần tình huống tương đương, lập kịch bản giả lập mới minh bạch và thực hiện các bước có quyền; không cài sẵn “đã duyệt/đạt/đủ công” để khớp số cuối. Các biến động kiểm thử cũng phải được cô lập khỏi bộ trình diễn.

Giữ đúng mức demo doanh nghiệp nhỏ: quản trị tiền/nợ/giá thành, hồ sơ/công/phép/lương cơ bản; chưa đào sâu kế toán pháp định, quyết toán thuế, hệ thống nhân sự lớn, nghiệp vụ pháp lý xuất khẩu hoặc tích hợp ngân hàng/hóa đơn/Zalo/máy chấm công. Đây là giới hạn hiện hành, không loại tài chính hoặc nhân sự khỏi V1. Không tạo thêm người duyệt hoặc thêm bước giám đốc cho giao dịch thông thường trái B24.

**Dự báo thời gian:** chưa đủ bằng chứng để cam kết ngày hoàn thành cả ERP. Sau D01, dùng thời gian thực xây/kiểm một luồng, các điểm vướng cấu trúc vật lý và môi trường để đưa dự báo D02–D08; cập nhật sau từng đợt. Mỗi đợt có điều kiện hoàn thành ở bảng trên, không chuyển chỉ vì đến ngày. Số 50 người không là cơ sở đo tải; khi chuẩn bị môi trường demo sẽ chốt và đo số phiên đồng thời/kích thước dữ liệu thực tế, ghi rõ kết quả.

**Đề xuất bước tiếp theo:** triển khai D01 và chọn tình huống D02 làm mục tiêu trình diễn đầu tiên. D01 bàn giao nền đăng nhập, danh mục và lưu dữ liệu có quyền; D02 mới có vòng bán–giao–thu hoàn chỉnh. Yêu cầu hiện tại chỉ lập kế hoạch, nên lần này chưa tạo mã ứng dụng, DB hoặc triển khai hosting.

## Căn cứ và truy vết

- [Yêu cầu chức năng](functional-requirements.md), [màn hình](screen-design.md), [ma trận nghiệm thu](design/traceability.csv) và [tiêu chí](demo-acceptance.md).
- [Dữ liệu hiện hành B29](database-design.md), [loại nguồn](database/source-contracts.csv), [đối chiếu luồng](database/workflow-coverage.md), [trách nhiệm nhập](database/input-responsibility.md).
- [Trách nhiệm/phê duyệt B24](responsibilities-approvals-handoffs.md), [kho](warehouse-workflows.md), [giao/tài chính](delivery-finance-workflows.md), [nhân sự](hr-workflows.md).
- [Ma trận kế hoạch theo 33 yêu cầu](design/development-roadmap.csv): mã đợt là thời điểm dự kiến bắt đầu/hoàn thiện phạm vi, **không là trạng thái tính năng đã xây hoặc đã nghiệm thu**. Tiêu chí gốc giữ nguyên; mỗi đợt chọn phần liên quan để kiểm, D08 kiểm toàn bộ.
