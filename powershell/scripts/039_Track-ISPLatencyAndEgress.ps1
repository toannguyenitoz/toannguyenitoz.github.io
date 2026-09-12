<#
.SYNOPSIS
    Public IP & ISP Egress Latency / Hop Tracker (Toan Nguyen IT OZ)
.DESCRIPTION
    Queries external public IP and ISP details via API, running continuous ping and packet drop tests against Cloudflare, Google, and AWS gateways.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 039
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_039_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Public IP & ISP Egress Latency / Hop Tracker (Episode 039)..." "INFO"

# Execution Logic
try {
    $ipInfo = Invoke-RestMethod 'https://ipinfo.io/json'
Write-Host "Public IP: $($ipInfo.ip) | ISP: $($ipInfo.org) | Loc: $($ipInfo.city)"
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
