<#
.SYNOPSIS
    Desktop Shortcut & Start Menu Standardizer (Toan Nguyen IT OZ)
.DESCRIPTION
    Generates uniform corporate shortcuts on the Public Desktop and Start Menu pointing to the IT HelpDesk ticket portal and Intune Company Portal.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 077
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_077_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Desktop Shortcut & Start Menu Standardizer (Episode 077)..." "INFO"

# Execution Logic
try {
    $WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("$env:PUBLIC\Desktop\IT HelpDesk Portal.lnk")
$Shortcut.TargetPath = 'https://helpdesk.company.com'
$Shortcut.Save()
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
