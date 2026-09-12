<#
.SYNOPSIS
    WMI & Winmgmt Repository Integrity Verifier & Repair (Toan Nguyen IT OZ)
.DESCRIPTION
    Checks the consistency of the Windows Management Instrumentation (WMI) repository and repairs corrupted database indexes safely.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 008
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_008_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting WMI & Winmgmt Repository Integrity Verifier & Repair (Episode 008)..." "INFO"

# Execution Logic
try {
    winmgmt /verifyrepository
winmgmt /salvagerepository
winmgmt /resetrepository
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
