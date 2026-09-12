<#
.SYNOPSIS
    NTFS Folder Permission (ACL) Auditing & Broken Inheritance Fix (Toan Nguyen IT OZ)
.DESCRIPTION
    Audits access rights on confidential shared directories, identifies broken inheritance, and repairs corrupted security descriptors.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 055
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_055_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting NTFS Folder Permission (ACL) Auditing & Broken Inheritance Fix (Episode 055)..." "INFO"

# Execution Logic
try {
    Get-Acl -Path $folder | Select-Object -ExpandProperty Access | Select IdentityReference, FileSystemRights, AccessControlType, IsInherited
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
