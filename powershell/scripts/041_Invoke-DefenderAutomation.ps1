<#
.SYNOPSIS
    Microsoft Defender Automation & Offline Scan Scheduler (Toan Nguyen IT OZ)
.DESCRIPTION
    Updates Microsoft Defender definitions directly from Microsoft Cloud, runs quick/full scans silently, and logs threat detection history.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 041
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_041_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Microsoft Defender Automation & Offline Scan Scheduler (Episode 041)..." "INFO"

# Execution Logic
try {
    Update-MpSignature
Start-MpScan -ScanType FullScan
Get-MpThreatDetection | Select ThreatName, InitialDetectionTime, Resources
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
