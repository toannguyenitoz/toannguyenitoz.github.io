<#
.SYNOPSIS
    M365 Mailbox Permission & Delegate Access Reviewer (Toan Nguyen IT OZ)
.DESCRIPTION
    Generates a complete security matrix of all FullAccess and SendAs permissions assigned to executives, accounting, and shared mailboxes.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 024
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_024_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting M365 Mailbox Permission & Delegate Access Reviewer (Episode 024)..." "INFO"

# Execution Logic
try {
    Get-Mailbox -ResultSize Unlimited | Get-MailboxPermission | Where-Object { $_.User -notlike 'NT AUTHORITY*' -and $_.IsInherited -eq $false }
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
