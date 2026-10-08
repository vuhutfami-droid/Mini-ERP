# Từ điển dữ liệu ERP demo Nasaki V1

Đặc tả logic theo B27, không phải SQL hoặc cơ sở dữ liệu đã tạo. Đọc [thiết kế tổng thể](../database-design.md). Có **91 bảng logic** trong 11 nhóm tên; nhóm quyền/danh mục là hạ tầng dùng chung, không thêm phân hệ kinh doanh. Số bảng gồm các dòng chi tiết và lịch sử cần bảo toàn; không tương ứng số màn hình.

## Cách đọc và trường dùng chung

- Mỗi bảng có `id:uuid` khóa chính và `workspace_id:uuid` khóa ngoại tới `core.demo_workspace`, trừ workspace tự định danh và năm bảng IAM toàn hệ thống (`access.person/account/role/permission/session`). Các bảng IAM này không có workspace_id; role_assignment gắn phạm vi bộ, FK đến account/role toàn hệ thống dùng id, FK nghiệp vụ còn lại dùng composite cùng bộ. Các khóa ngoại nghiệp vụ dùng cặp `(workspace_id,id)` để không liên kết nhầm nhánh. `core.company` chỉ một công ty trong bộ; không xây đa công ty.
- Bảng có `document_id` là phần mở rộng chứng từ: `document_id` cũng UNIQUE, nhận metadata phiên bản/người/duyệt từ core.document. Bảng có FK `id → core.document_line` dùng chính id dòng làm PK. Dòng ngoài chứng từ dùng UUID riêng.
- Bảng danh mục/nháp có `created_at`, `updated_at`, `row_version`; lịch sử append-only có `recorded_at`, `actor_account_id` được lưu qua nguồn/audit tương ứng. Các trường không lặp số lượng/tiền nghiệp vụ. Bản đã posted/đã dùng không sửa/xóa; bảng nháp giữ log sửa.
- `money` = số nguyên đồng có độ rộng tương đương decimal(20,0); `quantity` = decimal(18,3), kiểm viên nguyên; `decimal` tính giá/tỷ lệ tương đương decimal(28,12); `ratio` trong [0,1]. Chứng từ giữ quy tắc HALF_UP, không dùng float. `time` là thời điểm có múi giờ; `date` là ngày nghiệp vụ địa phương. `?` là có thể thiếu; FK nullable theo quy tắc mô tả (nháp/nguồn chưa có), phải đủ ở bước thực hiện quy định.
- Mục **Khóa ngoại** xác định đích thật, không dùng chuỗi `type + id` thay quan hệ. FK bảo vệ tồn tại/cùng bộ; điều kiện đúng loại/đúng bản/đúng người cần kiểm trong transaction. Không CASCADE DELETE giao dịch đã dùng.
- JSON chỉ cho tham số có cấu trúc đóng, ảnh chụp thỏa thuận/công thức, khoảng ca hoặc log đã lọc. Tất cả tiền, lượng, nguồn đối chiếu và quan hệ cần tổng hợp nằm ở cột/bảng có kiểu; không nhét đơn hàng, lương hoặc sổ kho vào JSON.
- FK tự trỏ gốc của document dùng cùng id bản đầu; các FK vòng (mẫu/lệnh, batch/lot) cho phép nháp rồi hoàn thiện liên kết trước xác nhận. Kiểm đủ phần mở rộng đúng type/kind khi đưa chứng từ vào sử dụng; registry không tự trở thành một giao dịch.

### D001 core.company

- **Phụ trách:** Dùng chung. **Mục đích:** Một đơn vị doanh nghiệp.
- **Trường nghiệp vụ:** `code:text`; `name:text`; `timezone:text`; `currency:enum(VND)`; `mode:enum(demo)`.
- **Khóa ngoại:** Không có FK riêng ngoài workspace..
- **Ràng buộc:** Một công ty trong mỗi bộ demo; không suy ra đa pháp nhân.
- **Yêu cầu:** FR01, FR33.

### D002 core.department

- **Phụ trách:** Nhân sự. **Mục đích:** Nhóm công việc của 50 người.
- **Trường nghiệp vụ:** `code:text`; `name:text`; `active:boolean`.
- **Khóa ngoại:** `company_id` → `core.company`.
- **Ràng buộc:** Mã duy nhất trong công ty; nhóm hành chính không đồng nghĩa bốn HR chuyên trách.
- **Yêu cầu:** FR01, FR28.

### D003 core.location

- **Phụ trách:** Kho / sản xuất / giao hàng. **Mục đích:** Nơi chịu trách nhiệm giữ hàng.
- **Trường nghiệp vụ:** `code:text`; `kind:enum(warehouse_zone,workshop,transit,external)`; `physical_warehouse_code:text?`; `active:boolean`.
- **Khóa ngoại:** `company_id` → `core.company`.
- **Ràng buộc:** VT/TP/CC/HL cùng KHO-01. Xưởng/đang giao không cộng vào tồn kho; không dùng vị trí làm kết luận QC.
- **Yêu cầu:** FR01, FR15, FR16, FR21.

### D004 core.unit

- **Phụ trách:** Dùng chung. **Mục đích:** Đơn vị và độ chính xác.
- **Trường nghiệp vụ:** `code:text`; `dimension:enum(piece,mass,volume,time)`; `decimal_places:smallint`.
- **Khóa ngoại:** Không có FK riêng ngoài workspace..
- **Ràng buộc:** Viên=0 số lẻ; kg/lít=3; phút công số nguyên. Đơn vị đóng gói quy đổi theo mặt hàng.
- **Yêu cầu:** FR01, FR16, FR29.

### D005 core.document

- **Phụ trách:** Bộ phận giữ chứng từ. **Mục đích:** Định danh một phiên bản chứng từ.
- **Trường nghiệp vụ:** `code:text`; `type:enum đóng`; `revision:integer`; `approval_state:enum(draft,submitted,rejected,approved,withdrawn,superseded)`; `effective_at:time`; `recorded_at:time`; `row_version:integer`; `reason:text?`.
- **Khóa ngoại:** `root_id` → `core.document`; `owner_employee_id` → `hr.employee`; `created_by_account_id` → `access.account`.
- **Ràng buộc:** Bản đầu root_id=self; unique(workspace,root,revision). Mã duy nhất theo gốc/loại. Bản đã dùng bất biến; root/type không đổi. Trạng thái thực hiện ở bảng nghiệp vụ, không suy từ đã duyệt.
- **Yêu cầu:** FR01, FR03, FR04, FR05, FR06, FR08, FR10, FR33.

### D006 core.document_line

- **Phụ trách:** Bộ phận giữ chứng từ. **Mục đích:** Mã dòng chung để liên kết và duyệt đúng phần.
- **Trường nghiệp vụ:** `line_no:integer`; `kind:enum đóng`.
- **Khóa ngoại:** `document_id` → `core.document`.
- **Ràng buộc:** Unique(document,line_no). Mỗi dòng có đúng một phần mở rộng nghiệp vụ phù hợp kind; không lưu tiền/lượng lần hai ở đây.
- **Yêu cầu:** FR03, FR04, FR05, FR06, FR08, FR27.

### D007 core.document_link

- **Phụ trách:** Bộ phận giữ chứng từ. **Mục đích:** Nguồn, thay đổi, đảo hoặc thay thế.
- **Trường nghiệp vụ:** `relation:enum(origin,amends,reverses,replaces,depends_on)`.
- **Khóa ngoại:** `from_document_id` → `core.document`; `to_document_id` → `core.document`.
- **Ràng buộc:** Không tự liên kết; unique hai nguồn+loại; kiểm chu trình cho quan hệ thay thế/phụ thuộc. Liên kết không thay FK lượng ở bảng nghiệp vụ.
- **Yêu cầu:** FR04, FR06, FR10, FR19, FR27.

### D008 core.approval

- **Phụ trách:** Theo bảng thẩm quyền B24. **Mục đích:** Đề nghị, kiểm và quyết định đúng phiên bản.
- **Trường nghiệp vụ:** `action:enum đóng`; `state:enum(requested,checked,approved,rejected,revoked)`; `requested_at:time`; `decided_at:time?`; `quantity_limit:quantity?`; `amount_limit:money?`; `reason:text`; `subject_identity_key:uuid?`.
- **Khóa ngoại:** `document_id` → `core.document`; `line_id` → `core.document_line`; `requester_employee_id` → `hr.employee`; `checker_employee_id` → `hr.employee`; `decider_employee_id` → `hr.employee`; `delegation_id` → `access.delegation`.
- **Ràng buộc:** line_id nullable để duyệt cả nguồn; các người kiểm/duyệt nullable khi còn chờ. Dòng phải thuộc đúng document. So người thật, không chỉ account. Duyệt tự hưởng hoặc ngoài ủy quyền bị ngăn.
- **Yêu cầu:** FR03, FR06, FR08, FR10, FR18, FR24, FR30, FR31.

### D009 core.handoff

- **Phụ trách:** Người giao và người nhận. **Mục đích:** Bàn giao từng phần, việc chờ và phản hồi.
- **Trường nghiệp vụ:** `state:enum(sent,accepted,needs_info,cancelled)`; `requested_qty:quantity?`; `accepted_qty:quantity?`; `due_at:time`; `received_at:time?`; `missing_reason:text?`.
- **Khóa ngoại:** `document_id` → `core.document`; `line_id` → `core.document_line`; `sender_employee_id` → `hr.employee`; `receiver_employee_id` → `hr.employee`; `unit_id` → `core.unit`.
- **Ràng buộc:** Lượng nhận không vượt gửi; line nullable cho việc không có dòng. Không tự tiếp nhận khi quá hạn. Hàng/tiền thực theo sổ riêng.
- **Yêu cầu:** FR04, FR10, FR32.

