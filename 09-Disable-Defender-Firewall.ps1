# Disable Windows Firewall
Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False

# Disable Microsoft Defender Real-Time Protection
Set-MpPreference -DisableRealtimeMonitoring $true

Write-Host "Windows Firewall disabled."
Write-Host "Microsoft Defender real-time protection disabled."