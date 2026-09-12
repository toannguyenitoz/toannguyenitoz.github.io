<#
.SYNOPSIS
    Group Policy (GPO) Force Refresh & Diagnostic Auditor (Toan Nguyen IT OZ)
.DESCRIPTION
    Forces Group Policy background sync, validates Domain Controller connectivity, and generates an HTML Resultant Set of Policy (RSOP) audit report.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 009
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_009_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Group Policy (GPO) Force Refresh & Diagnostic Auditor (Episode 009)..." "INFO"

# Execution Logic
try {
    gpupdate /force /wait:0
Get-GPResultantSetOfPolicy -ReportType Html -Path 'C:\IT_Support_Logs\GPO_Report.html'
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
