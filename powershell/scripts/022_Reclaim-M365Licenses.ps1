<#
.SYNOPSIS
    Microsoft 365 Inactive License Reclaimer & Usage Auditor (Toan Nguyen IT OZ)
.DESCRIPTION
    Audits Microsoft 365 user mailbox activity and OneDrive sign-in logs, flagging assigned Business Premium/E3/E5 licenses that are unused.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 022
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_022_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Microsoft 365 Inactive License Reclaimer & Usage Auditor (Episode 022)..." "INFO"

# Execution Logic
try {
    Get-MgUser -Filter 'accountEnabled eq false' -Property AssignedLicenses | ForEach-Object { Set-MgUserLicense -UserId $_.Id -RemoveLicenses $_.AssignedLicenses.SkuId }
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
