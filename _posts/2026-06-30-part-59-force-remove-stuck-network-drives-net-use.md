---
layout: post
title: "Windows Tips & Tricks – Part 59: Force Remove Stuck Network Drives (net use)"
date: 2026-06-30 07:54:08 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "Windows11", "Networking", "MappedDrive", "FileShare"]
image: /assets/images/posts/part-59-force-remove-stuck-network-drives-net-use.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7489425794218287104/"
description: "🗑️ Force Remove Stuck Network Drives (net use)"
---

![Windows Tips & Tricks – Part 59: Force Remove Stuck Network Drives (net use)](/assets/images/posts/part-59-force-remove-stuck-network-drives-net-use.jpg)

🗑️ Force Remove Stuck Network Drives (net use)

A mapped network drive shows a red X, won't open, and File Explorer freezes when you try to disconnect it.

Instead of rebooting the PC, remove the broken network connection with a single command.

- How to Do It

Open Command Prompt (run as the logged-in user, not Administrator)

Run:

net use Z: /delete

«Replace Z: with the drive letter you want to remove.»

🎯 Why IT Pros Use It

- Remove disconnected or stale mapped drives instantly

- Prevent File Explorer from freezing

- Resolve authentication issues after password changes

- Clear broken VPN or file server connections

- Faster and more reliable than using File Explorer

🚀 Pro Tip

Need to remove all mapped drives before reconnecting?

Run:

net use * /delete /y

Then reconnect to your network shares using your login script, Group Policy, or manual mapping.

- When File Explorer gets stuck, let the command line take over.

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7489425794218287104/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
