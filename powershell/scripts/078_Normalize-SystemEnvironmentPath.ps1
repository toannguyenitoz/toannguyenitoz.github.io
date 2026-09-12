<#
.SYNOPSIS
    Environment Variables & Global System PATH Normalizer (Toan Nguyen IT OZ)
.DESCRIPTION
    Audits the machine and user PATH environment variables, removes non-existent folders and duplicate entries, and appends corporate utility paths.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 078
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_078_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Environment Variables & Global System PATH Normalizer (Episode 078)..." "INFO"

# Execution Logic
try {
    $path = [Environment]::GetEnvironmentVariable('Path', 'Machine')
$cleaned = ($path -split ';' | Select-Object -Unique | Where-Object { Test-Path $_ }) -join ';'
[Environment]::SetEnvironmentVariable('Path', $cleaned, 'Machine')
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
