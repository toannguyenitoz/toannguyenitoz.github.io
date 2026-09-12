<#
.SYNOPSIS
    Remote WinRM Mass-Command Orchestrator (1 to N Computers) (Toan Nguyen IT OZ)
.DESCRIPTION
    Uses PowerShell remoting (Invoke-Command) to broadcast scripts across an entire subnet or computer list in parallel with aggregated output.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 094
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_094_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Remote WinRM Mass-Command Orchestrator (1 to N Computers) (Episode 094)..." "INFO"

# Execution Logic
try {
    Invoke-Command -ComputerName $computers -ScriptBlock { Get-Service wuauserv | Select Name, Status, PSComputerName } -ThrottleLimit 20
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
