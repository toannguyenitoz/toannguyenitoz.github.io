---
layout: post
title: "Windows Tips & Tricks – Part 79: Force-Clear a Frozen Print Queue"
date: 2026-07-25 13:45:21 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "SysAdmin", "HelpDesk", "Printers", "Windows11"]
image: /assets/images/posts/part-79-force-clear-a-frozen-print-queue.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7495622623930867712/"
description: "🔥 Force-Clear a Frozen Print Queue"
---

![Windows Tips & Tricks – Part 79: Force-Clear a Frozen Print Queue](/assets/images/posts/part-79-force-clear-a-frozen-print-queue.jpg)

🔥 Force-Clear a Frozen Print Queue

“My print job is stuck on ‘Deleting...’ and now nothing else will print!” 😩

A classic Helpdesk ticket: the Windows Print Spooler gets stuck and the Cancel button simply refuses to work.

- **The quick fix:**

🖥️ Open CMD as Administrator and run:

net stop spooler

del /Q /F /S "%systemroot%\System32\Spool\Printers*.*"

net start spooler

⚙️ What happens?

- Stop the Print Spooler
🧹 Clear stuck print jobs
▶️ Start the Spooler again
- Clean print queue — no reboot required

🚀 Why it matters

- Removes stuck and “ghost” print jobs
- Saves time and avoids unnecessary reboots
- Works across major printer brands
- Much faster than waiting for the GUI to respond

- **Pro Tip:**
Save these commands as FixPrinter.bat and turn them into a simple Helpdesk self-service tool.

🎯 Don’t reboot. Reset the Spooler.

🚀 Follow for more daily Windows, SysAdmin & IT Support tips!

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7495622623930867712/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
