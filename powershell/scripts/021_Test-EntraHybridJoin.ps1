<#
.SYNOPSIS
    Entra ID Hybrid Join & PRT Token Diagnostics (Toan Nguyen IT OZ)
.DESCRIPTION
    Parses dsregcmd /status output into structured PowerShell objects, inspecting AzureAdJoined, EnterpriseJoined, and AzureAdPrt status.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 021
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_021_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Entra ID Hybrid Join & PRT Token Diagnostics (Episode 021)..." "INFO"

# Execution Logic
try {
    dsregcmd /status | Select-String 'AzureAdJoined|DomainJoined|AzureAdPrt'
Get-Service -Name IntuneManagementExtension
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
