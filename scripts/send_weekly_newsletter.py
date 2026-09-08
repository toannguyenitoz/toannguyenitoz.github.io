#!/usr/bin/env python3
"""
Weekly Tech Dispatch Newsletter Dispatcher
Author: Toan Nguyen (Toan Nguyen IT OZ)
Multi-Provider Failover Pool:
  1. Resend Primary API Key (3,000 emails/month)
  2. Resend Backup 1 API Key (3,000 emails/month)
  3. Resend Backup 2 API Key (3,000 emails/month)
  4. Brevo API Key (300 emails/day)
  5. Gmail SMTP Fallback (500 emails/day)
"""

import os
import sys
import glob
import re
import json
import smtplib
from email.mime.multipart import MIMEMultipart
from email.mime.text import MIMEText
from datetime import datetime
import urllib.request
import urllib.error

SITE_URL = "https://toannguyenitoz.github.io"
AUTHOR_NAME = "Toan Nguyen"
AUTHOR_BRAND = "IT Support With Toan (Toan Nguyen IT OZ)"
SENDER_EMAIL = os.getenv("NEWSLETTER_SENDER_EMAIL", "newsletter@toannguyenitoz.github.io")
SENDER_NAME = "Toan Nguyen IT OZ"

def get_latest_post():
    post_files = sorted(glob.glob('_posts/*.md'), reverse=True)
    if not post_files:
        return None
    latest_file = post_files[0]
    with open(latest_file, 'r', encoding='utf-8') as f:
        content = f.read()

    fm_match = re.search(r'^---\s*\n(.*?)\n---\s*\n(.*)$', content, re.DOTALL)
    if not fm_match:
        return None
    
    fm_text = fm_match.group(1)

    title_m = re.search(r'^title:\s*["\']?(.*?)["\']?\s*$', fm_text, re.MULTILINE)
    desc_m = re.search(r'^description:\s*["\']?(.*?)["\']?\s*$', fm_text, re.MULTILINE)
    image_m = re.search(r'^image:\s*["\']?(.*?)["\']?\s*$', fm_text, re.MULTILINE)
    part_m = re.search(r'^part:\s*(\d+)', fm_text, re.MULTILINE)

    basename = os.path.basename(latest_file).replace('.md', '')
    date_parts = basename.split('-')
    if len(date_parts) >= 4:
        slug = '-'.join(date_parts[3:])
    else:
        slug = basename

    post_url = f"{SITE_URL}/posts/{slug}/"
    image_url = f"{SITE_URL}{image_m.group(1)}" if image_m else f"{SITE_URL}/assets/images/toan-avatar.jpg"

    return {
        "title": title_m.group(1) if title_m else "New SysAdmin SOP Guide",
        "description": desc_m.group(1) if desc_m else "Latest technical standard operating procedure and troubleshooting guide.",
        "image": image_url,
        "part": part_m.group(1) if part_m else None,
        "url": post_url
    }

def get_featured_video():
    videos_file = '_data/videos.yml'
    if not os.path.exists(videos_file):
        return None
    with open(videos_file, 'r', encoding='utf-8') as f:
        lines = f.readlines()
    
    title = ""
    yt_id = ""
    for line in lines:
        if 'title:' in line and not title:
            title = line.split('title:')[1].strip().strip('"\'')
        if 'youtube_id:' in line and not yt_id:
            yt_id = line.split('youtube_id:')[1].strip().strip('"\'')
        if title and yt_id:
            break
    
    if yt_id:
        return {
            "title": title or "Top Viewed Video Tutorial",
            "url": f"https://www.youtube.com/watch?v={yt_id}",
            "thumbnail": f"https://img.youtube.com/vi/{yt_id}/hqdefault.jpg"
        }
    return None

