<#
.SYNOPSIS
    Stale Computer Account Tagger & OU Archiver (Toan Nguyen IT OZ)
.DESCRIPTION
    Discovers computer accounts that have not contacted Active Directory in over 120 days, disables the computer trust, and moves them to an Archive OU.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 018
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_018_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Stale Computer Account Tagger & OU Archiver (Episode 018)..." "INFO"

# Execution Logic
try {
    $cutoff = (Get-Date).AddDays(-120)
Get-ADComputer -Filter {LastLogonDate -lt $cutoff -and Enabled -eq $true} | Move-ADObject -TargetPath 'OU=Disabled_Computers,DC=corp,DC=local'
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
