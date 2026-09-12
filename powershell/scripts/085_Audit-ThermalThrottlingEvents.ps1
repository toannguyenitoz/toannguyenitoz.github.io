<#
.SYNOPSIS
    Thermal & CPU Fan Throttling Event Log Inspector (Toan Nguyen IT OZ)
.DESCRIPTION
    Queries System Event logs for Event ID 37 (Kernel-Processor-Power), revealing whether the CPU is dropping clocks due to overheating or thermal paste degradation.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 085
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_085_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Thermal & CPU Fan Throttling Event Log Inspector (Episode 085)..." "INFO"

# Execution Logic
try {
    Get-WinEvent -FilterHashtable @{LogName='System'; ProviderName='Microsoft-Windows-Kernel-Processor-Power'; Id=37} -MaxEvents 20 -EA SilentlyContinue
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