### D010 core.attachment

- **Phụ trách:** Bộ phận của nguồn. **Mục đích:** Chỉ mục chứng cứ trong kho tệp.
- **Trường nghiệp vụ:** `storage_key:text`; `checksum:text`; `mime_type:text`; `byte_count:integer`; `sensitivity:enum(public_demo,internal,payroll)`; `simulated:boolean`.
- **Khóa ngoại:** `document_id` → `core.document`; `line_id` → `core.document_line`.
- **Ràng buộc:** Tệp ngoài DB/Git; đường dẫn không công khai; kiểm quyền theo nguồn. Không chứa chữ ký giả như thật.
- **Yêu cầu:** FR08, FR09, FR17, FR21, FR28, FR31.

### D011 core.audit_event

- **Phụ trách:** Hệ thống, giới hạn theo nguồn. **Mục đích:** Dấu vết thao tác và thay đổi.
- **Trường nghiệp vụ:** `action:text`; `recorded_at:time`; `correlation_key:uuid`; `redacted_change:json?`; `reason:text?`.
- **Khóa ngoại:** `document_id` → `core.document`; `actor_account_id` → `access.account`; `entered_for_employee_id` → `hr.employee`.
- **Ràng buộc:** Chỉ thêm; người nhập và người được nhập thay riêng; log chung không chứa lương/mật khẩu. Không thay sổ lượng/tiền.
- **Yêu cầu:** FR02, FR03, FR05, FR06, FR28, FR33.

### D012 core.period

- **Phụ trách:** Nhân sự / tài chính / kho theo loại kỳ. **Mục đích:** Chốt và mở lại kỳ.
- **Trường nghiệp vụ:** `domain:enum(attendance,payroll,stock,finance)`; `starts_on:date`; `ends_on:date`; `state:enum(open,closed)`; `closed_at:time?`.
- **Khóa ngoại:** `close_document_id` → `core.document`.
- **Ràng buộc:** Chốt công không chốt lương/tiền. Mở lại cần quyết định, log; sửa quá khứ dùng bản điều chỉnh.
- **Yêu cầu:** FR06, FR30, FR31.

### D013 core.policy_version

- **Phụ trách:** Bộ phận phụ trách chính sách. **Mục đích:** Tham số có hiệu lực và căn cứ.
- **Trường nghiệp vụ:** `kind:enum(calendar,specification,pricing,qc,production,payroll,leave,valuation,stock_alert)`; `code:text`; `version:integer`; `valid_from:time`; `valid_to:time?`; `parameters:json theo cấu trúc đóng`; `simulated:boolean`.
- **Khóa ngoại:** `approval_id` → `core.approval`.
- **Ràng buộc:** Mỗi loại có danh sách trường/đơn vị được phép, không là kho JSON nghiệp vụ. Không chồng hiệu lực cùng mã; bản được dùng bất biến. Tiền/lượng/giao dịch không nằm trong parameters.
- **Yêu cầu:** FR01, FR07, FR08, FR12, FR17, FR26, FR30, FR31.

### D014 core.demo_workspace

- **Phụ trách:** Quản trị bộ demo. **Mục đích:** Cách ly cơ sở, mốc và nhánh.
- **Trường nghiệp vụ:** `code:text`; `fixture_version:text`; `mode:enum(opening,completed_snapshot,scenario_branch)`; `scenario_code:text?`; `anchor_at:time`; `state:enum(preparing,ready,archived)`; `import_checksum:text`.
- **Khóa ngoại:** `parent_workspace_id` → `core.demo_workspace`.
- **Ràng buộc:** Unique(code,fixture_version,mode). Mọi dòng nghiệp vụ gắn workspace_id; nhánh không cộng vào cơ sở. Khôi phục làm bộ mới, giữ bộ cũ lưu trữ; không xóa người dùng/secret.
- **Yêu cầu:** FR01, FR05, FR33.

### D015 access.account

- **Phụ trách:** Quản trị truy cập theo quyết định. **Mục đích:** Tài khoản của người thật.
- **Trường nghiệp vụ:** `login:text`; `credential_hash:text?`; `state:enum(active,disabled)`; `auth_version:integer`.
- **Khóa ngoại:** `person_id` → `access.person`.
- **Ràng buộc:** Nhiều account trỏ một person ổn định. Hồ sơ nhân sự theo bộ nối cùng person; không bắt 50 người có account. Credential chỉ băm, không bản rõ hoặc Git.
- **Yêu cầu:** FR02, FR03, FR28.

### D016 access.role

- **Phụ trách:** Quản trị truy cập. **Mục đích:** Nhóm quyền công việc.
- **Trường nghiệp vụ:** `code:text`; `name:text`.
- **Khóa ngoại:** Không có FK riêng ngoài workspace..
- **Ràng buộc:** Vai trò không là phòng ban/người duyệt mới.
- **Yêu cầu:** FR02.

### D017 access.permission

- **Phụ trách:** Quản trị truy cập. **Mục đích:** Quyền của từng vai trò.
- **Trường nghiệp vụ:** `resource_kind:enum đóng`; `action:enum(view,create,check,approve,confirm,adjust,export)`; `scope:enum(self,assigned,department,company)`; `sensitive_fields:enumset?`.
- **Khóa ngoại:** `role_id` → `access.role`.
- **Ràng buộc:** Unique(role,resource,action,scope); quyền xuất và xem lương tách. Mặc định từ chối.
- **Yêu cầu:** FR02, FR32.

### D018 access.role_assignment

- **Phụ trách:** Quản trị truy cập theo quyết định. **Mục đích:** Cấp vai trò có hiệu lực.
- **Trường nghiệp vụ:** `valid_from:time`; `valid_to:time?`; `revoked_at:time?`.
- **Khóa ngoại:** `account_id` → `access.account`; `role_id` → `access.role`; `approval_id` → `core.approval`.
- **Ràng buộc:** Không tự cấp cho mình; ngừng quyền khi nghỉ hiệu lực. Cấp quyền chỉ là nguồn cho kiểm tra, không được mở toàn dữ liệu.
- **Yêu cầu:** FR02, FR28.

### D019 access.delegation

- **Phụ trách:** Giám đốc / người có thẩm quyền. **Mục đích:** Ủy quyền giới hạn.
- **Trường nghiệp vụ:** `action:enum`; `resource_kind:enum`; `valid_from:time`; `valid_to:time`; `quantity_limit:quantity?`; `amount_limit:money?`; `revoked_at:time?`.
- **Khóa ngoại:** `grantor_employee_id` → `hr.employee`; `grantee_employee_id` → `hr.employee`; `document_id` → `core.document`; `approval_id` → `core.approval`.
- **Ràng buộc:** Nguồn cụ thể nullable nếu phạm vi loại; không ủy quyền tiếp; không tự hưởng; duyệt mới kiểm thời hạn, quyết định cũ giữ nguyên.
- **Yêu cầu:** FR02, FR03, FR24, FR31.

### D020 access.operation_receipt

- **Phụ trách:** Hệ thống. **Mục đích:** Chống ghi trùng và đối chiếu mất phản hồi.
- **Trường nghiệp vụ:** `idempotency_key:text`; `action:enum`; `request_hash:text`; `state:enum(committed)`; `committed_at:time`; `result_reference:json chỉ ID`.
- **Khóa ngoại:** `account_id` → `access.account`; `document_id` → `core.document`.
- **Ràng buộc:** Unique(workspace,action,idempotency_key); cùng khóa khác nội dung từ chối. Tạo trong cùng transaction với kết quả, không ghi thành công trước commit.
- **Yêu cầu:** FR05, FR33.

### D021 catalog.product

- **Phụ trách:** Kinh doanh / sản xuất. **Mục đích:** Nhóm mẫu ngói/Terrazzo.
- **Trường nghiệp vụ:** `code:text`; `name:text`; `family:enum(tile,terrazzo,accessory)`; `active:boolean`.
- **Khóa ngoại:** Không có FK riêng ngoài workspace..
- **Ràng buộc:** Không giữ tồn theo sản phẩm cha; mã khác có nguồn B07.
- **Yêu cầu:** FR01, FR07, FR08.

### D022 catalog.item

- **Phụ trách:** Kho cùng bộ phận sử dụng. **Mục đích:** Vật tư hoặc biến thể có thể giao dịch.
- **Trường nghiệp vụ:** `code:text`; `name:text`; `kind:enum(material,finished,ppe)`; `color_code:text?`; `size_code:text?`; `width_mm:decimal?`; `length_mm:decimal?`; `pieces_per_m2:decimal?`; `custom_required:boolean`; `active:boolean`.
- **Khóa ngoại:** `product_id` → `catalog.product`; `base_unit_id` → `core.unit`; `specification_version_id` → `core.policy_version`.
- **Ràng buộc:** product nullable cho vật tư/PPE. Unique(workspace,code). Bản quy cách quan trọng tạo item/spec mới và ngừng mã cũ, không sửa ngược lịch sử; density không là BOM.
- **Yêu cầu:** FR01, FR07, FR08, FR11, FR16.

### D023 catalog.item_alias

- **Phụ trách:** Kinh doanh / kho. **Mục đích:** Mã website/cũ trỏ mã chuẩn.
- **Trường nghiệp vụ:** `alias:text`; `evidence:text`; `valid_from:date`.
- **Khóa ngoại:** `product_id` → `catalog.product`; `item_id` → `catalog.item`.
- **Ràng buộc:** Chính xác một đích product hoặc item; unique alias chuẩn hóa; alias product không tự đoán màu.
- **Yêu cầu:** FR01, FR07.

