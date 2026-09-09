#!/usr/bin/env python3
"""
LinkedIn Post to Jekyll Auto-Sync & Markdown Generator
-------------------------------------------------------
Fetches new posts from LinkedIn (via URL or tracking queue), extracts content,
normalizes Unicode fonts, downloads high-res images, formats PowerShell blocks,
and generates structured Jekyll posts in _posts/ with duplicate prevention.
"""

import os
import sys
import re
import json
import html
import urllib.request
import urllib.parse
import datetime

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
POSTS_DIR = os.path.join(BASE_DIR, "_posts")
IMAGES_DIR = os.path.join(BASE_DIR, "assets", "images", "posts")
TRACKER_FILE = os.path.join(BASE_DIR, "_data", "linkedin_tracker.yml")

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    "Accept-Language": "en-US,en;q=0.9",
}

def clean_unicode_math_symbols(text):
    """Translates LinkedIn mathematical bold/italic characters into plain standard ASCII text."""
    result = []
    for char in text:
        code = ord(char)
        if 0x1D400 <= code <= 0x1D419:  # Bold uppercase A-Z
            result.append(chr(code - 0x1D400 + ord('A')))
        elif 0x1D5D4 <= code <= 0x1D5ED:  # Sans-serif bold A-Z
            result.append(chr(code - 0x1D5D4 + ord('A')))
        elif 0x1D41A <= code <= 0x1D433:  # Bold lowercase a-z
            result.append(chr(code - 0x1D41A + ord('a')))
        elif 0x1D5EE <= code <= 0x1D607:  # Sans-serif bold a-z
            result.append(chr(code - 0x1D5EE + ord('a')))
        elif 0x1D7CE <= code <= 0x1D7D7:  # Bold digits 0-9
            result.append(chr(code - 0x1D7CE + ord('0')))
        elif 0x1D7EC <= code <= 0x1D7F5:  # Sans-serif bold digits 0-9
            result.append(chr(code - 0x1D7EC + ord('0')))
        else:
            result.append(char)
    return "".join(result)

def slugify(text):
    text = text.lower()
    text = re.sub(r'[^a-z0-9\s-]', '', text)
    text = re.sub(r'[\s-]+', '-', text).strip('-')
    return text

def is_post_already_published(part_num, title):
    """Checks if a post with this Part number or matching title already exists in _posts/."""
    if not os.path.exists(POSTS_DIR):
        return False
    
    existing_files = os.listdir(POSTS_DIR)
    if part_num:
        part_pattern = f"part-{part_num:02d}-"
        for f in existing_files:
            if part_pattern in f:
                return True

    title_slug = slugify(title)
    if title_slug:
        for f in existing_files:
            if title_slug in f:
                return True

    return False

