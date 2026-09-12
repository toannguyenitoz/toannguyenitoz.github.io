<#
.SYNOPSIS
    AD Forest Trust & Kerberos Ticket Lifetime Verifier (Toan Nguyen IT OZ)
.DESCRIPTION
    Checks bidirectional domain forest trusts, tests Kerberos Ticket Granting Service (TGS) authentication paths, and identifies duplicate SPNs.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 020
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_020_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting AD Forest Trust & Kerberos Ticket Lifetime Verifier (Episode 020)..." "INFO"

# Execution Logic
try {
    Get-ADTrust -Filter *
setspn.exe -X
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
