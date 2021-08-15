# Enable improved command line editing
#Install-Module -Name PSReadLine -RequiredVersion 2.1.0
Import-Module PSReadLine

# Enable predictive input (based on history)
Set-PSReadLineOption -PredictionSource History

# Custom prompt via: Install-Module oh-my-posh -Scope CurrentUser -AllowPrerelease
Set-PoshPrompt -Theme jandedobbeleer

# Default editor
Set-Item Env:EDITOR "vim"

# Enforce KDE theme on GUI apps that do support this
Set-Item Env:XDG_CURRENT_DESKTOP "KDE"

# path to evmone library for soltest/isoltest
Set-Item Env:ETH_EVMONE "${Env:HOME}/usr/opt/evmone/lib/libevmone.so"
