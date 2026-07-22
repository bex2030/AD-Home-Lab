Import-Module ActiveDirectory

# ============================================
# Add Users to Security Groups
# Domain: cyber.local
# ============================================

# Cyber Department
Add-ADGroupMember -Identity "GG_Cyber" -Members "osama"

# IT Department
Add-ADGroupMember -Identity "GG_IT" -Members "faris","mohamed"

# HR Department
Add-ADGroupMember -Identity "GG_HR" -Members "waleed"

# Management
Add-ADGroupMember -Identity "GG_Management" -Members "iis_server"

# Nested Group
# GG_IT -> Domain Admins
Add-ADGroupMember -Identity "Domain Admins" -Members "GG_IT"

Write-Host "Users and nested groups configured successfully."