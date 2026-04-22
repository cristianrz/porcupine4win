# install.ps1 - Porcupine4Win installer
# Must be run as Administrator

#Requires -RunAsAdministrator

$ErrorActionPreference = "Stop"

$EdgeDir    = "C:\Program Files (x86)\Microsoft\Edge\Application"
$EdgeExe    = Join-Path $EdgeDir "msedge.exe"
$EdgeBackup = Join-Path $EdgeDir "msedge.exe.bak"
$Porcupine  = Join-Path $PSScriptRoot "porcupine4win.exe"

function Write-Step($msg) { Write-Host "[+] $msg" -ForegroundColor Cyan }
function Write-Success($msg) { Write-Host "[✓] $msg" -ForegroundColor Green }
function Write-Fail($msg) { Write-Host "[✗] $msg" -ForegroundColor Red }

# Preflight checks
Write-Step "Checking prerequisites..."

if (-not (Test-Path $Porcupine)) {
    Write-Fail "porcupine4win.exe not found next to install.ps1"
    exit 1
}

if (-not (Test-Path $EdgeExe)) {
    Write-Fail "Microsoft Edge not found at $EdgeExe"
    exit 1
}

if (Test-Path $EdgeBackup) {
    Write-Fail "A backup already exists at $EdgeBackup — is Porcupine already installed?"
    Write-Host "    Run uninstall.ps1 first if you want to reinstall."
    exit 1
}

# Check Edge is not running
$EdgeProcs = Get-Process -Name "msedge" -ErrorAction SilentlyContinue
if ($EdgeProcs) {
    Write-Fail "Microsoft Edge is running. Please close it and try again."
    exit 1
}

# Backup
Write-Step "Backing up msedge.exe..."
Copy-Item $EdgeExe $EdgeBackup
Write-Success "Backup saved to $EdgeBackup"

# Install
Write-Step "Installing porcupine4win.exe..."
Copy-Item $Porcupine $EdgeExe -Force
Write-Success "Installed to $EdgeExe"

# Remind user to set Edge as default browser
Write-Host ""
Write-Host "Almost done! One manual step required:" -ForegroundColor Yellow
Write-Host "  1. Open Settings > Apps > Default apps"
Write-Host "  2. Set 'Microsoft Edge' as your default browser"
Write-Host ""
Write-Host "From now on, clicking any link will copy the URL to your clipboard"
Write-Host "instead of opening a browser. Run uninstall.ps1 to restore Edge."
Write-Host ""
Write-Success "Installation complete."
