<#
.SYNOPSIS
    Duplicate File Detection by SHA256 Hash (Toan Nguyen IT OZ)
.DESCRIPTION
    Hashes files of identical size using SHA256 cryptographic algorithms, safely identifying true duplicate files regardless of renaming.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 053
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_053_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Duplicate File Detection by SHA256 Hash (Episode 053)..." "INFO"

# Execution Logic
try {
    Get-ChildItem -Path $folder -File -Recurse | Group-Object -Property Length | Where-Object { $_.Count -gt 1 } | ForEach-Object { $_.Group | Get-FileHash -Algorithm SHA256 } | Group-Object -Property Hash | Where-Object { $_.Count -gt 1 }
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