def fetch_linkedin_data(url):
    """Fetches LinkedIn post page and parses structured JSON-LD & OpenGraph metadata."""
    print(f"[*] Fetching LinkedIn URL: {url}")
    req = urllib.request.Request(url, headers=HEADERS)
    with urllib.request.urlopen(req, timeout=15) as resp:
        page_html = resp.read().decode("utf-8", errors="ignore")
        final_url = resp.geturl()

    # 1. Canonical URL
    can = re.findall(r'<link\s+rel="canonical"\s+href="([^"]+)"', page_html)
    canonical_url = can[0] if can else final_url

    # 2. Image URL
    img_m = re.findall(r'<meta\s+property="og:image"\s+content="([^"]+)"', page_html)
    image_url = html.unescape(img_m[0]) if img_m else ""

    # 3. Post Text & Published Date from JSON-LD
    ld_scripts = re.findall(r'<script\s+type="application/ld\+json"[^>]*>(.*?)</script>', page_html, re.DOTALL)
    post_text = ""
    pub_date_str = ""
    for s in ld_scripts:
        try:
            d = json.loads(s.strip())
            if d.get("@type") == "SocialMediaPosting":
                post_text = d.get("articleBody") or d.get("text") or ""
                pub_date_str = d.get("datePublished") or ""
        except Exception:
            pass

    if not post_text:
        desc_m = re.findall(r'<meta\s+name="description"\s+content="([^"]+)"', page_html)
        if desc_m:
            post_text = html.unescape(desc_m[0])

    post_text = clean_unicode_math_symbols(post_text).strip()

    # 4. Extract Part number
    part_m = re.search(r'Part\s+(\d+)', post_text, re.IGNORECASE)
    part_num = int(part_m.group(1)) if part_m else None

    # 5. Extract Title
    lines = [ln.strip() for ln in post_text.split("\n") if ln.strip()]
    raw_title = ""
    for idx, ln in enumerate(lines):
        if "Part" in ln:
            if idx + 1 < len(lines):
                raw_title = lines[idx+1]
            else:
                raw_title = ln
            break
    if not raw_title and lines:
        raw_title = lines[0]

    clean_title = re.sub(r'^[^\w\s]+', '', raw_title).strip()
    # Strip any trailing hashtag lines or quotes
    clean_title = clean_title.strip('"').strip("'")

    # 6. Date formatting
    date_formatted = datetime.date.today().strftime("%Y-%m-%d")
    date_full = datetime.datetime.now().strftime("%Y-%m-%d 14:00:00 +0930")
    if pub_date_str:
        try:
            dt = datetime.datetime.fromisoformat(pub_date_str.replace("Z", "+00:00"))
            # convert to Adelaide time roughly (+9:30)
            dt_adl = dt + datetime.timedelta(hours=9, minutes=30)
            date_formatted = dt_adl.strftime("%Y-%m-%d")
            date_full = dt_adl.strftime("%Y-%m-%d %H:%M:%S +0930")
        except Exception:
            pass

    return {
        "part": part_num,
        "raw_title": raw_title,
        "clean_title": clean_title,
        "canonical_url": canonical_url,
        "image_url": image_url,
        "date_formatted": date_formatted,
        "date_full": date_full,
        "full_text": post_text,
    }

def format_markdown_article(data):
    """
    Transforms raw post text into an enhanced, structured Jekyll article with
    badges, callout cards, code snippets, and discussion CTA.
    """
    part = data["part"]
    title = data["clean_title"]
    date_full = data["date_full"]
    canonical_url = data["canonical_url"]
    slug = f"part-{part:02d}-{slugify(title)}" if part else slugify(title)
    image_rel_path = f"/assets/images/posts/{slug}.jpg"

    # Separate hashtags and core body
    body_lines = []
    tags = ["Windows Server", "SysAdmin", "PowerShell", "IT Support", "Troubleshooting", "ToanNguyenItOz"]
    if part:
        tags.append(f"Part-{part}")

    for line in data["full_text"].split("\n"):
        ln = line.strip()
        if ln.startswith("#"):
            # extract hashtags
            found_tags = re.findall(r'#(\w+)', ln)
            for t in found_tags:
                if t.lower() not in [x.lower() for x in tags]:
                    tags.append(t)
        else:
            body_lines.append(line)

    clean_body = "\n".join(body_lines).strip()

    # Description (first conversational paragraph)
    desc_match = re.search(r'“([^”]+)”|"([^"]+)"', clean_body)
    description = desc_match.group(1) if desc_match else f"{title} - Enterprise Systems Administration and Troubleshooting Guide."

    # Code block detection (detects PowerShell command patterns)
    formatted_body = clean_body
    # Replace quotes surrounding commands
    formatted_body = re.sub(
        r'&quot;(Get-WinEvent[^&]+)&quot;',
        r'```powershell\n\1\n```',
        formatted_body
    )
    formatted_body = re.sub(
        r'"(Get-WinEvent[^"]+)"',
        r'```powershell\n\1\n```',
        formatted_body
    )
    formatted_body = re.sub(
        r'&quot;(&quot;[^&]+ForEach-Object[^&]+)&quot;',
        r'```powershell\n\1\n```',
        formatted_body
    )

    tags_yaml = json.dumps(tags[:9])

    article = f"""---
layout: post
title: "Windows Tips & Tricks – Part {part}: {title}"
date: {date_full}
categories: [SysAdmin, PowerShell]
tags: {tags_yaml}
image: {image_rel_path}
linkedin_url: "{canonical_url}"
description: "{description}"
part: {part}
---

<div class="cmd-annotation-card" style="margin-bottom: 24px;">
  <div class="annotation-badge">
    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
    <span>LinkedIn Enterprise Series — Phase 3: SysAdmin Tools</span>
  </div>
  <p class="annotation-text">
    This guide is Part {part} of the <em>Windows Tips & Tricks</em> series published by <strong>Toan Nguyen (Toan Nguyen IT OZ)</strong>. In Phase 3, we move from desktop troubleshooting to enterprise Systems Administration. Follow on <a href="{canonical_url}" target="_blank" rel="noopener noreferrer">LinkedIn</a>.
  </p>
</div>

![Windows Tips & Tricks – Part {part}: {title}]({image_rel_path})

## 1. Scenario Overview & Problem Context

{clean_body}

---

> 🔗 **Join the Live Community Discussion:**
> Have questions or additional tips about this guide?
> 👉 **[View and join the original LinkedIn post discussion]({canonical_url})**
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — Enterprise Systems Administrator in Adelaide, South Australia.*
"""
    return slug, image_rel_path, article

