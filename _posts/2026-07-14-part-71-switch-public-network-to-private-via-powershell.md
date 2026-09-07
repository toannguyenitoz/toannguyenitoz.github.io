---
layout: post
title: "Windows Tips & Tricks – Part 71: Switch Public Network to Private via PowerShell"
date: 2026-07-14 12:41:42 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "SysAdmin", "HelpDesk", "PowerShell", "Networking"]
image: /assets/images/posts/part-71-switch-public-network-to-private-via-powershell.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7493057374207856640/"
description: "💬 “The PC has internet, but I can't access shared folders or network printers!”"
---

![Windows Tips & Tricks – Part 71: Switch Public Network to Private via PowerShell](/assets/images/posts/part-71-switch-public-network-to-private-via-powershell.jpg)

💬 “The PC has internet, but I can't access shared folders or network printers!”

🔎 The first thing I check is the Windows network profile.

If a trusted office network is incorrectly detected as Public, Network Discovery and File/Printer Sharing may not work.

🛠️ Quick Fix

1. Open Terminal (Admin)

2. Check the profile:

```powershell
Get-NetConnectionProfile
```

3. Change it to Private:

```powershell
Set-NetConnectionProfile -InterfaceIndex 12 -NetworkCategory Private
```

🔄 Replace 12 with your actual InterfaceIndex.

🎯 Why it matters

- Restore Network Discovery
- Troubleshoot network printers
- Access shared folders
- Useful for new PC deployment
- Faster than navigating Windows Settings

- ️ Pro Tip

Don't change every network to Private.

☕ Café | ✈️ Airport | 🏨 Hotel

- Keep untrusted networks as Public.

- Check → Identify → Fix → Verify

🚀 Follow for more practical Windows & IT Support tips!

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7493057374207856640/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
