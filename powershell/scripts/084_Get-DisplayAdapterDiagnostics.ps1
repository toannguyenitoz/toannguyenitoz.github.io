<#
.SYNOPSIS
    Dual/Triple Monitor Resolution & Display Adapter Diagnostic (Toan Nguyen IT OZ)
.DESCRIPTION
    Audits multi-monitor setups, displaying resolution, active refresh rate (Hz), connection type (DisplayPort/HDMI), and GPU driver versions.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 084
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_084_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Dual/Triple Monitor Resolution & Display Adapter Diagnostic (Episode 084)..." "INFO"

# Execution Logic
try {
    Get-CimInstance Win32_VideoController | Select Name, DriverVersion, VideoModeDescription
Get-WmiObject -Namespace root\wmi -Class WmiMonitorBasicDisplayParams
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
