---
layout: post
title: "Windows Tips & Tricks – Part 54: Check Account Lockout & Password Status in Seconds"
date: 2026-06-22 10:34:23 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "ActiveDirectory", "PowerShell", "HelpDesk", "SysAdmin"]
image: /assets/images/posts/part-54-check-account-lockout-password-status-in-second.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7487629862476722176/"
description: "🔓 Check Account Lockout & Password Status in Seconds"
---

![Windows Tips & Tricks – Part 54: Check Account Lockout & Password Status in Seconds](/assets/images/posts/part-54-check-account-lockout-password-status-in-second.jpg)

🔓 Check Account Lockout & Password Status in Seconds

A user can't sign in and says:

"My password isn't working. Is my account locked, or has my password expired?"

Before opening Active Directory Users and Computers (ADUC), quickly check the account status from the command line.

- How to Check

Open Command Prompt as Administrator and run:

```powershell
net user username /domain
```

«Replace username with the user's account name.»

You'll instantly see details such as:

- Account Active

- Account Expires

- Password Last Set

- Password Expires

- Last Logon

🎯 Why IT Pros Use It

- Verify whether the account is active

- Check password expiration dates

- Review the user's last logon

- Confirm the correct username

- Troubleshoot authentication issues without opening ADUC

🚀 Pro Tip

Need to identify all locked-out accounts in your Active Directory environment?

Run this PowerShell command (RSAT required):

```powershell
Search-ADAccount -LockedOut |
```
Select-Object Name, SamAccountName

This provides a quick list of every locked account, helping you resolve issues proactively.

- The fastest way to solve a login problem is to verify the account before making assumptions.

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7487629862476722176/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
