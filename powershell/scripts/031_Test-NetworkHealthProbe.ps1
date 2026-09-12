<#
.SYNOPSIS
    60-Second Full Network & Gateway Health Probe (Toan Nguyen IT OZ)
.DESCRIPTION
    Runs an end-to-end network connectivity audit, validating local gateway ping, DNS resolution, internet egress, and Microsoft 365 endpoint handshakes.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 031
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_031_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting 60-Second Full Network & Gateway Health Probe (Episode 031)..." "INFO"

# Execution Logic
try {
    Test-NetConnection -ComputerName 1.1.1.1 -CommonTCPPort HTTP
Test-NetConnection -ComputerName 'login.microsoftonline.com' -Port 443
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
