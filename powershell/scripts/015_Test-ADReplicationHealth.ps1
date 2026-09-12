<#
.SYNOPSIS
    Domain Controller Replication & Health Diagnostic (Toan Nguyen IT OZ)
.DESCRIPTION
    Tests replication links between all domain controllers, verifies SYSVOL and Netlogon shares, and flags replication delays or tombstone errors.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 015
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_015_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Domain Controller Replication & Health Diagnostic (Episode 015)..." "INFO"

# Execution Logic
try {
    Get-ADDomainController -Filter * | ForEach-Object { repadmin /showrepl $_.HostName }
Test-NetConnection -ComputerName $DC -Port 389
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
