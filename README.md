# AD-Home-Lab

> Complete Active Directory Home Lab built from scratch using PowerShell automation to simulate a real enterprise environment for Active Directory administration, security assessment, and penetration testing.

---

# Quick Start

## Download the project

Run the following PowerShell command:

```powershell
Invoke-WebRequest "https://github.com/bex2030/AD-Home-Lab/archive/refs/heads/main.zip" -OutFile "C:\Users\Administrator\AD-Home-Lab.zip"
```

Extract the archive, then run the PowerShell scripts listed in the **Deployment** section as **Administrator**.

---

## Create a Local Windows Account (No Microsoft Account)

During Windows 10/11 setup, open **Command Prompt** (`Shift +F10`) and run:

```cmd
start ms-cxh:localonly
```

This opens the local account creation wizard and allows Windows to be configured without signing in with a Microsoft account.

---

# Architecture

![Architecture](Screenshots/architecture.png)

---

# Overview

This project demonstrates how to deploy a complete Active Directory home lab from scratch using PowerShell automation.

The lab simulates a small enterprise network and provides a safe environment to practice Windows Server administration, Active Directory management, and realistic internal penetration testing techniques.

---

## Attack Flow

```text
ahmed
    │
    ▼
SMB Enumeration
    │
    ▼
support_notes.txt
    │
    ▼
Credential Discovery
    │
    ▼
Password Spraying
    │
    ▼
faris
    │
    ▼
GG_IT
    │
    ▼
Domain Admins

────────────────────────────

SPN Enumeration
    │
    ▼
Kerberoasting
    │
    ▼
iis_server

────────────────────────────

AS-REP Roasting
    │
    ▼
osama
```

---

# Table of Contents

