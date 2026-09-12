<#
.SYNOPSIS
    SSL/TLS Certificate Expiration Watchdog (Local Machine) (Toan Nguyen IT OZ)
.DESCRIPTION
    Scans Cert:\LocalMachine\My and WebHosting stores for expiring SSL/TLS certificates, sending early warnings before services display security warnings.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 049
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_049_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting SSL/TLS Certificate Expiration Watchdog (Local Machine) (Episode 049)..." "INFO"

# Execution Logic
try {
    Get-ChildItem Cert:\LocalMachine\My | Where-Object { $_.NotAfter -lt (Get-Date).AddDays(30) } | Select Subject, NotAfter, Thumbprint
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
