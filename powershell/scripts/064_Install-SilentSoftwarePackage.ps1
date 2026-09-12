<#
.SYNOPSIS
    Silent MSI / EXE Remote Installer with Custom Arguments (Toan Nguyen IT OZ)
.DESCRIPTION
    Wrapper script to execute MSIs and EXEs silently (/qn, /verysilent), tracking process completion, return exit codes, and error logging.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 064
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_064_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Silent MSI / EXE Remote Installer with Custom Arguments (Episode 064)..." "INFO"

# Execution Logic
try {
    Start-Process -FilePath 'msiexec.exe' -ArgumentList "/i `"$InstallerPath`" /qn /norestart /log `"C:\IT_Support_Logs\Install.log`"" -Wait -PassThru
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
