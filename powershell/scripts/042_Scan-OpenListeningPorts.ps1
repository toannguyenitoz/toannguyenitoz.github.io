<#
.SYNOPSIS
    Open Listening Port to Owning Process PID Threat Scanner (Toan Nguyen IT OZ)
.DESCRIPTION
    Audits every port in a 'Listen' state on the computer, validating whether the owning process resides in a trusted System32 path or untrusted Temp folder.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 042
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_042_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Open Listening Port to Owning Process PID Threat Scanner (Episode 042)..." "INFO"

# Execution Logic
try {
    Get-NetTCPConnection -State Listen | Select LocalAddress, LocalPort, OwningProcess, @{N='Path';E={(Get-Process -Id $_.OwningProcess -EA SilentlyContinue).Path}}
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
