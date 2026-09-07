---
layout: post
title: "Windows Tips & Tricks – Part 60: Access Remote Files with Windows Administrative Shares (C)"
date: 2026-07-01 21:46:05 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "Windows11", "AdminShares", "CShare", "ActiveDirectory"]
image: /assets/images/posts/part-60-access-remote-files-with-windows-administrative.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7489787666377428992/"
description: "📁 Access Remote Files with Windows Administrative Shares (C$)"
---

![Windows Tips & Tricks – Part 60: Access Remote Files with Windows Administrative Shares (C)](/assets/images/posts/part-60-access-remote-files-with-windows-administrative.jpg)

📁 Access Remote Files with Windows Administrative Shares (C$)

Need to retrieve a log file or copy an installer to a user's PC—but they're in the middle of an important meeting?

If you have the appropriate administrative permissions, Windows provides built-in Administrative Shares that let you access remote drives without starting a Remote Desktop session.

- How to Access It

⌨️ Press Windows + R

Type:

\\PC-NAME\C$

«Replace PC-NAME with the target computer's hostname or IP address.»

If prompted, authenticate using an account with the necessary administrative permissions.

🎯 Why IT Pros Use It

- Access the remote file system without RDP

- Retrieve log files, crash dumps, or configuration files

- Copy scripts and installers to remote devices

- Keep the user's session uninterrupted

- Perfect for enterprise administration and troubleshooting

🚀 Pro Tip

Need to place a file directly on the user's desktop?

Browse to:

\\PC-NAME\C$\Users\USERNAME\Desktop

Replace USERNAME with the user's profile name, then copy the required shortcut, script, or document.

«Note: Administrative shares ("C$", "D$", "ADMIN$") are available only when enabled, the target computer is reachable over the network, and your account has sufficient administrative privileges.»

- The best IT support solves problems behind the scenes—without interrupting the user.

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7489787666377428992/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