def get_active_subscribers():
    subscribers = set()

    subs_file = '_data/subscribers.yml'
    if os.path.exists(subs_file):
        with open(subs_file, 'r', encoding='utf-8') as f:
            for line in f:
                if 'email:' in line:
                    email = line.split('email:')[1].strip().strip('"\'')
                    if '@' in email:
                        subscribers.add(email.lower())

    sb_url = os.getenv("SUPABASE_URL", "https://imkgmhdqjloovqvsmifu.supabase.co")
    sb_key = os.getenv("SUPABASE_SERVICE_ROLE_KEY") or os.getenv("SUPABASE_ANON_KEY", "sb_publishable_scdg680eJ1137pIwWz3uFQ_sK_a-TcL")
    if sb_url and sb_key:
        try:
            req = urllib.request.Request(
                f"{sb_url}/rest/v1/subscribers?select=email",
                headers={
                    "apikey": sb_key,
                    "Authorization": f"Bearer {sb_key}"
                }
            )
            with urllib.request.urlopen(req, timeout=5) as resp:
                data = json.loads(resp.read().decode())
                for row in data:
                    if row.get('email') and '@' in row['email']:
                        subscribers.add(row['email'].strip().lower())
        except Exception as e:
            print(f"[*] Supabase subscriber read note: {e}")

    return sorted(list(subscribers))

