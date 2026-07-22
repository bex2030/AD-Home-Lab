# ============================================
# Install and Configure IIS
# Domain: cyber.local
# ============================================

# Install IIS
Install-WindowsFeature Web-Server -IncludeManagementTools

Import-Module WebAdministration
Import-Module ActiveDirectory

# Create Website Folder
New-Item -Path "C:\inetpub\CyberLab" -ItemType Directory -Force

# Create Website
if (-not (Test-Path "IIS:\Sites\CyberLab")) {
    New-Website `
        -Name "CyberLab" `
        -PhysicalPath "C:\inetpub\CyberLab" `
        -Port 80
}

# Create Application Pool
if (-not (Test-Path "IIS:\AppPools\CyberLabPool")) {
    New-WebAppPool -Name "CyberLabPool"
}

# Configure Application Pool to use the service account
Set-ItemProperty IIS:\AppPools\CyberLabPool -Name processModel.identityType -Value 3
Set-ItemProperty IIS:\AppPools\CyberLabPool -Name processModel.userName -Value "CYBER\iis_server"
Set-ItemProperty IIS:\AppPools\CyberLabPool -Name processModel.password -Value "Password123!"

# Assign Application Pool
Set-ItemProperty IIS:\Sites\CyberLab -Name applicationPool -Value "CyberLabPool"

# Register SPNs
setspn -S HTTP/DC-01 iis_server
setspn -S HTTP/DC-01.cyber.local iis_server

# Verify SPNs
Write-Host ""
Write-Host "Registered SPNs:"
setspn -L iis_server

Write-Host ""
Write-Host "IIS installed and configured successfully."