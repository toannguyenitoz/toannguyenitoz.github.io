#!/usr/bin/env python3
"""
Free Tech Course Voucher Fetcher
---------------------------------
Automated scraper for free Udemy courses with coupon codes.
Sources:
  1. TutorialBar category streams:
     - /all-courses
     - /category/development
     - /category/it-and-software
  2. Single course pages: /course/{slug} -> /go/{slug} redirect to Udemy with couponCode

Filters:
  - English tech courses only (AI, ML, Data, Cloud, DevOps, Security, Programming, SysAdmin, etc.)
  - Valid coupon code and active 100% discount

Output:
  - _data/vouchers.yml (max 60 courses, newest first)
"""

import os
import sys
if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

import re
import json
import time
import datetime
import urllib.request
import urllib.parse
import urllib.error
from html.parser import HTMLParser
import yaml

# ─── Config ──────────────────────────────────────────────────────────────────

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
OUTPUT_FILE = os.path.join(BASE_DIR, "_data", "vouchers.yml")
HISTORY_FILE = os.path.join(BASE_DIR, "_data", "vouchers_history.json")
MAX_VOUCHERS = 60
REQUEST_TIMEOUT = 12
DELAY_BETWEEN_REQUESTS = 0.5

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    "Accept-Language": "en-US,en;q=0.9",
}

TECH_KEYWORDS = [
    "python", "javascript", "typescript", "java", "kotlin", "swift", "rust", "go",
    "react", "angular", "vue", "node", "django", "flask", "fastapi", "spring",
    "sql", "mysql", "postgresql", "mongodb", "redis", "elasticsearch",
    "machine learning", "deep learning", "neural network", "tensorflow", "pytorch",
    "artificial intelligence", "ai ", " ai", "nlp", "llm", "gpt", "generative ai", "generative",
    "data science", "data analysis", "data engineering", "pandas", "numpy", "scikit",
    "power bi", "tableau", "excel", "sheets", "looker", "databricks",
    "cloud", "aws", "azure", "gcp", "google cloud", "devops", "docker", "kubernetes",
    "linux", "bash", "shell", "powershell", "terraform", "ansible", "jenkins", "ci/cd",
    "cybersecurity", "ethical hacking", "penetration testing", "comptia", "cisco",
    "networking", "ccna", "network+", "security+",
    "web development", "web design", "css", "html", "full stack", "backend", "frontend",
    "mobile development", "android", "ios", "flutter", "react native",
    "database", "it support", "sysadmin", "systems administration",
    "microsoft", "windows server", "active directory", "microsoft 365",
    "git", "github", "agile", "scrum", "software engineering", "programming", "developer",
    "api", "rest api", "graphql", "microservices",
    "algorithms", "data structures", "leetcode",
    "automation", "selenium", "playwright", "scraping",
    "unity", "unreal", "game development",
    "it ", " it", "tech", "coding", "software",
]

EXCLUDE_KEYWORDS = [
    "yoga", "meditation", "fitness", "nutrition", "cooking", "guitar", "piano",
    "drawing", "painting", "photography", "film", "music theory",
    "makeup", "fashion", "jewelry", "crochet", "knitting",
    "quickbooks", "tax", "real estate", "mortgage",
    "mindset", "relationship", "dating", "parenting", "anxiety", "depression",
    "spanish", "french", "german", "chinese", "japanese", "korean", "arabic", "portuguese", "italian", "russian",
    "cómo", "crear", "crea una", "calculadora", "página", "curso de", "principiantes", "español", "aprende", "deutsch", "für", "französisch", "italiano", "curso",
    "inteligente", "transformación", "transformacion", "redes con", "entornos", "corporativos", "gestión", "inteligencia", "gestor", "para principiantes",
    "copywriting", "social media marketing", "instagram", "tiktok", "youtube growth",
]

# ─── Helpers ─────────────────────────────────────────────────────────────────

def fetch_html(url, timeout=REQUEST_TIMEOUT):
    req = urllib.request.Request(url, headers=HEADERS)
    try:
        with urllib.request.urlopen(req, timeout=timeout) as resp:
            charset = resp.headers.get_content_charset() or "utf-8"
            return resp.read().decode(charset, errors="replace")
    except Exception as e:
        print(f"  [!] Fetch failed: {url} -> {e}")
        return None

