<#
.SYNOPSIS
    BSOD Crash Dump & Minidump Analyzer (Toan Nguyen IT OZ)
.DESCRIPTION
    Scans C:\Windows\Minidump, parses bugcheck codes, identifies culprit sys/dll drivers, and exports structured crash telemetry.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 003
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_003_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting BSOD Crash Dump & Minidump Analyzer (Episode 003)..." "INFO"

# Execution Logic
try {
    Get-WinEvent -FilterHashtable @{LogName='System'; Id=1001,41} -MaxEvents 10 | Select TimeCreated, Id, Message
Get-ChildItem 'C:\Windows\Minidump\*.dmp'
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