### D024 catalog.unit_conversion

- **Phụ trách:** Kho / mua hàng. **Mục đích:** Quy đổi đóng gói theo hàng, có bản.
- **Trường nghiệp vụ:** `version:integer`; `factor:decimal`; `valid_from:date`; `valid_to:date?`.
- **Khóa ngoại:** `item_id` → `catalog.item`; `from_unit_id` → `core.unit`; `to_unit_id` → `core.unit`; `approval_id` → `core.approval`.
- **Ràng buộc:** Factor>0; không sửa bản đã dùng; CEM 50kg/bao chỉ cho CEM. Thiếu quy đổi bị ngăn.
- **Yêu cầu:** FR01, FR14, FR15, FR16.

### D025 core.party

- **Phụ trách:** Kinh doanh / mua hàng. **Mục đích:** Một đối tác dùng chung mua/bán/trả/nhận.
- **Trường nghiệp vụ:** `code:text`; `name:text`; `roles:enumset(customer,supplier,payer,receiver,carrier)`; `customer_groups:enumset(dealer,contractor,owner,retail,export)`; `active:boolean`.
- **Khóa ngoại:** Không có FK riêng ngoài workspace..
- **Ràng buộc:** Một đối tác nhiều vai trò, không sao chép riêng cho từng bộ phận; chưa rõ bên trả được để chờ.
- **Yêu cầu:** FR01, FR07, FR08, FR14, FR23, FR25.

### D026 core.party_contact

- **Phụ trách:** Bộ phận phụ trách đối tác. **Mục đích:** Người liên hệ và địa điểm.
- **Trường nghiệp vụ:** `name:text`; `contact_channel:text?`; `address:text?`; `active:boolean`.
- **Khóa ngoại:** `party_id` → `core.party`.
- **Ràng buộc:** Địa chỉ giao lưu ảnh chụp trên đợt/đơn để thay liên hệ không sửa lịch sử.
- **Yêu cầu:** FR07, FR08, FR21.

### D027 core.party_authority

- **Phụ trách:** Kinh doanh / tài chính. **Mục đích:** Căn cứ đại diện hoặc trả thay.
- **Trường nghiệp vụ:** `action:enum(confirm_order,approve_sample,change_order,pay_on_behalf,receive)`; `valid_from:time`; `valid_to:time?`; `evidence_document_id:uuid`.
- **Khóa ngoại:** `party_id` → `core.party`; `contact_id` → `core.party_contact`; `scope_document_id` → `core.document`; `evidence_document_id` → `core.document`; `agent_party_id` → `core.party`.
- **Ràng buộc:** Scope nullable nếu giấy đại diện chung; trả thay không quyền đổi/duyệt mẫu; kiểm đúng nguồn/thời hạn. party_id là bên được đại diện; agent_party_id là tổ chức đại diện/trả thay nếu khác, contact là người ký căn cứ.
- **Yêu cầu:** FR08, FR09, FR10, FR23.

### D028 sales.inquiry

- **Phụ trách:** Kinh doanh. **Mục đích:** Một nhu cầu, nhiều lần liên hệ.
- **Trường nghiệp vụ:** `status:enum(open,clarifying,quoted,converted,closed)`; `project_notes:text`; `export_conditions_status:enum(not_applicable,pending,defined)`.
- **Khóa ngoại:** `document_id` → `core.document`; `customer_id` → `core.party`; `contact_id` → `core.party_contact`.
- **Ràng buộc:** Nhu cầu chưa đủ không tự thành đơn; khách xuất khẩu chờ điều kiện.
- **Yêu cầu:** FR07.

### D029 sales.inquiry_event

- **Phụ trách:** Kinh doanh. **Mục đích:** Các kênh và lần tiếp nhận.
- **Trường nghiệp vụ:** `channel:enum(phone,email,website,personal,referral)`; `received_at:time`; `summary:text`; `external_reference:text?`.
- **Khóa ngoại:** `inquiry_document_id` → `sales.inquiry`; `entered_by_account_id` → `access.account`.
- **Ràng buộc:** Nhiều kênh thuộc cùng inquiry, không tạo nhiều đơn tự động.
- **Yêu cầu:** FR07.

### D030 sales.estimate_line

- **Phụ trách:** Kinh doanh / sản xuất kiểm. **Mục đích:** Tư vấn số viên từ diện tích.
- **Trường nghiệp vụ:** `area_m2:decimal?`; `pieces_per_m2:decimal?`; `reserve_ratio:ratio?`; `rounded_pieces:quantity`; `state:enum(estimated,customer_confirmed)`; `customer_evidence:text?`.
- **Khóa ngoại:** `id` → `core.document_line` (PK dòng); `inquiry_document_id` → `sales.inquiry`; `item_id` → `catalog.item`; `policy_version_id` → `core.policy_version`.
- **Ràng buộc:** Các tham số có nguồn, làm tròn lên; phụ kiện dòng riêng, không tăng BOM bởi dự phòng tư vấn.
- **Yêu cầu:** FR07.

### D031 sales.order

- **Phụ trách:** Kinh doanh. **Mục đích:** Báo giá hoặc đơn đúng phiên bản.
- **Trường nghiệp vụ:** `kind:enum(quotation,order)`; `expires_at:time?`; `confirmed_at:time?`; `deposit_required:money`; `payment_terms:text`; `delivery_terms:text`; `tax_mode:enum(not_modelled)`; `customer_evidence:text?`; `feasibility_status:enum(pending,conditional,confirmed)`.
- **Khóa ngoại:** `document_id` → `core.document`; `inquiry_document_id` → `sales.inquiry`; `buyer_id` → `core.party`; `payer_id` → `core.party`; `receiver_id` → `core.party`; `authority_id` → `core.party_authority`; `price_policy_version_id` → `core.policy_version`.
- **Ràng buộc:** payer/receiver có thể khác buyer; ảnh chụp tên/địa chỉ/thỏa thuận ở chứng từ. Đơn liên kết báo giá, không sao giá động; thuế chưa mô phỏng không là 0%.
- **Yêu cầu:** FR08, FR21, FR23.

### D032 sales.order_line

- **Phụ trách:** Kinh doanh. **Mục đích:** Cam kết từng biến thể và giá.
- **Trường nghiệp vụ:** `quantity_pieces:quantity`; `list_price:decimal`; `discount_kind:enum(none,ratio,amount)`; `discount_value:decimal`; `agreed_unit_price:decimal`; `agreed_amount:money`; `requested_delivery_on:date`; `line_purpose:enum(sale,replacement)`; `specification_snapshot:json cấu trúc đóng`.
- **Khóa ngoại:** `id` → `core.document_line` (PK dòng); `order_document_id` → `sales.order`; `item_id` → `catalog.item`; `approved_sample_document_id` → `sales.sample`; `replacement_case_document_id` → `sales.change_case`.
- **Ràng buộc:** Mỗi dòng thuộc đúng order/version; giá/giảm một lần, giữ các số thỏa thuận bất biến sau duyệt. Tổng đã giao/bán không là cột sửa tay.
- **Yêu cầu:** FR08, FR10, FR11, FR21, FR22, FR27.

### D033 sales.sample

- **Phụ trách:** Kinh doanh cùng sản xuất/QC. **Mục đích:** Mẫu riêng và khách duyệt đúng bản.
- **Trường nghiệp vụ:** `sample_quantity:quantity`; `customer_decision:enum(pending,approved,rejected)`; `decided_at:time?`; `evidence:text?`.
- **Khóa ngoại:** `document_id` → `core.document`; `order_line_id` → `sales.order_line`; `sample_work_order_id` → `production.work_order`; `inspection_document_id` → `quality.inspection`; `customer_authority_id` → `core.party_authority`.
- **Ràng buộc:** Mẫu tách lệnh/phiếu và lượng bán. Quan hệ quay vòng tạo qua nháp trong transaction, bắt buộc đủ FK khi duyệt; duyệt nội bộ không thay khách.
- **Yêu cầu:** FR09, FR10.

### D034 sales.change_case

- **Phụ trách:** Kinh doanh giữ việc. **Mục đích:** Đổi/hủy, phản ánh, trả/thu hồi và phương án thương mại.
- **Trường nghiệp vụ:** `kind:enum(change,cancel,return,claim,recall)`; `affected_qty:quantity`; `resolution:enum(pending,credit,refund,replacement,rework,cancel,reject)`; `started_qty_snapshot:quantity`; `customer_evidence:text?`; `settlement_notes:text`.
- **Khóa ngoại:** `document_id` → `core.document`; `original_order_line_id` → `sales.order_line`; `new_order_line_id` → `sales.order_line`; `original_sale_line_id` → `finance.sale_line`; `approval_id` → `core.approval`.
- **Ràng buộc:** Không mặc định mất cọc; lượng đã làm/chưa làm/đã giao ghi căn cứ theo mốc. Một phương án có phần lượng cụ thể; chưa rõ giữ chờ. Tổng hoàn/giao bù kiểm đúng phạm vi đã duyệt.
- **Yêu cầu:** FR10, FR19, FR27.

### D035 purchase.order

- **Phụ trách:** Mua hàng. **Mục đích:** Đặt mua theo nhu cầu đã duyệt.
- **Trường nghiệp vụ:** `supplier_reference:text?`; `promised_on:date`; `payment_terms:text`; `comparison_notes:text?`.
- **Khóa ngoại:** `document_id` → `core.document`; `supplier_id` → `core.party`.
- **Ràng buộc:** Không bắt ba báo giá; duyệt PO không có tồn/nợ/tiền; thay giá/lượng tạo bản mới.
- **Yêu cầu:** FR14, FR24.

### D036 purchase.order_line

