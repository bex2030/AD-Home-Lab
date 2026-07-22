Import-Module ActiveDirectory

$ServiceOU = "OU=Service Accounts,OU=KSA,DC=cyber,DC=local"

$Password = ConvertTo-SecureString "Password123!" -AsPlainText -Force

New-ADUser `
    -Name "IIS Service" `
    -SamAccountName "iis_server" `
    -UserPrincipalName "iis_server@cyber.local" `
    -Path $ServiceOU `
    -AccountPassword $Password `
    -Enabled $true `
    -PasswordNeverExpires $true `
    -ChangePasswordAtLogon $false

Write-Host "Service account created successfully."