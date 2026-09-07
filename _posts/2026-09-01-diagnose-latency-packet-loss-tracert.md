---
layout: post
title: "Part 13: DIAGNOSE LATENCY WITH TRACERT"
date: 2026-09-01 08:12:00 +0930
categories: [Network Troubleshooting]
tags: [SysAdmin, Windows, IT-Support, Tips-and-Tricks, Networking, Troubleshooting, DNS]
part: 13
series: "LinkedIn IT Support Tips & Tricks"
image: "/assets/images/posts/tip_013.png"
description: "PINPOINT EXACTLY WHERE THE NETWORK FAILS. - Internet feels slow or dropping packets — is the issue your PC, router, or ISP?"
---

> **Series Note:** This guide is **Part 13** of my *Enterprise Windows & SysAdmin Tips & Tricks* series, originally published on LinkedIn to help IT professionals eliminate workflow bottlenecks and resolve complex endpoint issues faster.

---

## The Enterprise Scenario & Problem

Internet feels slow or dropping packets — is the issue your PC, router, or ISP?

In enterprise desktop environments and regulated corporate offices, IT specialists constantly encounter repetitive issues that eat away at productive hours. Having instant muscle memory for native Windows shortcuts, diagnostic command sequences, and root-cause remedies separates average helpdesk staff from high-performing Systems Administrators.

---

## Visual Architecture & Quick Reference Guide

Below is the high-resolution reference card for this technique:

![Part 13 Infographic]({{ '/assets/images/posts/tip_013.png' | relative_url }})

---

## Command Execution & Terminal Diagnostics

Open an elevated Command Prompt or Windows PowerShell terminal and execute:

```powershell
tracert 1.1.1.1
```

### Expected Terminal Output & Verification

```text
Hop 1: <1 ms   <1 ms   <1 ms   192.168.1.1  (Local Router OK)
Hop 2: 4 ms    3 ms    4 ms    10.20.0.1    (ISP Gateway OK)
Hop 3: 180 ms  240 ms  * * *   203.14.88.1  (ISP Backbone Spike)
Hop 4: 12 ms   11 ms   12 ms   1.1.1.1      (Destination Server)
```

---

## 💡 20+ Years Enterprise IT Pro-Tip

> **Toan's Pro-Tip:** Save tracert output to file: 'tracert 1.1.1.1 > tracert_log.txt' as hard proof when opening tickets with your ISP.

---

## Related Knowledge & Discussion

Have you implemented this optimization across your managed fleet or service desk queues? Connect with me on [LinkedIn](https://www.linkedin.com/in/{{ site.author.linkedin }}) to discuss enterprise automation, Azure cloud deployments, and systems hardening!
