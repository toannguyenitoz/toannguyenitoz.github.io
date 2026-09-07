---
layout: post
title: "Part 16: SWITCH TO HIGH-SPEED SECURE DNS"
date: 2026-09-04 08:15:00 +0930
categories: [Network Troubleshooting]
tags: [SysAdmin, Windows, IT-Support, Tips-and-Tricks, Networking, Troubleshooting, DNS]
part: 16
series: "LinkedIn IT Support Tips & Tricks"
image: "/assets/images/posts/tip_016.png"
description: "BOOST BROWSING SPEED & ENCRYPT QUERIES. - Websites resolving slowly and ISP logging every DNS request you make?"
---

> **Series Note:** This guide is **Part 16** of my *Enterprise Windows & SysAdmin Tips & Tricks* series, originally published on LinkedIn to help IT professionals eliminate workflow bottlenecks and resolve complex endpoint issues faster.

---

## The Enterprise Scenario & Problem

Websites resolving slowly and ISP logging every DNS request you make?

In enterprise desktop environments and regulated corporate offices, IT specialists constantly encounter repetitive issues that eat away at productive hours. Having instant muscle memory for native Windows shortcuts, diagnostic command sequences, and root-cause remedies separates average helpdesk staff from high-performing Systems Administrators.

---

## Visual Architecture & Quick Reference Guide

Below is the high-resolution reference card for this technique:

![Part 16 Infographic]({{ '/assets/images/posts/tip_016.png' | relative_url }})

---

## Step-by-Step Implementation Procedure

### Step 1: Open Settings > Network & internet > Wi-Fi or Ethernet
Execute this configuration carefully in accordance with your organization's endpoint policy.

### Step 2: Click 'Hardware properties' and choose 'DNS server assignment: Edit'
Execute this configuration carefully in accordance with your organization's endpoint policy.

### Step 3: Select 'Manual' > Toggle IPv4 ON
Execute this configuration carefully in accordance with your organization's endpoint policy.

### Step 4: Enter Preferred DNS: 1.1.1.1 and Alternate DNS: 1.0.0.1 (Enable DoH)
Execute this configuration carefully in accordance with your organization's endpoint policy.

---

## 💡 20+ Years Enterprise IT Pro-Tip

> **Toan's Pro-Tip:** Selecting 'Encrypted only (DNS over HTTPS)' encrypts your DNS traffic against local network eavesdropping.

---

## Related Knowledge & Discussion

Have you implemented this optimization across your managed fleet or service desk queues? Connect with me on [LinkedIn](https://www.linkedin.com/in/{{ site.author.linkedin }}) to discuss enterprise automation, Azure cloud deployments, and systems hardening!
