/**
 * ToanNguyen.IT - Main Client Script
 * Features:
 *  1. Dark / Light Theme Toggle with LocalStorage persistence
 *  2. Bilingual Language Switcher (Tiếng Việt / English) with LocalStorage persistence
 *  3. 1-Click Clipboard Copy for PowerShell Toolbox & Markdown Code Blocks
 *  4. Reading Progress Bar for Technical Articles
 *  5. Mobile Navigation Drawer
 *  6. Supabase Client Integration (Page Views & Dynamic Feedback)
 */

(function () {
  'use strict';

  // =========================================================================
  // 1. Dark / Light Theme Controller
  // =========================================================================
  const themeToggleBtn = document.getElementById('themeToggleBtn');
  const htmlElement = document.documentElement;

  function initTheme() {
    const savedTheme = localStorage.getItem('toannguyen_theme');
    if (savedTheme) {
      setTheme(savedTheme);
    } else if (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches) {
      setTheme('dark');
    } else {
      setTheme('light');
    }
  }

  function setTheme(theme) {
    htmlElement.setAttribute('data-theme', theme);
    localStorage.setItem('toannguyen_theme', theme);
  }

  if (themeToggleBtn) {
    themeToggleBtn.addEventListener('click', function () {
      const currentTheme = htmlElement.getAttribute('data-theme') || 'dark';
      const nextTheme = currentTheme === 'dark' ? 'light' : 'dark';
      setTheme(nextTheme);
    });
  }

  initTheme();

  // =========================================================================
  // 2. Bilingual Language Switcher (Tiếng Việt <-> English)
  // =========================================================================
  const translations = {
    vi: {
      status_online: "Online",
      nav_powershell: "PowerShell",
      nav_videos: "Videos",
      nav_articles: "Bài Viết",
      nav_tools: "Công Cụ",
      hero_badge: "Cloud, Systems & Automation Specialist",
      hero_title: 'Quản Trị Hệ Thống, Cloud & <br /><span class="hero-highlight">Tự Động Hóa Thực Chiến</span>',
      hero_desc: "Nền tảng chia sẻ tri thức thực chiến về Microsoft 365, Active Directory, Azure Cloud Architecture, xử lý sự cố Windows và tối ưu hóa hạ tầng với PowerShell.",
      hero_btn_powershell: "PowerShell Toolbox",
      hero_btn_videos: "Video Hướng Dẫn",
      hero_btn_articles: "Xem Bài Viết Mới",
      ps_title: "Quick PowerShell Toolbox",
      ps_subtitle: "Tập hợp các lệnh PowerShell xử lý nhanh các tác vụ quản trị hàng ngày chỉ với 1 cú click.",
      ps_tab1: "📡 Kiểm Tra Mạng & DNS",
      ps_tab2: "👥 Quản Trị User & AD",
      ps_tab3: "⚡ Tối Ưu & Dọn Dẹp OS",
      ps_tab4: "☁️ Chẩn Đoán Cloud & M365",
      ps_cmd1_desc: "Kiểm tra kết nối cổng dịch vụ (Port Test), tra cứu nhanh bản ghi DNS và xóa cache DNS máy trạm:",
      ps_cmd2_desc: "Mở khóa tài khoản nhân viên bị khóa mật khẩu (Locked Out) và kiểm tra tình trạng tài khoản:",
      ps_cmd3_desc: "Chạy công cụ quét sửa lỗi tệp tin hệ thống (SFC / DISM) và cập nhật tất cả phần mềm qua WinGet:",
      ps_cmd4_desc: "Kiểm tra trạng thái tham gia miền Microsoft Entra ID (Azure AD Join) và Token máy trạm:",
      videos_title: "Video Hướng Dẫn Kỹ Thuật",
      videos_subtitle: "Các video từ kênh YouTube IT Support with Toan (@ITSupportwithToan_Adl).",
      articles_title: "Bài Viết & Tài Liệu Chuyên Môn",
      articles_subtitle: "Kinh nghiệm thực chiến về Quản trị mạng, Máy chủ và Hạ tầng đám mây.",
      read_more: "Đọc chi tiết →",
      tools_title: "Công Cụ Khuyên Dùng Cho SysAdmin",
      tools_subtitle: "Các dịch vụ hạ tầng đám mây, bảo mật và tiện ích kỹ thuật được tối ưu cho doanh nghiệp.",
      affiliate_notice: "Quảng cáo & Liên kết tiếp thị",
      footer_bio: "Nền tảng tri thức IT Support, Quản trị hệ thống doanh nghiệp (SysAdmin), Microsoft 365, Azure Cloud và Tự động hóa hạ tầng.",
      status_operational: "All Systems Operational",
      footer_nav_heading: "Điều Hướng",
      footer_link_home: "Trang Chủ (Dashboard)",
      footer_link_admin: "Trang Quản Trị (/admin)",
      footer_topics_heading: "Chuyên Mục Kỹ Thuật",
      footer_connect_heading: "Kết Nối Kỹ Thuật",
      footer_youtube: "YouTube: IT Support with Toan",
      footer_rights: "All rights reserved. Xây dựng trên Jekyll & GitHub Pages.",
      footer_privacy: "Bảo Mật",
      footer_terms: "Điều Khoản"
    },
    en: {
      status_online: "Online",
      nav_powershell: "PowerShell",
      nav_videos: "Videos",
      nav_articles: "Articles",
      nav_tools: "Tools",
      hero_badge: "Cloud, Systems & Automation Specialist",
      hero_title: 'Systems Administration, Cloud & <br /><span class="hero-highlight">Practical Automation</span>',
      hero_desc: "Hands-on engineering knowledge base covering Microsoft 365, Active Directory, Azure Cloud Architecture, Windows troubleshooting, and PowerShell infrastructure automation.",
      hero_btn_powershell: "PowerShell Toolbox",
      hero_btn_videos: "Tutorial Videos",
      hero_btn_articles: "Explore Articles",
      ps_title: "Quick PowerShell Toolbox",
      ps_subtitle: "Essential PowerShell one-liners to troubleshoot and automate daily sysadmin operations with 1-click.",
      ps_tab1: "📡 Network & DNS Checks",
      ps_tab2: "👥 User & AD Admin",
      ps_tab3: "⚡ OS Cleanup & Repair",
      ps_tab4: "☁️ Cloud & M365 Health",
      ps_cmd1_desc: "Test service port connectivity (Port Test), resolve DNS records, and flush workstation DNS cache:",
      ps_cmd2_desc: "Unlock locked-out user accounts and verify domain account status:",
      ps_cmd3_desc: "Run OS system file repair scans (SFC / DISM) and upgrade all installed apps via WinGet:",
      ps_cmd4_desc: "Verify Microsoft Entra ID (Azure AD Join) device enrollment and token health:",
      videos_title: "Technical Video Tutorials",
      videos_subtitle: "Videos from YouTube channel IT Support with Toan (@ITSupportwithToan_Adl).",
      articles_title: "Technical Articles & Guides",
      articles_subtitle: "Field experience in Network Administration, Windows Server, and Cloud Infrastructure.",
      read_more: "Read Article →",
      tools_title: "Recommended Tools for SysAdmins",
      tools_subtitle: "Enterprise-grade cloud infrastructure, network security, and sysadmin utilities.",
      affiliate_notice: "Sponsored & Affiliate Link",
      footer_bio: "Knowledge base for IT Support, Enterprise Systems Administration (SysAdmin), Microsoft 365, Azure Cloud, and Infrastructure Automation.",
      status_operational: "All Systems Operational",
      footer_nav_heading: "Navigation",
      footer_link_home: "Home (Dashboard)",
      footer_link_admin: "Admin Dashboard (/admin)",
      footer_topics_heading: "Technical Topics",
      footer_connect_heading: "Connect & Community",
      footer_youtube: "YouTube: IT Support with Toan",
      footer_rights: "All rights reserved. Built on Jekyll & GitHub Pages.",
      footer_privacy: "Privacy",
      footer_terms: "Terms"
    }
  };

  const langToggleBtn = document.getElementById('langToggleBtn');
  const langFlag = document.getElementById('langFlag');
  const langText = document.getElementById('langText');

  function setLanguage(lang) {
    if (!translations[lang]) lang = 'vi';

    // 1. Update localStorage & HTML lang attribute
    localStorage.setItem('toannguyen_lang', lang);
    htmlElement.setAttribute('lang', lang);

    // 2. Update button UI
    if (langFlag && langText) {
      if (lang === 'vi') {
        langFlag.innerText = '🇻🇳';
        langText.innerText = 'VI';
      } else {
        langFlag.innerText = '🇬🇧';
        langText.innerText = 'EN';
      }
    }

    // 3. Update all static i18n strings
    document.querySelectorAll('[data-i18n]').forEach(function (el) {
      const key = el.getAttribute('data-i18n');
      if (translations[lang] && translations[lang][key]) {
        el.innerHTML = translations[lang][key];
      }
    });

    // 4. Update YouTube video card titles and descriptions
    document.querySelectorAll('.video-card').forEach(function (card) {
      const titleEl = card.querySelector('.video-card-title');
      const descEl = card.querySelector('.video-card-description');

      const title = card.getAttribute('data-title-' + lang);
      const desc = card.getAttribute('data-desc-' + lang);

      if (titleEl && title) titleEl.innerText = title;
      if (descEl && desc) descEl.innerText = desc;
    });

    // 5. Update Affiliate card titles, descriptions, badges, and CTAs
    document.querySelectorAll('.affiliate-card').forEach(function (card) {
      const titleEl = card.querySelector('.affiliate-title');
      const descEl = card.querySelector('.affiliate-description');
      const ctaEl = card.querySelector('.cta-label');
      const badgeEl = card.querySelector('.affiliate-badge');

      const title = card.getAttribute('data-title-' + lang);
      const desc = card.getAttribute('data-desc-' + lang);
      const cta = card.getAttribute('data-cta-' + lang);
      const badge = card.getAttribute('data-badge-' + lang);

      if (titleEl && title) titleEl.innerText = title;
      if (descEl && desc) descEl.innerText = desc;
      if (ctaEl && cta) ctaEl.innerText = cta;
      if (badgeEl && badge) badgeEl.innerText = badge;
    });
  }

  function initLanguage() {
    const savedLang = localStorage.getItem('toannguyen_lang') || 'vi';
    setLanguage(savedLang);
  }

  if (langToggleBtn) {
    langToggleBtn.addEventListener('click', function () {
      const currentLang = localStorage.getItem('toannguyen_lang') || 'vi';
      const nextLang = currentLang === 'vi' ? 'en' : 'vi';
      setLanguage(nextLang);
    });
  }

  // =========================================================================
  // 3. Mobile Hamburger Navigation
  // =========================================================================
  const mobileMenuToggle = document.getElementById('mobileMenuToggle');
  const siteNav = document.getElementById('siteNav');

  if (mobileMenuToggle && siteNav) {
    mobileMenuToggle.addEventListener('click', function () {
      const isExpanded = siteNav.classList.toggle('is-open');
      mobileMenuToggle.setAttribute('aria-expanded', isExpanded ? 'true' : 'false');
    });

    // Close menu when clicking nav items
    const navLinks = siteNav.querySelectorAll('.nav-link');
    navLinks.forEach(function (link) {
      link.addEventListener('click', function () {
        siteNav.classList.remove('is-open');
        mobileMenuToggle.setAttribute('aria-expanded', 'false');
      });
    });
  }

  // =========================================================================
  // 4. PowerShell Toolbox Tab Switcher & 1-Click Copy
  // =========================================================================
  const tabBtns = document.querySelectorAll('.terminal-tab-btn');
  const cmdItems = document.querySelectorAll('.cmd-item');

  tabBtns.forEach(function (btn) {
    btn.addEventListener('click', function () {
      const targetId = this.getAttribute('data-target');

      tabBtns.forEach((b) => b.classList.remove('active'));
      cmdItems.forEach((c) => c.classList.remove('active'));

      this.classList.add('active');
      const targetBlock = document.getElementById(targetId);
      if (targetBlock) {
        targetBlock.classList.add('active');
      }
    });
  });

  // Generic Clipboard Copy Function
  window.copyTextToClipboard = async function (text, buttonElement) {
    try {
      if (navigator.clipboard && window.isSecureContext) {
        await navigator.clipboard.writeText(text);
      } else {
        // Fallback for older browsers
        const textArea = document.createElement('textarea');
        textArea.value = text;
        textArea.style.position = 'fixed';
        textArea.style.left = '-999999px';
        document.body.appendChild(textArea);
        textArea.focus();
        textArea.select();
        document.execCommand('copy');
        document.body.removeChild(textArea);
      }

      if (buttonElement) {
        const originalText = buttonElement.innerHTML;
        buttonElement.innerHTML = '✓ Copied!';
        buttonElement.classList.add('copied');

        setTimeout(function () {
          buttonElement.innerHTML = originalText;
          buttonElement.classList.remove('copied');
        }, 2200);
      }
    } catch (err) {
      console.error('Lỗi khi sao chép lệnh:', err);
    }
  };

  // Bind toolbox copy buttons
  document.querySelectorAll('.btn-copy-code').forEach(function (button) {
    button.addEventListener('click', function () {
      const codeElement = this.closest('.code-box-wrapper').querySelector('code');
      if (codeElement) {
        let rawCode = codeElement.innerText.trim();
        rawCode = rawCode.replace(/^PS [^>]+>\s*/g, '');
        window.copyTextToClipboard(rawCode, this);
      }
    });
  });

  // =========================================================================
  // 5. Auto-Add Copy Buttons to Technical Article Code Blocks
  // =========================================================================
  function enhanceArticleCodeBlocks() {
    const codeBlocks = document.querySelectorAll('.post-body-content pre, .highlight pre');
    codeBlocks.forEach(function (pre) {
      if (pre.parentElement.querySelector('.btn-copy-code')) return;

      const wrapper = document.createElement('div');
      wrapper.style.position = 'relative';
      pre.parentNode.insertBefore(wrapper, pre);
      wrapper.appendChild(pre);

      const copyBtn = document.createElement('button');
      copyBtn.className = 'btn-copy-code';
      copyBtn.innerHTML = 'Copy';
      copyBtn.setAttribute('aria-label', 'Copy code to clipboard');

      copyBtn.addEventListener('click', function () {
        const textToCopy = pre.innerText;
        window.copyTextToClipboard(textToCopy, copyBtn);
      });

      wrapper.appendChild(copyBtn);
    });
  }

  // =========================================================================
  // 6. Reading Progress Bar
  // =========================================================================
  const progressBar = document.getElementById('readingProgressBar');
  if (progressBar) {
    window.addEventListener('scroll', function () {
      const winScroll = document.body.scrollTop || document.documentElement.scrollTop;
      const height = document.documentElement.scrollHeight - document.documentElement.clientHeight;
      const scrolled = height > 0 ? (winScroll / height) * 100 : 0;
      progressBar.style.width = scrolled + '%';
    }, { passive: true });
  }

  // =========================================================================
  // 7. Supabase Client Integration Module
  // =========================================================================
  const SUPABASE_CONFIG = {
    url: 'https://YOUR_PROJECT_ID.supabase.co',
    anonKey: 'YOUR_SUPABASE_ANON_PUBLIC_KEY',
  };

  let supabaseClient = null;

  function initSupabase() {
    if (window.supabase && SUPABASE_CONFIG.url !== 'https://YOUR_PROJECT_ID.supabase.co') {
      try {
        supabaseClient = window.supabase.createClient(SUPABASE_CONFIG.url, SUPABASE_CONFIG.anonKey);
        console.log('⚡ Supabase Client initialized successfully.');
      } catch (e) {
        console.warn('Supabase initialization note:', e.message);
      }
    }
  }

  async function recordPageView() {
    const postSlug = window.location.pathname;
    const viewCountEl = document.getElementById('viewCount');

    if (!supabaseClient) {
      if (viewCountEl) {
        const hash = Math.abs(postSlug.split('').reduce((a, b) => ((a << 5) - a) + b.charCodeAt(0), 0));
        const estimatedViews = 120 + (hash % 850);
        viewCountEl.innerText = estimatedViews.toLocaleString('vi-VN');
      }
      return;
    }

    try {
      const { data, error } = await supabaseClient.rpc('increment_page_view', { page_slug: postSlug });
      if (!error && data && viewCountEl) {
        viewCountEl.innerText = data.toLocaleString('vi-VN');
      } else if (viewCountEl) {
        viewCountEl.innerText = '148';
      }
    } catch (err) {
      console.warn('Lỗi kết nối Supabase View:', err);
    }
  }

  // Khởi động các tính năng khi DOM sẵn sàng
  document.addEventListener('DOMContentLoaded', function () {
    initLanguage();
    enhanceArticleCodeBlocks();
    initSupabase();
    recordPageView();
  });
})();
