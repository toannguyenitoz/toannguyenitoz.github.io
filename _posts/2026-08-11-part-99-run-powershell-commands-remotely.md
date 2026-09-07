---
layout: post
title: "Windows Tips & Tricks – Part 99: Run PowerShell Commands Remotely"
date: 2026-08-11 22:16:49 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "PowerShell", "SysAdmin", "HelpDesk", "PowerShellRemoting", "Automation"]
image: /assets/images/posts/part-99-run-powershell-commands-remotely.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7502467420004024320/"
description: "Need to fix something on a user's PC without taking over their screen? 👨‍💻"
---

![Windows Tips & Tricks – Part 99: Run PowerShell Commands Remotely](/assets/images/posts/part-99-run-powershell-commands-remotely.jpg)

Need to fix something on a user's PC without taking over their screen? 👨‍💻

Instead of opening Remote Desktop or interrupting their workflow, use PowerShell Remoting.

⌨️ Basic Syntax

```powershell
Invoke-Command -ComputerName PC-NAME -ScriptBlock { <Command> }
```

- Real-World Examples

🖨️ Restart Print Spooler:
```powershell
Invoke-Command -ComputerName LAPTOP-HR01 -ScriptBlock { Restart-Service Spooler -Force }
```

🔄 Force Group Policy update:
```powershell
Invoke-Command -ComputerName LAPTOP-HR01 -ScriptBlock { gpupdate /force }
```

💾 Check C: drive:
```powershell
Invoke-Command -ComputerName LAPTOP-HR01 -ScriptBlock { Get-Volume -DriveLetter C }
```

- Pro Tip

Need to target multiple PCs?

```powershell
Invoke-Command -ComputerName PC-01,PC-02,PC-03 -ScriptBlock { gpupdate /force }
```

One command → multiple remote machines.

🎯 Why IT Pros Use It

- Reduce unnecessary remote sessions
- Troubleshoot faster
- Automate repetitive support tasks
- Scale from one PC to many
- Build the foundation for enterprise automation

- ️ Remember: PowerShell Remoting requires appropriate permissions and remote-management/WinRM configuration. Test your environment before deploying commands broadly.

- Don’t interrupt the user for a 10-second fix. Run it remotely.

🚀 Tomorrow: Part 100 — the milestone!

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7502467420004024320/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
