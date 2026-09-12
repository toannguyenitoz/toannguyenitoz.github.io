<#
.SYNOPSIS
    Windows Update Reset & Cache Purger (Toan Nguyen IT OZ)
.DESCRIPTION
    Diagnoses and repairs stuck Windows Update loops by gracefully stopping services, purging SoftwareDistribution and Catroot2 caches.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 002
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_002_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Windows Update Reset & Cache Purger (Episode 002)..." "INFO"

# Execution Logic
try {
    Stop-Service wuauserv, bits, cryptsvc -Force
Rename-Item $env:SystemRoot\SoftwareDistribution SoftwareDistribution.bak
Start-Service wuauserv, bits, cryptsvc
usoclient StartScan
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
