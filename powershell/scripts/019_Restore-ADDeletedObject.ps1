<#
.SYNOPSIS
    Active Directory Recycle Bin Deleted Object Restorer (Toan Nguyen IT OZ)
.DESCRIPTION
    Queries the Active Directory Recycle Bin for accidentally deleted users, groups, or computers, and restores them intact with their SIDs and group links.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 019
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_019_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Active Directory Recycle Bin Deleted Object Restorer (Episode 019)..." "INFO"

# Execution Logic
try {
    Get-ADObject -Filter 'isDeleted -eq $true -and name -like "*$search*"' -IncludeDeletedObjects | Restore-ADObject
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
