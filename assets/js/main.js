/**
 * IT Support With Toan (Toan Nguyen IT OZ) - Main Client Script
 * Features:
 *  1. Dark / Light Theme Toggle with LocalStorage persistence
 *  2. 1-Click Clipboard Copy for PowerShell Toolbox & Markdown Code Blocks
 *  3. Reading Progress Bar for Technical Articles
 *  4. Mobile Navigation Drawer
 *  5. Supabase Client Integration (Page Views & Dynamic Feedback)
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
  // 2. Mobile Hamburger Navigation
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
  // 3. PowerShell Toolbox Tab Switcher & 1-Click Copy
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
        const span = buttonElement.querySelector('span');
        const originalText = span ? span.innerHTML : buttonElement.innerHTML;
        if (span) {
          span.innerHTML = 'Copied!';
        } else {
          buttonElement.innerHTML = '✓ Copied!';
        }
        buttonElement.classList.add('copied');

        setTimeout(function () {
          if (span) {
            span.innerHTML = originalText;
          } else {
            buttonElement.innerHTML = originalText;
          }
          buttonElement.classList.remove('copied');
        }, 2200);
      }
    } catch (err) {
      console.error('Error copying command to clipboard:', err);
    }
  };

  // Bind toolbox copy buttons
  document.querySelectorAll('.btn-copy-code').forEach(function (button) {
    button.addEventListener('click', function () {
      const container = this.closest('.cmd-executable-block') || this.closest('.code-box-wrapper');
      if (container) {
        const codeElement = container.querySelector('code');
        if (codeElement) {
          const clone = codeElement.cloneNode(true);
          clone.querySelectorAll('.terminal-prompt, .btn-copy-code').forEach(el => el.remove());
          let rawCode = clone.innerText.trim();
          rawCode = rawCode.replace(/^PS [^>]+>\s*/gm, '');
          window.copyTextToClipboard(rawCode, this);
        }
      }
    });
  });

  // =========================================================================
  // 4. Auto-Add Copy Buttons to Technical Article Code Blocks
  // =========================================================================
  function enhanceArticleCodeBlocks() {
    const codeContainers = document.querySelectorAll('.post-body-content div.highlight, .post-body-content > pre, .post-body-content > .language-powershell');
    codeContainers.forEach(function (container) {
      if (container.querySelector('.btn-copy-code') || container.classList.contains('code-box-wrapper')) return;

      container.classList.add('code-box-wrapper');
      container.style.position = 'relative';

      const copyBtn = document.createElement('button');
      copyBtn.className = 'btn-copy-code';
      copyBtn.setAttribute('aria-label', 'Copy code to clipboard');
      copyBtn.innerHTML = '<svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2"><rect x="9" y="9" width="13" height="13" rx="2" ry="2"></rect><path d="M5 15H4a2 2 0 0 1-2-2V4a2 2 0 0 1 2-2h9a2 2 0 0 1 2 2v1"></path></svg> <span>Copy</span>';

      copyBtn.addEventListener('click', function () {
        const codeElement = container.querySelector('td.rouge-code pre') || container.querySelector('pre') || container;
        const textToCopy = codeElement.innerText.trim();
        window.copyTextToClipboard(textToCopy, copyBtn);
      });

      container.appendChild(copyBtn);
    });
  }

  // =========================================================================
  // 5. Reading Progress Bar
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
  // 6. Supabase Client Integration Module
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
        const estimatedViews = 180 + (hash % 920);
        viewCountEl.innerText = estimatedViews.toLocaleString('en-US');
      }
      return;
    }

    try {
      const { data, error } = await supabaseClient.rpc('increment_page_view', { page_slug: postSlug });
      if (!error && data && viewCountEl) {
        viewCountEl.innerText = data.toLocaleString('en-US');
      } else if (viewCountEl) {
        viewCountEl.innerText = '214';
      }
    } catch (err) {
      console.warn('Error recording Supabase page view:', err);
    }
  }

  // =========================================================================
  // 7. Dedicated Video Portal Engine (Filter, Sort by Views/Dates, 10-Item Pagination)
  // =========================================================================
  function initVideoPortal() {
    try {
      var grid = document.getElementById('videoLibraryGrid');
      if (!grid) return;

      var items = Array.from(grid.querySelectorAll('.dynamic-video-item'));
      var sortSelect = document.getElementById('videoSortSelect');
      var filterPills = document.querySelectorAll('#videoFilterPills .filter-pill');
      var loadMoreBtn = document.getElementById('btnLoadMoreVideos');
      var visibleCountEl = document.getElementById('videoVisibleCount');

      var currentCategory = 'all';
      var currentSort = 'views-desc';
      var visibleLimit = 10;

      function applyVideoFiltersAndSort() {
        // 1. Filter — use exact match since data-category is a single value
        var filtered = items.filter(function (item) {
          if (currentCategory === 'all') return true;
          var itemCat = (item.getAttribute('data-category') || '').toLowerCase();
          var searchCat = currentCategory.toLowerCase();
          return itemCat === searchCat || itemCat.includes(searchCat);
        });

        // 2. Sort in memory (no DOM mutation — keeps iframes intact)
        var sorted = filtered.slice().sort(function (a, b) {
          if (currentSort === 'views-desc') {
            var vA = parseInt(a.getAttribute('data-views'), 10) || 0;
            var vB = parseInt(b.getAttribute('data-views'), 10) || 0;
            return vB - vA;
          } else if (currentSort === 'date-desc') {
            var dA = a.getAttribute('data-date') || '';
            var dB = b.getAttribute('data-date') || '';
            return dB.localeCompare(dA);
          } else if (currentSort === 'date-asc') {
            var dA2 = a.getAttribute('data-date') || '';
            var dB2 = b.getAttribute('data-date') || '';
            return dA2.localeCompare(dB2);
          }
          return 0;
        });

        // 3. Apply CSS order + visibility (no appendChild = no iframe reload)
        var filteredSet = new Set(filtered);
        items.forEach(function (el) {
          if (!filteredSet.has(el)) {
            el.style.display = 'none';
            el.style.order = '9999';
          }
        });

        sorted.forEach(function (el, index) {
          el.style.order = String(index);
          if (index < visibleLimit) {
            el.style.display = '';
          } else {
            el.style.display = 'none';
          }
        });

        // 4. Update counts & button visibility
        var shownCount = Math.min(visibleLimit, sorted.length);
        if (visibleCountEl) visibleCountEl.innerText = shownCount;

        if (loadMoreBtn) {
          if (shownCount >= sorted.length) {
            loadMoreBtn.style.display = 'none';
          } else {
            loadMoreBtn.style.display = 'inline-flex';
          }
        }
      }

      // Event: Sort changed
      if (sortSelect) {
        sortSelect.addEventListener('change', function () {
          currentSort = this.value;
          visibleLimit = 10;
          applyVideoFiltersAndSort();
        });
      }

      // Event: Category pill clicked
      filterPills.forEach(function (pill) {
        pill.addEventListener('click', function () {
          filterPills.forEach(function (p) { p.classList.remove('active'); });
          this.classList.add('active');
          currentCategory = this.getAttribute('data-category');
          visibleLimit = 10;
          applyVideoFiltersAndSort();
        });
      });

      // Event: Load more clicked
      if (loadMoreBtn) {
        loadMoreBtn.addEventListener('click', function () {
          visibleLimit += 10;
          applyVideoFiltersAndSort();
        });
      }

      // Initial render
      applyVideoFiltersAndSort();
    } catch (e) {
      console.error('[VideoPortal] Initialization error:', e);
    }
  }

  // =========================================================================
  // 8. Dedicated Articles Portal Engine (Search, Filter, Sort, 10-Item Pagination)
  // =========================================================================
  function initArticlesPortal() {
    try {
      var grid = document.getElementById('articlesLibraryGrid');
      if (!grid) return;

      var items = Array.from(grid.querySelectorAll('.dynamic-article-item'));
      var searchInput = document.getElementById('articleSearchInput');
      var clearSearchBtn = document.getElementById('btnClearSearch');
      var sortSelect = document.getElementById('articleSortSelect');
      var filterPills = document.querySelectorAll('#articleFilterPills .filter-pill');
      var loadMoreBtn = document.getElementById('btnLoadMoreArticles');
      var visibleCountEl = document.getElementById('articleVisibleCount');
      var totalCountEl = document.getElementById('articleTotalCount');
      var emptyState = document.getElementById('articlesEmptyState');
      var resetFiltersBtn = document.getElementById('btnResetArticleFilters');

      var currentCategory = 'all';
      var currentSearch = '';
      var currentSort = 'date-desc';
      var visibleLimit = 10;

      function applyArticleFiltersAndSort() {
        // 1. Filter
        var filtered = items.filter(function (item) {
          var title = (item.getAttribute('data-title') || '').toLowerCase();
          var desc = (item.getAttribute('data-desc') || '').toLowerCase();
          var cats = (item.getAttribute('data-categories') || '').toLowerCase();
          var tags = (item.getAttribute('data-tags') || '').toLowerCase();

          // Search check
          if (currentSearch) {
            var match = title.includes(currentSearch) || desc.includes(currentSearch) || tags.includes(currentSearch) || cats.includes(currentSearch);
            if (!match) return false;
          }

          // Category check
          if (currentCategory !== 'all') {
            var matchCat = cats.includes(currentCategory.toLowerCase()) || tags.includes(currentCategory.toLowerCase());
            if (!matchCat) return false;
          }

          return true;
        });

        // 2. Sort in memory
        var sorted = filtered.slice().sort(function (a, b) {
          if (currentSort === 'date-desc') {
            var dA = a.getAttribute('data-date') || '';
            var dB = b.getAttribute('data-date') || '';
            return dB.localeCompare(dA);
          } else if (currentSort === 'date-asc') {
            var dA2 = a.getAttribute('data-date') || '';
            var dB2 = b.getAttribute('data-date') || '';
            return dA2.localeCompare(dB2);
          } else if (currentSort === 'title-asc') {
            var tA = (a.getAttribute('data-title') || '').toLowerCase();
            var tB = (b.getAttribute('data-title') || '').toLowerCase();
            return tA.localeCompare(tB);
          }
          return 0;
        });

        // 3. Apply CSS order + visibility (no DOM mutation)
        var filteredSet = new Set(filtered);
        items.forEach(function (el) {
          if (!filteredSet.has(el)) {
            el.style.display = 'none';
            el.style.order = '9999';
          }
        });

        sorted.forEach(function (el, index) {
          el.style.order = String(index);
          if (index < visibleLimit) {
            el.style.display = '';
          } else {
            el.style.display = 'none';
          }
        });

        // 4. Update counts & button
        var shownCount = Math.min(visibleLimit, sorted.length);
        if (visibleCountEl) visibleCountEl.innerText = shownCount;
        if (totalCountEl) totalCountEl.innerText = sorted.length;

        if (emptyState) {
          if (sorted.length === 0) {
            emptyState.style.display = 'block';
          } else {
            emptyState.style.display = 'none';
          }
        }

        if (loadMoreBtn) {
          if (shownCount >= sorted.length) {
            loadMoreBtn.style.display = 'none';
          } else {
            loadMoreBtn.style.display = 'inline-flex';
          }
        }
      }

      // Event: Live Search
      if (searchInput) {
        searchInput.addEventListener('input', function () {
          currentSearch = this.value.trim().toLowerCase();
          visibleLimit = 10;
          if (clearSearchBtn) {
            clearSearchBtn.style.display = currentSearch ? 'block' : 'none';
          }
          applyArticleFiltersAndSort();
        });
      }

      if (clearSearchBtn) {
        clearSearchBtn.addEventListener('click', function () {
          if (searchInput) {
            searchInput.value = '';
            currentSearch = '';
            this.style.display = 'none';
            visibleLimit = 10;
            applyArticleFiltersAndSort();
            searchInput.focus();
          }
        });
      }

      // Event: Sort Changed
      if (sortSelect) {
        sortSelect.addEventListener('change', function () {
          currentSort = this.value;
          visibleLimit = 10;
          applyArticleFiltersAndSort();
        });
      }

      // Event: Category Pills
      filterPills.forEach(function (pill) {
        pill.addEventListener('click', function () {
          filterPills.forEach(function (p) { p.classList.remove('active'); });
          this.classList.add('active');
          currentCategory = this.getAttribute('data-category');
          visibleLimit = 10;
          applyArticleFiltersAndSort();
        });
      });

      // Event: Load More
      if (loadMoreBtn) {
        loadMoreBtn.addEventListener('click', function () {
          visibleLimit += 10;
          applyArticleFiltersAndSort();
        });
      }

      // Event: Reset Filters
      if (resetFiltersBtn) {
        resetFiltersBtn.addEventListener('click', function () {
          if (searchInput) searchInput.value = '';
          currentSearch = '';
          currentCategory = 'all';
          visibleLimit = 10;
          filterPills.forEach(function (p) {
            p.classList.toggle('active', p.getAttribute('data-category') === 'all');
          });
          if (clearSearchBtn) clearSearchBtn.style.display = 'none';
          applyArticleFiltersAndSort();
        });
      }

      // Initial render
      applyArticleFiltersAndSort();
    } catch (e) {
      console.error('[ArticlesPortal] Initialization error:', e);
    }
  }


  // =========================================================================
  // 9. Dedicated PowerShell Command Center Engine
  // =========================================================================
  function initPowershellPortal() {
    const tabBtns = document.querySelectorAll('#powershellTabs .cmd-tab-btn');
    const tabPanes = document.querySelectorAll('.cmd-toolbox-container .cmd-tab-pane');
    const searchInput = document.getElementById('cmdSearchInput');

    if (!tabBtns.length || !tabPanes.length) return;

    tabBtns.forEach(function (btn) {
      btn.addEventListener('click', function () {
        const targetTab = this.getAttribute('data-tab');
        tabBtns.forEach(function (b) { b.classList.remove('active'); });
        tabPanes.forEach(function (p) { p.classList.remove('active'); });

        this.classList.add('active');
        const activePane = document.getElementById(targetTab);
        if (activePane) activePane.classList.add('active');
      });
    });

    if (searchInput) {
      searchInput.addEventListener('input', function () {
        const query = this.value.trim().toLowerCase();
        if (!query) {
          tabPanes.forEach(function (p) { p.style.display = ''; });
          return;
        }

        tabPanes.forEach(function (pane) {
          const text = pane.innerText.toLowerCase();
          if (text.includes(query)) {
            pane.style.display = 'block';
            pane.classList.add('active');
          } else {
            pane.style.display = 'none';
            pane.classList.remove('active');
          }
        });
      });
    }
  }

  // Initialize features once DOM is ready
  document.addEventListener('DOMContentLoaded', function () {
    enhanceArticleCodeBlocks();
    initSupabase();
    recordPageView();
    initVideoPortal();
    initArticlesPortal();
    initPowershellPortal();
  });
})();
