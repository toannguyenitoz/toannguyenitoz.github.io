---
layout: post
title: "Windows Tips & Tricks – Part 110: Check the Clock – Fix Kerberos Time Drift"
date: 2026-09-17 06:30:00 +0930
categories: [SysAdmin, Active Directory]
tags: ["Active Directory", "Kerberos", "SysAdmin", "PowerShell", "Windows Server", "IT Support", "IT Operations", "Infrastructure", "Troubleshooting", "ToanNguyenItOz", "Part-110", "WindowsTips"]
image: /assets/images/posts/part-110-check-the-clock-fix-kerberos-time-drift.jpg
linkedin_url: "https://www.linkedin.com/posts/toan-nguyen-it-oz_windowstips-sysadmin-itsupport-share-7506101538336030722-uiDd/"
description: "Users suddenly cannot log in or access network shares, and Event Viewer is flooded with Kerberos errors. Before restarting servers, check the clock! Fix time drift beyond 5 minutes."
part: 110
---

<div class="cmd-annotation-card" style="margin-bottom: 24px;">
  <div class="annotation-badge">
    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
    <span>LinkedIn Enterprise Series — Phase 3: SysAdmin Tools</span>
  </div>
  <p class="annotation-text">
    This guide is Part 110 of the <em>Windows Tips & Tricks</em> series published by <strong>Toan Nguyen (Toan Nguyen IT OZ)</strong>. In Phase 3, we master core enterprise identity protocols, Kerberos authentication constraints, and infrastructure time synchronization. Follow on <a href="https://www.linkedin.com/posts/toan-nguyen-it-oz_windowstips-sysadmin-itsupport-share-7506101538336030722-uiDd/" target="_blank" rel="noopener noreferrer">LinkedIn</a>.
  </p>
</div>

![Windows Tips & Tricks – Part 110: Check the Clock – Fix Kerberos Time Drift](/assets/images/posts/part-110-check-the-clock-fix-kerberos-time-drift.jpg)

## 1. Scenario Overview & Problem Context

🚀 **Windows Tips & Tricks – Part 110**

⏱️ **Check the Clock: Fix Kerberos Time Drift**

* Users suddenly cannot log in to the domain.
* Network drives and shared folders return **“Access Denied.”**
* Event Viewer is flooded with cryptic Kerberos authentication errors.

> ⚠️ *Before resetting user passwords, rebooting Domain Controllers, or assuming that Active Directory database is corrupted — **check the system clock!***

In an Active Directory environment, time synchronization is not just a cosmetic setting — **it is a critical security requirement**. Kerberos ticket authentication will fail immediately when an endpoint workstation or server clock differs from the Domain Controller by more than **5 minutes** (default Kerberos maximum tolerance for computer clock synchronization).

This strict threshold protects the domain against **replay attacks** (where malicious actors intercept tickets and attempt to reuse them later).

---

## 2. ⚡ Step-by-Step Time Drift Troubleshooting

### Step 1: Open Command Prompt as Administrator
Press <kbd>Windows</kbd> + <kbd>S</kbd> to search for **Command Prompt** (or **Terminal**), right-click and select **Run as Administrator**.

### Step 2: Check the Time Offset
Use the built-in Windows Time diagnostics tool (`w32tm`) to view the exact time difference (in seconds) between your machine and the target server:

```cmd
w32tm /stripchart /computer:<TargetServerName> /samples:5 /dataonly
```

*(Replace `<TargetServerName>` with your Domain Controller hostname, e.g., `DC-01` or `AD-PDC`)*

**Example Output:**
```text
C:\> w32tm /stripchart /computer:DC-01 /samples:5 /dataonly
Tracking DC-01 [192.168.1.10:123].
Collecting 5 samples.
The current time is 17/09/2026 06:30:15.
06:30:15, +00.0001200s
06:30:17, +00.0001150s
06:30:19, +00.0000980s
06:30:21, +00.0001040s
06:30:23, +00.0001110s
```

> ℹ️ *If the offset exceeds `+300.0000000s` or `-300.0000000s` (5 minutes), Kerberos ticket granting will systematically fail.*

### Step 3: Force Immediate Resync
If the machine is out of sync, force it to rediscover the Domain Controller and sync its clock immediately:

**On local machine:**
```cmd
w32tm /resync /rediscover
```

**Remotely via PowerShell (Admin):**
```powershell
Invoke-Command -ComputerName <TargetServerName> -ScriptBlock { w32tm /resync /rediscover }
```

> ⚠️ *Note: Running this command remotely requires appropriate administrative permissions and enabled PowerShell Remoting (WinRM).*

---

## 3. 💡 Pro Tip — Investigate the PDC Emulator

In a healthy Active Directory domain:
1. **Domain Member Workstations & Servers** sync time with any available authenticating Domain Controller.
2. **Domain Controllers** sync time with the **PDC (Primary Domain Controller) Emulator**.
3. **PDC Emulator** must be configured to sync with a reliable external NTP source (such as `pool.ntp.org` or your enterprise GPS/hardware clock).

If multiple systems across your domain are experiencing simultaneous time drift, **the PDC Emulator itself is likely out of sync**.

### Identify the PDC Emulator FSMO Role:
Run this command from any domain machine:

```cmd
netdom query fsmo
```

Or via PowerShell:
```powershell
(Get-ADDomain).PDCEmulator
```

Once identified, inspect the PDC Emulator's NTP configuration and verify it reaches approved external time servers over UDP Port 123.

---

## 4. 🎯 Why It Matters for IT Operations

* ✅ **Fixes Kerberos Login Failures:** Eliminates mysterious domain authentication lockouts and blank login screens.
* ✅ **Resolves Unexpected “Access Denied” Errors:** Restores mapped drives, shared printer access, and DFS namespaces.
* ✅ **Protects Database & Transaction Consistency:** Prevents timestamp mismatch in SQL clustering, Exchange DAG replication, and SIEM logs.
* ✅ **Catches Virtual Machine Time Glitches:** Hyper-V and VMware guests often desync after host snapshots or sleep states.
* ✅ **Maintains Zero-Trust Security Hygiene:** Keeps Kerberos ticket validation compliant with enterprise security baselines.

---

## 5. 🎯 The Bigger Picture

When authentication suddenly breaks across the floor, do not rush to rebuild Active Directory, change trust relationships, or reset passwords.

> **SysAdmins do not panic when Kerberos breaks.**  
> **We check the clock. ⏱️**

---

> 🔗 **Join the Live Community Discussion:**  
> Have you ever encountered a domain-wide outage caused purely by a few minutes of time drift?  
> 👉 **[View and join the original LinkedIn post discussion](https://www.linkedin.com/posts/toan-nguyen-it-oz_windowstips-sysadmin-itsupport-share-7506101538336030722-uiDd/)**  
>  
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — Enterprise Systems Administrator in Adelaide, South Australia.*
