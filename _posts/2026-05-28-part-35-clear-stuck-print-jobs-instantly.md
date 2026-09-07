---
layout: post
title: "Windows Tips & Tricks – Part 35: Clear Stuck Print Jobs Instantly"
date: 2026-05-28 04:43:10 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "Windows11", "PrintSpooler", "PrinterFix", "HelpDesk"]
image: /assets/images/posts/part-35-clear-stuck-print-jobs-instantly.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7481086394434748416/"
description: "Print queue frozen? Documents won't print or delete?"
---

![Windows Tips & Tricks – Part 35: Clear Stuck Print Jobs Instantly](/assets/images/posts/part-35-clear-stuck-print-jobs-instantly.jpg)

Print queue frozen? Documents won't print or delete?

Reset the Print Spooler service.

- Run Command Prompt as Administrator

net stop spooler
del /Q /F /S "%systemroot%\System32\Spool\Printers\*.*"
net start spooler

🎯 Why IT Pros Use It

- Clear stuck print jobs

- Fix "Printer Offline" errors

- Restore printing without rebooting

- Save time troubleshooting printers

🚀 Pro Tip

Save these commands as FixPrinter.bat and run it as Administrator whenever a print queue gets stuck.

- Printers can sense fear. The command line reminds them who's in charge.

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7481086394434748416/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
