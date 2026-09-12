<#
.SYNOPSIS
    Automated Windows 11 Health & File Restorer (Toan Nguyen IT OZ)
.DESCRIPTION
    Scans component store, restores corrupted files using DISM, executes SFC repair, and cleans up obsolete WinSxS packages.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 001
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_001_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Automated Windows 11 Health & File Restorer (Episode 001)..." "INFO"

# Execution Logic
try {
    DISM /Online /Cleanup-Image /RestoreHealth
sfc /scannow
DISM /Online /Cleanup-Image /StartComponentCleanup
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
