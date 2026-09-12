<#
.SYNOPSIS
    Bad Password & Locked Out Account Instant Unblocker (Toan Nguyen IT OZ)
.DESCRIPTION
    Finds all currently locked-out domain users, determines which workstation/DC triggered the bad password count, and unlocks them instantly.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 012
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_012_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Bad Password & Locked Out Account Instant Unblocker (Episode 012)..." "INFO"

# Execution Logic
try {
    Search-ADAccount -LockedOut | Select SamAccountName, Name
Unlock-ADAccount -Identity $username
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
