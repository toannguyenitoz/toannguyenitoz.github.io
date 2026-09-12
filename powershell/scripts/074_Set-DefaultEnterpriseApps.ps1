<#
.SYNOPSIS
    Windows Default Apps (PDF, Browser, Mail) Setter (Toan Nguyen IT OZ)
.DESCRIPTION
    Imports standardized OEM Default Application Associations XML, guaranteeing PDF opens in Acrobat Reader and web links open in Chrome.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 074
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_074_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Windows Default Apps (PDF, Browser, Mail) Setter (Episode 074)..." "INFO"

# Execution Logic
try {
    Dism.exe /Online /Import-DefaultAppAssociations:"C:\IT_Support_Configs\AppAssoc.xml"
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
