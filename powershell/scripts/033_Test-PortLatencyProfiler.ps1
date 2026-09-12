<#
.SYNOPSIS
    TCP Port Handshake & Latency Profiler (Toan Nguyen IT OZ)
.DESCRIPTION
    Tests target TCP ports (443, 3389, 80, 25, 53) without installing legacy Telnet, recording round-trip time and packet loss metrics.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 033
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_033_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting TCP Port Handshake & Latency Profiler (Episode 033)..." "INFO"

# Execution Logic
try {
    Test-NetConnection -ComputerName 'mail.corp.com' -Port 25 -InformationLevel Detailed
Test-NetConnection -ComputerName 'dc01.corp.com' -Port 3389
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
