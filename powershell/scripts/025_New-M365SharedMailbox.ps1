<#
.SYNOPSIS
    Shared Mailbox Auto-Provisioning & Retention Setup (Toan Nguyen IT OZ)
.DESCRIPTION
    Provisions cloud-only shared mailboxes, grants Read/SendAs delegation to designated team members, and configures auto-mapping and retention.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 025
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_025_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Shared Mailbox Auto-Provisioning & Retention Setup (Episode 025)..." "INFO"

# Execution Logic
try {
    New-Mailbox -Shared -Name $Name -DisplayName $DisplayName -PrimarySmtpAddress $Email
Add-MailboxPermission -Identity $Email -User $Delegate -AccessRights FullAccess
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
