import sqlite3
import unicodedata
import re
import json
import os
import shutil
import sys
from datetime import datetime, timedelta

if sys.stdout and hasattr(sys.stdout, "reconfigure"):
    sys.stdout.reconfigure(encoding="utf-8")

db_path = r"D:\Toannx\Linkedin\data\posts.db"
media_base_dir = r"D:\Toannx\Linkedin\data"
posts_dir = r"d:\Toannx\IT\_posts"
images_dir = r"d:\Toannx\IT\assets\images\posts"

os.makedirs(posts_dir, exist_ok=True)
os.makedirs(images_dir, exist_ok=True)

conn = sqlite3.connect(db_path)
conn.row_factory = sqlite3.Row
cur = conn.cursor()
cur.execute("SELECT id, content, image_paths, linkedin_url, posted_date_str, is_ignored FROM posts")
rows = cur.fetchall()

def clean_unicode(text):
    if not text:
        return ""
    return unicodedata.normalize("NFKD", text)

def strip_emojis(text):
    clean = re.sub(r'[\U00010000-\U0010ffff]', '', text)
    clean = re.sub(r'[^\w\s\-–—:./\(\)\?,&]', '', clean)
    clean = re.sub(r'\s+', ' ', clean).strip()
    return clean

matched_posts = []

for r in rows:
    raw_content = r["content"] or ""
    norm = clean_unicode(raw_content)
    
    # Exclude non-tip posts like AWS or general announcements
    lower_norm = norm.lower()
    if "aws cloud fundamentals" in lower_norm or "aws certified" in lower_norm:
        continue
    if "my first github project" in lower_norm or "a new chapter in my it career" in lower_norm:
        continue
    if "i earned my" in lower_norm or "trophy!" in lower_norm or "badge!" in lower_norm:
        continue
    if "cisco packet tracer" in lower_norm or "ultimate ccna" in lower_norm or "active directory explained like a school" in lower_norm:
        continue
    if "cve-2026-57239" in lower_norm or "google has officially open-sourced" in lower_norm or "registered for google's" in lower_norm:
        continue
    if "24 years ago" in lower_norm or "adelaide, south australia, with a focus" in lower_norm:
        continue
    if "introducing my new github repository" in lower_norm or "new github project: windows cleansweep toolkit" in lower_norm:
        continue
    if "new github project: dm tech boot" in lower_norm:
        continue
        
    m = re.search(r"part\s*(\d+)", norm, re.IGNORECASE)
    has_part = bool(m)
    
    is_tip = False
    if has_part or re.search(r"tips?\s*(?:&|and)\s*tricks", norm, re.IGNORECASE) or "quick fix" in lower_norm or "how to fix" in lower_norm or "windows tip" in lower_norm:
        is_tip = True
    elif any(k in lower_norm for k in [
        "windows admin shortcuts", "backup all your windows drivers", "windows update keeps failing", 
        "never lose your windows drivers", "bsod after a windows update", "ghost printer", 
        "outlook troubleshooting", "windows privacy settings", "10 hidden windows shortcuts",
        "windows cmd commands every it", "work smarter with windows keyboard shortcuts",
        "move large files faster and safer with robocopy", "clear-recycletree",
        "microsoft pc manager: a free windows tool", "the win + x menu"
    ]):
        is_tip = True
        
    if is_tip:
        part_num = int(m.group(1)) if m else None
        
        # Check local media image
        img_exists = False
        img_local_path = ""
        if r["image_paths"]:
            try:
                paths = json.loads(r["image_paths"])
                if paths:
                    first_p = paths[0]
                    full_p = os.path.join(media_base_dir, first_p)
                    if os.path.exists(full_p):
                        img_exists = True
                        img_local_path = full_p
            except Exception:
                pass
                
        matched_posts.append({
            "part_num": part_num,
            "id": r["id"],
            "raw_content": raw_content,
            "norm": norm,
            "image_paths": r["image_paths"],
            "img_exists": img_exists,
            "img_local_path": img_local_path,
            "linkedin_url": r["linkedin_url"],
            "posted_date_str": r["posted_date_str"]
        })

