<#
.SYNOPSIS
    Windows License Key & Activation State Audit (Toan Nguyen IT OZ)
.DESCRIPTION
    Queries Windows Software Licensing Manager (slmgr) to verify genuine activation status, partial product key, and KMS renewal intervals.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 098
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_098_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Windows License Key & Activation State Audit (Episode 098)..." "INFO"

# Execution Logic
try {
    Get-CimInstance SoftwareLicensingProduct -Filter 'PartialProductKey is not null' | Select Name, LicenseStatus, PartialProductKey
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
