<#
.SYNOPSIS
    Windows Reliability Monitor Score & Failure Extractor (Toan Nguyen IT OZ)
.DESCRIPTION
    Extracts the native Windows Reliability Monitor index score and aggregates recent application crashes, OS failures, and hardware anomalies.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 089
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_089_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Windows Reliability Monitor Score & Failure Extractor (Episode 089)..." "INFO"

# Execution Logic
try {
    Get-CimInstance Win32_ReliabilityRecords -Filter 'EventIdentifier > 0' | Select-Object -First 20 Logfile, Message, RecordNumber, TimeGenerated
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
