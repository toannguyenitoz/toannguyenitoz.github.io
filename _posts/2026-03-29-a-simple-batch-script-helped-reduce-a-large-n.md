---
layout: post
title: "A simple Batch script helped reduce a large number of slow computer support tickets."
date: 2026-03-29 00:00:00 +0930
categories: ["PowerShell", "Automation"]
tags: ["Enterprise IT", "SysAdmin", "ToanNguyenItOz", "PowerShell", "Scripting", "Automation"]
image: /assets/images/posts/a-simple-batch-script-helped-reduce-a-large-n.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7470604112842301440/"
description: "Many users were experiencing sluggish performance, frozen applications, and unresponsive systems caused by excessive memory usage, background processes,..."
---

<div class="cmd-annotation-card" style="margin-bottom: 24px;">
  <div class="annotation-badge">
    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
    <span>LinkedIn Enterprise Series Origin</span>
  </div>
  <p class="annotation-text">
    This standard operating procedure and technical reference was authored by <strong>Toan Nguyen (Toan Nguyen IT OZ)</strong>. Connect with over 20+ years of banking and enterprise systems administration experience on <a href="https://www.linkedin.com/feed/update/urn:li:activity:7470604112842301440/" target="_blank" rel="noopener noreferrer">LinkedIn</a>.
  </p>
</div>

![A simple Batch script helped reduce a large number of slow computer support tickets.](/assets/images/posts/a-simple-batch-script-helped-reduce-a-large-n.jpg)

## 1. Scenario Overview & Problem Context

Many users were experiencing sluggish performance, frozen applications, and unresponsive systems caused by excessive memory usage, background processes, or applications stuck in a "Not Responding" state.

Instead of asking users to reboot their computers every time, I created a lightweight self-service solution they could run in seconds.

📈 The impact:

## 2. Step-by-Step Diagnostic & Implementation SOP

To resolve or implement this standard operating procedure effectively, execute the following technical workflow:

- **Many users were experiencing sluggish pe**: Many users were experiencing sluggish performance, frozen applications, and unresponsive systems caused by excessive memory usage, background processes, or applications stuck in a "Not Responding" state.

- **Instead of asking users to reboot their **: Instead of asking users to reboot their computers every time, I created a lightweight self-service solution they could run in seconds.

- **📈 The impact:**: 📈 The impact:

- **✅ Fewer performance-related helpdesk tic**: ✅ Fewer performance-related helpdesk tickets

- **✅ Less time spent on repetitive troubles**: ✅ Less time spent on repetitive troubleshooting

- **✅ Faster recovery for end users without **: ✅ Faster recovery for end users without disrupting their workflow

## 3. Production Command Scripts & Automation

```powershell
@echo off
REM Enterprise Automated PC Maintenance Script
echo Cleaning User Temp Directory...
del /s /f /q "%temp%\*.*" 2>nul
rd /s /q "%temp%" 2>nul
md "%temp%"

echo Flushing DNS Resolver Cache...
ipconfig /flushdns

echo Purging Memory Working Sets...
cleanmgr /sagerun:1
echo Maintenance Completed Successfully!
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
> 👉 **[View and join the original LinkedIn post discussion](https://www.linkedin.com/feed/update/urn:li:activity:7470604112842301440/)**
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