- **Phụ trách:** Mua hàng. **Mục đích:** Lượng đặt, giá và đơn vị mua.
- **Trường nghiệp vụ:** `quantity_input:quantity`; `quantity_base:quantity`; `unit_price:decimal`; `agreed_amount:money`; `promised_on:date`.
- **Khóa ngoại:** `id` → `core.document_line` (PK dòng); `order_document_id` → `purchase.order`; `item_id` → `catalog.item`; `input_unit_id` → `core.unit`; `conversion_id` → `catalog.unit_conversion`.
- **Ràng buộc:** Quy đổi nullable khi cùng đơn vị cơ sở; snapshot factor; nhận từng đợt kiểm còn được nhận, thừa cách ly.
- **Yêu cầu:** FR14, FR15, FR24.

### D037 purchase.supply_assignment

- **Phụ trách:** Mua hàng / kho. **Mục đích:** Dành phần đang về cho đúng nhu cầu.
- **Trường nghiệp vụ:** `quantity_base:quantity`; `state:enum(planned,cancelled,fulfilled)`; `effective_at:time`; `ended_at:time?`.
- **Khóa ngoại:** `purchase_line_id` → `purchase.order_line`; `demand_id` → `stock.demand`; `supersedes_assignment_id` → `purchase.supply_assignment`.
- **Ràng buộc:** Tổng đang về dành không vượt PO còn và nhu cầu; dự kiến không cộng tồn thực tế. Lịch sử sửa bằng bản mới liên kết.
- **Yêu cầu:** FR11, FR14.

### D038 stock.lot

- **Phụ trách:** Kho / sản xuất nguồn tạo. **Mục đích:** Nhận dạng nguồn vật tư/thành phẩm.
- **Trường nghiệp vụ:** `code:text`; `supplier_lot_code:text?`; `produced_on:date?`; `expires_on:date?`; `origin_kind:enum(opening,purchase,production,unknown)`.
- **Khóa ngoại:** `item_id` → `catalog.item`; `origin_document_id` → `core.document`; `production_batch_id` → `production.batch`.
- **Ràng buộc:** Unique workspace+code; unknown có nhãn, không bịa nguồn. Lô có nhiều phần/vị trí; hạn nullable khi chưa xác định.
- **Yêu cầu:** FR01, FR15, FR16, FR19.

### D039 stock.portion

- **Phụ trách:** Kho, QC giữ chất lượng. **Mục đích:** Phần đồng nhất chất lượng/quyền sở hữu của một lô.
- **Trường nghiệp vụ:** `quality_state:enum(pending,good,reject)`; `ownership:enum(company,third_party,unknown)`; `specification_snapshot:json đóng`.
- **Khóa ngoại:** `lot_id` → `stock.lot`; `parent_portion_id` → `stock.portion`; `quality_document_id` → `quality.inspection`.
- **Ràng buộc:** Không lưu lượng tồn tại đây. Tách phần chỉ bởi movement cùng transaction, không tự sinh lượng. Giữ chất lượng riêng với vị trí/khóa; nhiều hold cùng phần thì hết mọi hold mới dùng.
- **Yêu cầu:** FR11, FR15, FR17, FR19.

### D040 stock.movement

- **Phụ trách:** Kho / người xác nhận thực theo nguồn. **Mục đích:** Phiếu và sự kiện thực vào/ra/chuyển.
- **Trường nghiệp vụ:** `kind:enum(opening,receipt,transfer,quality_split,issue,return,consume,dispatch,disposal,count_adjustment)`; `execution_state:enum(draft,posted)`; `executed_at:time?`; `posting_sequence:integer?`.
- **Khóa ngoại:** `document_id` → `core.document`; `operation_receipt_id` → `access.operation_receipt`.
- **Ràng buộc:** posted mới tác động lượng. Phiếu xưởng tổ trưởng xác nhận phạm vi sản xuất; kho không tự sửa công/thực dùng. Không ghi lùi trước mốc/biến động liên quan.
- **Yêu cầu:** FR05, FR06, FR15, FR16, FR18, FR20, FR21.

### D041 stock.movement_line

- **Phụ trách:** Kho / xác nhận sản xuất đúng phạm vi. **Mục đích:** Sổ lượng qua hai đầu trách nhiệm.
- **Trường nghiệp vụ:** `quantity_input:quantity`; `quantity_base:quantity`; `conversion_factor_snapshot:decimal`; `reason:text?`.
- **Khóa ngoại:** `id` → `core.document_line` (PK dòng); `movement_document_id` → `stock.movement`; `from_portion_id` → `stock.portion`; `to_portion_id` → `stock.portion`; `from_location_id` → `core.location`; `to_location_id` → `core.location`; `input_unit_id` → `core.unit`; `conversion_id` → `catalog.unit_conversion`; `origin_line_id` → `stock.movement_line`; `demand_id` → `stock.demand`; `resolution_document_id` → `core.document`.
- **Ràng buộc:** Đầu vào/đầu ra nullable chỉ cho nhập ngoài/tiêu dùng/xuất ngoài hợp lệ; cặp portion/location cùng null. Chuyển nội bộ đủ hai đầu, qty>0, không mất lượng. Nhận trả hợp lệ không vượt gốc; thừa/không rõ nguồn nhận cách ly với case. Đầu xuất bán phải good/company/không hold/còn lượng.
- **Yêu cầu:** FR01, FR05, FR06, FR15, FR16, FR18, FR20, FR21, FR27.

### D042 stock.demand

- **Phụ trách:** Kinh doanh / sản xuất lập; kho đối chiếu. **Mục đích:** Nhu cầu hàng/vật tư không tự mất khi khóa lô.
- **Trường nghiệp vụ:** `purpose:enum(sale,production,approved_future_need,replacement)`; `needed_qty:quantity`; `needed_on:date`; `state:enum(open,closed,cancelled)`.
- **Khóa ngoại:** `source_line_id` → `core.document_line`; `item_id` → `catalog.item`; `unit_id` → `core.unit`; `supersedes_demand_id` → `stock.demand`; `id` → `core.document_line` (PK dòng).
- **Ràng buộc:** Unique nguồn+bản+item+purpose. Nhu cầu OTHER-001 là nguồn duyệt tương lai, không tạo lệnh đã thực hiện. Đổi nhu cầu tạo bản thay, không xóa giữ/giao cũ. Demand có dòng riêng; source_line nullable chỉ với nguồn material_need tương lai được duyệt, còn nhu cầu đơn/lệnh phải có source đúng loại.
- **Yêu cầu:** FR11, FR12, FR14, FR16, FR20.

### D043 stock.reservation_event

- **Phụ trách:** Kho. **Mục đích:** Lịch sử giữ, dùng, giải phóng và mất hiệu lực.
- **Trường nghiệp vụ:** `kind:enum(reserve,consume,release,invalidate)`; `quantity_base:quantity`; `executed_at:time`; `reason:text?`.
- **Khóa ngoại:** `demand_id` → `stock.demand`; `portion_id` → `stock.portion`; `location_id` → `core.location`; `reserve_event_id` → `stock.reservation_event`; `movement_line_id` → `stock.movement_line`; `approval_id` → `core.approval`.
- **Ràng buộc:** reserve_event nullable ở lần giữ đầu, các lần sau trỏ lần giữ gốc. Giữ không đổi tồn; tổng consume/release/invalidate không vượt phần giữ; khóa/đếm thiếu cùng transaction invalidate và tạo việc thiếu.
- **Yêu cầu:** FR05, FR11, FR17, FR20, FR21.

### D044 stock.count

- **Phụ trách:** Kho, người đếm/đối chiếu khác nhau. **Mục đích:** Mốc và phạm vi kiểm kê.
- **Trường nghiệp vụ:** `cutoff_at:time`; `scope:text`; `state:enum(counting,reviewed,approved,posted)`; `freeze_started_at:time`; `freeze_ended_at:time?`.
- **Khóa ngoại:** `document_id` → `core.document`; `counter_employee_id` → `hr.employee`; `reviewer_employee_id` → `hr.employee`.
- **Ràng buộc:** Đóng giao dịch phần đếm hoặc ghi đối chiếu giữa hai mốc; duyệt không tự điều chỉnh.
- **Yêu cầu:** FR06, FR20.

### D045 stock.count_line

- **Phụ trách:** Kho. **Mục đích:** Đếm thực theo lô/vị trí/điều kiện.
- **Trường nghiệp vụ:** `counted_qty:quantity`; `book_qty_at_cutoff:quantity`; `reason:text?`.
- **Khóa ngoại:** `id` → `core.document_line` (PK dòng); `count_document_id` → `stock.count`; `portion_id` → `stock.portion`; `location_id` → `core.location`; `adjustment_line_id` → `stock.movement_line`.
- **Ràng buộc:** Book snapshot có cutoff/sequence, chênh tính ra; điều chỉnh có nguồn, không sửa book để khớp.
- **Yêu cầu:** FR20.

### D046 production.bom

- **Phụ trách:** Sản xuất. **Mục đích:** Một phiên bản định mức/công đoạn.
- **Trường nghiệp vụ:** `code:text`; `version:integer`; `start_basis_qty:quantity`; `expected_yield:ratio`; `valid_from:date`; `valid_to:date?`.
- **Khóa ngoại:** `document_id` → `core.document`; `output_item_id` → `catalog.item`; `policy_version_id` → `core.policy_version`.
- **Ràng buộc:** Bản đã dùng bất biến, tỷ lệ chỉ kế hoạch; cùng mã không chồng hiệu lực.
- **Yêu cầu:** FR12, FR13, FR16.

### D047 production.bom_line

