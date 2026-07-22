Import-Module ActiveDirectory

# Create Root OU
New-ADOrganizationalUnit `
    -Name "KSA" `
    -Path "DC=cyber,DC=local"

# Create Child OUs
$BaseOU = "OU=KSA,DC=cyber,DC=local"

$OUs = @(
    "Users",
    "Groups",
    "Service Accounts",
    "Workstations"
)

foreach ($OU in $OUs) {
    New-ADOrganizationalUnit `
        -Name $OU `
        -Path $BaseOU
}

Write-Host "Organizational Units created successfully."