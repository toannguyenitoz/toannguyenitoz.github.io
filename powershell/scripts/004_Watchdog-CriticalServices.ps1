<#
.SYNOPSIS
    Windows Critical Service Watchdog & Auto-Healer (Toan Nguyen IT OZ)
.DESCRIPTION
    Audits business-critical services (Spooler, WinRM, LanmanServer, W32Time), detects stopped states, and heals them with automatic restart.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 004
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_004_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Windows Critical Service Watchdog & Auto-Healer (Episode 004)..." "INFO"

# Execution Logic
try {
    $services = @('Spooler','WinRM','LanmanServer','W32Time')
foreach ($s in $services) { if ((Get-Service $s).Status -ne 'Running') { Start-Service $s } }
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