- **Phụ trách:** Sản xuất. **Mục đích:** Vật tư và công đoạn tiêu dùng theo BOM.
- **Trường nghiệp vụ:** `material_qty:quantity`; `operation_code:text`; `sequence:integer`.
- **Khóa ngoại:** `id` → `core.document_line` (PK dòng); `bom_document_id` → `production.bom`; `item_id` → `catalog.item`; `unit_id` → `core.unit`.
- **Ràng buộc:** Qty>0, đúng dimension, không cộng dự phòng hai lần.
- **Yêu cầu:** FR12, FR16.

### D048 production.resource

- **Phụ trách:** Sản xuất. **Mục đích:** Nguồn tạo hình/hoàn thiện/chỗ dưỡng hộ.
- **Trường nghiệp vụ:** `code:text`; `kind:enum(machine,station,curing_space)`; `capacity_qty:quantity?`; `capacity_minutes:integer?`; `required_skill:text?`.
- **Khóa ngoại:** `location_id` → `core.location`; `policy_version_id` → `core.policy_version`.
- **Ràng buộc:** Một xưởng, nhiều nguồn; chỗ dưỡng hộ 8.000 là giới hạn lượng, khác giờ máy.
- **Yêu cầu:** FR12, FR13.

### D049 production.work_order

- **Phụ trách:** Quản lý sản xuất. **Mục đích:** Lệnh theo đơn/làm sẵn/mẫu/làm lại.
- **Trường nghiệp vụ:** `purpose:enum(customer_order,make_to_stock,sample,rework)`; `status:enum(draft,waiting,ready,running,reconciling,closed)`; `needed_good_qty:quantity`; `planned_start_qty:quantity`; `promised_on:date?`; `priority:integer`; `priority_reason:text?`.
- **Khóa ngoại:** `document_id` → `core.document`; `bom_document_id` → `production.bom`; `source_order_line_id` → `sales.order_line`; `source_case_document_id` → `sales.change_case`; `policy_version_id` → `core.policy_version`.
- **Ràng buộc:** Nguồn đơn nullable với làm sẵn. Mẫu/cọc/vật tư đủ trước thực hiện; closed cần hết WIP/lỗi và đủ chi phí. Lệnh mẫu không cộng vào lượng bán.
- **Yêu cầu:** FR09, FR10, FR12, FR13, FR18.

### D050 production.batch

- **Phụ trách:** Sản xuất. **Mục đích:** Một lô thực hiện của lệnh.
- **Trường nghiệp vụ:** `code:text`; `planned_start_qty:quantity`; `status:enum(waiting,forming,curing,finishing,qc,reconciling,closed)`.
- **Khóa ngoại:** `work_order_document_id` → `production.work_order`; `output_lot_id` → `stock.lot`.
- **Ràng buộc:** Lượng bắt đầu/thực đạt/lỗi từ operation và QC, không nhập số tổng sửa tay. Lot liên kết hai chiều kiểm đúng batch.
- **Yêu cầu:** FR12, FR13, FR17, FR19.

### D051 production.operation

- **Phụ trách:** Sản xuất. **Mục đích:** Công đoạn, thời điểm và sản lượng thực.
- **Trường nghiệp vụ:** `code:text`; `sequence:integer`; `planned_from:time?`; `planned_to:time?`; `actual_from:time?`; `actual_to:time?`; `started_qty:quantity`; `completed_qty:quantity`; `pending_qty:quantity`; `status:enum(planned,running,waiting,completed)`; `reason:text?`.
- **Khóa ngoại:** `document_id` → `core.document`; `batch_id` → `production.batch`; `policy_version_id` → `core.policy_version`.
- **Ràng buộc:** Khoảng actual có xác nhận; chờ sản phẩm không tự là giờ người. Cộng lượng giữa công đoạn theo dòng chuyển, không cộng toàn công đoạn thành sản lượng mới.
- **Yêu cầu:** FR12, FR13, FR17.

### D052 production.resource_booking

- **Phụ trách:** Quản lý sản xuất. **Mục đích:** Lịch nguồn lực và giờ máy thực.
- **Trường nghiệp vụ:** `kind:enum(planned,actual)`; `starts_at:time`; `ends_at:time`; `occupancy_qty:quantity?`; `state:enum(active,cancelled)`; `purpose:enum(form,finish,curing,setup,maintenance)`.
- **Khóa ngoại:** `resource_id` → `production.resource`; `operation_document_id` → `production.operation`; `supersedes_booking_id` → `production.resource_booking`.
- **Ràng buộc:** Không trùng nguồn độc quyền; nguồn sức chứa cộng occupancy tại mọi khoảng, không vượt 8.000; planned khác actual. Bản sửa nối bản trước.
- **Yêu cầu:** FR12, FR13, FR26.

### D053 production.material_use

- **Phụ trách:** Sản xuất xác nhận. **Mục đích:** Thực dùng/hao hụt theo lô và nguồn cấp.
- **Trường nghiệp vụ:** `kind:enum(consume,process_loss)`; `quantity_base:quantity`; `reason:text?`.
- **Khóa ngoại:** `id` → `core.document_line` (PK dòng); `operation_document_id` → `production.operation`; `source_issue_line_id` → `stock.movement_line`; `consumption_line_id` → `stock.movement_line`.
- **Ràng buộc:** Một consume movement chỉ gắn một use. Cấp=đã dùng+hao hụt+đã hoàn+còn tại xưởng; use không sinh xuất lần hai. Hoàn theo phiếu kho, không thêm bản hoàn độc lập.
- **Yêu cầu:** FR13, FR16, FR26.

### D054 quality.inspection

- **Phụ trách:** Chất lượng. **Mục đích:** Hồ sơ kiểm tra đúng nguồn/phạm vi.
- **Trường nghiệp vụ:** `inspection_kind:enum(incoming,in_process,finished,sample,return,dispatch)`; `inspected_qty:quantity`; `good_qty:quantity`; `reject_qty:quantity`; `pending_qty:quantity`; `coverage:enum(full,sample)`; `conclusion_state:enum(pending,confirmed)`; `concluded_at:time?`.
- **Khóa ngoại:** `document_id` → `core.document`; `source_line_id` → `core.document_line`; `lot_id` → `stock.lot`; `criteria_version_id` → `core.policy_version`; `sample_document_id` → `sales.sample`; `inspector_employee_id` → `hr.employee`.
- **Ràng buộc:** Good+reject+pending đối chiếu nguồn và phạm vi; sample chưa có luật không suy rộng. Không ghi good từ expected_yield. Phân phần kho đồng thời qua stock movement.
- **Yêu cầu:** FR09, FR15, FR17, FR27.

### D055 quality.measurement

- **Phụ trách:** Chất lượng. **Mục đích:** Số đo/ngoại quan và lỗi theo tiêu chí.
- **Trường nghiệp vụ:** `criterion_code:text`; `measured_value:decimal?`; `unit_code:text?`; `observed_text:text?`; `result:enum(pass,fail,pending)`; `affected_qty:quantity?`.
- **Khóa ngoại:** `inspection_document_id` → `quality.inspection`.
- **Ràng buộc:** Từ danh sách tiêu chí đóng đúng version; số đo chiều và số viên lỗi khác nhau; lỗi có thể chồng loại, không cộng lỗi theo loại thay lượng reject.
- **Yêu cầu:** FR17.

### D056 quality.hold_event

- **Phụ trách:** Chất lượng. **Mục đích:** Lịch sử khóa và giải phóng phần lô.
- **Trường nghiệp vụ:** `kind:enum(hold,release)`; `reason:text`; `executed_at:time`.
- **Khóa ngoại:** `portion_id` → `stock.portion`; `hold_event_id` → `quality.hold_event`; `inspection_document_id` → `quality.inspection`; `resolution_document_id` → `core.document`; `actor_employee_id` → `hr.employee`.
- **Ràng buộc:** Khóa toàn portion; khóa một phần phải split lượng trước. release trỏ hold gốc và cần QC đủ điều kiện; còn hold khác vẫn khóa. Khóa không giảm tồn nhưng invalidate giữ hợp lệ.
- **Yêu cầu:** FR11, FR17, FR19.

### D057 quality.disposition

- **Phụ trách:** Quản lý đề nghị / giám đốc duyệt / thực hiện. **Mục đích:** Phương án lỗi, làm lại, loại bỏ, thu hồi.
- **Trường nghiệp vụ:** `action:enum(rework,dispose,return_supplier,recall,downgrade)`; `approved_qty:quantity`; `resolution_notes:text`; `status:enum(proposed,approved,partly_executed,completed)`.
- **Khóa ngoại:** `document_id` → `core.document`; `inspection_document_id` → `quality.inspection`; `portion_id` → `stock.portion`; `case_document_id` → `sales.change_case`; `approval_id` → `core.approval`.
- **Ràng buộc:** Lượng xử lý thực từ movement/operation gắn resolution_document; duyệt không giảm. Thu hồi chưa thực về không tăng kho; hạ loại cần biến thể và quy cách mới đã duyệt.
- **Yêu cầu:** FR18, FR19, FR27.

### D058 delivery.shipment

- **Phụ trách:** Giao hàng phối hợp kinh doanh. **Mục đích:** Một đợt soạn/rời/nhận.
- **Trường nghiệp vụ:** `receiver_address_snapshot:text`; `carrier_notes:text`; `departed_at:time?`; `received_at:time?`; `status:enum(requested,picking,in_transit,partly_received,received,disputed)`.
- **Khóa ngoại:** `document_id` → `core.document`; `order_document_id` → `sales.order`; `receiver_id` → `core.party`; `carrier_id` → `core.party`; `receiver_authority_id` → `core.party_authority`.
- **Ràng buộc:** Giao đủ/tiền đủ là view riêng; warehouse dispatch mới departed, khách nhận chưa tự bán.
- **Yêu cầu:** FR21.

