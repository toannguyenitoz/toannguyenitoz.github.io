---
layout: post
title: "Windows Tips & Tricks – Part 103: Force-Close a Locked File on a Network Share"
date: 2026-09-10 06:03:38 +0930
categories: [SysAdmin, PowerShell]
tags: ["Windows Server", "SysAdmin", "PowerShell", "IT Support", "Troubleshooting", "ToanNguyenItOz", "Part-103", "WindowsTips", "WindowsServer"]
image: /assets/images/posts/part-103-force-close-a-locked-file-on-a-network-share.jpg
linkedin_url: "https://www.linkedin.com/posts/toan-nguyen-it-oz_windowstips-sysadmin-powershell-activity-7503551213120983040-lK0y"
description: "Sarah went home, but the Excel file is still locked. How do I release it without RDP-ing into the File Server?"
part: 103
---

<div class="cmd-annotation-card" style="margin-bottom: 24px;">
  <div class="annotation-badge">
    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
    <span>LinkedIn Enterprise Series — Phase 3: SysAdmin Tools</span>
  </div>
  <p class="annotation-text">
    This guide is Part 103 of the <em>Windows Tips & Tricks</em> series published by <strong>Toan Nguyen (Toan Nguyen IT OZ)</strong>. In Phase 3, we move from desktop troubleshooting to enterprise Systems Administration. Follow on <a href="https://www.linkedin.com/posts/toan-nguyen-it-oz_windowstips-sysadmin-powershell-activity-7503551213120983040-lK0y" target="_blank" rel="noopener noreferrer">LinkedIn</a>.
  </p>
</div>

![Windows Tips & Tricks – Part 103: Force-Close a Locked File on a Network Share](/assets/images/posts/part-103-force-close-a-locked-file-on-a-network-share.jpg)

## 1. Scenario Overview & Problem Context

📂 Windows Tips & Tricks – Part 103

🔓 Force-Close a Locked File on a Network Share

“Sarah went home, but the Excel file is still locked. How do I release it without RDP-ing into the File Server?”

This is a classic File Server ticket.

Instead of restarting the Server service — and disconnecting everyone — use PowerShell to identify and close the specific SMB file handle.

### ⌨️ Step 1 — Find the locked file

```powershell
Invoke-Command -ComputerName FS01 -ScriptBlock { 
    Get-SmbOpenFile | Where-Object { $_.Path -like "*Budget.xlsx" } 
}
```

🔎 Look for the `FileId` and confirm the path, user, and session before closing anything.

### 🔐 Step 2 — Close the specific file

```powershell
Invoke-Command -ComputerName FS01 -ScriptBlock { 
    Close-SmbOpenFile -FileId 12345 -Force 
}
```

> Replace `12345` with the actual `FileId` found in Step 1.

### ⚡ Pro Tip — Multiple matching files

```powershell
Invoke-Command -ComputerName FS01 -ScriptBlock { 
    Get-SmbOpenFile | Where-Object { $_.Path -like "*Budget*" } | ForEach-Object { 
        Close-SmbOpenFile -FileId $_.FileId -Force 
    } 
}
```

### 🎯 Why it matters

* ✅ Release a specific locked file
* ✅ No RDP required
* ✅ Avoid disconnecting every SMB user
* ✅ Faster File Server troubleshooting
* ✅ Practical PowerShell + SMB administration

⚠️ Important

Closing an SMB file handle can discard unsaved changes.

Always verify the file path, user/session and FileId before using "-Force".

💡 SysAdmin mindset:

Don’t restart the whole File Server for one locked file.

Find the handle. Verify it. Close only what you need. 🎯

🚀 Phase 3 — SysAdmin Tools continues!

---

> 🔗 **Join the Live Community Discussion:**
> Have questions or additional tips about this guide?
> 👉 **[View and join the original LinkedIn post discussion](https://www.linkedin.com/posts/toan-nguyen-it-oz_windowstips-sysadmin-powershell-activity-7503551213120983040-lK0y)**
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — Enterprise Systems Administrator in Adelaide, South Australia.*
