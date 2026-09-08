---
layout: post
title: "AWS Cloud Fundamentals – Part 1"
date: 2026-04-02 00:00:00 +0930
categories: ["Cloud Engineering", "AWS"]
tags: ["Enterprise IT", "SysAdmin", "ToanNguyenItOz", "CloudArchitecture", "AWS", "Networking"]
image: /assets/images/posts/aws-cloud-fundamentals-part-1.jpg
linkedin_url: "https://www.linkedin.com/feed/update/urn:li:activity:7470948006301683712/"
description: "☁️ AWS Cloud Basics Every IT Pro Should Know"
---

<div class="cmd-annotation-card" style="margin-bottom: 24px;">
  <div class="annotation-badge">
    <svg viewBox="0 0 24 24" width="14" height="14" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="16" x2="12" y2="12"></line><line x1="12" y1="8" x2="12.01" y2="8"></line></svg>
    <span>LinkedIn Enterprise Series Origin</span>
  </div>
  <p class="annotation-text">
    This standard operating procedure and technical reference was authored by <strong>Toan Nguyen (Toan Nguyen IT OZ)</strong>. Connect with over 20+ years of banking and enterprise systems administration experience on <a href="https://www.linkedin.com/feed/update/urn:li:activity:7470948006301683712/" target="_blank" rel="noopener noreferrer">LinkedIn</a>.
  </p>
</div>

![AWS Cloud Fundamentals – Part 1](/assets/images/posts/aws-cloud-fundamentals-part-1.jpg)

## 1. Scenario Overview & Problem Context

☁️ AWS Cloud Basics Every IT Pro Should Know

Amazon Web Services (AWS) is the world's leading cloud platform, providing scalable, secure, and reliable infrastructure for businesses of all sizes.

🔑 Key AWS Core Services

## 2. Step-by-Step Diagnostic & Implementation SOP

To resolve or implement this standard operating procedure effectively, execute the following technical workflow:

- **☁️ AWS Cloud Basics Every IT Pro Should **: ☁️ AWS Cloud Basics Every IT Pro Should Know

- **Amazon Web Services (AWS) is the world's**: Amazon Web Services (AWS) is the world's leading cloud platform, providing scalable, secure, and reliable infrastructure for businesses of all sizes.

- **🔑 Key AWS Core Services**: 🔑 Key AWS Core Services

- **🖥️ EC2 (Elastic Compute Cloud) • Virtual**: 🖥️ EC2 (Elastic Compute Cloud) • Virtual servers in the cloud • Run Windows or Linux workloads • Scale resources on demand

- **📦 S3 (Simple Storage Service) • Secure o**: 📦 S3 (Simple Storage Service) • Secure object storage • Store files, backups, logs, and media • Highly durable and scalable

- **🗄️ RDS (Relational Database Service) • M**: 🗄️ RDS (Relational Database Service) • Managed SQL databases • Supports MySQL, PostgreSQL, SQL Server, and more • Automated backups and maintenance

## 3. Production Command Scripts & Automation

```powershell
# Verify AWS CLI identity and active session
aws sts get-caller-identity

# List all Amazon Virtual Private Clouds (VPCs) and CIDR blocks
aws ec2 describe-vpcs --query "Vpcs[*].{VpcId:VpcId,CidrBlock:CidrBlock,State:State}" --output table
```

## 4. Technical Breakdown & Architecture Deep Dive

Understanding the low-level operating system mechanics and service interactions prevents unintended side effects:

- `<span class="cmd-tag">Administrative Security Context</span>`: Operations altering system state require local administrator privileges or domain delegatory rights.
- `<span class="cmd-tag">Service Architecture</span>`: Windows services and WMI/CIM providers interact directly with the hardware abstraction layer and kernel objects.
- **Enterprise Scale**: Implementing scripted automation reduces Mean Time to Resolution (MTTR) from hours to minutes across distributed endpoints.

## 5. Enterprise Verification Checklist

| Checkpoint | Verification Step | Common Remediation |
| :--- | :--- | :--- |
| **Administrative Privilege** | Run `whoami /priv` or verify elevated prompt | Launch PowerShell or Terminal via **Run as Administrator** |
| **Port & Network Health** | Test TCP handshake via `Test-NetConnection` | Verify firewall state and domain edge security rules |
| **Service Status** | Query service via `Get-Service` or `sc query` | Restart dependent services and inspect event logs |

## 💡 20+ Years Banking & Enterprise IT Pro-Tip

In mission-critical banking and corporate networks, always test administrative scripts against a staging organizational unit (OU) or non-production test tenant before applying widespread changes. Keep audit logs enabled to maintain complete regulatory compliance.

---

> 🔗 **Join the Live Community Discussion**:
> Have questions or insights about this technical guide?
> 👉 **[View and join the original LinkedIn post discussion](https://www.linkedin.com/feed/update/urn:li:activity:7470948006301683712/)**
>
> *Authored by [Toan Nguyen (Toan Nguyen IT OZ)](https://www.linkedin.com/in/toan-nguyen-it-oz/) — 20+ Years Enterprise & Banking IT Experience in Adelaide, South Australia.*
