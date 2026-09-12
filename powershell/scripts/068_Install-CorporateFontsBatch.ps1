<#
.SYNOPSIS
    Fonts & Enterprise TrueType Batch Installer (Toan Nguyen IT OZ)
.DESCRIPTION
    Automates copying and registry registration of enterprise corporate fonts into C:\Windows\Fonts, making them instantly available system-wide.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 068
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_068_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Fonts & Enterprise TrueType Batch Installer (Episode 068)..." "INFO"

# Execution Logic
try {
    Get-ChildItem -Path $fontDir -Filter *.ttf | ForEach-Object {
    Copy-Item $_.FullName "$env:SystemRoot\Fonts"
    New-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Fonts' -Name $_.Name -Value $_.Name -Force
}
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
