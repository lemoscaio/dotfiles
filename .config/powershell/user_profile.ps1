# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

#Oh My Posh
Import-Module posh-git
# I have a custom theme:
oh-my-posh init pwsh --config ~/.config/powershell/.caio.omp.json | Invoke-Expression
# I have an out-of-box theme:
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\jandedobbeleer.omp.json" | Invoke-Expression

#$omp_config = Join-Path $PSScriptRoot ".\caio.omp.json"
#oh-my-posh --init --shell pwsh --config $omp_config | Invoke-Expression

# Icons
Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadLineOption -EditMode Emacs
Set-PSReadLineOption -BellStyle None
Set-PSReadLineKeyHandler -Chord 'Ctrl+d' -Function DeleteChar
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

# Env
#$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"

# Alias
Set-Alias -Name vim -Value nvim
Set-Alias ll ls
#Set-Alias g git
#Set-Alias grep findstr
#Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
#Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'

# Utilities
#function which ($command) {
#  Get-Command -Name $command -ErrorAction SilentlyContinue |
#    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
#}
