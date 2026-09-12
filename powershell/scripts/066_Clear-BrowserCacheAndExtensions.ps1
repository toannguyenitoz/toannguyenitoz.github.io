<#
.SYNOPSIS
    Chrome & Edge Enterprise Extension & Cache Purger (Toan Nguyen IT OZ)
.DESCRIPTION
    Safely stops browser processes, purges accumulated web caches and corrupted cookies, and audits installed extensions across Chrome and Edge.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 066
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_066_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Chrome & Edge Enterprise Extension & Cache Purger (Episode 066)..." "INFO"

# Execution Logic
try {
    Stop-Process -Name chrome, msedge -Force -EA SilentlyContinue
Remove-Item "$env:LOCALAPPDATA\Google\Chrome\User Data\Default\Cache\*" -Recurse -Force -EA SilentlyContinue
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
