---
layout: post
title: "Windows Tips & Tricks – Part 52: Verify Applied Group Policies (gpresult)"
date: 2026-06-19 06:50:29 +0930
categories: [Windows, Troubleshooting]
tags: ["Windows", "IT Support", "Troubleshooting", "ToanNguyenITOz", "Windows11", "GroupPolicy", "GPO", "ActiveDirectory"]
image: /assets/images/posts/part-52-verify-applied-group-policies-gpresult.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7486895191312756736/"
description: "🛡️ Verify Applied Group Policies (gpresult)"
---

![Windows Tips & Tricks – Part 52: Verify Applied Group Policies (gpresult)](/assets/images/posts/part-52-verify-applied-group-policies-gpresult.jpg)

🛡️ Verify Applied Group Policies (gpresult)

A user says they can't see the new network drive, printer, or company application—even though the GPO was deployed yesterday.

Before changing Group Policy again, verify what the PC has actually received.

- How to Check

⌨️ Open Command Prompt as Administrator

Run:

gpresult /r

This displays the Group Policies currently applied to both the computer and the logged-in user.

🎯 Why IT Pros Use It

- Verify communication with the Domain Controller

- See which GPOs are applied or filtered out

- Check the user's Active Directory security group membership

- Troubleshoot missing mapped drives, printers, software deployment, and security settings

- Save time before escalating Group Policy issues

🚀 Pro Tip

Need a cleaner report?

Run:

gpresult /h C:\gp_report.html

Then open gp_report.html in your browser to view a detailed, easy-to-read report showing all applied and filtered Group Policies.

- Never assume a Group Policy has been applied—always verify it.

---

> 🔗 **Original LinkedIn Post**: [View discussion on LinkedIn](https://www.linkedin.com/feed/update/urn:li:activity:7486895191312756736/)
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
