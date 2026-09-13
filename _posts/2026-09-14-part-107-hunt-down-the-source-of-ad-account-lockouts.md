---
layout: post
title: "Windows Tips & Tricks – Part 107: Hunt Down the Source of AD Account Lockouts"
date: 2026-09-14 06:27:45 +0930
categories: [SysAdmin, Active Directory]
tags: ["Active Directory", "SysAdmin", "PowerShell", "Windows Server", "IT Support", "Infrastructure", "Account Lockout", "Troubleshooting", "ToanNguyenItOz", "Part-107", "WindowsTips"]
image: /assets/images/posts/part-107-hunt-down-the-source-of-ad-account-lockouts.jpg
linkedin_url: "https://www.linkedin.com/posts/toan-nguyen-it-oz_windowstips-sysadmin-activedirectory-activity-7505006834483732480-M6vO"
description: "It was unlocked five minutes ago — and it's locked again! Monday morning classic SysAdmin problem. Trace the Caller Computer Name with Event ID 4740 on the PDC Emulator."
part: 107
---

<div class="cmd-annotation-card" style="margin-bottom: 24px;">
  <div class="annotation-badge">
    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
    <span>LinkedIn Enterprise Series — Phase 3: SysAdmin Tools</span>
  </div>
  <p class="annotation-text">
    This guide is Part 107 of the <em>Windows Tips & Tricks</em> series published by <strong>Toan Nguyen (Toan Nguyen IT OZ)</strong>. In Phase 3, we move from basic helpdesk ticketing to root-cause enterprise identity and infrastructure troubleshooting. Follow on <a href="https://www.linkedin.com/posts/toan-nguyen-it-oz_windowstips-sysadmin-activedirectory-activity-7505006834483732480-M6vO" target="_blank" rel="noopener noreferrer">LinkedIn</a>.
  </p>
</div>

![Windows Tips & Tricks – Part 107: Hunt Down the Source of AD Account Lockouts](/assets/images/posts/part-107-hunt-down-the-source-of-ad-account-lockouts.jpg)

## 1. Scenario Overview & Problem Context

🕵️ **Windows Tips & Tricks – Part 107**

🔐 **Hunt Down the Source of AD Account Lockouts**

> *“It was unlocked five minutes ago — and it's locked again!”*

Monday morning. Classic SysAdmin headache. 😅

A user calls the service desk complaining their domain account keeps locking out repeatedly despite typing their password correctly. 

Instead of playing a losing game of repeatedly clicking "Unlock account", go straight to the Domain Controller to identify the originating source machine.

---

## 2. 🎯 Event ID 4740: The Lockout Event

In Windows Active Directory, **Event ID 4740** in the Security Event Log records:
> *“A user account was locked out.”*

Run this PowerShell command to query the most recent lockout events directly from your Domain Controller:

```powershell
Get-WinEvent -ComputerName DC01 -FilterHashtable @{LogName='Security'; ID=4740} -MaxEvents 5 | 
    Format-List TimeCreated, Message
```

🔎 **What to look for in the event details:**
* 👤 **Target Account Name:** The username that was locked out.
* 💻 **Caller Computer Name:** The hostname of the workstation, server, or device sending the failed authentication attempts.

The **Caller Computer Name** is your golden lead — it points you directly toward the endpoint generating the bad password traffic.

---

## 3. ⚡ Pro Tip — Always Query the PDC Emulator

In a multi-DC environment, authentication failures are forwarded to the **PDC (Primary Domain Controller) Emulator** FSMO role for validation. Consequently, lockout events are centralized on the PDC Emulator.

Find your domain's PDC Emulator dynamically and query its Security log in one seamless workflow:

```powershell
# 1. Discover the PDC Emulator in your Active Directory domain
(Get-ADDomain).PDCEmulator

# 2. Query Event ID 4740 directly on the PDC Emulator
Get-WinEvent -ComputerName (Get-ADDomain).PDCEmulator -FilterHashtable @{LogName='Security'; ID=4740} -MaxEvents 5 | 
    Select-Object TimeCreated, @{N='User'; E={$_.Properties[0].Value}}, @{N='CallerComputer'; E={$_.Properties[1].Value}}
```

Because the PDC Emulator has a specialized role in Active Directory account-lockout processing, it is always the most authoritative place to inspect during investigations.

---

## 4. 🔍 Where to Hunt Next on the Source Device

Once you pinpoint the **Caller Computer Name**, inspect these common culprits that silently keep trying old credentials in the background:

* 🔹 **Windows Credential Manager:** Stale saved network passwords or expired domain credentials.
* 🔹 **Persistent Mapped Network Drives:** Batches connecting with obsolete cached passwords.
* 🔹 **Scheduled Tasks:** Tasks configured to run under the user's account with an old password.
* 🔹 **Windows Services:** Background services set to Log On As the affected domain user.
* 🔹 **Disconnected RDP Sessions:** Active/disconnected remote desktop sessions running in the background trying to refresh Kerberos tickets.
* 🔹 **Mobile / Email / VPN Clients:** Smartphones, tablets, or remote VPN clients caching expired corporate Wi-Fi or Exchange credentials.

---

## 5. 🎯 Why It Matters for IT Operations

* ✅ **Find the root cause fast:** Stop treating the symptom by constantly unlocking accounts.
* ✅ **Identify rogue devices:** Pinpoint unmanaged mobile devices or forgotten test servers attacking domain credentials.
* ✅ **Save valuable Helpdesk time:** Eliminate repetitive ticket loops for the same user.
* ✅ **Audit enterprise authentication health:** Maintain security hygiene and reduce Kerberos/NTLM authentication noise across domain controllers.

---

## 6. 💡 SysAdmin Mindset

> **Don’t keep unlocking the account.**
> 
> **Find what is causing the lockout. 🎯**

🚀 Phase 3 — SysAdmin Tools continues!

---

> 🔗 **Join the Live Community Discussion:**
> Have questions or additional tips about Active Directory account lockouts and Event ID 4740?
> 👉 **[View and join the original LinkedIn post discussion](https://www.linkedin.com/posts/toan-nguyen-it-oz_windowstips-sysadmin-activedirectory-activity-7505006834483732480-M6vO)**
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — Enterprise Systems Administrator in Adelaide, South Australia.*
