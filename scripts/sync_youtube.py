#!/usr/bin/env python3
"""
YouTube Videos & Shorts Auto-Sync Engine
----------------------------------------
Monitors the official YouTube channel (@ITSupportwithToan_Adl) via its official RSS feed.
Detects newly published tutorials and Shorts, fetches high-resolution metadata
(exact title, duration, view counts, clean description), categorizes them,
and updates _data/videos.yml without duplicating existing videos.
"""

import os
import sys
import re
import xml.etree.ElementTree as ET
import urllib.request
import urllib.parse
import yaml
import datetime

if hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
VIDEOS_FILE = os.path.join(BASE_DIR, "_data", "videos.yml")
CHANNEL_ID = "UCWmu7TK9cx0AH17OrghZZSA"
RSS_URL = f"https://www.youtube.com/feeds/videos.xml?channel_id={CHANNEL_ID}"

HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/124.0.0.0 Safari/537.36",
    "Accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
}

def is_short_video(vid_id):
    """Verifies whether a video is a YouTube Short via redirect detection."""
    url = f"https://www.youtube.com/shorts/{vid_id}"
    req = urllib.request.Request(url, headers=HEADERS)
    try:
        with urllib.request.urlopen(req, timeout=10) as resp:
            return "/shorts/" in resp.geturl()
    except Exception:
        return False

def get_video_metadata(vid_id):
    """Extracts duration and viewCount directly from YouTube page HTML."""
    req = urllib.request.Request(f"https://www.youtube.com/watch?v={vid_id}", headers=HEADERS)
    duration_str = "01:00"
    views_count = 0
    short_desc = ""
    try:
        with urllib.request.urlopen(req, timeout=12) as resp:
            html = resp.read().decode("utf-8", errors="ignore")
            
            # Duration
            dur_m = re.findall(r'"approxDurationMs":"(\d+)"', html)
            if dur_m:
                ms = int(dur_m[0])
                total_sec = ms // 1000
                mins = total_sec // 60
                secs = total_sec % 60
                duration_str = f"{mins:02d}:{secs:02d}"

            # Views
            views_m = re.findall(r'"viewCount":"(\d+)"', html)
            if views_m:
                views_count = int(views_m[0])

            # Description
            desc_m = re.findall(r'"shortDescription":"([^"]+)"', html)
            if desc_m:
                short_desc = desc_m[0].replace('\\n', ' ').replace('\\"', '"').strip()
    except Exception as e:
        print(f"  [!] Failed to extract page metadata for {vid_id}: {e}")

    return duration_str, views_count, short_desc

def determine_category(title, is_short):
    """Categorizes the video based on keywords and format."""
    if is_short:
        return "Shorts"
    t = title.lower()
    if "powershell" in t or "script" in t:
        return "PowerShell"
    elif "windows 11" in t or "windows 10" in t:
        return "Windows 11"
    elif "security" in t or "firewall" in t or "lock" in t:
        return "Security"
    elif "troubleshoot" in t or "fix" in t or "freeze" in t or "repair" in t or "quiz" in t:
        return "Troubleshooting"
    elif "shortcut" in t or "productivity" in t:
        return "Productivity"
    elif "server" in t or "sysadmin" in t or "admin" in t:
        return "SysAdmin"
    return "IT Support"

def clean_title(title):
    """Strips trailing #Shorts, #Windows11 hashtags from video title."""
    t = re.sub(r'#\w+', '', title).strip()
    return re.sub(r'\s+', ' ', t)

def load_existing_videos():
    if not os.path.exists(VIDEOS_FILE):
        return []
    try:
        with open(VIDEOS_FILE, "r", encoding="utf-8") as f:
            data = yaml.safe_load(f)
            if isinstance(data, dict) and "items" in data:
                return data["items"]
            elif isinstance(data, list):
                return data
    except Exception as e:
        print(f"[!] Error loading {VIDEOS_FILE}: {e}")
    return []

def save_videos(items):
    data = {"items": items}
    with open(VIDEOS_FILE, "w", encoding="utf-8") as f:
        yaml.dump(data, f, allow_unicode=True, default_flow_style=False, sort_keys=False)
    print(f"[✓] Saved {len(items)} videos to {VIDEOS_FILE}")

def sync_channel_videos():
    print(f"[*] Checking YouTube RSS feed for channel: {CHANNEL_ID}")
    existing_items = load_existing_videos()
    existing_ids = {v.get("youtube_id") for v in existing_items if v.get("youtube_id")}
    print(f"[*] Currently tracked videos: {len(existing_ids)}")

    req = urllib.request.Request(RSS_URL, headers=HEADERS)
    with urllib.request.urlopen(req, timeout=12) as resp:
        xml_data = resp.read()

    root = ET.fromstring(xml_data)
    ns = {
        'atom': 'http://www.w3.org/2005/Atom',
        'yt': 'http://www.youtube.com/xml/schemas/2015',
        'media': 'http://search.yahoo.com/mrss/'
    }

    entries = root.findall('atom:entry', ns)
    print(f"[*] Found {len(entries)} recent videos in YouTube RSS feed")

    new_items = []
    for e in entries:
        vid_id = e.find('yt:videoId', ns).text
        raw_title = e.find('atom:title', ns).text
        published = e.find('atom:published', ns).text[:10]
        desc_rss = e.find('media:group/media:description', ns).text or ""

        if vid_id in existing_ids:
            continue

        print(f"[+] Discovered NEW YouTube video: [{vid_id}] {raw_title}")
        is_short = is_short_video(vid_id)
        duration_str, views_count, page_desc = get_video_metadata(vid_id)
        
        description = page_desc or desc_rss.strip().split('\n')[0] or "Practical technical walkthrough and IT support tutorial."
        if len(description) > 200:
            description = description[:197] + "..."

        title_cleaned = clean_title(raw_title)
        category = determine_category(title_cleaned, is_short)
        views_display = "New" if views_count < 10 else f"{views_count} views"

        new_entry = {
            "title": title_cleaned,
            "youtube_id": vid_id,
            "duration": duration_str,
            "category": category,
            "description": description,
            "published_date": published,
            "views_count": views_count,
            "views_display": views_display,
            "is_pinned": False,
        }
        new_items.append(new_entry)

    if not new_items:
        print("[*] No new videos discovered. Everything is up to date.")
        return 0

    print(f"[*] Adding {len(new_items)} new videos to videos.yml")
    # Insert new items right after pinned items
    pinned = [v for v in existing_items if v.get("is_pinned")]
    non_pinned = [v for v in existing_items if not v.get("is_pinned")]
    
    updated_items = pinned + new_items + non_pinned
    save_videos(updated_items)
    return len(new_items)

if __name__ == "__main__":
    count = sync_channel_videos()
    print(f"[*] Sync complete! Total new videos added: {count}")
