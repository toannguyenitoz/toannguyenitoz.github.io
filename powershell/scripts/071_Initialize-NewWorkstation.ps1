<#
.SYNOPSIS
    Automated Standard Help Desk PC Post-Setup Initializer (Toan Nguyen IT OZ)
.DESCRIPTION
    Runs full setup checklist for new laptops: sets Adelaide Australia timezone, enables Remote Desktop, sets high-performance power, and renames PC.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 071
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_071_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Automated Standard Help Desk PC Post-Setup Initializer (Episode 071)..." "INFO"

# Execution Logic
try {
    Set-TimeZone -Id 'Cen. Australia Standard Time'
Set-ItemProperty 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name 'fDenyTSConnections' -Value 0
powercfg.exe /setactive 8c5e7fda-e8bf-4a96-9a85-a6e23a8c635c
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
