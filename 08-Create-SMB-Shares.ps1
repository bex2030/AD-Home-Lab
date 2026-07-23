# ============================================
# Create SMB Shares
# Domain: cyber.local
# Server: DC-01
#
# Scenario:
# ahmed -> SMB Enumeration
# IT Share -> Credential Exposure (faris)
# Password Spraying -> Domain Admin (GG_IT)
# ============================================

Import-Module SmbShare
Import-Module ActiveDirectory

# ============================================
# Create Root Folder
# ============================================

New-Item `
    -Path "C:\Shares" `
    -ItemType Directory `
    -Force

# ============================================
# Create Department Folders
# ============================================

$Folders = @(
    "Cyber",
    "IT",
    "HR",
    "Management"
)

foreach ($Folder in $Folders) {

    New-Item `
        -Path "C:\Shares\$Folder" `
        -ItemType Directory `
        -Force

}

# ============================================
# IT Credential Exposure Scenario
# ============================================

@"
IT Support Notes
================

User: faris
Issue: Password reset completed successfully.
Temporary Password: Aa123456789
Status: Waiting for user confirmation.

TO DO: Delete this file after the user confirms login.

Created by:
IT Support Team

"@ | Out-File `
"C:\Shares\IT\support_notes.txt" `
-Encoding UTF8

# ============================================
# Cyber Department File
# ============================================

@"
Cyber Security Department
=========================

Internal Documentation

Tools:
- BloodHound
- PowerView
- SIEM

Classification:
Internal Use Only

"@ | Out-File `
"C:\Shares\Cyber\security_docs.txt" `
-Encoding UTF8

# ============================================
# Management Department File
# ============================================

@"
Management Department
=====================

Project:
CyberLab

Classification:
Internal

Author:
Management Team

"@ | Out-File `
"C:\Shares\Management\project.txt" `
-Encoding UTF8

# ============================================
# Create SMB Shares
# ============================================

$Shares = @(
    @{Name="Cyber"; Path="C:\Shares\Cyber"; Group="GG_Cyber"},
    @{Name="IT"; Path="C:\Shares\IT"; Group="GG_IT"},
    @{Name="HR"; Path="C:\Shares\HR"; Group="GG_HR"},
    @{Name="Management"; Path="C:\Shares\Management"; Group="GG_Management"}
)

foreach ($Share in $Shares) {

    if (!(Get-SmbShare -Name $Share.Name -ErrorAction SilentlyContinue)) {

        New-SmbShare `
            -Name $Share.Name `
            -Path $Share.Path `
            -FullAccess "CYBER\$($Share.Group)"

    }

}

# ============================================
# Allow Ahmed to Access the IT Share
# ============================================

Grant-SmbShareAccess `
    -Name "IT" `
    -AccountName "CYBER\ahmed" `
    -AccessRight Read `
    -Force

icacls "C:\Shares\IT" `
    /grant "CYBER\ahmed:(OI)(CI)RX"

# ============================================
# Enable SMB Firewall Rules
# ============================================

Enable-NetFirewallRule `
    -DisplayGroup "File and Printer Sharing"

# ============================================
# Verify SMB Shares
# ============================================

Get-SmbShare

Write-Host ""
Write-Host "========================================="
Write-Host " SMB Shares Created Successfully"
Write-Host " IT Credential Exposure Scenario Ready"
Write-Host " Password Spraying Scenario Ready"
Write-Host " Ahmed SMB Enumeration Enabled"
Write-Host "========================================="
