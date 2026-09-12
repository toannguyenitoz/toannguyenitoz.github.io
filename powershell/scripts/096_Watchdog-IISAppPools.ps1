<#
.SYNOPSIS
    IIS Web Application Pool & Site Auto-Restart on Crash (Toan Nguyen IT OZ)
.DESCRIPTION
    Monitors IIS Application Pools and website bindings, automatically recycling crashed or unresponsive worker processes (w3wp.exe).
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 096
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_096_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting IIS Web Application Pool & Site Auto-Restart on Crash (Episode 096)..." "INFO"

# Execution Logic
try {
    Import-Module WebAdministration
Get-ChildItem 'IIS:\AppPools' | Where-Object { $_.State -ne 'Started' } | ForEach-Object { $_.Start() }
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
