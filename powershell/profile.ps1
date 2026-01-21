# PowerShell profile - One Light theme + claude permissions

# PSReadLine colors (One Light theme)
Set-PSReadLineOption -Colors @{
    Command            = '#4078f2'  # blue
    Parameter          = '#a626a4'  # magenta
    Operator           = '#383a42'  # foreground
    Variable           = '#e45649'  # red
    String             = '#50a14f'  # green
    Number             = '#c18401'  # yellow
    Type               = '#0184bc'  # cyan
    Comment            = '#696c77'  # bright black
    Keyword            = '#a626a4'  # magenta
    Error              = '#e45649'  # red
    Selection          = '#bfceff'  # selection bg
    InlinePrediction   = '#696c77'  # gray
}

# Prompt matching bash: [hyperconsciousness HH:MM:SS] ~/path
function prompt {
    $time = Get-Date -Format "HH:mm:ss"
    $path = $PWD.Path -replace [regex]::Escape($HOME), '~'
    Write-Host "[hyperconsciousness $time] " -NoNewline -ForegroundColor DarkGray
    Write-Host $path -ForegroundColor Magenta
    return "> "
}

# Claude with all permissions
function claude { & claude.cmd --dangerously-skip-permissions @args }
function cc { & claude.cmd --dangerously-skip-permissions @args }

# Git shortcuts (matching bash aliases)
function gs { git status @args }
function gd { git diff @args }
function ga { git add @args }
function gc { git commit @args }
function gp { git push @args }
function gl { git log --oneline -20 @args }
function gco { git checkout @args }
function gcb { git checkout -b @args }
function gpl { git pull @args }

# Navigation
function docs { Set-Location ~/Documents }
function dt { Set-Location ~/Desktop }
function dl { Set-Location ~/Downloads }
function brain { Set-Location ~/Documents/brain }
function t { Set-Location ~/Documents/terminator }
function w { Set-Location ~/Documents/workflows }
function m { Set-Location ~/Documents/mediar-web-app }

# PSReadLine keybindings (similar to terminal emulators)
Set-PSReadLineKeyHandler -Key Ctrl+l -Function ClearScreen
Set-PSReadLineKeyHandler -Key Ctrl+a -Function BeginningOfLine
Set-PSReadLineKeyHandler -Key Ctrl+e -Function EndOfLine
Set-PSReadLineKeyHandler -Key Ctrl+w -Function BackwardDeleteWord
Set-PSReadLineKeyHandler -Key Ctrl+u -Function BackwardDeleteLine
Set-PSReadLineKeyHandler -Key Ctrl+k -Function ForwardDeleteLine

# History search with up/down arrows
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# Tab completion like bash
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

# Prediction/autocomplete
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# Utils
function list_ports { netstat -an | Select-String "LISTEN" }
Set-Alias -Name cls -Value Clear-Host
Set-Alias -Name which -Value Get-Command
