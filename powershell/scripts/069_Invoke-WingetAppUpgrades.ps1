<#
.SYNOPSIS
    Third-Party Patch Audit via Winget Upgrade Scanner (Toan Nguyen IT OZ)
.DESCRIPTION
    Queries Windows Package Manager for available updates across all installed third-party software and triggers silent unattended patching.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 069
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_069_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Third-Party Patch Audit via Winget Upgrade Scanner (Episode 069)..." "INFO"

# Execution Logic
try {
    winget upgrade --include-unknown
winget upgrade --all --silent --accept-package-agreements
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
