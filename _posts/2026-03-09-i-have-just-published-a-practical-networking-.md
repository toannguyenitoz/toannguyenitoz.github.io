---
layout: post
title: "I have just published a practical networking lab project on GitHub."
date: 2026-03-09 00:00:00 +0930
categories: ["Networking", "Infrastructure"]
tags: ["Enterprise IT", "SysAdmin", "ToanNguyenItOz", "Networking", "DNS", "TCP-IP"]
image: /assets/images/posts/i-have-just-published-a-practical-networking-.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7467463906253443072/"
description: "This project is a complete Cisco Packet Tracer solution for a small routed network with two LANs, two routers, two switches, dynamic routing, DHCP, SSH,..."
---

<div class="cmd-annotation-card" style="margin-bottom: 24px;">
  <div class="annotation-badge">
    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
    <span>LinkedIn Enterprise Series Origin</span>
  </div>
  <p class="annotation-text">
    This standard operating procedure and technical reference was authored by <strong>Toan Nguyen (Toan Nguyen IT OZ)</strong>. Connect with over 20+ years of banking and enterprise systems administration experience on <a href="https://www.linkedin.com/feed/update/urn:li:activity:7467463906253443072/" target="_blank" rel="noopener noreferrer">LinkedIn</a>.
  </p>
</div>

![I have just published a practical networking lab project on GitHub.](/assets/images/posts/i-have-just-published-a-practical-networking-.jpg)

## 1. Scenario Overview & Problem Context

This project is a complete Cisco Packet Tracer solution for a small routed network with two LANs, two routers, two switches, dynamic routing, DHCP, SSH, Telnet, and end-to-end connectivity testing.

What the lab includes:

✅ Router and switch initial configuration

## 2. Step-by-Step Diagnostic & Implementation SOP

To resolve or implement this standard operating procedure effectively, execute the following technical workflow:

- **This project is a complete Cisco Packet **: This project is a complete Cisco Packet Tracer solution for a small routed network with two LANs, two routers, two switches, dynamic routing, DHCP, SSH, Telnet, and end-to-end connectivity testing.

- **What the lab includes:**: What the lab includes:

- **✅ Router and switch initial configuratio**: ✅ Router and switch initial configuration

- **✅ IP addressing for LAN and WAN interfac**: ✅ IP addressing for LAN and WAN interfaces

- **✅ DHCP configuration for client PCs**: ✅ DHCP configuration for client PCs

- **✅ OSPF dynamic routing**: ✅ OSPF dynamic routing

## 3. Production Command Scripts & Automation

```powershell
# Flush local resolver cache and inspect authoritative DNS servers
Clear-DnsClientCache
Get-DnsClientServerAddress -AddressFamily IPv4

# Perform authoritative forward DNS resolution query
Resolve-DnsName -Name "toannguyenitoz.github.io" -Type A -DnsOnly
```

## 4. Technical Breakdown & Architecture Deep Dive

Understanding the low-level operating system mechanics and service interactions prevents unintended side effects:

- `<span class="cmd-tag">Administrative Security Context</span>`: Operations altering system state require local administrator privileges or domain delegatory rights.
- `<span class="cmd-tag">Service Architecture</span>`: Windows services and WMI/CIM providers interact directly with the hardware abstraction layer and kernel objects.
- **Enterprise Scale**: Implementing scripted automation reduces Mean Time to Resolution (MTTR) from hours to minutes across distributed endpoints.

## 5. Enterprise Verification Checklist

| Checkpoint | Verification Step | Common Remediation |
| :--- | :--- | :--- |
| **Administrative Privilege** | Run `whoami /priv` or verify elevated prompt | Launch PowerShell or Terminal via **Run as Administrator** |
| **Port & Network Health** | Test TCP handshake via `Test-NetConnection` | Verify firewall state and domain edge security rules |
| **Service Status** | Query service via `Get-Service` or `sc query` | Restart dependent services and inspect event logs |

## 💡 20+ Years Banking & Enterprise IT Pro-Tip

In mission-critical banking and corporate networks, always test administrative scripts against a staging organizational unit (OU) or non-production test tenant before applying widespread changes. Keep audit logs enabled to maintain complete regulatory compliance.

---

> 🔗 **Join the Live Community Discussion**:
> Have questions or insights about this technical guide?
> 👉 **[View and join the original LinkedIn post discussion](https://www.linkedin.com/feed/update/urn:li:activity:7467463906253443072/)**
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
