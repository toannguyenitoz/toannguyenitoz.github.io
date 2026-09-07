---
layout: post
title: "Windows Tips & Tricks – Part 28: Fix Password Loops with Credential Manager"
date: 2026-05-17 03:39:30 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "Windows11", "CredentialManager", "ActiveDirectory", "Microsoft365"]
image: /assets/images/posts/part-28-fix-password-loops-with-credential-manager.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7478568075164901376/"
description: "Outlook keeps asking for a password? Teams won't sign in? Account keeps getting locked?"
---

![Windows Tips & Tricks – Part 28: Fix Password Loops with Credential Manager](/assets/images/posts/part-28-fix-password-loops-with-credential-manager.jpg)

Outlook keeps asking for a password? Teams won't sign in? Account keeps getting locked?

The issue is often an old password stored in Windows.

- How to Open

⌨️ Windows + R

➡️ Type:

control keymgr.dll

➡️ Press Enter

➡️ Open Windows Credentials

🎯 Why IT Pros Use It

- Fix Outlook and Teams password prompts

- Resolve account lockouts

- Clear old VPN and Wi-Fi credentials

- Fix network drive access issues

🚀 Pro Tip

Check the Modified Date before deleting credentials.

Older entries are often the source of authentication problems.

- ️ Avoid deleting SSO_POP or MicrosoftAccount credentials unless you want users to re-sign in to Microsoft 365 apps.

- When passwords change, Windows sometimes needs help forgetting the old ones.

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7478568075164901376/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
