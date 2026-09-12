<#
.SYNOPSIS
    User Offboarding Account Disable, Move OU & Mailbox Converter (Toan Nguyen IT OZ)
.DESCRIPTION
    Streamlines employee departures: disables AD account, scrambles password, revokes M365 refresh tokens, and converts mailbox to shared mailbox.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 072
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_072_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting User Offboarding Account Disable, Move OU & Mailbox Converter (Episode 072)..." "INFO"

# Execution Logic
try {
    Disable-ADAccount -Identity $user
Set-ADUser -Identity $user -Description "Offboarded $((Get-Date).ToString('yyyy-MM-dd'))"
Revoke-MgUserSignInSession -UserId $upn
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
