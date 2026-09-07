---
layout: post
title: "Part 95: Check SSD/HDD Health Instantly"
date: 2026-09-01 20:00:00 +0930
categories: [Network Troubleshooting]
tags: [Windows, SysAdmin, IT-Support, Troubleshooting, Part-95]
part: 95
series: "LinkedIn Windows & IT Support Tips & Tricks"
image: "/assets/images/posts/tip_095.png"
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7501015173453893632/"
description: "Part 95 of the LinkedIn IT Support Tips & Tricks series by Toan Nguyen — Check SSD/HDD Health Instantly."
---

> **LinkedIn Series Origin:** This guide was originally shared on LinkedIn as part of the *Windows & IT Support Tips & Tricks* series by [Toan Nguyen](https://www.linkedin.com/feed/update/urn:li:activity:7501015173453893632/). Connect on LinkedIn to join the discussion and explore more enterprise troubleshooting playbooks.

---

## Visual Architecture & Quick Reference Guide

Below is the high-resolution reference card for this technique:

![Part 95 Infographic]({{ '/assets/images/posts/tip_095.png' | relative_url }})

---

## Technical Overview & Enterprise Diagnostic Walkthrough

🛠️ WINDOWS TIPS & TRICKS – PART 95

💾 Check SSD/HDD Health Instantly

“My PC is extremely slow and randomly freezes, but CPU and RAM usage look completely normal. Is the drive failing?”

🔍 Before reinstalling Windows or blaming the software, check the storage health first.

⚡ PowerShell:

```powershell
Get-PhysicalDisk | Format-Table FriendlyName, MediaType, HealthStatus, OperationalStatus
```

👀 Check these two fields:

🟢 HealthStatus → Healthy
🟢 OperationalStatus → OK

⚠️ Warning / Unhealthy / Failed → investigate immediately and back up the data.

💡 Pro Tip

On systems where PowerShell isn't available, you can also check via CMD:

wmic diskdrive get model, status

🚨 If you see “Pred Fail”, don't waste time troubleshooting Windows. Protect the data first.

🎯 The IT Pro mindset:
Don’t troubleshoot software on dying hardware.

🚀 Follow for more daily Windows, SysAdmin & IT Support tips!


hashtag
#ToanNguyenITOz 
hashtag
#WindowsTips 
hashtag
#SysAdmin 
hashtag
#ITSupport 
hashtag
#HelpDesk 
hashtag
#Hardware 
hashtag
#PowerShell 
hashtag
#Troubleshooting 
hashtag
#Windows11 
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
👉 **[View and join the original LinkedIn discussion](https://www.linkedin.com/feed/update/urn:li:activity:7501015173453893632/)**
