# Project Summary & Milestone Tracker

> **Project:** Toan Nguyen IT Oz Website Portal (`toannguyenitoz.github.io`)  
> **Repository:** `https://github.com/toannguyenitoz/toannguyenitoz.github.io`  
> **Last Updated:** September 19, 2026  
> **Platform:** Jekyll on GitHub Pages, Supabase, Resend API, GitHub Actions

---

## 1. Tổng Quan Dự Án (Executive Summary)

Trang web **Toan Nguyen IT Oz** là cổng thông tin chuyên ngành Quản trị Hệ thống (Systems Administration), Điện toán Đám mây (Cloud Computing - Azure/M365) và Tự động hóa PowerShell thực chiến, được phát triển bởi **Toan Nguyen** (Adelaide, Nam Úc).

Website kết hợp 3 trụ cột giá trị cốt lõi:
1. **Learn:** Hơn 135 bài viết chuyên sâu dạng Standard Operating Procedure (SOP) và chuỗi *Windows Tips & Tricks* (giai đoạn Phase 3: Công cụ SysAdmin).
2. **Build:** Trung tâm lệnh tự động hóa PowerShell Hub (`/powershell/`) với 100 script thực chiến cho vận hành doanh nghiệp.
3. **Share:** Hệ sinh thái video thực hành từ kênh YouTube `@ITSupportwithToan_Adl`, chuyên mục khóa học công nghệ miễn phí (`/courses/`) và bản tin tự động hàng tuần (Weekly Tech Dispatch).

---

## 2. Các Hạng Mục ĐÃ Hoàn Thành (Completed Milestones)

### 2.1. Cấu Trúc & Giao Diện Tổng Thể (UI/UX & Portal Redesign)
- [x] **Thiết kế giao diện hiện đại phong cách Azure Tech Dashboard:**
  - Hỗ trợ đầy đủ Dark Mode / Light Mode với bộ màu chuẩn Azure (`#0078D4`, `#38BDF8`, Dark Slate).
  - Tối ưu hóa layout 3 cột linh hoạt trên trang chủ (Left Sidebar, Center Articles Feed, Right Sidebar Videos & Contact).
- [x] **Thẻ Thông Tin Tác Giả & Kết Nối (Contact & Connect):**
  - Hiển thị avatar, chức danh, địa điểm Adelaide, nút kết nối nhanh LinkedIn và đăng ký kênh YouTube.
- [x] **Khối Phân Tích Lượng Truy Cập (Traffic Analytics Card):**
  - Chuyển đổi 100% sang tiếng Anh chuyên ngành chuẩn Enterprise.
  - Tối ưu bố cục hàng ngang (Full-width Horizontal Rows), không bị co kéo hay vỡ layout trên thiết bị di động.
  - Tích hợp ký hiệu biểu tượng hiện đại (`7D`, `30D`, `1Y`, `ALL`) thay thế các cụm chữ dài dòng.
  - Tách bạch cấu hình nguồn vào `_data/traffic.yml` gắn liền với Google Analytics 4 (`G-PEG1CS8900`).
  - Khắc phục triệt để hiện tượng số nhảy loạn khi F5 và phòng chống cache CSS trên trình duyệt.

### 2.2. Nội Dung & Chuỗi Bài Viết Thực Chiến (Content & Series)
- [x] **Xuất bản tổng cộng 135 bài viết SOP kỹ thuật:**
  - Các bài viết nền tảng: Active Directory, Entra ID, Windows Server, Group Policy, Network Troubleshooting, BitLocker.
- [x] **Chuỗi LinkedIn Windows Tips & Tricks (Phase 3: SysAdmin Tools):**
  - **Part 101:** Quản trị server từ xa không cần RDP (`Enter-PSSession`, WinRM).
  - **Part 102:** Điều tra nguyên nhân server khởi động lại (Event ID 1074, 6008, 41).
  - **Part 103:** Ép đóng file bị khóa trên ổ đĩa mạng chia sẻ (`Get-SmbOpenFile`, `Close-SmbOpenFile`).
  - **Part 104:** Khai thác Administrative Shares ẩn (`C$`, `Admin$`).
  - **Part 106:** Kiểm tra hàng loạt Uptime máy chủ sau bảo trì (`Get-CimInstance Win32_OperatingSystem`).
  - **Part 107:** Truy tìm nguồn gốc khóa tài khoản AD tự động (Event ID 4740 trên PDC Emulator).
  - **Part 108:** Kiểm tra và xuất báo cáo Group Policy từ xa (`gpresult /S /USER /H`).
  - **Part 110:** Xử lý lệch thời gian gây lỗi xác thực Kerberos và Access Denied (`w32tm /stripchart`, `Invoke-Command w32tm /resync`).
- [x] **Hệ thống điều hướng chuỗi bài thông minh (Sequential Series Navigation):**
  - Tự động sinh thanh điều hướng lùi/tiến giữa các phần liên tiếp (Ví dụ: từ Part 107 sang 108, từ 108 sang 110).

### 2.3. Hệ Thống Tự Động Hóa (CI/CD & Automation Workflows)
- [x] **GitHub Actions Workflow `fetch-vouchers.yml`:** Tự động lấy, lọc và cập nhật 60 voucher khóa học Udemy miễn phí còn hạn mỗi ngày.
- [x] **GitHub Actions Workflow `sync-youtube.yml`:** Tự động quét và đồng bộ các video hướng dẫn mới nhất từ YouTube vào website.
- [x] **GitHub Actions Workflow `sync-linkedin.yml`:** Đồng bộ các cập nhật và chia sẻ kỹ thuật từ LinkedIn.
- [x] **GitHub Actions Workflow `weekly-newsletter.yml`:** Tự động tạo và gửi email tóm tắt tin công nghệ và bài viết mới vào sáng thứ Hai qua Resend API.

---

## 3. Các Hạng Mục ĐANG Triển Khai (In-Progress)

1. **Chuẩn hóa Bộ Quy Tắc Dự Án & Hồ Sơ Quản Trị:**
   - Hoàn thiện `PROJECT_RULES.md` làm kim chỉ nam phát triển, đồng bộ quy trình đăng bài và chuẩn mực giao diện.
   - Hoàn thiện `SUMMARY.md` theo dõi tiến độ và các mốc thời gian thực hiện.
2. **Cập nhật đều đặn các phần tiếp theo của Series Windows Tips & Tricks:**
   - Tiếp tục đăng tải các bài viết mới từ LinkedIn (Part 109, Part 111+) khi hoàn thành.
3. **Theo dõi và duy trì độ chính xác của số liệu Google Analytics 4:**
   - Định kỳ cập nhật các số liệu thực tế từ dashboard GA4 vào `_data/traffic.yml`.

---

## 4. Kế Hoạch Tiếp Theo (Roadmap & Upcoming Tasks)

- [ ] **Mở rộng trung tâm PowerShell Hub:** Bổ sung thêm các module kịch bản tự động hóa chuyên sâu cho Microsoft Intune MDM và Microsoft 365 Security.
- [ ] **Tối ưu hóa SEO & Rich Results:** Bổ sung JSON-LD Schema dạng HowTo và TechnicalArticle cho toàn bộ các bài viết trong series.
- [ ] **Bổ sung tính năng Search nâng cao:** Nâng cấp bộ lọc tìm kiếm tức thời trên trang danh sách bài viết `/articles/`.
- [ ] **Tối ưu hóa thời gian tải trang:** Nén ảnh tự động và nâng cao điểm hiệu năng Google PageSpeed Insights.
