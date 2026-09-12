<#
.SYNOPSIS
    Windows Credential Manager Stale Entry Wiper (Toan Nguyen IT OZ)
.DESCRIPTION
    Enumerates and deletes outdated cached passwords and tokens in Windows Credential Manager causing repeated password prompts in Outlook and Teams.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 047
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_047_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Windows Credential Manager Stale Entry Wiper (Episode 047)..." "INFO"

# Execution Logic
try {
    cmdkey /list | Select-String 'Target:' | ForEach-Object {
    $target = ($_.ToString() -split 'Target: ')[1].Trim()
    if ($target -match 'MicrosoftOffice|Outlook') { cmdkey /delete:$target }
}
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
