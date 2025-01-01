oh-my-posh init pwsh --config 'C:\Users\trant\scoop\apps\oh-my-posh\current\themes\amro.omp.json' | Invoke-Expression

Import-Module Terminal-Icons

Clear-Host

$env:FZF_DEFAULT_OPTS='--height 70% --layout=reverse --border --info=inline --preview-window=right:50% --bind ctrl-/:toggle-preview'

$env:FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git --exclude node_modules --exclude venv --exclude build --exclude dist --exclude __pycache__ --exclude .cache --exclude .idea --exclude .vscode --exclude target --exclude out --exclude .mypy_cache --exclude .pytest_cache --exclude .ipynb_checkpoints --exclude .next --exclude .nuxt --exclude coverage --exclude tmp --exclude temp --exclude logs --exclude log --exclude .github'

function ff {
    nvim $(fzf --preview 'bat --style=numbers --color=always --line-range :500 {}')
}

function cdf {
    $dir = $(fd --type d --hidden --follow --exclude .git --exclude node_modules --exclude venv `
        --exclude build --exclude dist --exclude __pycache__ --exclude .cache --exclude .idea `
        --exclude .vscode --exclude target --exclude out --exclude .mypy_cache --exclude .pytest_cache `
        --exclude .ipynb_checkpoints --exclude .next --exclude .nuxt --exclude coverage --exclude tmp `
        --exclude temp --exclude logs --exclude log --exclude .github | fzf --preview 'dir -Force {}')
    if ($dir) {
        cd $dir
    }
}
