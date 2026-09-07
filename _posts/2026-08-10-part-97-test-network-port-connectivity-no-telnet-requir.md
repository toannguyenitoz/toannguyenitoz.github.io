---
layout: post
title: "Windows Tips & Tricks – Part 97: Test Network Port Connectivity — No Telnet Required"
date: 2026-08-10 08:24:52 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "SysAdmin", "HelpDesk", "Networking", "PowerShell", "SystemAdministrator"]
image: /assets/images/posts/part-97-test-network-port-connectivity-no-telnet-requir.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7501743932599513088/"
description: "🌐 Test Network Port Connectivity — No Telnet Required"
---

![Windows Tips & Tricks – Part 97: Test Network Port Connectivity — No Telnet Required](/assets/images/posts/part-97-test-network-port-connectivity-no-telnet-requir.jpg)

🌐 Test Network Port Connectivity — No Telnet Required

«“The user can ping the server, but the application still says Connection Refused. Is the firewall blocking the port?”»

This is a classic HelpDesk troubleshooting scenario.

A successful "ping" only confirms that the destination responds to ICMP. It doesn't tell you whether the specific TCP port your application needs is reachable.

Instead of installing the legacy Telnet Client, Windows gives us a built-in PowerShell tool that can test the exact port in seconds.

- How to execute it

Open PowerShell / Windows Terminal and run:

```powershell
Test-NetConnection -ComputerName <Server_IP_or_Name> -Port <PortNumber>
```

For example:

```powershell
Test-NetConnection -ComputerName 192.168.1.50 -Port 443
```

Or for RDP:

```powershell
Test-NetConnection -ComputerName 192.168.1.50 -Port 3389
```

🔍 What should you look for?

Focus on:

TcpTestSucceeded

🟢 True → The TCP connection to that port succeeded.

🔴 False → The connection failed. The service may be down, the port may be blocked by a firewall, or traffic may be restricted somewhere along the path.

This immediately helps you narrow down whether you're dealing with a network connectivity problem or an application/service problem.

- Why this matters

- Test a specific TCP port without installing Telnet
- Troubleshoot HTTPS, RDP, SQL Server and custom applications
- Collect clear evidence before escalating to the Network/Security team
- Quickly distinguish connectivity issues from application issues
- Perfect for both local and remote troubleshooting

🚀 Pro Tip

You can use the built-in alias:

tnc 192.168.1.50 -Port 443

Need to investigate the network path as well?

tnc 192.168.1.50 -TraceRoute

Don't just say “the network is down.”

Test the actual destination and the actual port.

That's how you turn a vague HelpDesk ticket into useful technical evidence. 🔎

- Stop guessing if a port is blocked. Prove it with one PowerShell command.

Follow for more daily IT Support & SysAdmin Tips! 🚀

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7501743932599513088/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
