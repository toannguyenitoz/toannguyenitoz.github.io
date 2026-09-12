<#
.SYNOPSIS
    Automated Daily Critical Configuration Backup to NAS/Cloud (Toan Nguyen IT OZ)
.DESCRIPTION
    Compresses essential user workspaces, browser bookmarks, and network configs into a timestamped zip file and uploads to a remote network share.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 091
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_091_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Automated Daily Critical Configuration Backup to NAS/Cloud (Episode 091)..." "INFO"

# Execution Logic
try {
    $dest = "\\NAS01\Backups\$env:COMPUTERNAME\$((Get-Date).ToString('yyyyMMdd'))"
Compress-Archive -Path "C:\IT_Support_Configs" -DestinationPath "$dest.zip" -Force
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
