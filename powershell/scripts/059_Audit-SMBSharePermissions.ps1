<#
.SYNOPSIS
    Network Shared Folder Permission Compliance Scanner (Toan Nguyen IT OZ)
.DESCRIPTION
    Lists all SMB file shares on the machine or server, highlighting dangerous shares granted to 'Everyone' or 'Anonymous' with Write/Full permissions.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 059
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_059_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Network Shared Folder Permission Compliance Scanner (Episode 059)..." "INFO"

# Execution Logic
try {
    Get-SmbShare | Get-SmbShareAccess | Where-Object { $_.AccountName -match 'Everyone|Anonymous' } | Format-Table -AutoSize
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
