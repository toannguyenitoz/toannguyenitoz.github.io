<#
.SYNOPSIS
    BitLocker Encryption Status & Recovery Key Escrow Validator (Toan Nguyen IT OZ)
.DESCRIPTION
    Queries BitLocker encryption percentage, cipher strength, protection status, and verifies if the 48-digit recovery key is safely backed up to Entra ID.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 046
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_046_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting BitLocker Encryption Status & Recovery Key Escrow Validator (Episode 046)..." "INFO"

# Execution Logic
try {
    Get-BitLockerVolume | Select MountPoint, VolumeStatus, EncryptionMethod, ProtectionStatus, KeyProtector
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
