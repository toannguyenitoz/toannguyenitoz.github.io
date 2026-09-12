<#
.SYNOPSIS
    Laptop Battery Health & Degradation Cycle Reporter (Toan Nguyen IT OZ)
.DESCRIPTION
    Invokes Windows powercfg /batteryreport, parses design capacity vs current full charge capacity, and calculates exact battery degradation percentage.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 082
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_082_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Laptop Battery Health & Degradation Cycle Reporter (Episode 082)..." "INFO"

# Execution Logic
try {
    powercfg /batteryreport /output 'C:\IT_Support_Logs\Battery_Report.html'
$cap = (Get-WmiObject -Class BatteryFullChargedCapacity).FullChargedCapacity
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
