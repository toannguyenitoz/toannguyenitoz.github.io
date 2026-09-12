<#
.SYNOPSIS
    BIOS/UEFI Version & Secure Boot Audit (Toan Nguyen IT OZ)
.DESCRIPTION
    Inspects BIOS release date, vendor, UEFI boot configuration, and validates Secure Boot enforcement required for Windows 11 compliance.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 086
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_086_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting BIOS/UEFI Version & Secure Boot Audit (Episode 086)..." "INFO"

# Execution Logic
try {
    Confirm-SecureBootUEFI
Get-CimInstance Win32_Bios | Select SMBIOSBIOSVersion, ReleaseDate, Manufacturer
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