### D059 delivery.shipment_line

- **Phụ trách:** Giao hàng / kho ghi thực xuất. **Mục đích:** Biến thể/lô của đợt giao.
- **Trường nghiệp vụ:** `planned_qty:quantity`.
- **Khóa ngoại:** `id` → `core.document_line` (PK dòng); `shipment_document_id` → `delivery.shipment`; `order_line_id` → `sales.order_line`; `dispatch_line_id` → `stock.movement_line`.
- **Ràng buộc:** Dispatch nullable trước rời, một dòng một nguồn portion/lô; nhiều lô nhiều dòng. Phải đúng đơn/version/item/receiver và còn giao.
- **Yêu cầu:** FR19, FR21, FR22, FR27.

### D060 delivery.acceptance_line

- **Phụ trách:** Giao hàng. **Mục đích:** Kết quả khách nhận từng phần.
- **Trường nghiệp vụ:** `received_qty:quantity`; `accepted_qty:quantity`; `refused_qty:quantity`; `damaged_qty:quantity`; `executed_at:time`; `evidence:text`.
- **Khóa ngoại:** `id` → `core.document_line` (PK dòng); `shipment_line_id` → `delivery.shipment_line`; `receiver_contact_id` → `core.party_contact`.
- **Ràng buộc:** Tổng nhận không vượt thực xuất chưa ghi nhận; accepted+refused=received, damaged là phân loại trong refused nếu áp dụng, không cộng đôi. Giữ lượng thiếu/đang giao riêng.
- **Yêu cầu:** FR21, FR22, FR27.

### D061 finance.cash_account

- **Phụ trách:** Tài chính. **Mục đích:** Quỹ/tài khoản và số dư tính từ sổ.
- **Trường nghiệp vụ:** `code:text`; `kind:enum(cash,bank)`; `currency:enum(VND)`; `active:boolean`.
- **Khóa ngoại:** Không có FK riêng ngoài workspace..
- **Ràng buộc:** Không có cột số dư sửa tay; không tự thấu chi.
- **Yêu cầu:** FR23, FR24, FR25.

### D062 finance.payment_request

- **Phụ trách:** Kế toán / HR lập; giám đốc duyệt. **Mục đích:** Được phép chi theo nguồn.
- **Trường nghiệp vụ:** `requested_amount:money`; `purpose:enum(supplier,advance,payroll,refund,expense,transfer)`; `status:enum(requested,approved,partly_paid,paid)`; `beneficiary_name_snapshot:text`.
- **Khóa ngoại:** `document_id` → `core.document`; `beneficiary_party_id` → `core.party`; `beneficiary_employee_id` → `hr.employee`; `obligation_id` → `finance.obligation`; `approval_id` → `core.approval`; `destination_cash_account_id` → `finance.cash_account`.
- **Ràng buộc:** Party hoặc employee, transfer nội bộ có tài khoản đích. Có thể ứng chưa có obligation; duyệt không chi; tổng thực chi không vượt được phép.
- **Yêu cầu:** FR24, FR31.

### D063 finance.cash_movement

- **Phụ trách:** Người thu/chi xác nhận. **Mục đích:** Một biến động tiền thực hoặc số đầu.
- **Trường nghiệp vụ:** `direction:enum(in,out,opening)`; `amount:money`; `executed_at:time`; `external_reference:text?`; `transfer_key:uuid?`; `allocation_scope:enum(unidentified,customer,supplier,employee,internal)`; `posting_state:enum(draft,posted)`.
- **Khóa ngoại:** `id` → `core.document_line` (PK dòng); `cash_account_id` → `finance.cash_account`; `payment_request_document_id` → `finance.payment_request`; `party_id` → `core.party`; `employee_id` → `hr.employee`; `authority_id` → `core.party_authority`; `operation_receipt_id` → `access.operation_receipt`.
- **Ràng buộc:** Amount>0, actual chứng cứ; opening riêng không doanh thu. Out cần request/duyệt và đủ số dư. Transfer hai đầu cùng khóa/transaction. Thu chưa rõ cho party null và không được phân bổ. Chỉ posted có tiền thực; draft không vào sổ hoặc nguồn phân bổ. party_id/employee_id ghi bên trả hoặc nhận thực, không đổi thành chủ nghĩa vụ khi trả thay.
- **Yêu cầu:** FR05, FR23, FR24, FR25, FR31.

### D064 finance.obligation

- **Phụ trách:** Tài chính. **Mục đích:** Khoản phải thu/trả/hoàn theo nguồn.
- **Trường nghiệp vụ:** `kind:enum(receivable,payable,refund_payable,advance_recovery)`; `original_amount:money`; `due_on:date?`; `status:enum(open,settled,disputed)`; `beneficiary_name_snapshot:text`.
- **Khóa ngoại:** `source_line_id` → `core.document_line`; `party_id` → `core.party`; `employee_id` → `hr.employee`.
- **Ràng buộc:** Một chủ nghĩa vụ party hoặc employee; unique nguồn+loại. AP sau đối chiếu không tự từ PO; lương chỉ dòng đủ duyệt, dòng CEO chờ riêng. Dư có là ứng/phải hoàn, không phải thu âm.
- **Yêu cầu:** FR22, FR24, FR25, FR27, FR31.

### D065 finance.obligation_event

- **Phụ trách:** Tài chính. **Mục đích:** Điều chỉnh nghĩa vụ không sửa gốc.
- **Trường nghiệp vụ:** `event_kind:enum(amount_change,due_date_change)`; `direction:enum(increase,decrease)?`; `amount:money?`; `executed_at:time`; `reason:text`; `new_due_on:date?`.
- **Khóa ngoại:** `id` → `core.document_line` (PK dòng); `obligation_id` → `finance.obligation`; `original_event_id` → `finance.obligation_event`; `approval_id` → `core.approval`.
- **Ràng buộc:** Số gốc bất biến, phần điều chỉnh có nguồn bán/đối chiếu/phương án; không giảm quá còn hợp lệ. Chuyển phần đã thu thành nghĩa vụ hoàn phải tái phân loại ứng có căn cứ. Amount_change bắt direction/amount>0; due_date_change chỉ new_due_on, không đổi tiền; due tại mốc dựng từ ngày gốc và event được duyệt, không sửa gốc.
- **Yêu cầu:** FR06, FR24, FR25, FR27, FR30.

### D066 finance.allocation_event

- **Phụ trách:** Kế toán. **Mục đích:** Dùng tiền cho nghĩa vụ hoặc giữ nguồn hoàn.
- **Trường nghiệp vụ:** `kind:enum(settle,reverse_settle,reserve_refund,release_refund,consume_refund)`; `amount:money`; `executed_at:time`.
- **Khóa ngoại:** `cash_movement_id` → `finance.cash_movement`; `obligation_id` → `finance.obligation`; `original_allocation_id` → `finance.allocation_event`; `refund_movement_id` → `finance.cash_movement`; `authority_id` → `core.party_authority`.
- **Ràng buộc:** Chỉ settle đúng bên/hướng; tiền chưa dùng trừ cả phần bị giữ hoàn. Reverse không thu/chi mới. Consume_refund nối thực chi để phần thu cũ không trở lại khả dụng. Tổng không vượt nguồn/nghĩa vụ. cash.party_id là người trả/nhận thực, obligation.party_id là chủ nghĩa vụ; nếu khác bắt authority đúng represented party/agent/nguồn. Nguồn chưa rõ phải có hồ sơ đối chiếu xác định chủ trước settle, không sửa tiền thực.
- **Yêu cầu:** FR05, FR23, FR24, FR25, FR27, FR31.

### D067 finance.sale

- **Phụ trách:** Kế toán. **Mục đích:** Ghi nhận bán hoặc điều chỉnh thương mại.
- **Trường nghiệp vụ:** `kind:enum(sale,credit,debit)`; `executed_at:time`; `tax_mode:enum(not_modelled)`; `status:enum(draft,posted)`.
- **Khóa ngoại:** `document_id` → `core.document`; `order_document_id` → `sales.order`; `case_document_id` → `sales.change_case`; `approval_id` → `core.approval`.
- **Ràng buộc:** Sale thường chỉ sau chấp nhận; credit/debit có căn cứ và quyết định; không hóa đơn pháp lý.
- **Yêu cầu:** FR22, FR27.

### D068 finance.sale_line

- **Phụ trách:** Kế toán. **Mục đích:** Doanh thu theo lượng/giá đã chấp nhận.
- **Trường nghiệp vụ:** `quantity_pieces:quantity`; `unit_price_snapshot:decimal`; `amount:money`; `cogs_status:enum(provisional,confirmed)`.
- **Khóa ngoại:** `id` → `core.document_line` (PK dòng); `sale_document_id` → `finance.sale`; `acceptance_line_id` → `delivery.acceptance_line`; `original_sale_line_id` → `finance.sale_line`; `order_line_id` → `sales.order_line`.
- **Ràng buộc:** Bán không vượt accepted chưa ghi; credit/debit chỉ gốc đã ghi và phần còn; không xuất kho lần hai. Giá vốn nguồn value_entry, không nhân giá bán.
- **Yêu cầu:** FR22, FR26, FR27.

### D069 finance.purchase_match

