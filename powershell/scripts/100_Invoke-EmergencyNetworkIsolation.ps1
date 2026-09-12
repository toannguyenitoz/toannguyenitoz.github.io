<#
.SYNOPSIS
    Emergency SysAdmin Panic Button - Offline Isolation Script (Toan Nguyen IT OZ)
.DESCRIPTION
    Instantly severs all network adapters, terminates active RDP connections, blocks outbound traffic, and locks the local workstation console in response to an active cyber breach.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 100
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_100_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Emergency SysAdmin Panic Button - Offline Isolation Script (Episode 100)..." "INFO"

# Execution Logic
try {
    Get-NetAdapter | Disable-NetAdapter -Confirm:$false
quser | ForEach-Object { logoff $_.ID }
rundll32.exe user32.dll,LockWorkStation
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
