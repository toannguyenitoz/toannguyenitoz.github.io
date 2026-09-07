---
layout: post
title: "Windows Tips & Tricks – Part 38: Unstick Frozen Windows Updates"
date: 2026-06-01 22:19:01 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "Windows11", "WindowsUpdate", "HelpDesk", "SysAdmin"]
image: /assets/images/posts/part-38-unstick-frozen-windows-updates.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7482231566761349121/"
description: "Windows Update stuck at 0% Downloading, Pending Install, or failing repeatedly?"
---

![Windows Tips & Tricks – Part 38: Unstick Frozen Windows Updates](/assets/images/posts/part-38-unstick-frozen-windows-updates.jpg)

Windows Update stuck at 0% Downloading, Pending Install, or failing repeatedly?

A corrupted update cache may be the culprit.

- Run Command Prompt as Administrator

net stop wuauserv
net stop bits
ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
net start wuauserv
net start bits

🎯 Why IT Pros Use It

- Fix endless update loops

- Clear corrupted update downloads

- Force Windows to download fresh update files

- Improve security by restoring update functionality

🚀 Pro Tip

The SoftwareDistribution folder stores temporary Windows Update files.

Renaming it forces Windows to create a brand-new update cache automatically.

After updates install successfully, you can delete the old folder to recover disk space.

- Sometimes the fastest fix is starting with a clean update cache.

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7482231566761349121/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
