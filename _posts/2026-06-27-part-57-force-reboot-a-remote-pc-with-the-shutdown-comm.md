---
layout: post
title: "Windows Tips & Tricks – Part 57: Force Reboot a Remote PC with the Shutdown Command"
date: 2026-06-27 04:10:14 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "Windows11", "CommandPrompt", "RemoteSupport", "Shutdown"]
image: /assets/images/posts/part-57-force-reboot-a-remote-pc-with-the-shutdown-comm.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7488696163953713153/"
description: "A user's PC is completely frozen."
---

![Windows Tips & Tricks – Part 57: Force Reboot a Remote PC with the Shutdown Command](/assets/images/posts/part-57-force-reboot-a-remote-pc-with-the-shutdown-comm.jpg)

A user's PC is completely frozen.

❌ Mouse won't move.

❌ Keyboard is unresponsive.

❌ Remote Desktop and remote support tools can't connect.

Before asking them to hold the power button, try restarting the computer remotely.

- How to Do It

Open Command Prompt as Administrator and run:

```powershell
shutdown /m \\PC-NAME /r /f /t 0
```

«Replace PC-NAME with the target computer's hostname or IP address.»

🎯 Why IT Pros Use It

- Restart a remote PC without physical access

- Force-close unresponsive applications

- Execute an immediate reboot

- Avoid unnecessary hard power-offs that may risk file system corruption

- Perfect for enterprise and Active Directory environments

🚀 Pro Tip

Need to warn the user before restarting?

Schedule the reboot with a custom message:

```powershell
shutdown /m \\PC-NAME /r /f /t 60 /c "IT Support is restarting your PC to resolve an issue. Please save your work."
```

The user will receive a Windows notification with a 60-second countdown, giving them time to save any open work before the restart begins.

- When remote support tools stop responding, the command line can still save the day.

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7488696163953713153/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