def download_image(img_url, dest_path):
    """Downloads high-res image from LinkedIn CDN."""
    if not img_url:
        return False
    try:
        os.makedirs(os.path.dirname(dest_path), exist_ok=True)
        req = urllib.request.Request(img_url, headers=HEADERS)
        with urllib.request.urlopen(req, timeout=15) as resp:
            data = resp.read()
        with open(dest_path, "wb") as f:
            f.write(data)
        print(f"[✓] Image downloaded: {dest_path} ({len(data)} bytes)")
        return True
    except Exception as e:
        print(f"[!] Failed to download image: {e}")
        return False

def sync_post(url):
    """Main workflow to process a single LinkedIn URL."""
    data = fetch_linkedin_data(url)
    part = data["part"]
    title = data["clean_title"]

    print(f"[*] Checking duplicate status for Part {part} - {title}...")
    if is_post_already_published(part, title):
        print(f"[i] Post (Part {part}: '{title}') already exists on website. Skipping.")
        return False

    slug, image_rel_path, markdown_content = format_markdown_article(data)
    
    # Save Image
    dest_image_path = os.path.join(BASE_DIR, image_rel_path.lstrip("/").replace("/", os.sep))
    if data["image_url"]:
        download_image(data["image_url"], dest_image_path)

    # Save Markdown Post
    post_filename = f"{data['date_formatted']}-{slug}.md"
    dest_post_path = os.path.join(POSTS_DIR, post_filename)
    with open(dest_post_path, "w", encoding="utf-8") as f:
        f.write(markdown_content)

    print(f"[✓] New post generated successfully: {dest_post_path}")
    return True

def sync_from_tracker():
    """Reads URLs from _data/linkedin_tracker.yml and syncs any new ones."""
    if not os.path.exists(TRACKER_FILE):
        print(f"[!] Tracker file not found at {TRACKER_FILE}")
        return 0

    with open(TRACKER_FILE, "r", encoding="utf-8") as f:
        content = f.read()

    urls = re.findall(r'https?://[^\s\'"]+', content)
    added = 0
    for u in urls:
        try:
            if sync_post(u):
                added += 1
        except Exception as e:
            print(f"[!] Error processing {u}: {e}")
    return added

if __name__ == "__main__":
    if len(sys.argv) > 1:
        target_url = sys.argv[1]
        print(f"[*] Processing command-line target URL: {target_url}")
        sync_post(target_url)
    else:
        print("[*] Running automatic sync from tracker queue...")
        count = sync_from_tracker()
        print(f"[*] Finished sync. Total new posts created: {count}")
