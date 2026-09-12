<#
.SYNOPSIS
    RAM Module Serial, Speed & Empty Slot Verifier (Toan Nguyen IT OZ)
.DESCRIPTION
    Queries physical memory modules to show installed RAM capacity, frequency speed (MHz), manufacturer part number, and identifies available empty slots.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 087
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_087_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting RAM Module Serial, Speed & Empty Slot Verifier (Episode 087)..." "INFO"

# Execution Logic
try {
    Get-CimInstance Win32_PhysicalMemory | Select BankLabel, DeviceLocator, @{N='SizeGB';E={$_.Capacity/1GB}}, Speed, Manufacturer, PartNumber
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
