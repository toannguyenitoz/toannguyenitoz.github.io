---
layout: post
title: "Windows Tips & Tricks – Part 67: Check Active Directory Account Status Instantly"
date: 2026-07-09 19:05:51 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "HelpDesk", "SysAdmin", "ActiveDirectory", "SystemAdministrator"]
image: /assets/images/posts/part-67-check-active-directory-account-status-instantly.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7491959019524259840/"
description: "«“I’m sure my password is correct, but Windows keeps saying access denied. Am I locked out?”»"
---

![Windows Tips & Tricks – Part 67: Check Active Directory Account Status Instantly](/assets/images/posts/part-67-check-active-directory-account-status-instantly.jpg)

«“I’m sure my password is correct, but Windows keeps saying access denied. Am I locked out?”»

This is one of the most common Helpdesk tickets.

Instead of opening Active Directory Users and Computers (ADUC) or starting an RDP session just to check one account, you can query Active Directory directly from CMD.

🛠️ Quick Check

Open Command Prompt and run:

```powershell
net user USERNAME /domain
```

Replace "USERNAME" with the user's login ID.

The command gives you important account information, including:

- Account active
- Account locked
- Password last set
- Password expires
- Last logon

- Why this matters

- Quickly troubleshoot login failures
- Identify account status without opening ADUC
- Check password expiration
- Save time when supporting users remotely
- Useful when working through VPN or a remote support session

🚀 Pro Tip

Need to check who has Local Administrator rights on a workstation?

Run:

net localgroup administrators

You'll immediately see the users and groups assigned to the local Administrators group.

«Don't guess why a user can't log in.
Ask Active Directory.»

Small commands like these can save minutes on every ticket — and hundreds of hours across a Helpdesk team.

Follow for more practical Windows, IT Support & SysAdmin tips.

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7491959019524259840/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
