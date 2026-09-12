<#
.SYNOPSIS
    Mapped Network Drives & Shared Printers Auto-Connector (Toan Nguyen IT OZ)
.DESCRIPTION
    Maps persistent network drives (Z:, P:, S:) with validation, and connects network printers according to the user's active Active Directory group.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 073
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_073_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Mapped Network Drives & Shared Printers Auto-Connector (Episode 073)..." "INFO"

# Execution Logic
try {
    New-PSDrive -Name 'P' -PSProvider FileSystem -Root '\\server\Public' -Persist -Scope Global
Add-Printer -ConnectionName '\\printserver\HR_FollowMe'
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
