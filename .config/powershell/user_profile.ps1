# set PowerShell to UTF-8
[console]::InputEncoding = [console]::OutputEncoding = New-Object System.Text.UTF8Encoding

#Oh My Posh
#Import-Module posh-git
# I have a custom theme:
oh-my-posh init pwsh --config ~/.config/powershell/.caio.omp.json | Invoke-Expression
# I have an out-of-box theme:
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\montys.omp.json" | Invoke-Expression

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

# =============================================================================
#
# Utility functions for zoxide.
#

# pwd based on zoxide's format.
function __zoxide_pwd {
    $cwd = Get-Location
    if ($cwd.Provider.Name -eq "FileSystem") {
        $cwd.ProviderPath
    }
}

# cd + custom logic based on the value of _ZO_ECHO.
function __zoxide_cd($dir, $literal) {
    $dir = if ($literal) {
        Set-Location -LiteralPath $dir -Passthru -ErrorAction Stop
    } else {
        Set-Location -Path $dir -Passthru -ErrorAction Stop
    }
}

# =============================================================================
#
# Hook configuration for zoxide.
#

# Hook to add new entries to the database.
function __zoxide_hook {
    $result = __zoxide_pwd
    if ($null -ne $result) {
        zoxide add -- $result
    }
}

# Initialize hook.

$__zoxide_hooked = (Get-Variable __zoxide_hooked -ValueOnly -ErrorAction SilentlyContinue)
if ($__zoxide_hooked -ne 1) {
    $__zoxide_hooked = 1
    $prompt_old = $function:prompt
    function prompt {
        $null = __zoxide_hook
        & $prompt_old
    }
}

# =============================================================================
#
# When using zoxide with --no-cmd, alias these internal functions as desired.
#

# Jump to a directory using only keywords.
function __zoxide_z {
    if ($args.Length -eq 0) {
        __zoxide_cd ~ $true
    }
    elseif (
        $args.Length -eq 1 -and
        (($args[0] -eq '-' -or $args[0] -eq '+') -or (Test-Path $args[0] -PathType Container))
    ) {
        __zoxide_cd $args[0] $false
    }
    else {
        $result = __zoxide_pwd
        if ($null -ne $result) {
            $result = zoxide query --exclude $result -- @args
        }
        else {
            $result = zoxide query -- @args
        }
        if ($LASTEXITCODE -eq 0) {
            __zoxide_cd $result $true
        }
    }
}

# Jump to a directory using interactive search.
function __zoxide_zi {
    $result = zoxide query -i -- @args
    if ($LASTEXITCODE -eq 0) {
        __zoxide_cd $result $true
    }
}

# =============================================================================
#
# Commands for zoxide. Disable these using --no-cmd.
#

Set-Alias -Name z -Value __zoxide_z -Option AllScope -Scope Global -Force
Set-Alias -Name zi -Value __zoxide_zi -Option AllScope -Scope Global -Force

# Fzf
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Key Tab -ScriptBlock { Invoke-FzfTabCompletion }
Set-PsFzfOption -TabExpansion

# Env
#$env:GIT_SSH = "C:\Windows\system32\OpenSSH\ssh.exe"

# Alias
Set-Alias -Name vim -Value nvim
Set-Alias ll ls
function tt { npm run test }
function dev { npm run dev }
function strt {npm run start }
Set-Alias cc 'cls'
#Set-Alias g git
#Set-Alias grep findstr
#Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
#Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'


# Utilities
#function which ($command) {
#  Get-Command -Name $command -ErrorAction SilentlyContinue |
#    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
#}
