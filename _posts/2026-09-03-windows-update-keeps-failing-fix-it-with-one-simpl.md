---
layout: post
title: "Windows Update Keeps Failing? Fix It with One Simple Script"
date: 2026-09-03 00:24:08 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "Windows11", "Windows10", "WindowsUpdate", "Microsoft", "HelpDesk"]
image: /assets/images/posts/windows-update-keeps-failing-fix-it-with-one-simpl.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7470431962394955776/"
description: "Have you ever encountered:"
---

![Windows Update Keeps Failing? Fix It with One Simple Script](/assets/images/posts/windows-update-keeps-failing-fix-it-with-one-simpl.jpg)

- Windows Update Keeps Failing? Fix It with One Simple Script!

Have you ever encountered:

❌ Windows Update stuck at 0%, 20%, or 100%
❌ Updates downloading forever but never installing
❌ Error codes appearing every time you check for updates
❌ Windows Update simply refusing to work

Instead of spending hours troubleshooting, try resetting the entire Windows Update infrastructure with a simple batch script.

🚀 What This Script Does

- Stops Windows Update Services
• Windows Update Service (wuauserv)
• Background Intelligent Transfer Service (BITS)
• Cryptographic Services (cryptsvc)
• Windows Installer (msiserver)

🧹 Clears Corrupted Update Cache
The script automatically resets:

📂 SoftwareDistribution
📂 Catroot2

These folders are common causes of update failures and corrupted downloads.

🔄 Restarts All Critical Services
Once cleanup is complete, all required services are started again automatically.

🩺 Repairs System Files
The script runs:

💻 sfc /scannow

This built-in Windows utility scans for missing or corrupted system files and repairs them whenever possible.

📝 How to Create and Run the Script

1. Open Notepad

2. Copy and paste the script into the Notepad window

3. Click File → Save As

4. In Save as type, select:
📄 All Files (.)

5. Save the file as:
💾 WindowsUpdateRepair.bat

6. Right-click the file and select:
🛡️ Run as Administrator

7. Wait for the process to complete

8. Restart your computer and check Windows Update again

- When Should You Use This?

- Windows Update errors
- Failed cumulative updates
- Update installation loops
- Corrupted update cache
- General Windows Update troubleshooting

- ️ Important

- Run the script as Administrator
- The system scan may take 10–30 minutes depending on your hardware
- A restart is recommended after the process completes

🎯 Final Result

✔ Clean Windows Update cache
✔ Repaired system files
✔ Refreshed update services
✔ Better chance of successful Windows Updates

💬 Sometimes the quickest solution isn't reinstalling Windows — it's simply resetting the components that Windows Update relies on.

🚀 Follow for more Windows Tips, IT Support tricks, and productivity hacks every day!

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7470431962394955776/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
