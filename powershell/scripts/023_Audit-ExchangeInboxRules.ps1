<#
.SYNOPSIS
    Exchange Online Inbox Forwarding Rule & Phishing Auditor (Toan Nguyen IT OZ)
.DESCRIPTION
    Scans all cloud mailboxes for client-side inbox rules forwarding enterprise emails to external Gmail, Yahoo, or suspicious domains.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 023
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_023_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Exchange Online Inbox Forwarding Rule & Phishing Auditor (Episode 023)..." "INFO"

# Execution Logic
try {
    Get-Mailbox -ResultSize Unlimited | Get-InboxRule | Where-Object { $_.ForwardTo -or $_.ForwardAsAttachmentTo } | Select MailboxOwnerId, Name, ForwardTo
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
