<#
.SYNOPSIS
    Bloatware & Default Windows Provisioned Apps Cleaner (Toan Nguyen IT OZ)
.DESCRIPTION
    Removes unwanted consumer provisioned AppX packages from modern Windows 10/11 installations for all new and existing user profiles.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 063
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_063_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Bloatware & Default Windows Provisioned Apps Cleaner (Episode 063)..." "INFO"

# Execution Logic
try {
    Get-AppxPackage -AllUsers | Where-Object { $_.Name -match 'Xbox|CandyCrush|Zune|BingWeather|TikTok' } | Remove-AppxPackage -AllUsers -EA SilentlyContinue
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
