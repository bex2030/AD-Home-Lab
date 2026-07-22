Import-Module ActiveDirectory

$UsersOU = "OU=Users,OU=KSA,DC=cyber,DC=local"

$Users = @(
    @{
        FirstName = "Ahmed"
        LastName = "A"
        Sam = "ahmed"
        Password = "Aa123456789"
    },
    @{
        FirstName = "Faris"
        LastName = "A"
        Sam = "faris"
        Password = "Aa123456789"
    },
    @{
        FirstName = "Mohamed"
        LastName = "A"
        Sam = "mohamed"
        Password = "Passw0rd123"
    },
    @{
        FirstName = "Waleed"
        LastName = "A"
        Sam = "waleed"
        Password = "Welcome123!"
    },
    @{
        FirstName = "Osama"
        LastName = "A"
        Sam = "osama"
        Password = "Pass0rd1"
    }
)


foreach ($User in $Users) {

    $SecurePassword = ConvertTo-SecureString $User.Password -AsPlainText -Force

    New-ADUser `
        -Name "$($User.FirstName) $($User.LastName)" `
        -GivenName $User.FirstName `
        -Surname $User.LastName `
        -SamAccountName $User.Sam `
        -UserPrincipalName "$($User.Sam)@cyber.local" `
        -Path $UsersOU `
        -AccountPassword $SecurePassword `
        -Enabled $true `
        -ChangePasswordAtLogon $false `
        -PasswordNeverExpires $true
}

# Disable Kerberos Pre-Authentication for AS-REP Roasting lab

Set-ADAccountControl `
    -Identity "osama" `
    -DoesNotRequirePreAuth $true

Write-Host "Kerberos pre-authentication disabled for osama."

Write-Host "All users created successfully."