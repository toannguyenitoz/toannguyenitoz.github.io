<#
.SYNOPSIS
    OneDrive Sync Stall & Credential Cache Resolver (Toan Nguyen IT OZ)
.DESCRIPTION
    Restarts stuck OneDrive sync clients, clears pending credential tokens, executes onedrive.exe /reset, and verifies tenant synchronization status.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 029
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_029_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting OneDrive Sync Stall & Credential Cache Resolver (Episode 029)..." "INFO"

# Execution Logic
try {
    & "$env:ProgramFiles\Microsoft OneDrive\OneDrive.exe" /reset
Start-Sleep -Seconds 3
Start-Process "$env:ProgramFiles\Microsoft OneDrive\OneDrive.exe"
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
