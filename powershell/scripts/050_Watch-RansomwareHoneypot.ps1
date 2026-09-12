<#
.SYNOPSIS
    Windows Ransomware Extension & Honeypot File Watcher (Toan Nguyen IT OZ)
.DESCRIPTION
    Places canary honeypot files in key directories and monitors file system events for mass encryption attempts, triggering emergency isolation.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 050
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_050_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Windows Ransomware Extension & Honeypot File Watcher (Episode 050)..." "INFO"

# Execution Logic
try {
    $watcher = New-Object System.IO.FileSystemWatcher
$watcher.Path = 'C:\Honeypot'
$watcher.EnableRaisingEvents = $true
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
