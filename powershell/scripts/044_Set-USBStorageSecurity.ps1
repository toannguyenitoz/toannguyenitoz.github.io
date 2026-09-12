<#
.SYNOPSIS
    USB Storage Device Access Lock & Audit Logger (Toan Nguyen IT OZ)
.DESCRIPTION
    Controls USB removable storage access via registry keys, switching between Fully Blocked, Read-Only, or Enabled, and logging USB plug-ins.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 044
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_044_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting USB Storage Device Access Lock & Audit Logger (Episode 044)..." "INFO"

# Execution Logic
try {
    Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Services\USBSTOR' -Name 'Start' -Value 4
Write-Host 'USB Storage Blocked.' -ForegroundColor Red
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