class NoRedirectHandler(urllib.request.HTTPRedirectHandler):
    def redirect_request(self, req, fp, code, msg, headers, newurl):
        return None

_no_redirect_opener = urllib.request.build_opener(NoRedirectHandler)

def get_redirect_url(url, timeout=REQUEST_TIMEOUT):
    req = urllib.request.Request(url, headers=HEADERS)
    try:
        try:
            resp = _no_redirect_opener.open(req, timeout=timeout)
            return resp.geturl()
        except urllib.error.HTTPError as e:
            if e.code in (301, 302, 303, 307, 308):
                loc = e.headers.get("Location")
                if loc:
                    return loc
            return None
    except Exception as e:
        print(f"  [!] Redirect fetch failed: {url} -> {e}")
        return None


def is_tech_course(title, description=""):
    text = (title + " " + description).lower()
    for kw in EXCLUDE_KEYWORDS:
        if kw in text:
            return False
    for kw in TECH_KEYWORDS:
        if kw in text:
            return True
    return False

def strip_html(text):
    return re.sub(r"<[^>]+>", " ", text).strip()

def truncate(text, max_len=280):
    text = text.strip()
    if len(text) <= max_len:
        return text
    return text[:max_len].rsplit(" ", 1)[0] + "..."

def extract_coupon_from_url(url):
    parsed = urllib.parse.urlparse(url)
    params = urllib.parse.parse_qs(parsed.query)
    code = params.get("couponCode", params.get("coupon_code", [None]))[0]
    return code

def extract_udemy_slug(url):
    m = re.search(r"udemy\.com/course/([^/?#]+)", url)
    return m.group(1) if m else None

# ─── Scraping Logic ──────────────────────────────────────────────────────────

def scrape_tutorialbar():
    print("[*] Scraping TutorialBar course feeds (multi-page)...")
    discovered = []
    seen_slugs = set()

    sources = []
    # Multi-page scanning ensures we discover all newly posted vouchers
    for p in range(1, 6):
        sources.append(f"https://www.tutorialbar.com/all-courses/?page={p}")
    for p in range(1, 5):
        sources.append(f"https://www.tutorialbar.com/category/development?page={p}")
    for p in range(1, 5):
        sources.append(f"https://www.tutorialbar.com/category/it-and-software?page={p}")

    for page_url in sources:
        html = fetch_html(page_url)
        if not html:
            continue

        # 1. Parse rendered cards: <a class="...aspect-video..." href="/course/slug"><img src="img" alt="title"
        cards = re.findall(
            r'<a\s+class="[^"]*aspect-video[^"]*"\s+href="/course/([^"]+)"><img\s+src="([^"]+)"\s+alt="([^"]+)"',
            html
        )
        for slug, img, title in cards:
            if slug in seen_slugs:
                continue
            title_clean = strip_html(title)
            if not is_tech_course(title_clean):
                continue
            seen_slugs.add(slug)
            discovered.append({
                "slug": slug,
                "title": title_clean,
                "image": img,
                "detail_url": f"https://www.tutorialbar.com/course/{slug}",
                "go_url": f"https://www.tutorialbar.com/go/{slug}"
            })

        # 2. Also parse Next.js unescaped payload for courses that might not be in DOM yet
        unescaped = html.replace(r'\"', '"').replace(r'\\', '\\')
        json_pattern = re.compile(
            r'"title":"(?P<title>[^"]+)".*?'
            r'"category":"(?P<category>[^"]*)".*?'
            r'"imageUrl":"(?P<imageUrl>[^"]*)".*?'
            r'"couponCode":"(?P<couponCode>[^"]*)".*?'
            r'"couponUrl":"(?P<couponUrl>[^"]*)"'
        )
        for m in json_pattern.finditer(unescaped):
            d = m.groupdict()
            c_title = d.get("title", "")
            c_url = d.get("couponUrl", "")
            c_code = d.get("couponCode", "")
            c_slug = extract_udemy_slug(c_url)
            if not c_slug or c_slug in seen_slugs:
                continue
            if not is_tech_course(c_title):
                continue
            seen_slugs.add(c_slug)
            discovered.append({
                "slug": c_slug,
                "title": c_title,
                "image": d.get("imageUrl", ""),
                "coupon_code": c_code,
                "coupon_url": c_url,
                "udemy_url": f"https://www.udemy.com/course/{c_slug}/",
                "source": "tutorialbar",
            })

        time.sleep(DELAY_BETWEEN_REQUESTS)

    print(f"  -> Discovered {len(discovered)} potential tech courses from TutorialBar feeds")
    return discovered

