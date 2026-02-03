#Requires -RunAsAdministrator
# Windows Setup Script
# Run this script as Administrator

Write-Host "=== Windows Setup Script ===" -ForegroundColor Cyan

# --- Set Windows 10 Classic Context Menu ---
Write-Host "`n[1/3] Setting Windows 10 Classic Context Menu..." -ForegroundColor Yellow

$regPath = "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32"

if (!(Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}
Set-ItemProperty -Path $regPath -Name "(Default)" -Value "" -Force

Write-Host "Classic context menu enabled. Restart Explorer or reboot to apply." -ForegroundColor Green

# --- Check if Winget is installed ---
Write-Host "`n[2/3] Checking if Winget is installed..." -ForegroundColor Yellow

try {
    $wingetVersion = winget --version
    Write-Host "Winget is installed: $wingetVersion" -ForegroundColor Green
}
catch {
    Write-Host "Winget is NOT installed. Please install App Installer from Microsoft Store." -ForegroundColor Red
    Write-Host "Opening Microsoft Store page for App Installer..." -ForegroundColor Yellow
    Start-Process "ms-windows-store://pdp/?ProductId=9NBLGGH4NNS1"
    Read-Host "Press Enter after installing Winget to continue..."
}

# --- Install Applications via Winget ---
Write-Host "`n[3/3] Installing Applications via Winget..." -ForegroundColor Yellow

$apps = @(
    @{ Name = "Steam";           Id = "Valve.Steam" },
    @{ Name = "Discord";         Id = "Discord.Discord" },
    @{ Name = "Zen Browser";     Id = "Zen-Team.Zen-Browser" },
    @{ Name = "VS Code";         Id = "Microsoft.VisualStudioCode" },
    @{ Name = "Visual Studio";   Id = "Microsoft.VisualStudio.2022.Community" },
    @{ Name = "PowerToys";       Id = "Microsoft.PowerToys" },
    @{ Name = "GlazeWM";         Id = "glzr-io.glazewm" },
    @{ Name = "WezTerm";         Id = "wez.wezterm" },
    @{ Name = "Neovim";          Id = "Neovim.Neovim" },
    @{ Name = "TranslucentTB";   Id = "CharlesMilette.TranslucentTB" },
    @{ Name = "Spotify";         Id = "Spotify.Spotify" },
    @{ Name = "Git";             Id = "Git.Git" }
)

foreach ($app in $apps) {
    Write-Host "`nInstalling $($app.Name)..." -ForegroundColor Cyan
    winget install -e --id $app.Id --accept-source-agreements --accept-package-agreements

    if ($LASTEXITCODE -eq 0) {
        Write-Host "$($app.Name) installed successfully." -ForegroundColor Green
    }
    else {
        Write-Host "Failed to install $($app.Name) or already installed." -ForegroundColor Yellow
    }
}

# --- Install WSL with Arch Linux ---
Write-Host "`nInstalling WSL..." -ForegroundColor Cyan
wsl --install --no-distribution

Write-Host "`nInstalling Arch Linux for WSL..." -ForegroundColor Cyan
winget install -e --id yuk7.archwsl

# --- Copy Configuration Files ---
Write-Host "`n[4/4] Copying Configuration Files..." -ForegroundColor Yellow

# Get the script's directory (where dotfiles are located)
$dotfilesDir = $PSScriptRoot

# Zen Browser config
$zenSource = Join-Path $dotfilesDir ".zen"
$zenDest = Join-Path $env:APPDATA "zen"

if (Test-Path $zenSource) {
    Write-Host "Copying Zen Browser config..." -ForegroundColor Cyan
    if (Test-Path $zenDest) {
        Remove-Item -Path $zenDest -Recurse -Force
    }
    Copy-Item -Path $zenSource -Destination $zenDest -Recurse -Force
    Write-Host "Zen Browser config copied to $zenDest" -ForegroundColor Green
}
else {
    Write-Host "Zen Browser config not found at $zenSource" -ForegroundColor Yellow
}

# Neovim config
$nvimSource = Join-Path $dotfilesDir ".config\nvim"
$nvimDest = Join-Path $env:LOCALAPPDATA "nvim"

if (Test-Path $nvimSource) {
    Write-Host "Copying Neovim config..." -ForegroundColor Cyan
    if (Test-Path $nvimDest) {
        Remove-Item -Path $nvimDest -Recurse -Force
    }
    Copy-Item -Path $nvimSource -Destination $nvimDest -Recurse -Force
    Write-Host "Neovim config copied to $nvimDest" -ForegroundColor Green
}
else {
    Write-Host "Neovim config not found at $nvimSource" -ForegroundColor Yellow
}

# WezTerm config
$weztermSource = Join-Path $dotfilesDir ".config\wezterm"
$weztermDest = Join-Path $env:USERPROFILE ".config\wezterm"

if (Test-Path $weztermSource) {
    Write-Host "Copying WezTerm config..." -ForegroundColor Cyan
    if (Test-Path $weztermDest) {
        Remove-Item -Path $weztermDest -Recurse -Force
    }
    New-Item -Path (Split-Path $weztermDest -Parent) -ItemType Directory -Force | Out-Null
    Copy-Item -Path $weztermSource -Destination $weztermDest -Recurse -Force
    Write-Host "WezTerm config copied to $weztermDest" -ForegroundColor Green
}
else {
    Write-Host "WezTerm config not found at $weztermSource" -ForegroundColor Yellow
}

# --- Restart Explorer to apply context menu changes ---
Write-Host "`n=== Setup Complete ===" -ForegroundColor Cyan
$restart = Read-Host "Would you like to restart Explorer now to apply context menu changes? (Y/N)"
if ($restart -eq "Y" -or $restart -eq "y") {
    Stop-Process -Name explorer -Force
    Start-Process explorer
    Write-Host "Explorer restarted." -ForegroundColor Green
}

Write-Host "`nAll done! You may need to restart your computer for all changes to take effect." -ForegroundColor Green
