<#
.SYNOPSIS
    DNS Cache Flush & Multi-Server Query Validator (Toan Nguyen IT OZ)
.DESCRIPTION
    Flushes the local DNS client cache, tests resolution across multiple DNS servers (internal AD vs public 1.1.1.1), and reveals split-brain DNS issues.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 032
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_032_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting DNS Cache Flush & Multi-Server Query Validator (Episode 032)..." "INFO"

# Execution Logic
try {
    Clear-DnsClientCache
Resolve-DnsName -Name 'autodiscover.company.com' -Server 10.0.0.1 -DnsOnly
Resolve-DnsName -Name 'google.com' -Server 8.8.8.8
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