- **Phụ trách:** Mua hàng / kế toán đối chiếu. **Mục đích:** Chứng từ nghĩa vụ và giá trị mua được chấp nhận.
- **Trường nghiệp vụ:** `accepted_qty:quantity`; `accepted_amount:money`; `supplier_reference:text`; `due_on:date`; `status:enum(pending,confirmed,disputed)`.
- **Khóa ngoại:** `id` → `core.document_line` (PK dòng); `purchase_line_id` → `purchase.order_line`; `receipt_line_id` → `stock.movement_line`; `inspection_document_id` → `quality.inspection`; `supplier_id` → `core.party`.
- **Ràng buộc:** Không vượt phần nhận/đạt/chưa đối chiếu; lỗi/thừa chờ riêng; supplier reference chống nhập trùng theo nguồn, không giả nhận đạt cả PO.
- **Yêu cầu:** FR14, FR15, FR24.

### D070 finance.reconciliation_line

- **Phụ trách:** Tài chính. **Mục đích:** Đối chiếu quỹ/ngân hàng giả lập theo mốc.
- **Trường nghiệp vụ:** `external_reference:text`; `observed_amount:money`; `direction:enum(in,out)`; `observed_at:time`; `state:enum(unmatched,matched,disputed)`.
- **Khóa ngoại:** `id` → `core.document_line` (PK dòng); `cash_account_id` → `finance.cash_account`; `cash_movement_id` → `finance.cash_movement`.
- **Ràng buộc:** Movement nullable nếu chưa khớp; không tự sinh tiền từ sao kê. Chênh có hồ sơ xử lý, không sửa số cuối.
- **Yêu cầu:** FR23, FR25.

### D071 finance.cost_source

- **Phụ trách:** Tài chính; HR cung cấp phần lương. **Mục đích:** Một nguồn chi phí được đối chiếu.
- **Trường nghiệp vụ:** `kind:enum(material,labor,overhead,additional,recoverable)`; `amount:money`; `state:enum(provisional,confirmed)`; `basis_notes:text`.
- **Khóa ngoại:** `source_line_id` → `core.document_line`; `payroll_line_id` → `hr.payroll_line`; `material_use_line_id` → `production.material_use`; `policy_version_id` → `core.policy_version`; `supersedes_source_id` → `finance.cost_source`; `id` → `core.document_line` (PK dòng).
- **Ràng buộc:** Unique nguồn+loại+bản; material/labor trỏ đúng loại nguồn, overhead source_line chứng từ chi phí chứ không tiền chi. Nguồn thu hồi tách, không cộng trùng AP/chi tiền. Cost source có dòng riêng; source_line nullable chỉ với nguồn overhead/additional tự khai có chứng từ và duyệt; material/labor phải có nguồn.
- **Yêu cầu:** FR18, FR26, FR31.

### D072 finance.cost_allocation

- **Phụ trách:** Tài chính. **Mục đích:** Phân bổ nguồn đến lô hoặc chi phí khác.
- **Trường nghiệp vụ:** `amount:money`; `cost_bucket:enum(batch,other_workshop,nonproduction,recovery)`; `basis_quantity:decimal`; `state:enum(provisional,confirmed)`.
- **Khóa ngoại:** `id` → `core.document_line` (PK dòng); `cost_source_id` → `finance.cost_source`; `batch_id` → `production.batch`; `policy_version_id` → `core.policy_version`; `supersedes_allocation_id` → `finance.cost_allocation`.
- **Ràng buộc:** Batch nullable với nguồn khác; bản cũ giữ. Tổng phân bổ đang hiệu lực không vượt nguồn; nguyên liệu/nhân công/chung không cộng lại lúc chi tiền.
- **Yêu cầu:** FR18, FR26, FR31.

### D073 finance.cost_basis

- **Phụ trách:** Tài chính; sản xuất/HR xác nhận nguồn giờ. **Mục đích:** Các dòng thực làm/giờ máy/vật tư cho phân bổ.
- **Trường nghiệp vụ:** `basis_kind:enum(labor_minutes,machine_minutes,material_qty)`; `basis_quantity:decimal`.
- **Khóa ngoại:** `allocation_line_id` → `finance.cost_allocation`; `work_interval_id` → `hr.work_interval`; `resource_booking_id` → `production.resource_booking`; `material_use_line_id` → `production.material_use`.
- **Ràng buộc:** Chính xác một nguồn phù hợp kind; machine phải actual; labor phải confirmed/direct. Không lấy giờ người thành giờ máy.
- **Yêu cầu:** FR12, FR26, FR29, FR31.

### D074 finance.cost_sheet

- **Phụ trách:** Tài chính cùng sản xuất đối chiếu. **Mục đích:** Bản giá thành lô được chốt hoặc tạm tính.
- **Trường nghiệp vụ:** `state:enum(provisional,confirmed)`; `published_total:money?`; `good_qty_snapshot:quantity`; `missing_sources:text?`.
- **Khóa ngoại:** `document_id` → `core.document`; `batch_id` → `production.batch`; `valuation_policy_version_id` → `core.policy_version`.
- **Ràng buộc:** Tổng tính từ allocations đúng bản có nguồn, published_total chỉ ảnh chụp khi chốt; đủ lượng/lỗi/nguồn trước confirmed.
- **Yêu cầu:** FR13, FR18, FR26.

### D075 finance.value_entry

- **Phụ trách:** Tài chính. **Mục đích:** Sổ giá trị kho/xưởng/đang giao/giá vốn.
- **Trường nghiệp vụ:** `from_bucket:enum(source,inventory,wip,transit,cogs,expense,recovery)`; `to_bucket:enum tương ứng`; `amount:money`; `executed_at:time`; `valuation_state:enum(provisional,confirmed)`; `quantity_basis:quantity?`; `rounding_rule:text`.
- **Khóa ngoại:** `id` → `core.document_line` (PK dòng); `item_id` → `catalog.item`; `movement_line_id` → `stock.movement_line`; `cost_sheet_document_id` → `finance.cost_sheet`; `sale_line_id` → `finance.sale_line`; `original_value_entry_id` → `finance.value_entry`.
- **Ràng buộc:** Hai bucket khác nhau, amount>0; mỗi biến động giá trị có đúng nguồn và chỉ ghi một lần theo action. Chốt/sửa giá trị không thêm lượng; xuất hết mang giá trị còn. Theo item/workspace và bucket, giữ lô vật lý riêng với bình quân.
- **Yêu cầu:** FR06, FR15, FR16, FR22, FR26, FR27.

### D076 hr.employee

- **Phụ trách:** Nhân sự. **Mục đích:** Một hồ sơ người, không bắt có tài khoản.
- **Trường nghiệp vụ:** `code:text`; `identity_key:uuid`; `name:text`; `joined_on:date`; `left_on:date?`.
- **Khóa ngoại:** `identity_key` → `access.person`.
- **Ràng buộc:** Unique(workspace,code/identity_key); identity ổn định, không tạo người thứ hai để tự duyệt; dữ liệu thật không Git. Dept/lương lịch sử ở employment, không số hiện tại thay quá khứ. Trạng thái tại mốc lấy employment hiệu lực, không cột trạng thái hiện tại thay quá khứ.
- **Yêu cầu:** FR01, FR02, FR28, FR31.

### D077 hr.employment

- **Phụ trách:** Nhân sự theo quyết định. **Mục đích:** Hợp đồng/bộ phận/quản lý/chính sách theo hiệu lực.
- **Trường nghiệp vụ:** `valid_from:date`; `valid_to:date?`; `contract_kind:text`; `contract_end_on:date?`; `position:text`; `base_salary:money`; `fixed_allowance:money`; `probation_notes:text?`; `lifecycle_state:enum(preparing,probation,active,suspended,left)`.
- **Khóa ngoại:** `document_id` → `core.document`; `employee_id` → `hr.employee`; `department_id` → `core.department`; `manager_employee_id` → `hr.employee`; `payroll_policy_version_id` → `core.policy_version`.
- **Ràng buộc:** Không chồng khoảng chính một người; thay đổi tạo bản mới đúng mốc; một bộ phận chính, không tăng đầu người do kiêm nhiệm.
- **Yêu cầu:** FR28, FR31.

### D078 hr.qualification

- **Phụ trách:** Nhân sự / quản lý xác nhận. **Mục đích:** Kỹ năng, hướng dẫn an toàn và sự cố cơ sở.
- **Trường nghiệp vụ:** `kind:enum(skill,safety_training,incident)`; `code:text`; `valid_from:date`; `valid_to:date?`; `state:enum(pending,qualified,expired,closed)`; `impact_notes:text?`.
- **Khóa ngoại:** `document_id` → `core.document`; `employee_id` → `hr.employee`.
- **Ràng buộc:** Chỉ loại cần cho công đoạn; incident không cấp qualification, không tự phạt/khấu trừ; chứng cứ giả lập có nhãn.
- **Yêu cầu:** FR12, FR28.

### D079 hr.equipment_handoff

- **Phụ trách:** Nhân sự / kho. **Mục đích:** Cấp/trả đồ bảo hộ và dụng cụ.
- **Trường nghiệp vụ:** `kind:enum(issue,return,replace)`; `executed_at:time`; `acknowledgement:text`.
- **Khóa ngoại:** `document_id` → `core.document`; `employee_id` → `hr.employee`; `movement_line_id` → `stock.movement_line`; `original_handoff_id` → `hr.equipment_handoff`.
- **Ràng buộc:** Hàng có kho liên kết phiếu thực đúng một lần; bàn giao không xuất thêm. Không phải hệ tài sản/khấu hao.
- **Yêu cầu:** FR16, FR28.

### D080 hr.calendar_day

