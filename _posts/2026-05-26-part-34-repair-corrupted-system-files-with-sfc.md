---
layout: post
title: "Windows Tips & Tricks – Part 34: Repair Corrupted System Files with SFC"
date: 2026-05-26 14:51:13 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "Windows11", "SFC", "DISM", "HelpDesk"]
image: /assets/images/posts/part-34-repair-corrupted-system-files-with-sfc.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7480726294943461377/"
description: "Start Menu glitching? Random Windows errors? Strange system behavior?"
---

![Windows Tips & Tricks – Part 34: Repair Corrupted System Files with SFC](/assets/images/posts/part-34-repair-corrupted-system-files-with-sfc.jpg)

Start Menu glitching? Random Windows errors? Strange system behavior?

Before reinstalling Windows, run System File Checker (SFC).

- How to Run

⌨️ Search cmd

➡️ Run as Administrator

➡️ Type:

```powershell
sfc /scannow
```

🎯 Why IT Pros Use It

- Repair corrupted Windows files

- Fix UI glitches and crashes

- Resolve issues after failed updates

- Avoid unnecessary Windows reinstalls

🚀 Pro Tip

If SFC can't fix everything, run:

```powershell
DISM /Online /Cleanup-Image /RestoreHealth
```

Then run:

```powershell
sfc /scannow
```

again.

- Repair first. Reinstall later.

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7480726294943461377/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
