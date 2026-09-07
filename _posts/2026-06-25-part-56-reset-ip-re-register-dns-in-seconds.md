---
layout: post
title: "Windows Tips & Tricks – Part 56: Reset IP & Re-register DNS in Seconds"
date: 2026-06-25 14:18:17 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "SysAdmin", "HelpDesk", "Networking", "ActiveDirectory", "DHCP"]
image: /assets/images/posts/part-56-reset-ip-re-register-dns-in-seconds.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7488331489043132416/"
description: "🔄 Reset IP & Re-register DNS in Seconds"
---

![Windows Tips & Tricks – Part 56: Reset IP & Re-register DNS in Seconds](/assets/images/posts/part-56-reset-ip-re-register-dns-in-seconds.jpg)

🔄 Reset IP & Re-register DNS in Seconds

> "I reconnected to the office Wi-Fi, but I still can't access internal servers or shared drives!"

This is a common issue in corporate environments.

Sometimes a workstation ends up with an APIPA address (169.254.x.x) because it couldn't reach the DHCP server. In other cases, stale DNS records prevent access to internal resources after network or infrastructure changes.

Before restarting the PC, try refreshing the network configuration.

🛠️ Steps

⌨️ Press Windows + S

➡️ Search for Command Prompt

➡️ Run as Administrator

Execute the following commands one by one:

```powershell
ipconfig /release
```
```powershell
ipconfig /renew
```
```powershell
ipconfig /registerdns
```

- Why it works

Renews the DHCP lease with a fresh IP address.

Re-registers the computer's DNS record in Active Directory.

Resolves many internal name resolution issues.

Often restores access to file shares, printers and internal applications without rebooting.

- Pro Tip

If the problem persists, reset the TCP/IP and Winsock stack:

```powershell
netsh int ip reset
```
```powershell
netsh winsock reset
```

Then restart the computer.

These commands can resolve stubborn networking issues caused by corrupted TCP/IP settings or Winsock catalog entries.

---

🎯 A few seconds in Command Prompt can save several minutes of unnecessary troubleshooting.

What's your go-to command when a user's network suddenly stops working?

👇 Share your favourite troubleshooting tip in the comments!

---

> Note: ipconfig /registerdns is most useful on domain-joined Windows devices in an Active Directory environment. On home networks or devices outside a Windows domain, it usually has little or no effect.

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7488331489043132416/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
