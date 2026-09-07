---
layout: post
title: "Part 15: TEST OPEN PORTS WITH POWERSHELL"
date: 2026-09-03 08:14:00 +0930
categories: [Network Troubleshooting]
tags: [SysAdmin, Windows, IT-Support, Tips-and-Tricks, Networking, Troubleshooting, DNS]
part: 15
series: "LinkedIn IT Support Tips & Tricks"
image: "/assets/images/posts/tip_015.png"
description: "CHECK RDP, SQL, AND WEB PORTS IN 2 SECONDS. - Can't reach a database or remote server — is it a firewall blocking the port?"
---

> **Series Note:** This guide is **Part 15** of my *Enterprise Windows & SysAdmin Tips & Tricks* series, originally published on LinkedIn to help IT professionals eliminate workflow bottlenecks and resolve complex endpoint issues faster.

---

## The Enterprise Scenario & Problem

Can't reach a database or remote server — is it a firewall blocking the port?

In enterprise desktop environments and regulated corporate offices, IT specialists constantly encounter repetitive issues that eat away at productive hours. Having instant muscle memory for native Windows shortcuts, diagnostic command sequences, and root-cause remedies separates average helpdesk staff from high-performing Systems Administrators.

---

## Visual Architecture & Quick Reference Guide

Below is the high-resolution reference card for this technique:

![Part 15 Infographic]({{ '/assets/images/posts/tip_015.png' | relative_url }})

---

## Command Execution & Terminal Diagnostics

Open an elevated Command Prompt or Windows PowerShell terminal and execute:

```powershell
Test-NetConnection -ComputerName srv-prod01 -Port 3389
```

### Expected Terminal Output & Verification

```text
ComputerName     : srv-prod01
RemoteAddress    : 192.168.10.50
RemotePort       : 3389 (RDP)
TcpTestSucceeded : True   <-- PORT IS REACHABLE AND OPEN
```

---

## 💡 20+ Years Enterprise IT Pro-Tip

> **Toan's Pro-Tip:** If TcpTestSucceeded = False, test port 443 (HTTPS) next to confirm if the host is reachable at all before debugging firewall rules.

---

## Related Knowledge & Discussion

Have you implemented this optimization across your managed fleet or service desk queues? Connect with me on [LinkedIn](https://www.linkedin.com/in/{{ site.author.linkedin }}) to discuss enterprise automation, Azure cloud deployments, and systems hardening!
