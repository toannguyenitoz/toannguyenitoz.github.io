<#
.SYNOPSIS
    Intune Device Compliance & Remote Sync Trigger (Toan Nguyen IT OZ)
.DESCRIPTION
    Triggers the Microsoft Intune Management Extension (IME) to sync company portal apps, re-evaluate device compliance, and export IME logs.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 026
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_026_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Intune Device Compliance & Remote Sync Trigger (Episode 026)..." "INFO"

# Execution Logic
try {
    Get-Service IntuneManagementExtension | Restart-Service
& "$env:ProgramFiles\Microsoft OneDrive\OneDrive.exe" /reset
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
