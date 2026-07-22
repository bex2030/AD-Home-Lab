# ============================================
# Active Directory Deployment
# Domain: cyber.local
# Server: DC-01
# ============================================

# Install AD DS and Management Tools
Install-WindowsFeature AD-Domain-Services -IncludeManagementTools

# DSRM Password
$DSRMPassword = ConvertTo-SecureString "P@ssw0rd123!" -AsPlainText -Force

# Create New Forest
Install-ADDSForest `
    -DomainName "cyber.local" `
    -DomainNetbiosName "CYBER" `
    -InstallDNS `
    -CreateDnsDelegation:$false `
    -DatabasePath "C:\Windows\NTDS" `
    -LogPath "C:\Windows\NTDS" `
    -SysvolPath "C:\Windows\SYSVOL" `
    -SafeModeAdministratorPassword $DSRMPassword `
    -NoRebootOnCompletion:$false `
    -Force