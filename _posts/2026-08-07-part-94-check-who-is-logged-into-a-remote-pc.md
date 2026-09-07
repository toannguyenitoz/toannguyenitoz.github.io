---
layout: post
title: "Windows Tips & Tricks – Part 94: Check Who Is Logged Into a Remote PC"
date: 2026-08-07 04:40:58 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "SysAdmin", "HelpDesk", "RemoteSupport", "Windows11"]
image: /assets/images/posts/part-94-check-who-is-logged-into-a-remote-pc.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7500664827191836672/"
description: "💬 “I need to reboot a remote PC, but is someone still working on it?”"
---

![Windows Tips & Tricks – Part 94: Check Who Is Logged Into a Remote PC](/assets/images/posts/part-94-check-who-is-logged-into-a-remote-pc.jpg)

💬 “I need to reboot a remote PC, but is someone still working on it?”

🚨 Don’t reboot blindly!

As an IT Support professional, you can check active sessions remotely using a simple built-in Windows command.

⌨️ Open CMD and run:

quser /server:COMPUTERNAME

🔎 You’ll immediately see:

👤 Username
🆔 Session ID
🟢 State – Active / Disconnected
⏱️ Idle Time

- Pro Tip

Found an old Disconnected session?

You can sign it out remotely:

```powershell
logoff <SessionID> /server:COMPUTERNAME
```

- ️ Careful: Never log off an active session without confirming with the user. Unsaved work could be lost.

🎯 The IT Pro Mindset:

Check → Confirm → Act.

🖥️ Don’t reboot blindly. Know who is using the machine first.

🚀 Follow for more daily IT Support & SysAdmin tips!

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7500664827191836672/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
