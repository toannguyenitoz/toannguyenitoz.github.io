<#
.SYNOPSIS
    Windows Fast Startup & Hibernation Storage Optimizer (Toan Nguyen IT OZ)
.DESCRIPTION
    Disables Windows Fast Startup and removes hiberfil.sys to reclaim RAM-equivalent disk space on SSDs while eliminating hybrid sleep boot bugs.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 007
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_007_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Windows Fast Startup & Hibernation Storage Optimizer (Episode 007)..." "INFO"

# Execution Logic
try {
    powercfg.exe /hibernate off
Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power' -Name HiberbootEnabled -Value 0
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
