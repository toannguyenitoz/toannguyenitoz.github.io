---
layout: post
title: "Windows Tips & Tricks – Part 66: Find Which App Is Locking a File – Resource Monitor"
date: 2026-07-08 05:13:54 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "HelpDesk", "SysAdmin", "Windows11", "SystemAdministrator"]
image: /assets/images/posts/part-66-find-which-app-is-locking-a-file-resource-monit.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7491597549343072257/"
description: "🔓 Find Which App Is Locking a File – Resource Monitor"
---

![Windows Tips & Tricks – Part 66: Find Which App Is Locking a File – Resource Monitor](/assets/images/posts/part-66-find-which-app-is-locking-a-file-resource-monit.jpg)

🔓 Find Which App Is Locking a File – Resource Monitor

«“I’m trying to delete or rename a file, but Windows says it’s being used by another program. I’ve already closed everything!” 😤»

Before rebooting the PC or randomly closing applications, let Windows tell you exactly which process is holding the file.

🛠️ How to find it

⌨️ Press Windows + R
➡️ Type:

resmon

➡️ Press Enter
➡️ Go to the CPU tab
➡️ Expand Associated Handles
➡️ In Search Handles, type the file name

Windows will show the process currently using the file — for example:

"winword.exe"
"excel.exe"
"explorer.exe"

You can then investigate and, where appropriate, end the offending process.

- Why this matters

- Find hidden processes locking files
- Avoid unnecessary PC reboots
- Useful for troubleshooting OneDrive, Office and file-share issues
- Built into Windows — no third-party software required

🚀 Pro Tip:
If you have Microsoft PowerToys installed, File Locksmith provides an even easier way to see “What’s using this file?” directly from File Explorer.

«Don't reboot the PC just to delete one file.
Find the process. Fix the problem. Keep the user working.»

Follow for more practical Windows & IT Support tips. 🚀

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7491597549343072257/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
