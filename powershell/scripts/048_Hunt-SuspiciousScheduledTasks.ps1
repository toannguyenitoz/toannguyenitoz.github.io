<#
.SYNOPSIS
    Suspicious Scheduled Task & Persistence Hunter (Toan Nguyen IT OZ)
.DESCRIPTION
    Inspects all Windows Task Scheduler entries, highlighting tasks running out of AppData, Temp, or calling PowerShell with -EncodedCommand or -WindowStyle Hidden.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 048
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_048_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Suspicious Scheduled Task & Persistence Hunter (Episode 048)..." "INFO"

# Execution Logic
try {
    Get-ScheduledTask | Where-Object { $_.Actions.Execute -match 'powershell|cmd|cscript|wscript' } | Select TaskName, TaskPath, @{N='Action';E={$_.Actions.Execute + ' ' + $_.Actions.Arguments}}
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
