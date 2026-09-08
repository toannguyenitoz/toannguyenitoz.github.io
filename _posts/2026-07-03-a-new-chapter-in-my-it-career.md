---
layout: post
title: "A New Chapter in My IT Career!"
date: 2026-07-03 00:00:00 +0930
categories: ["Active Directory", "Identity Management"]
tags: ["Enterprise IT", "SysAdmin", "ToanNguyenItOz", "ActiveDirectory", "ADDS", "DomainServices"]
image: /assets/images/toan-avatar.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7491045847577571328/"
description: "I’m excited to share that I’ve started a new Remote Desktop Support Level 2 placement with DXC Technology in Adelaide."
---

<div class="cmd-annotation-card" style="margin-bottom: 24px;">
  <div class="annotation-badge">
    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
    <span>LinkedIn Enterprise Series Origin</span>
  </div>
  <p class="annotation-text">
    This standard operating procedure and technical reference was authored by <strong>Toan Nguyen (Toan Nguyen IT OZ)</strong>. Connect with over 20+ years of banking and enterprise systems administration experience on <a href="https://www.linkedin.com/feed/update/urn:li:activity:7491045847577571328/" target="_blank" rel="noopener noreferrer">LinkedIn</a>.
  </p>
</div>

![A New Chapter in My IT Career!](/assets/images/toan-avatar.jpg)

## 1. Scenario Overview & Problem Context

I’m excited to share that I’ve started a new Remote Desktop Support Level 2 placement with DXC Technology in Adelaide.

This is a great opportunity to gain hands-on experience in an enterprise IT support environment and put my technical skills into practice.

💻 What I’ll be working with:

## 2. Step-by-Step Diagnostic & Implementation SOP

To resolve or implement this standard operating procedure effectively, execute the following technical workflow:

- **I’m excited to share that I’ve started a**: I’m excited to share that I’ve started a new Remote Desktop Support Level 2 placement with DXC Technology in Adelaide.

- **This is a great opportunity to gain hand**: This is a great opportunity to gain hands-on experience in an enterprise IT support environment and put my technical skills into practice.

- **💻 What I’ll be working with:**: 💻 What I’ll be working with:

- **🔹 Remote Desktop Support – Level 2**: 🔹 Remote Desktop Support – Level 2

- **🔹 ServiceNow – Incident & Service Reques**: 🔹 ServiceNow – Incident & Service Request Management

- **🔹 Microsoft Intune – Endpoint & Applicat**: 🔹 Microsoft Intune – Endpoint & Application Management

## 3. Production Command Scripts & Automation

```powershell
# Active Directory Comprehensive Domain Health Check
Import-Module ActiveDirectory
Get-ADDomain | Select-Object Name, Forest, DomainMode, PDCEmulator
Get-ADUser -Filter 'Enabled -eq $true' -Properties MemberOf | Select-Object -First 10 Name, SamAccountName, UserPrincipalName
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
> 👉 **[View and join the original LinkedIn post discussion](https://www.linkedin.com/feed/update/urn:li:activity:7491045847577571328/)**
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