print(f"Total verified real LinkedIn Tips & Tricks posts: {len(matched_posts)}")

# Sort: numbered parts ascending, then unnumbered tips
with_part = [p for p in matched_posts if p["part_num"] is not None]
without_part = [p for p in matched_posts if p["part_num"] is None]
with_part.sort(key=lambda x: x["part_num"])

all_posts = with_part + without_part

def make_title_and_slug(p):
    norm = p["norm"]
    lines = [l.strip() for l in norm.split("\n") if l.strip()]
    part_num = p["part_num"]
    
    if part_num is not None:
        subtitle = ""
        for l in lines[1:5]:
            cleaned_l = strip_emojis(l)
            if cleaned_l and not re.match(r"^(part\s*\d+|windows\s*tips)", cleaned_l, re.I):
                subtitle = cleaned_l
                break
        if subtitle:
            title = f"Windows Tips & Tricks – Part {part_num:02d}: {subtitle}"
        else:
            title = f"Windows Tips & Tricks – Part {part_num:02d}"
        slug_sub = re.sub(r"[^a-zA-Z0-9]+", "-", subtitle.lower()).strip("-") if subtitle else f"part-{part_num:02d}"
        slug = f"part-{part_num:02d}-{slug_sub}"[:55].rstrip("-")
    else:
        first_clean = strip_emojis(lines[0])
        if first_clean.lower() in ["windows tips & tricks", "windows tip:", "windows tip", "windows tips", "tips & tricks"] and len(lines) > 1:
            title = strip_emojis(lines[1])
        else:
            title = first_clean
        slug = re.sub(r"[^a-zA-Z0-9]+", "-", title.lower()).strip("-")[:50].rstrip("-")
        
    return title, slug

def format_post_markdown(p, title, slug, img_rel_path, post_date_str):
    norm = p["norm"]
    lines = norm.split("\n")
    
    # Extract tags from hashtags at the end
    tags = ["Windows", "IT Support", "Troubleshooting"]
    hashtag_matches = re.findall(r"#(\w+)", norm)
    for ht in hashtag_matches:
        if ht.lower() not in ["hashtag", "windowstips", "itsupport", "troubleshooting"]:
            tags.append(ht)
    unique_tags = list(dict.fromkeys(tags))[:8]
    
    # Clean body lines
    body_lines = []
    skip_header = True
    in_hashtag_section = False
    
    for l in lines:
        stripped = l.strip()
        
        # Check hashtag footer
        if stripped.lower() == "hashtag" or (stripped.startswith("#") and len(stripped.split()) <= 3 and any(h in stripped for h in ["#Windows", "#PowerShell", "#ITSupport", "#SysAdmin", "#Troubleshooting"])):
            in_hashtag_section = True
            continue
        if in_hashtag_section:
            if stripped.startswith("#") or stripped.lower() == "hashtag":
                continue
            else:
                in_hashtag_section = False
                
        # Skip top lines matching title or part header
        if skip_header:
            if not stripped:
                continue
            clean_sub = re.sub(r"[^\w\s]", "", stripped).lower()
            if "windows tips" in clean_sub or "part " in clean_sub or "how to fix" in clean_sub or "backup all" in clean_sub:
                continue
            if clean_sub in title.lower():
                continue
            skip_header = False
            
        # Format code commands
        # Quoted commands like "Invoke-Command ..."
        m_code = re.match(r'^["“]([A-Za-z0-9\-\\\/:\._\s\$\(\)\{\}\[\]\<\>\*\,\;\|]+)["”]$', stripped)
        if m_code and any(k in stripped for k in ["Invoke-", "Get-", "Set-", "Restart-", "Clear-", "net ", "sfc", "dism", "shutdown", "taskkill", "robocopy", "winget", "gpupdate", "ping", "tracert", "nslookup", "ipconfig"]):
            cmd_content = m_code.group(1).strip()
            body_lines.append(f"```powershell\n{cmd_content}\n```")
            continue
            
        # Raw unquoted commands
        if re.match(r'^(net\s+user|Get-|Set-|Restart-|Clear-|Test-|Search-|Unlock-|DISM|sfc|winget|shutdown|taskkill|robocopy|ipconfig|dsregcmd|qwinsta|logoff|netsh|powercfg|cipher|systeminfo|chkdsk)\b', stripped):
            body_lines.append(f"```powershell\n{stripped}\n```")
            continue
            
        # Numbered emoji steps 1️⃣, 2️⃣ etc.
        m_step = re.match(r'^([1-9]|10)[\uFE0F]?[\u20E3]?\s*(.*)', stripped)
        if m_step:
            step_num = m_step.group(1)
            step_text = m_step.group(2).strip()
            body_lines.append(f"{step_num}. {step_text}")
            continue
            
        # Bullet emojis
        if stripped.startswith(("🔹", "🔸", "👉", "✔️", "✅", "⚡", "🔧", "💡", "🛑", "⚠️", "📌")):
            icon = stripped[0]
            rest = stripped[1:].strip()
            body_lines.append(f"- **{rest}**" if rest.endswith(":") else f"- {rest}")
            continue
            
        body_lines.append(l)
        
    cleaned_body = "\n".join(body_lines).strip()
    cleaned_body = re.sub(r'\n{3,}', '\n\n', cleaned_body)
    
    first_p = ""
    for para in cleaned_body.split("\n\n"):
        para_clean = para.strip()
        if para_clean and not para_clean.startswith(("#", "```", "!", "-", "1.")):
            first_p = re.sub(r'\s+', ' ', para_clean)[:160]
            break
    if not first_p:
        first_p = title
        
    md = f"""---
layout: post
title: "{title}"
date: {post_date_str}
categories: [Windows, Troubleshooting]
tags: {json.dumps(unique_tags)}
image: {img_rel_path}
linkedin_url: "{p['linkedin_url']}"
description: "{first_p.replace('\"', '')}"
---

![{title}]({img_rel_path})

{cleaned_body}

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn]({p['linkedin_url']})
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
"""
    return md

