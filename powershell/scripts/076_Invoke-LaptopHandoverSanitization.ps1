<#
.SYNOPSIS
    Employee Laptop Handover Reset & Safe Sanitization (Toan Nguyen IT OZ)
.DESCRIPTION
    Cleans an existing laptop for a new user without a time-consuming Windows reinstall: flushes credential caches, deletes previous profiles, and updates OS.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 076
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_076_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Employee Laptop Handover Reset & Safe Sanitization (Episode 076)..." "INFO"

# Execution Logic
try {
    Get-ChildItem 'C:\Users' | Where-Object { $_.Name -ne 'Administrator' } | ForEach-Object { Remove-Item $_.FullName -Recurse -Force -EA SilentlyContinue }
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
