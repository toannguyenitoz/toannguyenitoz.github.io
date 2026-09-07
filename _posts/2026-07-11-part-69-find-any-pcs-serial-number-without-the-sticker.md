---
layout: post
title: "Windows Tips & Tricks – Part 69: Find Any PCs Serial Number Without the Sticker"
date: 2026-07-11 08:57:48 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "HelpDesk", "SysAdmin", "PowerShell", "Windows11"]
image: /assets/images/posts/part-69-find-any-pcs-serial-number-without-the-sticker.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7492347950141108224/"
description: "«“I need the laptop's Service Tag, but the sticker is completely worn out!”»"
---

![Windows Tips & Tricks – Part 69: Find Any PCs Serial Number Without the Sticker](/assets/images/posts/part-69-find-any-pcs-serial-number-without-the-sticker.jpg)

«“I need the laptop's Service Tag, but the sticker is completely worn out!”»

This is a classic Helpdesk situation.

The user can't read the sticker.
The desktop is under a desk.
The laptop is connected to a docking station.
And you just need one piece of information to create a hardware support ticket.

Don't crawl under the desk.

Ask Windows. 😎

🛠️ How to Check

Open PowerShell and run:

```powershell
Get-CimInstance Win32_BIOS | Select-Object SerialNumber
```

Windows will return the manufacturer's Serial Number / Service Tag stored in the system BIOS.

- Why this matters

- No need to physically inspect the device
- Avoids mistakes from reading tiny or damaged labels
- Useful for Dell, HP, Lenovo and other OEM devices
- Perfect for warranty and hardware replacement tickets
- Saves time when supporting multiple users

🚀 Pro Tip – Check a Remote PC

If you have the required administrative permissions, you can query another Windows computer remotely:

Invoke-Command -ComputerName "PC-NAME" -ScriptBlock {
```powershell
Get-CimInstance Win32_BIOS | Select-Object SerialNumber
```
}

Replace "PC-NAME" with the target computer name.

No RDP.
No interrupting the user.
Just the information you need.

- ️ Legacy Command

You may still see this command in older IT documentation:

wmic bios get serialnumber

It can work on systems where WMIC is still available, but PowerShell/CIM is the better approach for modern Windows environments.

«💡 Stop squinting at faded stickers.
Ask the operating system.»

Small command.
Big time saver for Helpdesk.

Follow for more practical Windows, IT Support & SysAdmin tips. 🚀

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7492347950141108224/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
