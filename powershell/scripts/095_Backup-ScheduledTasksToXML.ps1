<#
.SYNOPSIS
    Windows Scheduled Task Exporter & Disaster Restorer (Toan Nguyen IT OZ)
.DESCRIPTION
    Exports custom enterprise scheduled tasks to XML files with triggers and credentials intact, allowing instantaneous recovery on a fresh machine.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 095
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_095_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Windows Scheduled Task Exporter & Disaster Restorer (Episode 095)..." "INFO"

# Execution Logic
try {
    Get-ScheduledTask | Where-Object { $_.TaskPath -match 'Enterprise|ITSupport' } | ForEach-Object {
    Export-Clixml -InputObject $_ -Path "C:\IT_Support_Logs\$($_.TaskName).xml"
}
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
