# Copies the Windows dotfiles into place. Run from PowerShell 7.
# Existing files are kept as <name>.bak.
$here = $PSScriptRoot

$targets = @{
    "starship.toml"                    = "$HOME\.config\starship.toml"
    "Microsoft.PowerShell_profile.ps1" = $PROFILE.CurrentUserCurrentHost
    "komorebi.json"                    = "$HOME\komorebi.json"
    "komorebi.bar.json"                = "$HOME\komorebi.bar.json"
    "whkdrc"                           = "$HOME\.config\whkdrc"
    "terminal\settings.json"           = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
}

foreach ($src in $targets.Keys) {
    $dest = $targets[$src]
    New-Item -ItemType Directory -Force (Split-Path $dest) | Out-Null
    if (Test-Path $dest) { Copy-Item $dest "$dest.bak" -Force }
    Copy-Item (Join-Path $here $src) $dest -Force
    Write-Host "copied $src -> $dest"
}
