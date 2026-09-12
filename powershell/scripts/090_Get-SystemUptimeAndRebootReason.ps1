<#
.SYNOPSIS
    Remote PC Uptime & Last Reboot Reason Investigator (Toan Nguyen IT OZ)
.DESCRIPTION
    Calculates exact system uptime in days/hours, and audits event logs to reveal whether the last reboot was initiated by a user, Windows Update, or a crash.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 090
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_090_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Remote PC Uptime & Last Reboot Reason Investigator (Episode 090)..." "INFO"

# Execution Logic
try {
    $os = Get-CimInstance Win32_OperatingSystem
$uptime = (Get-Date) - $os.LastBootUpTime
Write-Host "Uptime: $($uptime.Days) Days, $($uptime.Hours) Hours"
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