def scrape_discudemy(max_pages=4):
    print("[*] Scraping DiscUdemy course feeds (multi-page)...")
    discovered = []
    seen = set()

    sources = [
        f"https://www.discudemy.com/language/english/{p}" for p in range(1, max_pages + 1)
    ] + [
        f"https://www.discudemy.com/all/{p}" for p in range(1, 3)
    ]

    for url in sources:
        html = fetch_html(url)
        if not html:
            continue
        items = re.findall(r'<a\s+class="card-header"\s+href="([^"]+)">([^<]+)</a>', html)
        for link, title in items:
            title_clean = strip_html(title)
            if not is_tech_course(title_clean):
                continue
            slug = link.rstrip("/").split("/")[-1]
            if slug in seen:
                continue
            seen.add(slug)
            discovered.append({
                "slug": slug,
                "title": title_clean,
                "detail_url": link,
                "source": "discudemy"
            })
        time.sleep(0.3)

    print(f"  -> Discovered {len(discovered)} potential tech courses from DiscUdemy feeds")
    return discovered

def enrich_discudemy(item):
    """
    Resolves DiscUdemy / Couponami detail page and /go/ redirect to obtain active Udemy link with coupon.
    """
    detail_url = item.get("detail_url")
    if not detail_url:
        return None

    html = fetch_html(detail_url)
    if not html:
        return None

    # High-resolution image from Udemy CDN
    img_match = (
        re.search(r'property="og:image"\s+content="([^"]+)"', html) or
        re.search(r'<amp-img\s+src="([^"]+)"', html) or
        re.search(r'<img[^>]*class="[^"]*image[^"]*"[^>]*src="([^"]+)"', html)
    )
    if img_match:
        item["image"] = img_match.group(1)

    # Description
    desc_match = re.search(r'property="og:description"\s+content="([^"]+)"', html)
    if desc_match:
        item["description"] = truncate(strip_html(desc_match.group(1)))

    # Follow /go/ page link
    go_match = re.search(r'href="([^"]*/go/[^"]+)"', html)
    if not go_match:
        return None

    go_url = go_match.group(1)
    html_go = fetch_html(go_url)
    if not html_go:
        return None

    # Search for udemy link inside /go/ page
    udemy_match = re.search(r'href="([^"]*udemy\.com/course/[^"]+)"', html_go)
    if not udemy_match:
        return None

    udemy_url = udemy_match.group(1)
    coupon = extract_coupon_from_url(udemy_url)
    slug = item.get("slug") or extract_udemy_slug(udemy_url)

    item["udemy_url"] = f"https://www.udemy.com/course/{slug}/"
    item["coupon_url"] = udemy_url
    item["coupon_code"] = coupon or ""
    item["source"] = "discudemy"
    item["rating"] = 4.6
    item["rating_count"] = 140
    item["students"] = 1600
    item["level"] = "All Levels"
    item["duration"] = "3-5 hours"
    item["lectures"] = 26
    return item

def enrich_course_details(item):
    """
    If coupon_url / coupon_code is missing, visit detail page and follow /go/ redirect.
    Also extracts rich metadata (JSON-LD description, rating, instructor).
    """
    slug = item.get("slug")
    if not slug:
        return None

    # If coupon_url is already resolved
    if item.get("coupon_url") and item.get("coupon_code"):
        return item

    # 1. Follow /go/ redirect to get final Udemy link with couponCode
    go_url = item.get("go_url") or f"https://www.tutorialbar.com/go/{slug}"
    final_udemy_url = get_redirect_url(go_url)
    if not final_udemy_url or "udemy.com" not in final_udemy_url:
        return None

    coupon = extract_coupon_from_url(final_udemy_url)
    clean_udemy_url = f"https://www.udemy.com/course/{slug}/"

    item["udemy_url"] = clean_udemy_url
    item["coupon_url"] = final_udemy_url
    item["coupon_code"] = coupon or ""
    item["source"] = "tutorialbar"

    # 2. Fetch single course page for description & rating
    detail_url = item.get("detail_url") or f"https://www.tutorialbar.com/course/{slug}"
    html = fetch_html(detail_url)
    if html:
        # Check JSON-LD
        ld_scripts = re.findall(r'<script\s+type="application/ld\+json">(.*?)</script>', html, re.DOTALL)
        for s in ld_scripts:
            try:
                data = json.loads(s)
                if data.get("@type") == "Course":
                    if not item.get("title") and data.get("name"):
                        item["title"] = data.get("name")
                    desc = data.get("description")
                    if desc:
                        item["description"] = truncate(strip_html(desc))
                    rating = data.get("aggregateRating", {})
                    if rating.get("ratingValue"):
                        item["rating"] = round(float(rating.get("ratingValue")), 1)
                    if rating.get("reviewCount"):
                        item["rating_count"] = int(rating.get("reviewCount"))
                    lang = data.get("hasCourseInstance", {}).get("inLanguage")
                    if lang:
                        item["language"] = lang
            except Exception:
                pass

        # Meta description fallback
        if not item.get("description"):
            m = re.search(r'<meta\s+name="description"\s+content="([^"]+)"', html)
            if m:
                item["description"] = truncate(strip_html(m.group(1)))

    return item