- **Phụ trách:** Nhân sự. **Mục đích:** Ngày làm và các khoảng ca có phiên bản.
- **Trường nghiệp vụ:** `work_date:date`; `day_kind:enum(work,weekly_off,holiday,exception)`; `shift_code:text`; `work_ranges:json mảng khoảng giờ đóng`; `scheduled_minutes:integer`.
- **Khóa ngoại:** `policy_version_id` → `core.policy_version`.
- **Ràng buộc:** Unique lịch+bản+ngày+ca; work_ranges không chồng, loại trưa; tổng scheduled_minutes kiểm từ khoảng. Tháng 26 ngày chỉ fixture, không hardcode mọi tháng.
- **Yêu cầu:** FR12, FR29, FR30, FR31.

### D081 hr.schedule

- **Phụ trách:** Quản lý / HR kiểm. **Mục đích:** Phân công dự kiến từng người.
- **Trường nghiệp vụ:** `starts_at:time`; `ends_at:time`; `purpose:enum(work,setup,training,maintenance,other)`; `state:enum(planned,cancelled)`.
- **Khóa ngoại:** `document_id` → `core.document`; `employee_id` → `hr.employee`; `calendar_day_id` → `hr.calendar_day`; `operation_document_id` → `production.operation`; `supersedes_schedule_id` → `hr.schedule`.
- **Ràng buộc:** Operation nullable nếu không SX; không trùng người/nghỉ; đủ qualification và người active; planned không làm công thực.
- **Yêu cầu:** FR12, FR28, FR29, FR30.

### D082 hr.attendance

- **Phụ trách:** Tổ trưởng ghi / quản lý xác nhận / HR chốt. **Mục đích:** Một bản công người/ngày/ca.
- **Trường nghiệp vụ:** `revision:integer`; `state:enum(draft,pending,confirmed,closed)`; `source_key:text`; `reason:text?`.
- **Khóa ngoại:** `document_id` → `core.document`; `employee_id` → `hr.employee`; `calendar_day_id` → `hr.calendar_day`; `supersedes_attendance_id` → `hr.attendance`; `confirmed_by_employee_id` → `hr.employee`; `period_id` → `core.period`.
- **Ràng buộc:** Unique người/ngày/ca/bản; chỉ một bản hiện hành có hiệu lực. Thiếu nguồn giữ pending; sửa sau chốt thêm bản điều chỉnh, không xóa công cũ.
- **Yêu cầu:** FR05, FR29, FR30, FR31.

### D083 hr.work_interval

- **Phụ trách:** Tổ trưởng / quản lý xác nhận. **Mục đích:** Khoảng thực làm/nghỉ/chờ và trực tiếp theo người.
- **Trường nghiệp vụ:** `starts_at:time`; `ends_at:time`; `kind:enum(direct,support,waiting,training,business_trip,paid_leave,unpaid_leave,unverified,overtime)`; `paid_status:enum(paid,unpaid,pending_policy)`; `state:enum(pending,confirmed)`.
- **Khóa ngoại:** `attendance_document_id` → `hr.attendance`; `operation_document_id` → `production.operation`; `leave_document_id` → `hr.leave_request`; `overtime_approval_id` → `core.approval`.
- **Ràng buộc:** Một khoảng một loại; direct bắt operation, leave bắt nguồn phép nếu thuộc phép; không trùng người/khoảng/bản hiện hành, không trưa. Thời gian chờ sản phẩm khác chờ có mặt của người.
- **Yêu cầu:** FR12, FR26, FR29, FR30, FR31.

### D084 hr.leave_request

- **Phụ trách:** Quản lý duyệt / HR kiểm. **Mục đích:** Đề nghị nghỉ và bàn giao.
- **Trường nghiệp vụ:** `leave_kind:enum(annual_paid,unpaid,sick,other)`; `starts_at:time`; `ends_at:time`; `scheduled_leave_minutes:integer`; `state:enum(requested,approved,cancelled,used)`; `reason:text`.
- **Khóa ngoại:** `document_id` → `core.document`; `employee_id` → `hr.employee`; `replacement_employee_id` → `hr.employee`; `policy_version_id` → `core.policy_version`; `approval_id` → `core.approval`.
- **Ràng buộc:** Chỉ tính phút trong lịch làm, loại nghỉ không tự trừ phép năm. Duyệt giữ, actual chốt mới dùng.
- **Yêu cầu:** FR12, FR30.

### D085 hr.leave_event

- **Phụ trách:** Nhân sự. **Mục đích:** Sổ phép đầu/phát sinh/giữ/dùng/điều chỉnh.
- **Trường nghiệp vụ:** `kind:enum(opening,accrue,reserve,release,use,adjust_increase,adjust_decrease)`; `minutes:integer`; `executed_at:time`.
- **Khóa ngoại:** `id` → `core.document_line` (PK dòng); `employee_id` → `hr.employee`; `leave_document_id` → `hr.leave_request`; `reserve_event_id` → `hr.leave_event`; `approval_id` → `core.approval`.
- **Ràng buộc:** Minutes>0; use giảm phần reserve còn và entitlement cùng transaction, không trừ đôi; xem mốc từ sổ, không cập nhật số dư tay.
- **Yêu cầu:** FR06, FR30.

### D086 hr.payroll_run

- **Phụ trách:** Nhân sự lập / tài chính kiểm. **Mục đích:** Kỳ và phiên bản bảng thu nhập.
- **Trường nghiệp vụ:** `revision:integer`; `state:enum(draft,checked,partly_approved,approved,closed)`; `limitations:enum(not_modelled_mandatory_deductions)`.
- **Khóa ngoại:** `document_id` → `core.document`; `period_id` → `core.period`; `attendance_close_document_id` → `core.document`; `policy_version_id` → `core.policy_version`; `supersedes_run_id` → `hr.payroll_run`.
- **Ràng buộc:** Không lấy trạng thái bảng ghi duyệt mọi dòng; kỳ công/bản policy cố định, điều chỉnh có bản gốc.
- **Yêu cầu:** FR06, FR30, FR31.

### D087 hr.payroll_line

- **Phụ trách:** Nhân sự / tài chính kiểm tra / người duyệt đủ quyền. **Mục đích:** Thu nhập một người, duyệt từng dòng.
- **Trường nghiệp vụ:** `state:enum(provisional,checked,pending_independent_review,approved)`; `income_before_mandatory:money`; `mandatory_deductions_status:enum(not_modelled)`; `calculation_snapshot:json cấu trúc đóng`.
- **Khóa ngoại:** `id` → `core.document_line` (PK dòng); `payroll_document_id` → `hr.payroll_run`; `employee_id` → `hr.employee`; `employment_document_id` → `hr.employment`; `approval_id` → `core.approval`; `original_payroll_line_id` → `hr.payroll_line`.
- **Ràng buộc:** Unique bảng+người. Snapshot công thức và phần công đã xác nhận; dòng CEO chờ độc lập. Đã trả/ứng/còn tính từ cash+allocation, không ghi tay; không gọi thực lĩnh pháp lý.
- **Yêu cầu:** FR06, FR24, FR26, FR30, FR31.

### D088 hr.payroll_component

- **Phụ trách:** Nhân sự. **Mục đích:** Từng khoản lương/phụ cấp/chênh có căn cứ.
- **Trường nghiệp vụ:** `kind:enum(time_salary,fixed_allowance,approved_bonus,overtime,adjustment)`; `direction:enum(increase,decrease)`; `amount:money`; `basis_minutes:integer?`; `rate_snapshot:decimal?`; `reason:text?`.
- **Khóa ngoại:** `payroll_line_id` → `hr.payroll_line`; `policy_version_id` → `core.policy_version`; `approval_id` → `core.approval`.
- **Ràng buộc:** Chỉ khoản đã dùng/chính sách có nguồn; không tự tiền phạt/khấu trừ pháp lý. Tổng thành payroll income đúng dấu; ứng không là component giảm chi phí.
- **Yêu cầu:** FR26, FR30, FR31.

### D089 access.session

- **Phụ trách:** Hệ thống xác thực. **Mục đích:** Phiên đăng nhập có hạn và thu hồi.
- **Trường nghiệp vụ:** `token_hash:text`; `issued_at:time`; `expires_at:time`; `revoked_at:time?`; `auth_version_snapshot:integer`.
- **Khóa ngoại:** `account_id` → `access.account`.
- **Ràng buộc:** Chỉ lưu băm token; kiểm account active/auth_version và hết hạn mỗi lần; nghỉ việc hoặc đổi quyền thu hồi phiên liên quan. Không log token.
- **Yêu cầu:** FR02, FR28.

### D090 finance.cost_sheet_line

- **Phụ trách:** Tài chính. **Mục đích:** Chốt đúng các phân bổ nguồn của một bản giá thành.
- **Trường nghiệp vụ:** `included_amount:money`.
- **Khóa ngoại:** `id` → `core.document_line` (PK dòng); `cost_sheet_document_id` → `finance.cost_sheet`; `allocation_line_id` → `finance.cost_allocation`.
- **Ràng buộc:** Unique sheet+allocation; amount khớp nguồn đã duyệt, không dùng danh sách phân bổ hiện tại thay bản đã chốt. Bản sau có thể tái dùng nguồn chưa đổi, không phân bổ lại tiền.
- **Yêu cầu:** FR06, FR13, FR26.

### D091 access.person

- **Phụ trách:** Quản trị định danh phối hợp HR. **Mục đích:** Người thật ổn định qua tài khoản và các bộ demo.
- **Trường nghiệp vụ:** `identity_code:text`; `display_name:text`; `state:enum(active,disabled)`; `simulated:boolean`.
- **Khóa ngoại:** Không có FK riêng ngoài workspace..
- **Ràng buộc:** Định danh toàn hệ thống; unique identity_code có kiểm căn cứ, không tự thêm người trùng để duyệt cho mình. Một person có nhiều account/hồ sơ demo nhưng vẫn cùng người.
- **Yêu cầu:** FR02, FR03, FR28, FR33.
