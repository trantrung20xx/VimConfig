# HELLO
$ascii = @"

     _______                       _______
    |_     _|.----..---.-..-----. |_     _|.----..--.--..-----..-----.
      |   |  |   _||  _  ||     |   |   |  |   _||  |  ||     ||  _  |
      |___|  |__|  |___._||__|__|   |___|  |__|  |_____||__|__||___  |
                                                               |_____|

"@

Write-Host $ascii

#==========================================================================================================================================#
#==========================================================================================================================================#

#oh-my-posh init pwsh --config 'C:\Users\trant\scoop\apps\oh-my-posh\current\themes\amro.omp.json' | Invoke-Expression

#Import-Module Terminal-Icons

$env:FZF_DEFAULT_OPTS='--height 80% --layout=reverse --border --info=inline --preview-window=right:50% --bind ctrl-/:toggle-preview'

$env:FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git --exclude node_modules --exclude venv --exclude build --exclude dist --exclude __pycache__ --exclude .cache --exclude .idea --exclude .vscode --exclude target --exclude out --exclude .mypy_cache --exclude .pytest_cache --exclude .ipynb_checkpoints --exclude .next --exclude .nuxt --exclude coverage --exclude tmp --exclude temp --exclude logs --exclude log --exclude .github'

function ff {
    $file = $(fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')
    if ($file) {
        nvim $file
    }
}

function ffr {
    $file = $(fd --type f --hidden --follow --exclude .git --exclude node_modules --exclude venv `
        --exclude build --exclude dist --exclude __pycache__ --exclude .cache --exclude .idea `
        --exclude .vscode --exclude target --exclude out --exclude .mypy_cache --exclude .pytest_cache `
        --exclude .ipynb_checkpoints --exclude .next --exclude .nuxt --exclude coverage --exclude tmp `
        --exclude temp --exclude logs --exclude log --exclude .github --glob "*" "$env:USERPROFILE"`
        | fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')
    if ($file) {
        nvim $file
    }
}

function cdf {
    $dir = $(fd --type d --hidden --follow --exclude .git --exclude node_modules --exclude venv `
        --exclude build --exclude dist --exclude __pycache__ --exclude .cache --exclude .idea `
        --exclude .vscode --exclude target --exclude out --exclude .mypy_cache --exclude .pytest_cache `
        --exclude .ipynb_checkpoints --exclude .next --exclude .nuxt --exclude coverage --exclude tmp `
        --exclude temp --exclude logs --exclude log --exclude .github | fzf --preview 'tree /A {}')
    if ($dir) {
        cd $dir
    }
}

function cdfr {
    $dir = $(fd --type d --hidden --follow --exclude .git --exclude node_modules --exclude venv `
        --exclude build --exclude dist --exclude __pycache__ --exclude .cache --exclude .idea `
        --exclude .vscode --exclude target --exclude out --exclude .mypy_cache --exclude .pytest_cache `
        --exclude .ipynb_checkpoints --exclude .next --exclude .nuxt --exclude coverage --exclude tmp `
        --exclude temp --exclude logs --exclude log --exclude .github --glob "*" "$env:USERPROFILE"`
        | fzf --preview 'tree /A {}')
    if ($dir) {
        cd $dir
    }
}

Remove-Item Alias:ls

# Setup Alias
$env:EZA_DEFAULT_OPTIONS = "--icons --color=always --git --header"
function list { eza @($env:EZA_DEFAULT_OPTIONS -split " ") $args }

