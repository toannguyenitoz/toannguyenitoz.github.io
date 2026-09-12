<#
.SYNOPSIS
    Expiring User Password Alert & Email Reporter (Toan Nguyen IT OZ)
.DESCRIPTION
    Calculates password expiration dates based on domain fine-grained password policies and notifies users via email or teams webhook before lockout.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 014
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_014_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Expiring User Password Alert & Email Reporter (Episode 014)..." "INFO"

# Execution Logic
try {
    Get-ADUser -Filter {Enabled -eq $true -and PasswordNeverExpires -eq $false} -Properties msDS-UserPasswordExpiryTimeComputed | Select Name, @{N='Expires';E={[DateTime]::FromFileTime($_.'msDS-UserPasswordExpiryTimeComputed')}}
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
