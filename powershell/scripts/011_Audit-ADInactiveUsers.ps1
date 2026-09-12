<#
.SYNOPSIS
    AD Inactive & Stale User Account Auditor (90+ Days) (Toan Nguyen IT OZ)
.DESCRIPTION
    Queries Active Directory for user accounts that have not authenticated in over 90 days, distinguishing service accounts from human employees.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 011
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_011_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting AD Inactive & Stale User Account Auditor (90+ Days) (Episode 011)..." "INFO"

# Execution Logic
try {
    $date = (Get-Date).AddDays(-90)
Search-ADAccount -AccountInactive -TimeSpan 90.00:00:00 -UsersOnly | Select Name, SamAccountName, LastLogonDate
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
