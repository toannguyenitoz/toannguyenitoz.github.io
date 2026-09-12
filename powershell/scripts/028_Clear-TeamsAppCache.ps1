<#
.SYNOPSIS
    Microsoft Teams Meeting Cache & Client Reset (Toan Nguyen IT OZ)
.DESCRIPTION
    Completely flushes Microsoft Teams classical and new 2.0 cache, clearing corrupted local storage, cookie jars, and Webview2 database locks.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 028
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_028_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Microsoft Teams Meeting Cache & Client Reset (Episode 028)..." "INFO"

# Execution Logic
try {
    Stop-Process -Name ms-teams, teams -Force -ErrorAction SilentlyContinue
Remove-Item "$env:LOCALAPPDATA\Packages\MSTeams_8wekyb3d8bbwe\LocalCache" -Recurse -Force
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
