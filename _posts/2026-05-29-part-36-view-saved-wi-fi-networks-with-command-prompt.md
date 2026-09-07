---
layout: post
title: "Windows Tips & Tricks – Part 36: View Saved Wi-Fi Networks with Command Prompt"
date: 2026-05-29 18:35:07 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "Windows11", "WiFi", "Networking", "HelpDesk"]
image: /assets/images/posts/part-36-view-saved-wi-fi-networks-with-command-prompt.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7481449054770601984/"
description: "📶 View Saved Wi-Fi Networks with Command Prompt"
---

![Windows Tips & Tricks – Part 36: View Saved Wi-Fi Networks with Command Prompt](/assets/images/posts/part-36-view-saved-wi-fi-networks-with-command-prompt.jpg)

📶 View Saved Wi-Fi Networks with Command Prompt

Need to know which Wi-Fi networks have been saved on a Windows PC?

Command Prompt can quickly list all wireless profiles stored on the device.

- How to Run

⌨️ Search cmd

➡️ Run as Administrator

➡️ Type:

```powershell
netsh wlan show profile
```

➡️ Press Enter

🎯 Why IT Pros Use It

- View all saved Wi-Fi profiles

- Verify if a network has been stored previously

- Troubleshoot Wi-Fi connection issues

- Speed up laptop migrations and rebuilds

🚀 Pro Tip

Need to back up Wi-Fi profiles before replacing a PC?

Use:

```powershell
netsh wlan export profile folder=C:\temp
```

This exports saved wireless profiles for documentation or migration purposes.

- ️ Only access network information on devices and networks you own or are authorized to manage.

- Sometimes the fastest troubleshooting tool is already built into Windows.

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7481449054770601984/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
