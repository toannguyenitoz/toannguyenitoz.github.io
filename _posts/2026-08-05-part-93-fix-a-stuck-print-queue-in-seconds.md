---
layout: post
title: "Windows Tips & Tricks – Part 93: Fix a Stuck Print Queue in Seconds"
date: 2026-08-05 14:49:01 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "SysAdmin", "HelpDesk", "Windows11", "Printers"]
image: /assets/images/posts/part-93-fix-a-stuck-print-queue-in-seconds.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7500290397190053888/"
description: "💬 “My document has been stuck on ‘Deleting’ and now nothing else will print!”"
---

![Windows Tips & Tricks – Part 93: Fix a Stuck Print Queue in Seconds](/assets/images/posts/part-93-fix-a-stuck-print-queue-in-seconds.jpg)

💬 “My document has been stuck on ‘Deleting’ and now nothing else will print!”

When the Windows Print Queue is frozen, clicking Cancel often does nothing. Instead of rebooting the whole PC, reset the Print Spooler directly from CMD.

⌨️ Run CMD as Administrator and execute:

net stop spooler

del /Q /F /S "%systemroot%\System32\Spool\Printers*.*"

net start spooler

- What happens?

🔴 Stop the Print Spooler
🧹 Clear corrupted spool files
🟢 Restart the Print Spooler

The stuck print jobs are removed and the queue starts fresh.

🎯 Why IT Pros use it: ✅ No full PC reboot
- Clears “ghost” print jobs
- Fixes jobs stuck on “Deleting”
- Saves valuable HelpDesk time

- Pro Tip: Turn these commands into a FixPrinter.bat script for controlled self-service support.

- ️ Note: This clears all pending print jobs on that PC, so use it when you are sure the queued jobs can be discarded.

🖨️ Stuck queu?
Stop → Clear → Restart → Print.

Happy Tuesday! ☕🚀

Follow for more daily IT Support & SysAdmin tips.

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7500290397190053888/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