def render_email_html(post, video, subscriber_email):
    now_date = datetime.now().strftime("%B %d, %Y")
    part_badge = f'<span style="background:#0284C7;color:#ffffff;font-size:11px;font-weight:700;padding:3px 8px;border-radius:4px;margin-right:8px;text-transform:uppercase;">Part {post["part"]}</span>' if post.get('part') else ''

    video_block = ""
    if video:
        video_block = f"""
          <tr>
            <td style="padding:0 30px 24px;">
              <div style="border:1px solid #334155;border-radius:10px;padding:18px;background-color:#1E293B;">
                <span style="color:#F59E0B;font-size:12px;font-weight:700;text-transform:uppercase;">▶ Video Masterclass</span>
                <h3 style="margin:6px 0 10px;font-size:15px;color:#F8FAFC;">{video['title']}</h3>
                <a href="{video['url']}" style="color:#38BDF8;font-size:13px;font-weight:600;text-decoration:none;">
                  Watch on YouTube Walkthrough →
                </a>
              </div>
            </td>
          </tr>
        """

    html = f"""<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Weekly Tech Dispatch</title>
</head>
<body style="margin:0;padding:0;background-color:#090D16;font-family:-apple-system,BlinkMacSystemFont,'Segoe UI',Roboto,Helvetica,Arial,sans-serif;color:#F8FAFC;">
  <table role="presentation" width="100%" cellspacing="0" cellpadding="0" border="0" style="background-color:#090D16;padding:30px 10px;">
    <tr>
      <td align="center">
        <table role="presentation" width="100%" max-width="600" cellspacing="0" cellpadding="0" border="0" style="max-width:600px;background-color:#0F172A;border:1px solid #1E293B;border-radius:14px;overflow:hidden;box-shadow:0 10px 25px rgba(0,0,0,0.5);">
          
          <!-- Header Banner -->
          <tr>
            <td style="padding:26px 30px;background:linear-gradient(135deg,#0078D4 0%,#0284C7 100%);text-align:center;">
              <span style="display:inline-block;font-size:24px;margin-bottom:6px;">⚡</span>
              <h1 style="margin:0;font-size:22px;font-weight:800;color:#FFFFFF;letter-spacing:-0.02em;">WEEKLY TECH DISPATCH</h1>
              <p style="margin:6px 0 0;font-size:13px;color:rgba(255,255,255,0.9);font-weight:500;">Enterprise SysAdmin • Azure Cloud • PowerShell • {now_date}</p>
            </td>
          </tr>

          <!-- Intro Message -->
          <tr>
            <td style="padding:24px 30px 16px;color:#CBD5E1;font-size:14px;line-height:1.6;">
              Hi there, 👋<br><br>
              Here is your weekly roundup of battle-tested standard operating procedures, sysadmin troubleshooting guides, and production scripts from <strong>{AUTHOR_BRAND}</strong> in Adelaide, Australia.
            </td>
          </tr>

          <!-- Featured SOP Article Card -->
          <tr>
            <td style="padding:0 30px 20px;">
              <div style="border:1px solid #334155;border-radius:10px;overflow:hidden;background-color:#1E293B;">
                <img src="{post['image']}" alt="{post['title']}" style="width:100%;max-height:260px;object-fit:cover;display:block;">
                <div style="padding:20px;">
                  <div style="margin-bottom:10px;">
                    {part_badge}
                    <span style="color:#38BDF8;font-size:12px;font-weight:600;">Featured Field Blueprint</span>
                  </div>
                  <h2 style="margin:0 0 10px;font-size:17px;font-weight:700;line-height:1.4;">
                    <a href="{post['url']}" style="color:#F8FAFC;text-decoration:none;">{post['title']}</a>
                  </h2>
                  <p style="margin:0 0 16px;color:#94A3B8;font-size:13px;line-height:1.5;">
                    {post['description']}
                  </p>
                  <a href="{post['url']}" style="display:inline-block;background:#0078D4;color:#FFFFFF;padding:10px 20px;border-radius:6px;text-decoration:none;font-size:13px;font-weight:700;">
                    Read Full Step-by-Step Guide →
                  </a>
                </div>
              </div>
            </td>
          </tr>

          {video_block}

          <!-- PowerShell Pro-Tip Box -->
          <tr>
            <td style="padding:0 30px 24px;">
              <div style="background:#0B132B;border-left:4px solid #38BDF8;padding:14px 18px;border-radius:0 8px 8px 0;">
                <strong style="color:#38BDF8;font-size:13px;display:block;margin-bottom:6px;">⚡ SysAdmin Pro-Tip of the Week:</strong>
                <p style="margin:0;font-size:12px;color:#94A3B8;line-height:1.5;font-family:Consolas,monospace;">
                  Never RDP into remote domain controllers for routine administration. Use Remote Server Administration Tools (RSAT) or Invoke-Command over WinRM to keep credential exposure at zero.
                </p>
              </div>
            </td>
          </tr>

          <!-- Footer & Unsubscribe -->
          <tr>
            <td style="padding:24px 30px;background-color:#0B0F19;border-top:1px solid #1E293B;text-align:center;font-size:12px;color:#64748B;line-height:1.7;">
              You are receiving this email because you subscribed on <a href="{SITE_URL}" style="color:#38BDF8;text-decoration:none;">toannguyenitoz.github.io</a>.<br>
              Published with 💙 by {AUTHOR_NAME} • Adelaide, South Australia.<br><br>
              <div style="margin-bottom:12px;">
                <a href="{SITE_URL}/unsubscribe/?email={subscriber_email}" style="display:inline-block;padding:6px 14px;background:#1E293B;border:1px solid #334155;border-radius:4px;color:#EF4444;text-decoration:none;font-weight:600;font-size:11px;">
                  🚫 Unsubscribe from Weekly Dispatch
                </a>
              </div>
              <a href="{SITE_URL}/#contact" style="color:#94A3B8;text-decoration:underline;">Contact</a> • 
              <a href="https://www.linkedin.com/in/toan-nguyen-it-oz/" style="color:#94A3B8;text-decoration:underline;">LinkedIn</a> • 
              <a href="https://www.youtube.com/@ITSupportwithToan_Adl" style="color:#94A3B8;text-decoration:underline;">YouTube</a> • 
              <a href="{SITE_URL}/unsubscribe/?email={subscriber_email}" style="color:#64748B;text-decoration:underline;">Unsubscribe</a>
            </td>
          </tr>

        </table>
      </td>
    </tr>
  </table>
</body>
</html>"""
    return html

def send_via_resend(api_key, recipient, subject, html_content):
    url = "https://api.resend.com/emails"
    headers = {
        "Authorization": f"Bearer {api_key}",
        "Content-Type": "application/json",
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/115.0.0.0 Safari/537.36"
    }
    payload = json.dumps({
        "from": f"{SENDER_NAME} <onboarding@resend.dev>" if "onboarding" in SENDER_EMAIL else f"{SENDER_NAME} <{SENDER_EMAIL}>",
        "to": [recipient],
        "subject": subject,
        "html": html_content
    }).encode('utf-8')

    req = urllib.request.Request(url, data=payload, headers=headers, method='POST')
    with urllib.request.urlopen(req, timeout=10) as resp:
        return resp.status in (200, 201)

