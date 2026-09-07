---
layout: post
title: "Part 71: Switch Public Network to Private via PowerShell"
date: 2026-08-06 10:24:00 +0930
categories: [Network Troubleshooting]
tags: [Windows, SysAdmin, IT-Support, Troubleshooting, Part-71]
part: 71
series: "LinkedIn Windows & IT Support Tips & Tricks"
image: "/assets/images/posts/tip_071.png"
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7493057374207856640/"
description: "Part 71 of the LinkedIn IT Support Tips & Tricks series by Toan Nguyen — Switch Public Network to Private via PowerShell."
---

> **LinkedIn Series Origin:** This guide was originally shared on LinkedIn as part of the *Windows & IT Support Tips & Tricks* series by [Toan Nguyen](https://www.linkedin.com/feed/update/urn:li:activity:7493057374207856640/). Connect on LinkedIn to join the discussion and explore more enterprise troubleshooting playbooks.

---

## Visual Architecture & Quick Reference Guide

Below is the high-resolution reference card for this technique:

![Part 71 Infographic]({{ '/assets/images/posts/tip_071.png' | relative_url }})

---

## Technical Overview & Enterprise Diagnostic Walkthrough

🚀 Windows Tips & Tricks – Part 71

📶 Switch Public Network to Private via PowerShell

💬 “The PC has internet, but I can't access shared folders or network printers!”

🔎 The first thing I check is the Windows network profile.

If a trusted office network is incorrectly detected as Public, Network Discovery and File/Printer Sharing may not work.

🛠️ Quick Fix

1️⃣ Open Terminal (Admin)

2️⃣ Check the profile:

```powershell
Get-NetConnectionProfile
```

3️⃣ Change it to Private:

Set-NetConnectionProfile -InterfaceIndex 12 -NetworkCategory Private

🔄 Replace 12 with your actual InterfaceIndex.

🎯 Why it matters

✅ Restore Network Discovery
✅ Troubleshoot network printers
✅ Access shared folders
✅ Useful for new PC deployment
✅ Faster than navigating Windows Settings

⚠️ Pro Tip

Don't change every network to Private.

☕ Café | ✈️ Airport | 🏨 Hotel

👉 Keep untrusted networks as Public.

💡 Check → Identify → Fix → Verify

🚀 Follow for more practical Windows & IT Support tips!


hashtag
#ToanNguyenITOz 
hashtag
#WindowsTips 
hashtag
#ITSupport 
hashtag
#SysAdmin 
hashtag
#HelpDesk 
hashtag
#PowerShell 
hashtag
#Networking 
hashtag
#Windows11

---

## 💡 20+ Years Banking & Enterprise IT Takeaway

In high-availability enterprise environments, resolving endpoint anomalies at the root cause without requiring full workstation reboots or disruptive re-imaging saves hundreds of hours of service desk escalation. Master these native diagnostic routines to keep users productive and systems compliant.

---

## 🔗 Original Post & Community Discussion

Have you deployed this technique in your enterprise environment or corporate fleet? 
👉 **[View and join the original LinkedIn discussion](https://www.linkedin.com/feed/update/urn:li:activity:7493057374207856640/)**
