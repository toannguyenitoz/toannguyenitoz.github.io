---
layout: post
title: "Windows Tips & Tricks – Part 83: Check Disk Health Instantly with PowerShell"
date: 2026-07-31 21:13:10 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "SysAdmin", "PowerShell", "HelpDesk", "Hardware"]
image: /assets/images/posts/part-83-check-disk-health-instantly-with-powershell.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7497030460523347969/"
description: "💬 “The PC is extremely slow. Is the SSD dying?”"
---

![Windows Tips & Tricks – Part 83: Check Disk Health Instantly with PowerShell](/assets/images/posts/part-83-check-disk-health-instantly-with-powershell.jpg)

💬 “The PC is extremely slow. Is the SSD dying?”

Before installing third-party tools, let Windows check the physical drive for you. ⚡

💻 Open Terminal (Admin) and run:

```powershell
Get-PhysicalDisk | Select FriendlyName, OperationalStatus, HealthStatus, MediaType, Size
```

🔎 Check for:

- HealthStatus → Healthy / Warning / Unhealthy
- OperationalStatus → OK / problem
- SSD or HDD
- Drive capacity

🎯 Pro Tip

For deeper reliability information:

```powershell
Get-StorageReliabilityCounter
```

- Catching disk problems early can prevent unexpected downtime and data loss.

- Don’t wait for the disk to fail. Check it before it does. 🚀

Follow for more practical Windows, IT Support & SysAdmin tips!

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7497030460523347969/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
