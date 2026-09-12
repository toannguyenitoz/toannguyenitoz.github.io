<#
.SYNOPSIS
    Automated Maintenance Window Rebooter with User Warning (Toan Nguyen IT OZ)
.DESCRIPTION
    Prompts logged-on users with a friendly 15-minute countdown modal dialog before initiating system restart after critical updates.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 099
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_099_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Automated Maintenance Window Rebooter with User Warning (Episode 099)..." "INFO"

# Execution Logic
try {
    shutdown.exe /r /t 900 /c "IT Maintenance Window: This PC will restart in 15 minutes to apply critical security updates. Please save your work."
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
