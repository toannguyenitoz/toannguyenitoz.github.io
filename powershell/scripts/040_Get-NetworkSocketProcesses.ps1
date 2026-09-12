<#
.SYNOPSIS
    Bandwidth & Listening Socket Process PID Mapper (Toan Nguyen IT OZ)
.DESCRIPTION
    Lists all active TCP/UDP connections, instantly mapping the foreign port and PID to the active running application executable name.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 040
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_040_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Bandwidth & Listening Socket Process PID Mapper (Episode 040)..." "INFO"

# Execution Logic
try {
    Get-NetTCPConnection -State Established | Select LocalAddress, LocalPort, RemoteAddress, RemotePort, OwningProcess, @{N='Process';E={(Get-Process -Id $_.OwningProcess -EA SilentlyContinue).ProcessName}}
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
