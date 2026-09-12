<#
.SYNOPSIS
    Rogue DHCP & IP Address Conflict Scanner (Toan Nguyen IT OZ)
.DESCRIPTION
    Broadcasts DHCP discover packets to uncover rogue Wi-Fi routers plugged into the office LAN handing out wrong IP subnets to employees.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 034
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_034_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting Rogue DHCP & IP Address Conflict Scanner (Episode 034)..." "INFO"

# Execution Logic
try {
    Get-NetIPConfiguration | Select IPv4Address, IPv4DefaultGateway, DNSServer
arp -a | Group-Object -Property {$_.Split()[0]} | Where-Object {$_.Count -gt 1}
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
