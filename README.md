# ToanNguyen.IT | Systems Administration & Cloud Engineering Website

Website cá nhân và nền tảng tri thức chuyên sâu về **IT Support, Quản trị hệ thống Windows/Linux, Microsoft 365, Azure Cloud và Tự động hóa với PowerShell** của người dùng **toannguyenitoz**.

- **URL chính thức:** [https://toannguyenitoz.github.io](https://toannguyenitoz.github.io)
- **Hệ thống Quản trị Nội dung (CMS):** [https://toannguyenitoz.github.io/admin](https://toannguyenitoz.github.io/admin)
- **Kiến trúc:** Static Site Generator (Jekyll) + GitHub Pages (Chi phí máy chủ $0).

---

## 🚀 Các Tính Năng Nổi Bật

1. **Giao diện Tech Modern Dashboard (Azure Cloud Style):**
   - Hỗ trợ đầy đủ 2 chế độ **Light** (#F8FAFC, #0078D4) và **Dark** (#090D16, #38BDF8).
   - Header kính mờ (Glassmorphism) với đèn trạng thái xung nhịp động (`● Online`).
   - Footer 4 cột chuẩn Enterprise Cloud Console với hiển thị trạng thái hệ thống (`● All Systems Operational`).

2. **Quick PowerShell Toolbox:**
   - Hộp lệnh mô phỏng giao diện Windows Terminal chuyên nghiệp.
   - Sao chép lệnh 1-chạm (1-Click Copy) chuyển đổi hiệu ứng `✓ Copied!`.

3. **Decap CMS Trực Quan (`/admin`):**
   - Đăng nhập xác thực với tài khoản GitHub.
   - Quản lý bài viết blog kỹ thuật, danh sách video YouTube và liên kết Affiliate trực tiếp trên giao diện web trực quan mà không cần gõ lệnh Git.

4. **YouTube Showcase Tối Ưu PageSpeed:**
   - Tỷ lệ chuẩn 16:9 responsive, chế độ bảo mật `youtube-nocookie.com` và Lazy Loading.

5. **Affiliate Cards Hợp Chuẩn:**
   - Các khối CTA giới thiệu công cụ kỹ thuật tuân thủ tiêu chuẩn Google SEO (`rel="nofollow sponsored"`).

6. **Tích hợp Sẵn Supabase Backend:**
   - Bộ khung kết nối Supabase JS client v2 tại `assets/js/main.js` sẵn sàng theo dõi lượt xem và nhận phản hồi từ người đọc.

---

## 🛠️ Hướng Dẫn Đẩy Lên GitHub & Kích Hoạt

### 1. Khởi tạo Git và Commit
Mở Terminal tại thư mục này và chạy:

```bash
git init
git add .
git commit -m "feat: initial commit for toannguyenitoz.github.io"
git branch -M main
git remote add origin https://github.com/toannguyenitoz/toannguyenitoz.github.io.git
git push -u origin main
```

### 2. Bật GitHub Pages
1. Vào mục **Settings** của repository trên GitHub.
2. Chọn menu **Pages** bên tay trái.
3. Dưới mục **Build and deployment**:
   - Source: **Deploy from a branch**
   - Branch: `main` / Folder: `/ (root)`
4. Nhấn **Save**. Sau khoảng 1-2 phút, trang web sẽ chính thức hoạt động tại `https://toannguyenitoz.github.io`.
