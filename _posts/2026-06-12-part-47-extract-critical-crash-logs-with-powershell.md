---
layout: post
title: "Windows Tips & Tricks – Part 47: Extract Critical Crash Logs with PowerShell"
date: 2026-06-12 23:22:40 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "PowerShell", "Windows11", "SysAdmin", "SystemAdministrator"]
image: /assets/images/posts/part-47-extract-critical-crash-logs-with-powershell.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7485073428723458048/"
description: "When Windows crashes or throws a BSOD, you don't always need to open Event Viewer."
---

![Windows Tips & Tricks – Part 47: Extract Critical Crash Logs with PowerShell](/assets/images/posts/part-47-extract-critical-crash-logs-with-powershell.jpg)

When Windows crashes or throws a BSOD, you don't always need to open Event Viewer.

PowerShell can retrieve critical system events in seconds.

- Run PowerShell as Administrator

Paste the following command:

```powershell
Get-WinEvent -FilterHashtable @{LogName='System'; Level=1,2} -MaxEvents 15 |
```
Select-Object TimeCreated, Id, Message |
Format-Table -AutoSize

🎯 Why IT Pros Use It

- Skip the slow Event Viewer GUI

- Display only Critical and Error events

- Quickly identify Event ID, timestamp, and error details

- Perfect for remote troubleshooting and automation

🚀 Pro Tip

Need to escalate an incident?

Export the results directly to a CSV file:

```powershell
Get-WinEvent -FilterHashtable @{LogName='System'; Level=1,2} -MaxEvents 15 |
```
Select-Object TimeCreated, Id, Message |
Export-Csv "C:\CrashLogs.csv" -NoTypeInformation

Attach the CSV to your ServiceNow, Jira, or ITSM ticket for faster Tier 2/3 investigation.

- Don't scroll through thousands of log entries. Let PowerShell bring the important ones to you.

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7485073428723458048/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
