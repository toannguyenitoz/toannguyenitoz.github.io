---
layout: post
title: "Part 93: Fix a Stuck Print Queue in Seconds"
date: 2026-08-30 15:12:00 +0930
categories: [Network Troubleshooting]
tags: [Windows, SysAdmin, IT-Support, Troubleshooting, Part-93]
part: 93
series: "LinkedIn Windows & IT Support Tips & Tricks"
image: "/assets/images/posts/tip_093.png"
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7500290397190053888/"
description: "Part 93 of the LinkedIn IT Support Tips & Tricks series by Toan Nguyen — Fix a Stuck Print Queue in Seconds."
---

> **LinkedIn Series Origin:** This guide was originally shared on LinkedIn as part of the *Windows & IT Support Tips & Tricks* series by [Toan Nguyen](https://www.linkedin.com/feed/update/urn:li:activity:7500290397190053888/). Connect on LinkedIn to join the discussion and explore more enterprise troubleshooting playbooks.

---

## Visual Architecture & Quick Reference Guide

Below is the high-resolution reference card for this technique:

![Part 93 Infographic]({{ '/assets/images/posts/tip_093.png' | relative_url }})

---

## Technical Overview & Enterprise Diagnostic Walkthrough

Windows Tips & Tricks – Part 93 🖨️

🔧 Fix a Stuck Print Queue in Seconds

💬 “My document has been stuck on ‘Deleting’ and now nothing else will print!”

When the Windows Print Queue is frozen, clicking Cancel often does nothing. Instead of rebooting the whole PC, reset the Print Spooler directly from CMD.

⌨️ Run CMD as Administrator and execute:

net stop spooler

del /Q /F /S "%systemroot%\System32\Spool\Printers*.*"

net start spooler

⚡ What happens?

🔴 Stop the Print Spooler
🧹 Clear corrupted spool files
🟢 Restart the Print Spooler

The stuck print jobs are removed and the queue starts fresh.

🎯 Why IT Pros use it: ✅ No full PC reboot
✅ Clears “ghost” print jobs
✅ Fixes jobs stuck on “Deleting”
✅ Saves valuable HelpDesk time

💡 Pro Tip: Turn these commands into a FixPrinter.bat script for controlled self-service support.

⚠️ Note: This clears all pending print jobs on that PC, so use it when you are sure the queued jobs can be discarded.

🖨️ Stuck queu?
Stop → Clear → Restart → Print.

Happy Tuesday! ☕🚀

Follow for more daily IT Support & SysAdmin tips.


hashtag
#ToanNguyenITOz 
hashtag
#WindowsTips 
hashtag
#ITSupport 
hashtag
#SysAdmin 
hashtag
#HelpDesk 
hashtag
#Troubleshooting 
hashtag
#Windows11 
hashtag
#Printers 
hashtag
#SystemAdministrator 
hashtag
#TechTips 
hashtag
#ITOperations

---

## 💡 20+ Years Banking & Enterprise IT Takeaway

In high-availability enterprise environments, resolving endpoint anomalies at the root cause without requiring full workstation reboots or disruptive re-imaging saves hundreds of hours of service desk escalation. Master these native diagnostic routines to keep users productive and systems compliant.

---

## 🔗 Original Post & Community Discussion

Have you deployed this technique in your enterprise environment or corporate fleet? 
👉 **[View and join the original LinkedIn discussion](https://www.linkedin.com/feed/update/urn:li:activity:7500290397190053888/)**
