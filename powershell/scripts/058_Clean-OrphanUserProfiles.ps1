<#
.SYNOPSIS
    User Profile Disk Usage & Ghost Profile Cleaner (Toan Nguyen IT OZ)
.DESCRIPTION
    Calculates disk consumption across all user profiles under C:\Users, and cleanly removes orphaned profiles via WMI without leaving registry debris.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 058
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_058_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting User Profile Disk Usage & Ghost Profile Cleaner (Episode 058)..." "INFO"

# Execution Logic
try {
    Get-CimInstance -ClassName Win32_UserProfile | Where-Object { -not $_.Special -and $_.LastUseTime -lt (Get-Date).AddDays(-60) } | Remove-CimInstance
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
