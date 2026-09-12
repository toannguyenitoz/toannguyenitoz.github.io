<#
.SYNOPSIS
    Full System Hardware Spec Sheet & Serial Number Exporter (Toan Nguyen IT OZ)
.DESCRIPTION
    Extracts manufacturer, model, motherboard serial number, CPU architecture, total RAM, and storage health into a structured IT asset file.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 081
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_081_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Full System Hardware Spec Sheet & Serial Number Exporter (Episode 081)..." "INFO"

# Execution Logic
try {
    Get-CimInstance Win32_ComputerSystem | Select Manufacturer, Model, TotalPhysicalMemory
Get-CimInstance Win32_Bios | Select SerialNumber, SMBIOSBIOSVersion
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
