# uninstall.ps1 - Porcupine4Win uninstaller
# Must be run as Administrator

#Requires -RunAsAdministrator

$ErrorActionPreference = "Stop"

$EdgeDir    = "C:\Program Files (x86)\Microsoft\Edge\Application"
$EdgeExe    = Join-Path $EdgeDir "msedge.exe"
$EdgeBackup = Join-Path $EdgeDir "msedge.exe.bak"

function Write-Step($msg) { Write-Host "[+] $msg" -ForegroundColor Cyan }
function Write-Success($msg) { Write-Host "[✓] $msg" -ForegroundColor Green }
function Write-Fail($msg) { Write-Host "[✗] $msg" -ForegroundColor Red }

Write-Step "Checking for backup..."

if (-not (Test-Path $EdgeBackup)) {
    Write-Fail "No backup found at $EdgeBackup — is Porcupine installed?"
    exit 1
}

# Check Edge is not running
$EdgeProcs = Get-Process -Name "msedge" -ErrorAction SilentlyContinue
if ($EdgeProcs) {
    Write-Fail "Microsoft Edge is running. Please close it and try again."
    exit 1
}

# Restore
Write-Step "Restoring msedge.exe from backup..."
Copy-Item $EdgeBackup $EdgeExe -Force
Write-Success "msedge.exe restored"

# Remove backup
Write-Step "Removing backup..."
Remove-Item $EdgeBackup -Force
Write-Success "Backup removed"

Write-Host ""
Write-Success "Uninstall complete. Microsoft Edge has been restored."
