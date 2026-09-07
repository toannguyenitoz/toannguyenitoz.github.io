---
layout: post
title: "Windows Tips & Tricks – Part 75: Recover Saved Wi-Fi Passwords via Command Line"
date: 2026-07-20 20:09:30 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "SysAdmin", "HelpDesk", "Networking", "SystemAdministrator", "TechTips"]
image: /assets/images/posts/part-75-recover-saved-wi-fi-passwords-via-command-line.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7494536718445096960/"
description: "📶 Recover Saved Wi-Fi Passwords via Command Line"
---

![Windows Tips & Tricks – Part 75: Recover Saved Wi-Fi Passwords via Command Line](/assets/images/posts/part-75-recover-saved-wi-fi-passwords-via-command-line.jpg)

📶 Recover Saved Wi-Fi Passwords via Command Line

“I just got a new company phone, but I can’t remember the office Wi-Fi password!” 😅

A classic HelpDesk situation.

The Windows laptop is already connected to the Wi-Fi — or has connected to it before — but nobody remembers the password.

Instead of hunting through router settings or asking the Network Team, you can retrieve the saved Wi-Fi password directly from Windows.

⌨️ Step 1 – Find saved Wi-Fi profiles

Open Command Prompt and run:

"netsh wlan show profiles"

Find the Wi-Fi network you need.

🔐 Step 2 – Reveal the saved password

Run:

"netsh wlan show profile name="WIFI_NAME" key=clear"

Replace "WIFI_NAME" with the actual Wi-Fi profile name.

Then look under:

Security settings → Key Content

That is the saved Wi-Fi password.

- Why this is useful

- Helps provision a new device quickly
- Useful when supporting remote workers
- Retrieves passwords for previously connected networks
- No need to access the router
- Built into Windows — no third-party tools required

🚀 Pro Tip

If you need to back up Wi-Fi profiles, Windows can export them with:

"netsh wlan export profile key=clear folder=C:\WiFiBackup"

- ️ Security note: The exported XML files can contain the Wi-Fi credentials in readable form. Protect the backup and delete it securely when it is no longer needed.

If Windows knows the Wi-Fi profile, you can retrieve it. 😉

Happy Sunday! ☕💻

Follow for more daily Windows, SysAdmin & IT Support tips.

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7494536718445096960/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
