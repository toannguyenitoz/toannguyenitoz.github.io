---
layout: post
title: "Windows Tips & Tricks – Part 49: Update All Your Apps with One Command (Winget)"
date: 2026-06-14 13:14:38 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "Winget", "WindowsPackageManager", "Windows11", "Automation"]
image: /assets/images/posts/part-49-update-all-your-apps-with-one-command-winget.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7485794564914446336/"
description: "🚀 Update All Your Apps with One Command (Winget)"
---

![Windows Tips & Tricks – Part 49: Update All Your Apps with One Command (Winget)](/assets/images/posts/part-49-update-all-your-apps-with-one-command-winget.jpg)

🚀 Update All Your Apps with One Command (Winget)

Still opening Chrome, Zoom, Adobe Reader, and other apps one by one just to check for updates?

Windows includes a built-in package manager that can update multiple applications with a single command.

- How to Run It

⌨️ Open Command Prompt or Windows Terminal as Administrator

Run:

```powershell
winget upgrade --all
```

Windows will automatically download and install available updates for supported applications.

🎯 Why IT Pros Use It

- Update multiple applications at once

- Improve security by patching outdated software

- Save time compared to manual updates

- Built into modern Windows versions

- Great for IT maintenance and endpoint management

🚀 Pro Tip

Want to review available updates before installing them?

Run:

```powershell
winget upgrade
```

You'll see a table showing:

📦 Application Name

🔢 Current Version

🆕 Available Version

This lets you decide exactly what to update.

- One command can replace dozens of manual software updates.

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7485794564914446336/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
