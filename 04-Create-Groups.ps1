Import-Module ActiveDirectory

$GroupsOU = "OU=Groups,OU=KSA,DC=cyber,DC=local"

$Groups = @(
    "GG_Cyber",
    "GG_IT",
    "GG_HR",
    "GG_Management"
)

foreach ($Group in $Groups) {

    New-ADGroup `
        -Name $Group `
        -SamAccountName $Group `
        -GroupScope Global `
        -GroupCategory Security `
        -Path $GroupsOU
}

Write-Host "Security groups created successfully."