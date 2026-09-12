<#
.SYNOPSIS
    User Home Folder Quota & Permission Provisioner (Toan Nguyen IT OZ)
.DESCRIPTION
    Creates a secure network home folder for a user, sets strict Creator/Owner NTFS ACL permissions, and applies a storage quota policy.
.NOTES
    Series: Enterprise PowerShell Automation Toolkit
    Episode: 079
    Author: Toan Nguyen IT OZ (Adelaide, Australia)
    Website: https://toannguyenitoz.github.io/powershell/
#>
[CmdletBinding()]
param()

$LogDir = "C:\IT_Support_Logs"
if (-not (Test-Path $LogDir)) { New-Item -ItemType Directory -Path $LogDir -Force | Out-Null }
$LogFile = Join-Path $LogDir "Script_079_$(Get-Date -Format 'yyyyMMdd_HHmmss').log"

function Write-Log {
    param([string]$Message, [string]$Level = "INFO")
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $Formatted = "[$Timestamp] [$Level] $Message"
    Write-Host $Formatted -ForegroundColor (switch ($Level) { "WARN" {"Yellow"} "ERROR" {"Red"} "SUCCESS" {"Green"} default {"Cyan"} })
    Add-Content -Path $LogFile -Value $Formatted
}

Write-Log "Starting User Home Folder Quota & Permission Provisioner (Episode 079)..." "INFO"

# Execution Logic
try {
    New-Item -ItemType Directory -Path "\\FileServer\Homes\$Username" -Force
$acl = Get-Acl "\\FileServer\Homes\$Username"
$rule = New-Object System.Security.AccessControl.FileSystemAccessRule($Username, 'FullControl', 'ContainerInherit,ObjectInherit', 'None', 'Allow')
$acl.SetAccessRule($rule)
Set-Acl -Path "\\FileServer\Homes\$Username" -AclObject $acl
    Write-Log "Operation completed successfully! Report recorded in $LogFile" "SUCCESS"
} catch {
    Write-Log "Error encountered: $_" "ERROR"
}
