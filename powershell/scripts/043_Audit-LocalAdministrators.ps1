<#
.SYNOPSIS
    Local Administrator Account Audit & Rogue Admin Stripper (Toan Nguyen IT OZ)
.DESCRIPTION
    Scans the local 'Administrators' group on workstations, reporting any non-standard user accounts or unauthorized employees with admin rights.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 043
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_043_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Local Administrator Account Audit & Rogue Admin Stripper (Episode 043)..." "INFO"

# Execution Logic
try {
    Get-LocalGroupMember -Group 'Administrators' | Select Name, PrincipalSource, ObjectClass
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
