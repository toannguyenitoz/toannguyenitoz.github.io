---
layout: post
title: "Windows Tips & Tricks – Part 05: View All Shared Folders on Your PC"
date: 2026-05-02 21:24:08 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "Part-05", "Windows11", "Windows10", "PCTips", "ComputerTips"]
image: /assets/images/posts/part-05-view-all-shared-folders-on-your-pc.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7470946304270188544/"
description: "Want to see exactly what folders are being shared on your Windows computer? Open Shared Folders Manager: Press Windows R Type: fsmgmt.msc Press Enter What youll"
part: 5
---

<div class="cmd-annotation-card" style="margin-bottom: 24px;">
  <div class="annotation-badge">
    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
    <span>LinkedIn Enterprise Series Origin</span>
  </div>
  <p class="annotation-text">
    This standard operating procedure is part of Part 05 of the *Windows Tips & Tricks* series published by <strong>Toan Nguyen (Toan Nguyen IT OZ)</strong>. Connect with over 20+ years of banking and enterprise systems administration experience on <a href="https://www.linkedin.com/feed/update/urn:li:activity:7470946304270188544/" target="_blank" rel="noopener noreferrer">LinkedIn</a>.
  </p>
</div>

![Windows Tips & Tricks – Part 05: View All Shared Folders on Your PC](/assets/images/posts/part-05-view-all-shared-folders-on-your-pc.jpg)

## 1. Scenario Overview & Problem Context

Want to see exactly what folders are being shared on your Windows computer? Open Shared Folders Manager: Press Windows R Type: fsmgmt.msc Press Enter What youll find: Shared Folders – All folders currently shared on your PC Sessions – Users currently connected Open Files – Files being accessed remotely Useful for security audits Troubleshooting network sharing issues Monitoring active user connections Managing file access permissions Pro Tip: Review your shared folders regularly to ensure confidential files and sensitive business data arent accidentally exposed to your network. One practical Windows tip every day. Learn Automate Troubleshoot Improve

Want to see exactly what folders are being shared on your Windows computer? Open Shared Folders Manager: Press Windows R Type: fsmgmt.msc Press Enter What youll find: Shared Folders – All folders currently shared on your PC Sessions – Users currently connected Open Files – Files being accessed remotely Useful for security audits Troubleshooting network sharing issues Monitoring active user connections Managing file access permissions Pro Tip: Review your shared folders regularly to ensure confidential files and sensitive business data arent accidentally exposed to your network. One practical Windows tip every day. Learn Automate Troubleshoot Improve

## 2. Step-by-Step Diagnostic & Remediation SOP

Execute this procedure using an elevated console (**Run as Administrator**) to ensure necessary system access:

- Useful for security audits Troubleshooting network sharing issues Monitoring active user connections Managing file access permissions

- Follow for more daily Windows tips, SysAdmin tricks, and IT support knowledge.


## 3. Production Command Scripts

```powershell
ipconfig /all
```

## 4. Technical Breakdown & Parameter Deep Dive

Understanding how native Windows administrative tools operate helps prevent unintended side effects across domain environments:

- `<span class="cmd-tag">Elevated PowerShell</span>`: Operates within the elevated administrative security context to interact directly with core OS services.
- **Silent Background Execution**: Minimizes end-user disruption by querying or modifying configuration parameters without requiring an intrusive remote desktop takeover.

## 5. Enterprise Troubleshooting & Verification Checklist

| Checkpoint | Verification Step | Common Remediation |
| :--- | :--- | :--- |
| **Administrative Privilege** | Run `whoami /priv` or check elevated terminal badge | Ensure PowerShell is launched via **Run as Administrator** |
| **Firewall & Ports** | Verify local Windows Defender Firewall state | Permit WinRM (TCP 5985/5986) or ICMP/RPC rules if remote |
| **Service Dependencies** | Query associated Windows Service state | Check Event Viewer (`eventvwr.msc`) Application/System logs for error codes |


## 💡 20+ Years Banking & Enterprise IT Pro-Tip

In high-availability enterprise environments, resolving endpoint anomalies at the command line without requiring a full system reboot or user session interruption significantly lowers Mean Time to Resolution (MTTR). Always verify event logs and confirm service availability before closing user tickets.

---

> 🔗 **Join the Live Community Discussion**:
> Have questions or additional variations for this command?
> 👉 **[View and join the original LinkedIn post discussion](https://www.linkedin.com/feed/update/urn:li:activity:7470946304270188544/)**
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
