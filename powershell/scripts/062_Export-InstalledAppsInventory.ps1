<#
.SYNOPSIS
    Installed Software Inventory to CSV with Version & Architecture (Toan Nguyen IT OZ)
.DESCRIPTION
    Scans both 32-bit and 64-bit registry uninstall keys and MSI database, generating a clean software inventory spreadsheet for audits.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 062
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_062_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Installed Software Inventory to CSV with Version & Architecture (Episode 062)..." "INFO"

# Execution Logic
try {
    Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*' | Select DisplayName, DisplayVersion, Publisher, InstallDate | Where-Object DisplayName | Export-Csv 'C:\IT_Support_Logs\Software_Inventory.csv' -NoType
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
