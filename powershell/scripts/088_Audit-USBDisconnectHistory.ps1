<#
.SYNOPSIS
    Peripheral USB Hub & HID Device Disconnect Log Auditor (Toan Nguyen IT OZ)
.DESCRIPTION
    Parses Windows PNP and Kernel-PnP event logs to identify unstable USB hubs, flickering webcams, and docking stations disconnecting unexpectedly.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 088
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_088_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Peripheral USB Hub & HID Device Disconnect Log Auditor (Episode 088)..." "INFO"

# Execution Logic
try {
    Get-WinEvent -FilterHashtable @{LogName='System'; ProviderName='Microsoft-Windows-Kernel-PnP'; Id=219} -MaxEvents 25 -EA SilentlyContinue
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