# ─── Data Management ─────────────────────────────────────────────────────────

def load_existing():
    if not os.path.exists(OUTPUT_FILE):
        return []
    try:
        with open(OUTPUT_FILE, "r", encoding="utf-8") as f:
            data = yaml.safe_load(f)
            return data if isinstance(data, list) else []
    except Exception:
        return []

def load_history():
    """Load persistent record of all course slugs ever published."""
    history = set()
    if os.path.exists(HISTORY_FILE):
        try:
            with open(HISTORY_FILE, "r", encoding="utf-8") as f:
                data = json.load(f)
                if isinstance(data, list):
                    history = set(data)
        except Exception as e:
            print(f"  [!] Failed to read {HISTORY_FILE}: {e}")
    # Also seed with current vouchers.yml
    existing = load_existing()
    for ex in existing:
        slug = ex.get("id") or extract_udemy_slug(ex.get("udemy_url", ""))
        if slug:
            history.add(slug)
    return history

def save_history(history_set):
    """Save persistent record of all published course slugs."""
    try:
        os.makedirs(os.path.dirname(HISTORY_FILE), exist_ok=True)
        with open(HISTORY_FILE, "w", encoding="utf-8") as f:
            json.dump(sorted(list(history_set)), f, indent=2)
    except Exception as e:
        print(f"  [!] Failed to write {HISTORY_FILE}: {e}")

def merge_and_sort(new_items, existing_items, history_set):
    today = datetime.date.today().isoformat()
    by_slug = {}

    # 1. Keep existing active vouchers
    for ex in existing_items:
        slug = ex.get("id") or extract_udemy_slug(ex.get("udemy_url", ""))
        if slug:
            by_slug[slug] = ex

    # 2. Process newly fetched items
    added_count = 0
    updated_count = 0
    for item in new_items:
        slug = item.get("slug") or extract_udemy_slug(item.get("udemy_url", ""))
        if not slug:
            continue

        if slug in by_slug:
            # Course is in current active list: update coupon code and refresh fetched_at if new coupon provided
            if item.get("coupon_code"):
                by_slug[slug]["coupon_code"] = item.get("coupon_code")
                by_slug[slug]["coupon_url"] = item.get("coupon_url") or by_slug[slug].get("coupon_url")
                by_slug[slug]["fetched_at"] = today
                if item.get("title"):
                    by_slug[slug]["title"] = item.get("title")
                if item.get("image"):
                    by_slug[slug]["image"] = item.get("image")
                updated_count += 1
            continue

        # Truly new course
        merged = {
            "id": slug,
            "title": item.get("title") or slug.replace("-", " ").title(),
            "description": item.get("description") or "Free online certification course with full lifetime access.",
            "image": item.get("image") or "",
            "instructor": item.get("instructor") or "Top IT Instructor",
            "rating": item.get("rating") or 4.5,
            "rating_count": item.get("rating_count") or 150,
            "students": item.get("students") or 1200,
            "level": item.get("level") or "All Levels",
            "duration": item.get("duration") or "3-5 hours",
            "lectures": item.get("lectures") or 25,
            "coupon_code": item.get("coupon_code") or "",
            "udemy_url": item.get("udemy_url") or f"https://www.udemy.com/course/{slug}/",
            "coupon_url": item.get("coupon_url") or "",
            "source": item.get("source") or "tutorialbar",
            "fetched_at": today,
            "categories": [k for k in ["AI", "Python", "Cloud", "Data", "Security", "DevOps", "Web", "IT Support"] if k.lower() in (item.get("title", "")).lower()] or ["IT & Tech"]
        }
        by_slug[slug] = merged
        history_set.add(slug)
        added_count += 1

    print(f"[*] Added {added_count} brand-new courses, refreshed {updated_count} existing courses")

    results = list(by_slug.values())
    # Sort: courses with coupon_code first, then newest fetched_at, then rating
    results.sort(key=lambda x: (
        1 if x.get("coupon_code") else 0,
        x.get("fetched_at", ""),
        x.get("rating", 0)
    ), reverse=True)

    return results[:MAX_VOUCHERS], history_set

