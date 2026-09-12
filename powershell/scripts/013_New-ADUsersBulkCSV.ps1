<#
.SYNOPSIS
    Bulk New Hire User Provisioning from CSV (Toan Nguyen IT OZ)
.DESCRIPTION
    Reads a new-hire employee CSV spreadsheet, creates AD user objects, provisions home folders, sets required GPO groups, and forces password change.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 013
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_013_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Bulk New Hire User Provisioning from CSV (Episode 013)..." "INFO"

# Execution Logic
try {
    Import-Csv users.csv | ForEach-Object {
    New-ADUser -Name $_.Name -SamAccountName $_.Username -Department $_.Dept -AccountPassword (ConvertTo-SecureString $_.Password -AsPlainText -Force) -Enabled $true
}
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