- [Features](#features)
- [Lab Environment](#lab-environment)
- [Hardware Requirements](#hardware-requirements)
- [Virtual Machine Resources](#virtual-machine-resources)
- [Network Configuration](#network-configuration)
- [Domain Information](#domain-information)
- [Deployment](#deployment)
- [Active Directory Structure](#active-directory-structure)
- [Services](#services)
- [Lab Scenario](#lab-scenario)
- [Attack Scenarios](#attack-scenarios)
- [Defensive Concepts](#defensive-concepts)
- [Tools Used](#tools-used)
- [Learning Outcomes](#learning-outcomes)
- [Future Improvements](#future-improvements)
- [Screenshots](#screenshots)
- [Author](#author)

---

# Features

- Automated Active Directory deployment
- PowerShell automation
- Organizational Units (OUs)
- Users and Security Groups
- Nested Active Directory Groups
- Service Accounts
- Kerberos SPN Configuration
- IIS Web Server
- Department SMB Shares
- Credential Exposure Scenario
- Password Spraying
- Password Reuse
- Kerberoasting
- AS-REP Roasting
- BloodHound Attack Path Analysis
- Domain-Joined Workstations
- Enterprise-like Active Directory Structure

---

# Lab Environment

| Machine | Operating System | Role |
|----------|------------------|------|
| DC-01 | Windows Server 2022 | Domain Controller |
| WIN10-01 | Windows 10 | Domain Client |
| Kali | Kali Linux | Attacker Machine |

---

# Hardware Requirements

| Component | Requirement |
|------------|-------------|
| CPU | 4 Cores |
| RAM | 16 GB |
| Storage | 100 GB |
| Hypervisor | VMware Workstation |
| Network | NAT |

---

# Virtual Machine Resources

## DC-01

```text
CPU: 2 Cores
RAM: 4 GB
Storage: 60 GB
```

### Services

- Active Directory Domain Services (AD DS)
- DNS
- IIS
- SMB

---

## WIN10-01

```text
CPU: 2 Cores
RAM: 2 GB
Storage: 40 GB
```

### Role

- Domain Client

---

## Kali Linux

```text
CPU: 2 Cores
RAM: 2 GB
Storage: 30 GB
```

### Role

- Internal Security Assessment
- Enumeration
- Attack Simulation

---

# Network Configuration

### Hypervisor

```text
VMware Workstation
```

### Network Mode

```text
NAT
```

All machines receive IP addresses automatically through VMware DHCP.

---

# Domain Information

```text
Domain  : cyber.local
NetBIOS : CYBER
```

---

# Deployment

Run the following PowerShell scripts from an elevated PowerShell session on the Domain Controller in the following order.

> **Note**
>
> Run **00-Rename-Server.ps1** first. The server will automatically restart after the computer name is changed. Once the restart is complete, continue with the remaining scripts.

```powershell
00-Rename-Server.ps1
01-Install-ADDS.ps1
02-Create-OUs.ps1
03-Create-Users.ps1
04-Create-Groups.ps1
05-Add-GroupMembers.ps1
06-Create-ServiceAccounts.ps1
07-Install-IIS.ps1
08-Create-SMB-Shares.ps1
09-Disable-Security.ps1
```

---

# Active Directory Structure

```text
cyber.local

└── KSA
    ├── Users
    │   ├── ahmed
    │   ├── faris
    │   ├── mohamed
    │   ├── waleed
    │   └── osama
    │
    ├── Groups
    │   ├── GG_IT
    │   ├── GG_HR
    │   ├── GG_Cyber
    │   └── GG_Management
    │
    ├── Service Accounts
    │   └── iis_server
    │
    └── Workstations
        └── WIN10-01
```

## Users

| User | Department | Group | Description |
|------|------------|-------|-------------|
| ahmed | Employee | None | Low-privileged domain user |
| faris | IT Support | GG_IT | IT support technician |
| mohamed | IT Support | GG_IT | Senior IT support technician |
| waleed | Human Resources | GG_HR | HR employee |
| osama | Cyber Security | GG_Cyber | Kerberos pre-authentication disabled |
| iis_server | Service Account | GG_Management | IIS service account with an HTTP SPN |

---

# Services

## Active Directory

- User Management
- Group Management
- Organizational Units (OUs)
- Kerberos Authentication
- Security Groups

## DNS

- Domain Name Resolution
- Client Domain Joining

## IIS

| Setting | Value |
|---------|-------|
| Website | CyberLab |
| Port | 80 |

## SMB File Shares

| Share | Permission |
|--------|------------|
| IT | GG_IT |
| HR | GG_HR |
| Cyber | GG_Cyber |
| Management | GG_Management |

> **Note**
>
> The **IT** share grants read-only access to the **ahmed** account to simulate an internal credential exposure scenario.
>
> ---

# Lab Scenario

This lab simulates a realistic internal Active Directory security assessment from the perspective of an authenticated domain user.

## Phase 1 – Initial Access

The assessment begins with the compromised credentials of **ahmed**, a low-privileged domain user.

```text
Username: ahmed
Password: Aa123456789
```

---

## Phase 2 – SMB Enumeration

Using the compromised **ahmed** account, the attacker enumerates accessible SMB shares.

The **IT** share contains an internal support note that was accidentally left behind after a password reset.

The note reveals the temporary password assigned to **faris**.

```text
\\DC-01\IT
        │
        ▼
support_notes.txt
        │
        ▼
Username: faris
Password: Aa123456789
```

### Demonstrates

- SMB Enumeration
- Credential Discovery
- Insecure Credential Storage

---

## Phase 3 – Password Spraying

Using the password discovered in the IT support note, the attacker performs a password spraying attack against domain users.

The attack reveals that **faris** is reusing the same password.

```text
support_notes.txt
        │
        ▼
Password Spraying
        │
        ▼
faris
Password: Aa123456789
        │
        ▼
GG_IT
        │
        ▼
Domain Admins
```

Because **GG_IT** is nested inside **Domain Admins**, compromising the **faris** account results in **Domain Administrator** privileges.

### Demonstrates

- Password Spraying
- Password Reuse
- Nested Group Privilege Escalation

---

## Phase 4 – Kerberoasting

The **iis_server** service account is configured with an HTTP Service Principal Name (SPN).

The attacker enumerates Service Principal Names (SPNs), requests a Kerberos service ticket, and performs offline password cracking to recover the service account credentials.

```text
Username: iis_server
Password: Password123!
```

### Demonstrates

- SPN Enumeration
- Kerberoasting
- Offline Password Cracking

---

## Phase 5 – AS-REP Roasting

The **osama** account has Kerberos pre-authentication disabled.

The attacker performs an AS-REP Roasting attack to obtain an AS-REP hash without prior knowledge of the user's password.

After cracking the hash offline, the attacker recovers the account credentials.

```text
Username: osama
Password: Pass0rd1
```

### Demonstrates

- AS-REP Roasting
- Offline Password Cracking

---

# Attack Scenarios

The lab supports the following attack scenarios:

- Active Directory Enumeration
- LDAP Enumeration
- SMB Enumeration
- SMB Share Discovery
- Credential Discovery
- Insecure Credential Storage
- User Enumeration
- Password Spraying
- Password Reuse
- Kerberoasting
- AS-REP Roasting
- BloodHound Analysis
- SharpHound Data Collection
- PowerView Enumeration
- SMB Permission Testing
- Nested Group Privilege Escalation

---

# Defensive Concepts

The lab also demonstrates the following defensive concepts:

- Least Privilege
- Security Groups
- Nested Group Management
- Service Account Management
- SMB Permissions
- Password Policies
- Credential Protection
- Kerberos Authentication
- Active Directory Hardening
- Windows Firewall
- Security Auditing

---

# Tools Used

## Infrastructure

- VMware Workstation
- Windows Server 2022
- Windows 10
- Kali Linux

## Enumeration

- Nmap
- enum4linux
- smbclient
- rpcclient
- CrackMapExec
- Kerbrute

## Active Directory

- BloodHound
- SharpHound
- PowerView
- Impacket

## Offensive Security

- Evil-WinRM
- Responder
- Inveigh
- Burp Suite

---

# Learning Outcomes

After completing this project, you will gain hands-on experience with:

- Deploying an Active Directory environment using PowerShell
- Windows Server Administration
- Active Directory Management
- Organizational Units (OUs)
- Security Groups
- Nested Group Administration
- Windows Authentication
- Kerberos Authentication
- SMB Configuration
- Active Directory Enumeration
- SMB Enumeration
- Credential Discovery
- Password Spraying
- Password Reuse Assessment
- Kerberoasting
- AS-REP Roasting
- BloodHound Analysis
- Privilege Escalation Analysis
- Enterprise Environment Simulation

---

# Future Improvements

- Group Policy (GPO)
- SQL Server
- Active Directory Certificate Services (AD CS)
- Sysmon
- Microsoft Defender
- LAPS
- Windows Event Forwarding (WEF)
- Wazuh SIEM Integration
- Elastic Stack Integration

---

# Screenshots

## Active Directory Users and Computers

![ADUC](Screenshots/aduc.png)

## SMB Enumeration

![SMB Enumeration](Screenshots/smb-enumeration.png)

## Password Spraying

![Password Spraying](Screenshots/passwordspraying.png)

## Kerberoasting

![Kerberoasting](Screenshots/kerberoasting.png)

## AS-REP Roasting

![AS-REP Roasting](Screenshots/asreproasting.png)

## BloodHound

![BloodHound](Screenshots/bloodhound.png)

## IIS Website

![IIS](Screenshots/iis.png)

## Domain Join

![Domain Join](Screenshots/domainjoin.png)

---

---

# Author

**Osama Aljohani**

## Certifications

- eCPPTv3
- eWPTXv3
- eWPTv2
- eJPTv2
