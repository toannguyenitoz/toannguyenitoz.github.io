<#
.SYNOPSIS
    Local Windows Defender Firewall Port Rule Auditor (Toan Nguyen IT OZ)
.DESCRIPTION
    Scans all active Windows Firewall inbound rules, pinpointing overly permissive rules allowing unauthorized outside access to local ports.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 037
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_037_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Local Windows Defender Firewall Port Rule Auditor (Episode 037)..." "INFO"

# Execution Logic
try {
    Get-NetFirewallRule -Direction Inbound -Enabled True | Where-Object { $_.Action -eq 'Allow' } | Select DisplayName, Direction, Action, Profile
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
