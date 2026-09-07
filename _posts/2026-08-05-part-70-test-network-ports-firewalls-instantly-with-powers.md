---
layout: post
title: "Part 70: Test Network Ports  Firewalls Instantly with PowerShell"
date: 2026-08-05 08:00:00 +0930
categories: [Network Troubleshooting]
tags: [Windows, SysAdmin, IT-Support, Troubleshooting, Part-70]
part: 70
series: "LinkedIn Windows & IT Support Tips & Tricks"
image: "/assets/images/posts/tip_070.png"
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7492687409466396672/"
description: "Part 70 of the LinkedIn IT Support Tips & Tricks series by Toan Nguyen — Test Network Ports  Firewalls Instantly with PowerShell."
---

> **LinkedIn Series Origin:** This guide was originally shared on LinkedIn as part of the *Windows & IT Support Tips & Tricks* series by [Toan Nguyen](https://www.linkedin.com/feed/update/urn:li:activity:7492687409466396672/). Connect on LinkedIn to join the discussion and explore more enterprise troubleshooting playbooks.

---

## Visual Architecture & Quick Reference Guide

Below is the high-resolution reference card for this technique:

![Part 70 Infographic]({{ '/assets/images/posts/tip_070.png' | relative_url }})

---

## Technical Overview & Enterprise Diagnostic Walkthrough

🪟 Windows Tips & Tricks – Part 70

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

✅ TCP port is reachable.

TcpTestSucceeded : False

⚠️ The port is not reachable. Possible causes include a firewall rule, network ACL, routing issue, or the target service not listening.

💡 Pro Tip

For faster troubleshooting, use the built-in alias:

tnc SERVER-NAME -Port 443

For example:

tnc google.com -Port 443

Why this matters

✅ Quickly separates network connectivity issues from application issues
✅ Tests the actual TCP port used by the application
✅ Helps provide evidence before escalating to Network/Security teams
✅ No third-party tools or Telnet installation required
✅ Perfect for Helpdesk and Desktop Support troubleshooting

💡 Ping tells you the server is responding.
Port testing tells you whether the application can actually reach its destination.

What network troubleshooting command do you use most often? 👇


hashtag
#WindowsTips 
hashtag
#PowerShell 
hashtag
#SysAdmin 
hashtag
#ITSupport 
hashtag
#HelpDesk 
hashtag
#Networking 
hashtag
#Windows11 
hashtag
#SystemAdministrator 
hashtag
#ITOperations 
hashtag
#Troubleshooting 
hashtag
#DesktopSupport 
hashtag
#ToanNguyenITOZ

---

## 💡 20+ Years Banking & Enterprise IT Takeaway

In high-availability enterprise environments, resolving endpoint anomalies at the root cause without requiring full workstation reboots or disruptive re-imaging saves hundreds of hours of service desk escalation. Master these native diagnostic routines to keep users productive and systems compliant.

---

## 🔗 Original Post & Community Discussion

Have you deployed this technique in your enterprise environment or corporate fleet? 
👉 **[View and join the original LinkedIn discussion](https://www.linkedin.com/feed/update/urn:li:activity:7492687409466396672/)**
