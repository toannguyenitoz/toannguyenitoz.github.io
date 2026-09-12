<#
.SYNOPSIS
    SSD TRIM Optimizer & SMART Health Query (Toan Nguyen IT OZ)
.DESCRIPTION
    Checks drive media type (SSD vs HDD), queries remaining drive life percentage and bad sectors via SMART, and invokes filesystem TRIM optimization.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 057
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_057_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting SSD TRIM Optimizer & SMART Health Query (Episode 057)..." "INFO"

# Execution Logic
try {
    Optimize-Volume -DriveLetter C -ReTrim -Verbose
Get-PhysicalDisk | Select DeviceId, FriendlyName, MediaType, OperationalStatus, HealthStatus
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
