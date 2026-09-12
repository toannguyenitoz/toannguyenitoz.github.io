<#
.SYNOPSIS
    Outlook Email Signature HTML Batch Generator (Toan Nguyen IT OZ)
.DESCRIPTION
    Pulls job title, department, mobile number, and office location from Active Directory to generate a standardized company HTML Outlook signature.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 080
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_080_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Outlook Email Signature HTML Batch Generator (Episode 080)..." "INFO"

# Execution Logic
try {
    $adUser = Get-ADUser -Identity $env:USERNAME -Properties Title, Department, TelephoneNumber
$html = "<p><b>$($adUser.Name)</b><br>$($adUser.Title) | $($adUser.Department)<br>Tel: $($adUser.TelephoneNumber)</p>"
Set-Content "$env:APPDATA\Microsoft\Signatures\Standard.htm" -Value $html
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
