---
layout: post
title: "New GitHub Project: Windows CleanSweep Toolkit"
date: 2026-05-12 00:00:00 +0930
categories: ["PowerShell", "Automation"]
tags: ["Enterprise IT", "SysAdmin", "ToanNguyenItOz", "PowerShell", "Scripting", "Automation"]
image: /assets/images/posts/new-github-project-windows-cleansweep-toolkit.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7481046915845881857/"
description: "I have just started a new IT Support portfolio project:"
---

<div class="cmd-annotation-card" style="margin-bottom: 24px;">
  <div class="annotation-badge">
    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
    <span>LinkedIn Enterprise Series Origin</span>
  </div>
  <p class="annotation-text">
    This standard operating procedure and technical reference was authored by <strong>Toan Nguyen (Toan Nguyen IT OZ)</strong>. Connect with over 20+ years of banking and enterprise systems administration experience on <a href="https://www.linkedin.com/feed/update/urn:li:activity:7481046915845881857/" target="_blank" rel="noopener noreferrer">LinkedIn</a>.
  </p>
</div>

![New GitHub Project: Windows CleanSweep Toolkit](/assets/images/posts/new-github-project-windows-cleansweep-toolkit.jpg)

## 1. Scenario Overview & Problem Context

I have just started a new IT Support portfolio project:

🔗 Windows CleanSweep Toolkit

This project is a PowerShell-based Windows cleanup and maintenance toolkit designed for IT Support, Helpdesk, and Desktop Support scenarios.

## 2. Step-by-Step Diagnostic & Implementation SOP

To resolve or implement this standard operating procedure effectively, execute the following technical workflow:

- **I have just started a new IT Support por**: I have just started a new IT Support portfolio project:

- **🔗 Windows CleanSweep Toolkit**: 🔗 Windows CleanSweep Toolkit

- **This project is a PowerShell-based Windo**: This project is a PowerShell-based Windows cleanup and maintenance toolkit designed for IT Support, Helpdesk, and Desktop Support scenarios.

- **The goal is simple:**: The goal is simple:

- **✅ Scan common Windows junk locations**: ✅ Scan common Windows junk locations

- **✅ Review temporary files, browser cache,**: ✅ Review temporary files, browser cache, crash dumps and update leftovers

## 3. Production Command Scripts & Automation

```powershell
# Purge Windows Temp files and system cache safely
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "$env:SystemRoot\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue

# Clear Windows Update software distribution cache
Stop-Service -Name wuauserv -Force
Remove-Item -Path "$env:SystemRoot\SoftwareDistribution\Download\*" -Recurse -Force -ErrorAction SilentlyContinue
Start-Service -Name wuauserv
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
> 👉 **[View and join the original LinkedIn post discussion](https://www.linkedin.com/feed/update/urn:li:activity:7481046915845881857/)**
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
