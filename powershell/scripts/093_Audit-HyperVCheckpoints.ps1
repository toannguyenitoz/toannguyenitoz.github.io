<#
.SYNOPSIS
    Hyper-V VM Snapshot & Checkpoint Health Watchdog (Toan Nguyen IT OZ)
.DESCRIPTION
    Scans local Hyper-V hosts for abandoned snapshots older than 7 days, warning admins before delta AVHDX files consume the entire storage volume.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 093
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_093_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Hyper-V VM Snapshot & Checkpoint Health Watchdog (Episode 093)..." "INFO"

# Execution Logic
try {
    Get-VMSnapshot -VMName * | Where-Object { $_.CreationTime -lt (Get-Date).AddDays(-7) } | Select VMName, Name, CreationTime
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