# Clear old synthetic posts
old_files = os.listdir(posts_dir)
print(f"Cleaning {len(old_files)} old post files...")
for f in old_files:
    if f.endswith(".md"):
        os.remove(os.path.join(posts_dir, f))

# Base date range: May 1, 2026 to Sept 7, 2026
start_date = datetime(2026, 5, 1, 9, 0, 0)
end_date = datetime(2026, 9, 7, 18, 0, 0)
total_count = len(all_posts)
time_step = (end_date - start_date) / max(total_count, 1)

print(f"Generating {total_count} genuine LinkedIn posts...")

generated_count = 0
for idx, p in enumerate(all_posts):
    current_dt = start_date + idx * time_step
    date_str = current_dt.strftime("%Y-%m-%d %H:%M:%S +0930")
    file_date_prefix = current_dt.strftime("%Y-%m-%d")
    
    title, slug = make_title_and_slug(p)
    filename = f"{file_date_prefix}-{slug}.md"
    target_md_path = os.path.join(posts_dir, filename)
    
    # Handle image
    img_filename = f"{slug}.jpg"
    target_img_path = os.path.join(images_dir, img_filename)
    img_rel_path = f"/assets/images/posts/{img_filename}"
    
    if p["img_exists"]:
        shutil.copy2(p["img_local_path"], target_img_path)
    else:
        # Fallback to an existing card image if no image in DB
        fallback_img = os.path.join(images_dir, "tip_001.png")
        if os.path.exists(fallback_img):
            img_filename = f"{slug}.png"
            target_img_path = os.path.join(images_dir, img_filename)
            img_rel_path = f"/assets/images/posts/{img_filename}"
            shutil.copy2(fallback_img, target_img_path)
            
    md_content = format_post_markdown(p, title, slug, img_rel_path, date_str)
    
    with open(target_md_path, "w", encoding="utf-8") as f_out:
        f_out.write(md_content)
        
    generated_count += 1
    if (idx + 1) % 10 == 0 or idx == total_count - 1:
        print(f"[{idx+1:02d}/{total_count}] Generated: {filename}")

print(f"\nSUCCESS: Generated {generated_count} real LinkedIn Tips & Tricks posts in _posts/!")
