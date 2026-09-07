---
layout: post
title: "Windows Tips & Tricks – Part 92: Boot Directly to Advanced Startup or BIOS"
date: 2026-08-04 00:57:04 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "SysAdmin", "HelpDesk", "Windows11", "PowerShell"]
image: /assets/images/posts/part-92-boot-directly-to-advanced-startup-or-bios.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7499941830764052480/"
description: "💬 “I need Safe Mode, but this laptop boots too fast to catch the F8 or Delete key!”"
---

![Windows Tips & Tricks – Part 92: Boot Directly to Advanced Startup or BIOS](/assets/images/posts/part-92-boot-directly-to-advanced-startup-or-bios.jpg)

💬 “I need Safe Mode, but this laptop boots too fast to catch the F8 or Delete key!”

Modern NVMe SSDs can boot Windows in seconds. Instead of repeatedly restarting and fighting with the boot keys, let Windows take you directly to the recovery environment.

⌨️ Quick Trick

Press Windows + R → type cmd → Enter

Then run:

```powershell
shutdown /r /o /f /t 00
```

🛠️ What it does: 🔹 /r → Restart
- /o → Advanced Boot Options
- /f → Force-close applications
- /t 00 → Restart immediately

Windows will reboot directly to the 🔵 Choose an option screen, where you can access Safe Mode, Startup Repair and other recovery tools.

- Pro Tip – Need BIOS/UEFI?

From an Administrator Terminal, run:

```powershell
shutdown /r /fw /t 00
```

🚀 Windows will reboot directly into the motherboard’s BIOS/UEFI interface.

🎯 Stop mashing F-keys.
Let Windows take you there.

Happy Monday! ☕🚀

Follow for more daily Windows, IT Support & SysAdmin tips.

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7499941830764052480/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