def send_via_brevo(api_key, recipient, subject, html_content):
    url = "https://api.brevo.com/v3/smtp/email"
    headers = {
        "api-key": api_key,
        "Content-Type": "application/json"
    }
    payload = json.dumps({
        "sender": {"name": SENDER_NAME, "email": "theodorenguyensa@gmail.com"},
        "to": [{"email": recipient}],
        "subject": subject,
        "htmlContent": html_content
    }).encode('utf-8')

    req = urllib.request.Request(url, data=payload, headers=headers, method='POST')
    with urllib.request.urlopen(req, timeout=10) as resp:
        return resp.status in (200, 201)

def send_via_gmail_smtp(user, app_password, recipient, subject, html_content):
    msg = MIMEMultipart('alternative')
    msg['Subject'] = subject
    msg['From'] = f"{SENDER_NAME} <{user}>"
    msg['To'] = recipient
    msg.attach(MIMEText(html_content, 'html'))

    with smtplib.SMTP_SSL('smtp.gmail.com', 465, timeout=10) as server:
        server.login(user, app_password)
        server.sendmail(user, recipient, msg.as_string())
    return True

def dispatch_email_with_failover(recipient, subject, html_content):
    providers = []

    # 1. Primary Resend Key
    if os.getenv("RESEND_API_KEY"):
        providers.append(("Resend Primary", lambda: send_via_resend(os.getenv("RESEND_API_KEY"), recipient, subject, html_content)))

    # 2. Resend Backup Key 1
    if os.getenv("RESEND_API_KEY_BACKUP_1"):
        providers.append(("Resend Backup 1", lambda: send_via_resend(os.getenv("RESEND_API_KEY_BACKUP_1"), recipient, subject, html_content)))

    # 3. Resend Backup Key 2
    if os.getenv("RESEND_API_KEY_BACKUP_2"):
        providers.append(("Resend Backup 2", lambda: send_via_resend(os.getenv("RESEND_API_KEY_BACKUP_2"), recipient, subject, html_content)))

    # 4. Brevo API (Sendinblue)
    if os.getenv("BREVO_API_KEY"):
        providers.append(("Brevo API", lambda: send_via_brevo(os.getenv("BREVO_API_KEY"), recipient, subject, html_content)))

    # 5. Gmail SMTP Fallback
    if os.getenv("GMAIL_USER") and os.getenv("GMAIL_APP_PASSWORD"):
        providers.append(("Gmail SMTP", lambda: send_via_gmail_smtp(os.getenv("GMAIL_USER"), os.getenv("GMAIL_APP_PASSWORD"), recipient, subject, html_content)))

    if not providers:
        print("  [!] Notice: No provider credentials in environment. Simulated dispatch successful.")
        return True

    for provider_name, send_fn in providers:
        try:
            success = send_fn()
            if success:
                print(f"  [+] Sent successfully to {recipient} via {provider_name}")
                return True
        except Exception as err:
            print(f"  [-] {provider_name} failed or rate-limited: {err}. Failing over to next provider...")

    print(f"  [X] All email providers exhausted for {recipient}!")
    return False

def main():
    print("=================================================================")
    print(" Weekly Tech Dispatch - Automated Newsletter Engine")
    print("=================================================================")

    post = get_latest_post()
    if not post:
        print("[!] No blog posts found in _posts/. Aborting.")
        sys.exit(1)

    print(f"[*] Latest Featured Guide: {post['title']}")
    video = get_featured_video()
    if video:
        print(f"[*] Featured Video: {video['title']}")

    subscribers = get_active_subscribers()
    print(f"[*] Total Active Subscribers: {len(subscribers)}")

    if not subscribers:
        print("[!] No active subscribers found. Exiting.")
        return

    subject = f"⚡ Tech Dispatch: {post['title']}"

    success_count = 0
    fail_count = 0

    for email in subscribers:
        print(f"[*] Dispatching to: {email}...")
        html = render_email_html(post, video, email)
        if dispatch_email_with_failover(email, subject, html):
            success_count += 1
        else:
            fail_count += 1

    print("\n=================================================================")
    print(f" Newsletter Run Finished: {success_count} succeeded, {fail_count} failed.")
    print("=================================================================")

if __name__ == '__main__':
    main()