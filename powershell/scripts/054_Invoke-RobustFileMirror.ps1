<#
.SYNOPSIS
    Robocopy Robust File Mirroring with Retry & Logging (Toan Nguyen IT OZ)
.DESCRIPTION
    Wraps robust robocopy with enterprise flags (/MIR /ZB /MT:16 /R:2 /W:3 /COPYALL /LOG), ideal for server migrations and bulk backup jobs.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 054
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_054_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Robocopy Robust File Mirroring with Retry & Logging (Episode 054)..." "INFO"

# Execution Logic
try {
    robocopy.exe $Source $Destination /MIR /ZB /MT:16 /R:2 /W:3 /COPYALL /NP /LOG:"C:\IT_Support_Logs\Robocopy.log"
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
