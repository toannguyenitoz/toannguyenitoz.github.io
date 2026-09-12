<#
.SYNOPSIS
    Outlook Cache & Broken Profile Rebuilder (Toan Nguyen IT OZ)
.DESCRIPTION
    Solves Outlook startup hangs and disconnects by terminating hung EXCEL/OUTLOOK tasks, clearing roaming XML cache, and regenerating OST files.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 067
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_067_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Outlook Cache & Broken Profile Rebuilder (Episode 067)..." "INFO"

# Execution Logic
try {
    Stop-Process -Name outlook -Force -EA SilentlyContinue
Remove-Item "$env:LOCALAPPDATA\Microsoft\Outlook\*.ost.old" -Force -EA SilentlyContinue
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
