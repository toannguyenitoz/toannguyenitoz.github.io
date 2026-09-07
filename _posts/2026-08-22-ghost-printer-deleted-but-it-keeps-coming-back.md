---
layout: post
title: "Ghost Printer? Deleted... but it keeps coming back"
date: 2026-08-22 23:20:29 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "Printer", "Kyocera", "ActiveDirectory", "PowerShell", "DesktopSupport"]
image: /assets/images/posts/ghost-printer-deleted-but-it-keeps-coming-back.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7488431909593858048/"
description: "👻 Ghost Printer? Deleted... but it keeps coming back!"
---

![Ghost Printer? Deleted... but it keeps coming back](/assets/images/posts/ghost-printer-deleted-but-it-keeps-coming-back.jpg)

👻 Ghost Printer? Deleted... but it keeps coming back!

One of the most interesting printer issues I've recently investigated involved a Kyocera network printer on a Windows computer joined to Active Directory.

The user reported:

«"I delete the printer... but it comes back a few seconds later."»

Naturally, the first thought was:

❓ Is Group Policy redeploying it?
❓ Is there a logon script?
❓ Is it coming from a Print Server?

So the investigation began.

- "Get-Printer" returned nothing.

- "Get-CimInstance Win32_Printer" also couldn't find the printer.

Yet the printer was still visible in Printers & scanners.

Since the computer was domain-joined, Active Directory and GPO were the obvious suspects.

After checking:

✔ Group Policy deployment
✔ Logon scripts
✔ Print Server mappings
✔ Scheduled Tasks

...none of them were responsible.

The breakthrough came after removing the Kyocera KX Driver.

Suddenly, the "ghost printer" disappeared—and it never came back.

This case was a great reminder that not every issue on a domain-joined computer is caused by Active Directory or Group Policy.

Sometimes the root cause is much closer to the client itself.

🧠 Lessons learned

• Don't jump to conclusions because a PC is domain-joined.
• Always validate your assumptions with evidence.
• Check the printer driver and vendor utilities before blaming GPO.
• Compare what the Windows GUI shows with PowerShell and CIM results.
• Eliminate potential causes one by one until the real root cause is found.

I've documented the complete investigation, troubleshooting process, commands used and lessons learned in my GitHub repository.

🔗 https://lnkd.in/gVtChu_X

Have you ever encountered a ghost printer that kept reappearing after deletion? I'd love to hear what caused it in your environment.

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7488431909593858048/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
