<#
.SYNOPSIS
    Oversized Files (>1GB) Scanner & Tree Mapper (Toan Nguyen IT OZ)
.DESCRIPTION
    Deep-scans local drives for files exceeding 1GB, sorting them in descending order and formatting sizes in clean GB/MB units for rapid cleanup.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 052
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_052_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Oversized Files (>1GB) Scanner & Tree Mapper (Episode 052)..." "INFO"

# Execution Logic
try {
    Get-ChildItem C:\ -Recurse -File -EA SilentlyContinue | Where-Object { $_.Length -gt 1GB } | Select FullName, @{N='SizeGB';E={[math]::Round($_.Length/1GB, 2)}} | Sort SizeGB -Descending | Select -First 20
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
