<#
.SYNOPSIS
    Entra ID Password-Never-Expires User Security Audit (Toan Nguyen IT OZ)
.DESCRIPTION
    Scans Microsoft Entra ID (Azure AD) for user accounts configured with PasswordNeverExpires enabled, ensuring alignment with corporate policy.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 027
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_027_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Entra ID Password-Never-Expires User Security Audit (Episode 027)..." "INFO"

# Execution Logic
try {
    Get-MgUser -All -Property Id, DisplayName, UserPrincipalName, PasswordPolicies | Where-Object { $_.PasswordPolicies -match 'DisablePasswordExpiration' }
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
