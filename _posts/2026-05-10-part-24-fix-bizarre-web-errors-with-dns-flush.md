---
layout: post
title: "Windows Tips & Tricks – Part 24: Fix Bizarre Web Errors with DNS Flush"
date: 2026-05-10 20:11:42 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "Windows11", "Networking", "DNS", "HelpDesk"]
image: /assets/images/posts/part-24-fix-bizarre-web-errors-with-dns-flush.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7477099491217551361/"
description: "Website not loading?"
---

![Windows Tips & Tricks – Part 24: Fix Bizarre Web Errors with DNS Flush](/assets/images/posts/part-24-fix-bizarre-web-errors-with-dns-flush.jpg)

Website not loading?

Getting "Site can't be reached" errors while the internet connection is working fine?

Before troubleshooting the router or escalating the issue, try clearing the local DNS cache.

- How to Run

⌨️ Press Windows + S

➡️ Search cmd

➡️ Run as Administrator

➡️ Type:

```powershell
ipconfig /flushdns
```

➡️ Press Enter

🎯 Why IT Pros Use It

- Clears outdated DNS records

- Fixes website access issues after IP changes

- Resolves internal application connectivity problems

- Takes only a few seconds to perform

🚀 Pro Tip

If DNS flushing doesn't help, refresh the IP address:

```powershell
ipconfig /release
```

```powershell
ipconfig /renew
```

This forces Windows to request a new IP lease from the DHCP server.

- There's an old IT joke: "It's always DNS." More often than not, it's true.

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7477099491217551361/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
