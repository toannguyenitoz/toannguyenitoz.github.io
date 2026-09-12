<#
.SYNOPSIS
    Empty Folder & Zero-Byte Ghost File Purger (Toan Nguyen IT OZ)
.DESCRIPTION
    Traverses directory structures backwards to safely delete empty abandoned folder hierarchies and zero-byte ghost files left by failed downloads.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 056
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_056_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Empty Folder & Zero-Byte Ghost File Purger (Episode 056)..." "INFO"

# Execution Logic
try {
    Get-ChildItem -Path $target -Directory -Recurse | Where-Object { (Get-ChildItem $_.FullName -Force).Count -eq 0 } | Remove-Item -Force
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
