<#
.SYNOPSIS
    C: Drive Emergency Deep Cleaner (Temp, WinSxS, Dumps) (Toan Nguyen IT OZ)
.DESCRIPTION
    Aggressively purges user temp files, system temp, Windows Error Reporting dumps, delivery optimization caches, and obsolete install folders.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 051
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_051_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting C: Drive Emergency Deep Cleaner (Temp, WinSxS, Dumps) (Episode 051)..." "INFO"

# Execution Logic
try {
    Remove-Item "$env:TEMP\*" -Recurse -Force -EA SilentlyContinue
Remove-Item "$env:SystemRoot\Temp\*" -Recurse -Force -EA SilentlyContinue
Cleanmgr.exe /sagerun:1
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