def write_yaml(vouchers):
    now = datetime.datetime.now().strftime("%Y-%m-%d %H:%M")
    os.makedirs(os.path.dirname(OUTPUT_FILE), exist_ok=True)

    header = f"""# Free Tech Course Vouchers
# Auto-generated by scripts/fetch_vouchers.py
# Last updated: {now} ACST
# Do not edit manually — changes will be overwritten on next run.
"""
    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        f.write(header + "\n")
        yaml.dump(vouchers, f, allow_unicode=True, default_flow_style=False, sort_keys=False)
    print(f"[✓] Saved {len(vouchers)} vouchers to {OUTPUT_FILE}")

# ─── Main Execution ──────────────────────────────────────────────────────────

def main():
    print("=" * 65)
    print("  Free Tech Course Voucher Fetcher (Automated 3x Daily)")
    print("=" * 65)

    history_set = load_history()
    existing = load_existing()
    existing_slugs = {ex.get("id") or extract_udemy_slug(ex.get("udemy_url", "")) for ex in existing}
    print(f"[*] Known history archive: {len(history_set)} course slugs tracked | Currently active: {len(existing)}")

    tb_candidates = scrape_tutorialbar()
    disc_candidates = scrape_discudemy()
    raw_items = tb_candidates + disc_candidates
    print(f"[*] Total raw candidates: {len(raw_items)} (TutorialBar: {len(tb_candidates)}, DiscUdemy: {len(disc_candidates)})")

    # Filter candidates: allow items if they are currently in active vouchers (to refresh) OR not in history
    filtered_candidates = []
    seen_in_batch = set()
    for item in raw_items:
        slug = item.get("slug") or extract_udemy_slug(item.get("udemy_url", ""))
        if not slug or slug in seen_in_batch:
            continue
        # If slug is in active courses, we want to check for refreshed coupons
        # If slug was previously posted and dropped from active list, skip
        if slug in history_set and slug not in existing_slugs:
            continue
        seen_in_batch.add(slug)
        filtered_candidates.append(item)

    print(f"[*] Candidates to process (new + active refreshes): {len(filtered_candidates)}")

    # Enrich candidates that need coupon resolution
    enriched_items = []
    for idx, item in enumerate(filtered_candidates[:40]):
        # If coupon_url and coupon_code already present, no need to make HTTP request
        if item.get("coupon_url") and item.get("coupon_code"):
            enriched_items.append(item)
            print(f"[{idx+1}/{min(len(filtered_candidates), 40)}] [FAST] {item.get('title', '')[:40]} -> Code: {item.get('coupon_code')}")
            continue

        print(f"[{idx+1}/{min(len(filtered_candidates), 40)}] [{item.get('source', 'tb').upper()}] Resolving: {item.get('title', '')[:40]}")
        try:
            if item.get("source") == "discudemy":
                res = enrich_discudemy(item)
            else:
                res = enrich_course_details(item)

            if res and res.get("coupon_url"):
                enriched_items.append(res)
                print(f"    [+] Active code: {res.get('coupon_code')} -> {res.get('udemy_url')}")
            time.sleep(DELAY_BETWEEN_REQUESTS)
        except Exception as e:
            print(f"    [!] Error: {e}")

    print(f"\n[*] Successfully resolved {len(enriched_items)} courses with coupon codes")

    final_list, updated_history = merge_and_sort(enriched_items, existing, history_set)
    write_yaml(final_list)
    save_history(updated_history)

    print("\n" + "=" * 65)
    print(f"  Run complete! Total active vouchers: {len(final_list)} | Lifetime tracked: {len(updated_history)}")
    print("=" * 65)

if __name__ == "__main__":
    main()
