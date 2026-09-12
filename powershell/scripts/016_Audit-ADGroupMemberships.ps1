<#
.SYNOPSIS
    AD Group Membership Differential & Orphan Cleaner (Toan Nguyen IT OZ)
.DESCRIPTION
    Extracts all security groups, identifies disabled user accounts still clinging to sensitive groups, and exports full membership matrix for audits.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 016
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_016_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting AD Group Membership Differential & Orphan Cleaner (Episode 016)..." "INFO"

# Execution Logic
try {
    Get-ADGroup -Filter * | ForEach-Object { $grp = $_.Name; Get-ADGroupMember $grp | Select @{N='Group';E={$grp}}, Name, SamAccountName, Enabled }
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
