<#
.SYNOPSIS
    Print Spooler Deep Purge & Stuck Queue Cleanser (Toan Nguyen IT OZ)
.DESCRIPTION
    Safely stops Print Spooler, purges locked .SHD/.SPL spool files in System32\spool\PRINTERS, and restarts print subsystem without server reboot.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 005
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_005_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Print Spooler Deep Purge & Stuck Queue Cleanser (Episode 005)..." "INFO"

# Execution Logic
try {
    Stop-Service Spooler -Force
Remove-Item $env:SystemRoot\System32\spool\PRINTERS\* -Force
Start-Service Spooler
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
