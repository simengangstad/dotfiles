export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(
    git
    history-substring-search
    cp
    history
)

source $ZSH/oh-my-zsh.sh

bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey -v

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    export LC_ALL=en_US.UTF-8  
    export LANG=en_US.UTF-8
    export PATH="/opt/SEGGER/JLink:$PATH"
    export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu"

    . "$HOME/.cargo/env"
    
    export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | batcat -p -lman'"
else
    ZSH_DISABLE_COMPFIX="true"

    alias icloud="cd $HOME/Library/Mobile\ Documents/com~apple~CloudDocs"
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/Applications/ARM/bin:$PATH"

    export XDG_CONFIG_HOME="$HOME/.config"
    export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat -p -lman'"

    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Aliases
alias mkdir='mkdir -pv'
alias vim='nvim'

# Path
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# Fzf
source <(fzf --zsh)
export FZF_DEFAULT_COMMAND='find . \( -name node_modules -o -name .git -o -name build -o -name .ccls-cache -o -name .venv -o -name __pycache__ -o -name .cache -o -name .mypy_cache -o -name .pytest_cache \) -prune -o -print'

# Eza
alias ls='eza'
alias ld='eza -lDh'
alias lf='eza -lfh'
alias lh='eza -dlh .* --group-directories-first'
alias ll='eza -T'
alias lt='eza -alh --sort=modified'

# Bat
export BAT_THEME="Catppuccin Macchiato"
alias cat="bat"

# Duf
alias df="duf"

# Dust 
alias du="dust"

# Zoxide
alias cd="z"
eval "$(zoxide init zsh)"
