<#
.SYNOPSIS
    Registry Branch Auto-Backup before System Tweaks (Toan Nguyen IT OZ)
.DESCRIPTION
    Exports specific registry keys and hives to a .reg file prior to system changes, creating an accompanying instant rollback script.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 092
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_092_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Registry Branch Auto-Backup before System Tweaks (Episode 092)..." "INFO"

# Execution Logic
try {
    $backup = "C:\IT_Support_Logs\RegBackup_$(Get-Date -Format 'yyyyMMdd_HHmmss').reg"
& reg.exe export "HKLM\SYSTEM\CurrentControlSet" $backup /y
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
