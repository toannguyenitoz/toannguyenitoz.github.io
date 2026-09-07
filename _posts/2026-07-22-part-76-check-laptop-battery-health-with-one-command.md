---
layout: post
title: "Windows Tips & Tricks – Part 76: Check Laptop Battery Health With One Command"
date: 2026-07-22 10:01:27 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "SysAdmin", "HelpDesk", "Hardware", "BatteryHealth"]
image: /assets/images/posts/part-76-check-laptop-battery-health-with-one-command.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7494872296394776576/"
description: "My battery drops from 100% to dead in less than an hour. Do I need a new battery?"
---

![Windows Tips & Tricks – Part 76: Check Laptop Battery Health With One Command](/assets/images/posts/part-76-check-laptop-battery-health-with-one-command.jpg)

"My battery drops from 100% to dead in less than an hour. Do I need a new battery?"

Before replacing the battery, let Windows show you the actual numbers. 📊

- **How to check:**

🖥️ Press Windows + X
➡️ Select Terminal (Admin)
➡️ Run:

```powershell
powercfg /batteryreport /output "C:\battery_report.html"
```

📄 Windows will generate a detailed HTML report.

Look for:

- Design Capacity – original battery capacity
- Full Charge Capacity – current maximum capacity
- Capacity History – degradation over time

- Why it matters

- Proves whether the battery is actually degraded
- Supports hardware replacement & warranty claims
- Helps distinguish battery problems from heavy power usage
- No third-party diagnostic software required

🚀 Pro Tip

Don't guess whether the battery is dying.

Let Windows give you the data.

Follow for more daily SysAdmin & IT Support tips! 💻🚀

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7494872296394776576/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
