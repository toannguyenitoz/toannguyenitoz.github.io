---
layout: post
title: "Windows Tips & Tricks – Part 95: Check SSD/HDD Health Instantly"
date: 2026-08-08 18:32:55 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "SysAdmin", "HelpDesk", "Hardware", "PowerShell"]
image: /assets/images/posts/part-95-check-ssd-hdd-health-instantly.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7501015173453893632/"
description: "💾 Check SSD/HDD Health Instantly"
---

![Windows Tips & Tricks – Part 95: Check SSD/HDD Health Instantly](/assets/images/posts/part-95-check-ssd-hdd-health-instantly.jpg)

💾 Check SSD/HDD Health Instantly

“My PC is extremely slow and randomly freezes, but CPU and RAM usage look completely normal. Is the drive failing?”

🔍 Before reinstalling Windows or blaming the software, check the storage health first.

- **PowerShell:**

```powershell
Get-PhysicalDisk | Format-Table FriendlyName, MediaType, HealthStatus, OperationalStatus
```

👀 Check these two fields:

🟢 HealthStatus → Healthy
🟢 OperationalStatus → OK

- ️ Warning / Unhealthy / Failed → investigate immediately and back up the data.

- Pro Tip

On systems where PowerShell isn't available, you can also check via CMD:

wmic diskdrive get model, status

🚨 If you see “Pred Fail”, don't waste time troubleshooting Windows. Protect the data first.

🎯 The IT Pro mindset:
Don’t troubleshoot software on dying hardware.

🚀 Follow for more daily Windows, SysAdmin & IT Support tips!

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7501015173453893632/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
