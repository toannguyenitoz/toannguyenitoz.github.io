# Project Rules & Development Guidelines

> **Repository:** `toannguyenitoz.github.io`  
> **Brand & Author:** Toan Nguyen IT Oz (Adelaide, South Australia)  
> **Live Website:** [https://toannguyenitoz.github.io](https://toannguyenitoz.github.io)  
> **Target Audience:** Enterprise IT Specialists, Systems Administrators, Helpdesk Engineers, Cloud & Automation Professionals.

---

## 1. Nguyên Tắc Cốt Lõi (Core Principles)

1. **Ngôn ngữ bài viết & giao diện:**
   - Tất cả nhãn (labels), thẻ trạng thái (badges), số liệu phân tích, thuật ngữ kỹ thuật trên giao diện hiển thị mặc định bằng **tiếng Anh chuyên ngành chuẩn Enterprise (100% English)**, ngắn gọn, súc tích.
   - Giao tiếp, trao đổi và thảo luận với chủ dự án bằng tiếng Việt hoặc tiếng Anh theo ngữ cảnh người dùng yêu cầu.

2. **Chân thực & Chính xác về Dữ liệu (No Fake Numbers):**
   - Không được tạo số liệu ảo (fake data) hàng trăm nghìn view gây hiểu nhầm.
   - Dữ liệu lượt xem, phân tích truy cập được cấu hình tập trung tại `_data/traffic.yml` và được đối chiếu định kỳ với Google Analytics 4 (`G-PEG1CS8900`).
   - Tuyệt đối không để số liệu nhảy loạn xạ khi người dùng F5 hoặc refresh trang.

3. **Thiết kế Giao diện (UI/UX Standards):**
   - **Tối giản, chuyên nghiệp & tinh tế (Clean & Modern Azure Dashboard):** Tránh dùng icon màu mè hoặc emoji gây rối mắt trong các dashboard kỹ thuật; ưu tiên dùng SVG vector hoặc huy hiệu ký hiệu (badge pills: `7D`, `30D`, `1Y`, `ALL`).
   - **Không vỡ layout trên mobile và sidebar:** Cột sidebar trái có chiều rộng giới hạn, không dùng layout grid 2 cột quá hẹp gây đè chữ; ưu tiên dạng hàng ngang full-width (`display: flex; justify-content: space-between;`).
   - **Phòng chống lỗi cache (Cache-Busting):** Khi bổ sung hoặc sửa đổi các khối giao diện động quan trọng, nhúng style CSS cục bộ (scoped inline CSS) hoặc bổ sung timestamp cache-buster để trình duyệt người dùng không hiển thị layout cũ.

---

## 2. Quy Trình Đăng Bài Viết Mới (Post Publishing Workflow)

Khi người dùng gửi liên kết bài viết LinkedIn (dạng `https://lnkd.in/...` hoặc link bài viết trực tiếp):

1. **Thu thập thông tin bài viết:**
   - Resolve link rút gọn để lấy link LinkedIn gốc.
   - Tải ảnh infographic/thumbnail chất lượng cao về thư mục: `assets/images/posts/part-[XXX]-[slug].jpg`.
   - Trích xuất tiêu đề, nội dung, mã lệnh PowerShell/CMD, giải pháp và bài học SysAdmin.

2. **Tạo tệp bài viết Markdown:**
   - Đặt tại thư mục `_posts/` theo định dạng chuẩn Jekyll:  
     `_posts/YYYY-MM-DD-part-[XXX]-[slug].md`
   - **Frontmatter bắt buộc:**
     ```yaml
     ---
     layout: post
     title: "Windows Tips & Tricks – Part [XXX]: [Tên bài viết]"
     date: YYYY-MM-DD HH:mm:ss +0930
     categories: [SysAdmin, Active Directory] # hoặc chuyên mục phù hợp
     tags: ["Windows Server", "SysAdmin", "PowerShell", "Part-[XXX]", "WindowsTips", "ToanNguyenItOz"]
     image: /assets/images/posts/part-[XXX]-[slug].jpg
     linkedin_url: "https://www.linkedin.com/posts/..."
     description: "Mô tả ngắn gọn, súc tích chuẩn SEO (dưới 160 ký tự)."
     part: [XXX]
     ---
     ```

3. **Cấu trúc nội dung bài viết:**
   - Thẻ ghi chú đầu bài liên kết chuỗi kiến thức (`cmd-annotation-card`).
   - Hình ảnh bài viết rõ nét.
   - **Mục 1: Tình huống thực tế (Scenario Overview & Problem Context):** Nêu rõ vấn đề người dùng gặp phải.
   - **Mục 2: Giải pháp & Câu lệnh (Step-by-Step Solution & Code):** Khối mã lệnh PowerShell/CMD định dạng Rouge rõ ràng.
   - **Mục 3: Phân tích sâu / Pro Tip:** Lưu ý quản trị, xử lý ngoại lệ, FSMO role hoặc cấu hình cần thiết.
   - **Mục 4: Giá trị thực tiễn (Why It Matters):** Lợi ích đối với vận hành hệ thống IT doanh nghiệp.
   - **Mục 5: SysAdmin Mindset & Liên kết thảo luận:** Trích dẫn bài học cốt lõi và link thảo luận LinkedIn.

4. **Kiểm tra liên kết chuỗi (Series Navigation):**
   - Đảm bảo thuộc tính `part: [XXX]` để hệ thống tự động sinh nút điều hướng lùi/tiến liền mạch.

---

## 3. Quản Lý Tự Động Hóa & Workflows (GitHub Actions)

Hệ thống có 4 GitHub Actions tự động:
1. `fetch-vouchers.yml`: Tự động tìm kiếm, xác thực và làm mới 60 voucher khóa học công nghệ Udemy miễn phí định kỳ (chạy lúc 06:00 & 18:00 UTC).
2. `sync-youtube.yml`: Tự động đồng bộ các video hướng dẫn và Shorts mới nhất từ kênh YouTube `@ITSupportwithToan_Adl` vào `_data/videos.yml`.
3. `sync-linkedin.yml`: Đồng bộ bài viết và liên kết chia sẻ từ LinkedIn.
4. `weekly-newsletter.yml`: Tự động gửi email bản tin công nghệ tổng hợp hàng tuần vào thứ Hai qua dịch vụ Resend API.

**Quy tắc phối hợp Git khi làm việc:**
- Trước khi push bài viết mới hoặc sửa giao diện, **luôn luôn thực hiện `git pull --rebase origin main`** để tránh xung đột với các commit tự động từ GitHub Actions (`auto: update free course vouchers`, `auto: sync latest YouTube videos`).
- Sau khi push, kiểm tra trạng thái quy trình `pages build and deployment` để đảm bảo bài viết được xuất bản thành công không lỗi syntax.

---

## 4. Quản Lý Thống Kê Truy Cập (Traffic Telemetry)

- File cấu hình nguồn: `_data/traffic.yml`.
- Các chỉ số quản lý chính:
  - `last_7_days`: 7 ngày gần nhất (kèm % tăng trưởng).
  - `last_30_days`: 30 ngày gần nhất (kèm % tăng trưởng).
  - `last_1_year`: 1 năm qua (`365D`).
  - `total_all_time`: Tổng tích lũy (`ALL`).
  - `channels`: Tỉ trọng nguồn truy cập (Google %, LinkedIn %, Direct %).
- Khi có số liệu mới từ Google Analytics 4, cập nhật trực tiếp vào file này để website hiển thị đồng bộ.
