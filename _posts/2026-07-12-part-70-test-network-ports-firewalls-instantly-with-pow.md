---
layout: post
title: "Windows Tips & Tricks – Part 70: Test Network Ports & Firewalls Instantly with PowerShell"
date: 2026-07-12 22:49:45 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "PowerShell", "SysAdmin", "HelpDesk", "Networking", "Windows11"]
image: /assets/images/posts/part-70-test-network-ports-firewalls-instantly-with-pow.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7492687409466396672/"
description: "🔌 Test Network Ports & Firewalls Instantly with PowerShell"
---

![Windows Tips & Tricks – Part 70: Test Network Ports & Firewalls Instantly with PowerShell](/assets/images/posts/part-70-test-network-ports-firewalls-instantly-with-pow.jpg)

🔌 Test Network Ports & Firewalls Instantly with PowerShell

> “The user can ping the server, but the application still can't connect. Is the firewall blocking the port?”

This is a classic IT Support scenario.

A successful ping only proves that the device responds to ICMP. It does not prove that the application can communicate over its required TCP port.

Instead of guessing, use PowerShell:

```powershell
Test-NetConnection -ComputerName SERVER-NAME -Port 1433
```

Replace SERVER-NAME and 1433 with the actual server and application port.

🔎 Check the result

TcpTestSucceeded : True

- TCP port is reachable.

TcpTestSucceeded : False

- ️ The port is not reachable. Possible causes include a firewall rule, network ACL, routing issue, or the target service not listening.

- Pro Tip

For faster troubleshooting, use the built-in alias:

tnc SERVER-NAME -Port 443

For example:

tnc google.com -Port 443

Why this matters

- Quickly separates network connectivity issues from application issues
- Tests the actual TCP port used by the application
- Helps provide evidence before escalating to Network/Security teams
- No third-party tools or Telnet installation required
- Perfect for Helpdesk and Desktop Support troubleshooting

- Ping tells you the server is responding.
Port testing tells you whether the application can actually reach its destination.

What network troubleshooting command do you use most often? 👇

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7492687409466396672/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
