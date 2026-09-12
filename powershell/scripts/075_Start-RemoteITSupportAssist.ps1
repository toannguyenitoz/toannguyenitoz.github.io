<#
.SYNOPSIS
    Remote Assistance & Quick Assist Quick-Launcher (Toan Nguyen IT OZ)
.DESCRIPTION
    Launches Microsoft Quick Assist with diagnostic arguments, opens required firewall traversal ports, and establishes remote support channels.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 075
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_075_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Remote Assistance & Quick Assist Quick-Launcher (Episode 075)..." "INFO"

# Execution Logic
try {
    Start-Process 'quickassist.exe'
Enable-PSRemoting -Force -SkipNetworkProfileCheck
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
