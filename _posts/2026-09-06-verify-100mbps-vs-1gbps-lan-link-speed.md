---
layout: post
title: "Part 18: VERIFY 100MBPS VS 1GBPS LAN SPEED"
date: 2026-09-06 08:17:00 +0930
categories: [Network Troubleshooting]
tags: [SysAdmin, Windows, IT-Support, Tips-and-Tricks, Networking, Troubleshooting, DNS]
part: 18
series: "LinkedIn IT Support Tips & Tricks"
image: "/assets/images/posts/tip_018.png"
description: "FIND DAMAGED ETHERNET CABLES IN SECONDS. - Gigabit fiber internet only downloading at 95Mbps on your desktop PC?"
---

> **Series Note:** This guide is **Part 18** of my *Enterprise Windows & SysAdmin Tips & Tricks* series, originally published on LinkedIn to help IT professionals eliminate workflow bottlenecks and resolve complex endpoint issues faster.

---

## The Enterprise Scenario & Problem

Gigabit fiber internet only downloading at 95Mbps on your desktop PC?

In enterprise desktop environments and regulated corporate offices, IT specialists constantly encounter repetitive issues that eat away at productive hours. Having instant muscle memory for native Windows shortcuts, diagnostic command sequences, and root-cause remedies separates average helpdesk staff from high-performing Systems Administrators.

---

## Visual Architecture & Quick Reference Guide

Below is the high-resolution reference card for this technique:

![Part 18 Infographic]({{ '/assets/images/posts/tip_018.png' | relative_url }})

---

## Command Execution & Terminal Diagnostics

Open an elevated Command Prompt or Windows PowerShell terminal and execute:

```powershell
Get-NetAdapter | Select-Object Name, InterfaceDescription, LinkSpeed, Status
```

### Expected Terminal Output & Verification

```text
Name      InterfaceDescription            LinkSpeed   Status
Ethernet  Intel(R) Ethernet Connection     100 Mbps    Up  <-- FAULT DETECTED
Wi-Fi     Intel(R) Wi-Fi 6 AX201 160MHz   866 Mbps    Up
Diagnosis: Cable pin 4/5/7/8 broken. Replace with Cat6 patch lead.
```

---

## 💡 20+ Years Enterprise IT Pro-Tip

> **Toan's Pro-Tip:** Cat5e/Cat6 cables need all 8 pins working for Gigabit. If even 1 pin is crimped poorly, NIC drops to 100Mbps.

---

## Related Knowledge & Discussion

Have you implemented this optimization across your managed fleet or service desk queues? Connect with me on [LinkedIn](https://www.linkedin.com/in/{{ site.author.linkedin }}) to discuss enterprise automation, Azure cloud deployments, and systems hardening!
