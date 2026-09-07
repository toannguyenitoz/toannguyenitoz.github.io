---
layout: post
title: "Windows Tips & Tricks – Part 53: Retrieve a PC Serial Number in Seconds"
date: 2026-06-20 20:42:26 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "Windows11", "PowerShell", "WMIC", "AssetManagement"]
image: /assets/images/posts/part-53-retrieve-a-pc-serial-number-in-seconds.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7487256308023193601/"
description: "Need a laptop's serial number for a warranty claim or hardware support ticket?"
---

![Windows Tips & Tricks – Part 53: Retrieve a PC Serial Number in Seconds](/assets/images/posts/part-53-retrieve-a-pc-serial-number-in-seconds.jpg)

Need a laptop's serial number for a warranty claim or hardware support ticket?

Instead of asking users to flip over their laptop and read a tiny, faded sticker, let Windows retrieve it for you.

- Using Command Prompt

Open Command Prompt as Administrator and run:

wmic bios get serialnumber

The system will display the device's OEM serial number (such as a Dell Service Tag or Lenovo Serial Number).

🎯 Why IT Pros Use It

- Retrieve the correct serial number instantly

- No need to inspect faded labels or barcodes

- Perfect for warranty checks and vendor support

- Reduce errors caused by mistyped serial numbers

- Save time during remote support sessions

🚀 Pro Tip

wmic is being deprecated in newer versions of Windows.

Use the PowerShell equivalent instead:

```powershell
Get-CimInstance Win32_BIOS | Select-Object SerialNumber
```

If you have the necessary permissions, you can also query a remote computer:

Invoke-Command -ComputerName "PC-NAME" -ScriptBlock {
```powershell
Get-CimInstance Win32_BIOS | Select-Object SerialNumber
```
}

- Don't ask users to read tiny stickers—let Windows do it for you.

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7487256308023193601/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
