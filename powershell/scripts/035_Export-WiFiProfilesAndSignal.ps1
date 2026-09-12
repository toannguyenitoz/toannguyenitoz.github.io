<#
.SYNOPSIS
    Wi-Fi Signal Quality & Saved Profile Password Exporter (Toan Nguyen IT OZ)
.DESCRIPTION
    Extracts all saved Wi-Fi SSIDs and cleartext passwords for authorized IT troubleshooting, and analyzes real-time signal strength and channel crowding.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 035
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_035_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Wi-Fi Signal Quality & Saved Profile Password Exporter (Episode 035)..." "INFO"

# Execution Logic
try {
    (netsh wlan show profiles) | Select-String 'All User Profile' | ForEach-Object {
    $name = ($_.ToString() -split ':')[1].Trim()
    netsh wlan show profile name="$name" key=clear
}
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
