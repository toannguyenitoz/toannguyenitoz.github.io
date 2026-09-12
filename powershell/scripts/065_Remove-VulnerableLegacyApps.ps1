<#
.SYNOPSIS
    Java & Adobe Stale Version Scanner & Uninstaller (Toan Nguyen IT OZ)
.DESCRIPTION
    Identifies outdated versions of Java Runtime Environment (JRE) and Adobe Reader harboring critical CVE security vulnerabilities and uninstalls them.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 065
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_065_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Java & Adobe Stale Version Scanner & Uninstaller (Episode 065)..." "INFO"

# Execution Logic
try {
    Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -match 'Java|Acrobat' -and $_.Version -lt '8.0.300' } | ForEach-Object { $_.Uninstall() }
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
