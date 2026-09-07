---
layout: post
title: "Windows Tips & Tricks – Part 80: Which Process Is Using My Port?"
date: 2026-07-27 03:37:19 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "SysAdmin", "Networking", "HelpDesk", "WindowsServer"]
image: /assets/images/posts/part-80-which-process-is-using-my-port.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7495947788954791937/"
description: "“Port 80 is already in use!” 😩"
---

![Windows Tips & Tricks – Part 80: Which Process Is Using My Port?](/assets/images/posts/part-80-which-process-is-using-my-port.jpg)

“Port 80 is already in use!” 😩

Ever tried starting a web server or application only to discover that another process has already claimed the port?

- Don’t guess. Let Windows tell you exactly which process is responsible.

🖥️ Open CMD as Administrator and run:

netstat -ano | findstr :80

🔎 The last column shows the PID (Process ID) using the port.

Then identify the application:

tasklist /fi "pid eq 4520"

➡️ Replace 4520 with the PID you found.

- **Why it’s useful:**

- Quickly troubleshoot “Port already in use” errors
- Identify hidden services occupying network ports
- Avoid wasting time closing applications one by one
- Useful for Windows Server, web servers and development environments

🔥 Pro Tip:

Want to see all listening ports and their associated processes?

netstat -abno

You can also save the output for later analysis:

netstat -abno > C:\ports.txt

- Stop guessing. Find the PID. Identify the process. 🎯

🚀 Follow for more practical Windows, IT Support & SysAdmin tips!

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7495947788954791937/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
