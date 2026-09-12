<#
.SYNOPSIS
    Silent Enterprise Winget Multi-App Pack Installer (Toan Nguyen IT OZ)
.DESCRIPTION
    Leverages native Windows Package Manager (winget) to silently install a standardized IT support software bundle with zero user clicks.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 061
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_061_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Silent Enterprise Winget Multi-App Pack Installer (Episode 061)..." "INFO"

# Execution Logic
try {
    $apps = @('Google.Chrome', '7zip.7zip', 'Adobe.Acrobat.Reader.64-bit', 'Microsoft.VisualStudioCode')
foreach ($a in $apps) { winget install --id $a --silent --accept-package-agreements --accept-source-agreements }
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
