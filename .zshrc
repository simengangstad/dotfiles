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

alias mkdir='mkdir -pv'
alias vim='nvim'
bindkey -v

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    export LC_ALL=en_US.UTF-8  
    export LANG=en_US.UTF-8
    export PATH="$HOME/.local/bin:$PATH"
    export PATH="/mnt/c/arduino-cli:$PATH"
    export PATH="/usr/local/texlive/2022/bin/x86_64-linux:$PATH"
    export PATH="/opt/SEGGER/JLink:$PATH"
    export PATH="$HOME/go/bin/:$PATH"
    export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu"

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

    . "$HOME/.cargo/env"
    
    export PATH="$HOME/.local/app/gcc-arm-none-eabi/bin:$PATH"
    export PATH="$HOME/.cargo/bin:$PATH"

elif [[ "$OSTYPE" == "darwin23.0" ]]; then
    ZSH_DISABLE_COMPFIX="true"

    alias icloud="cd $HOME/Library/Mobile\ Documents/com~apple~CloudDocs"
    export PATH="/opt/homebrew/bin:$PATH"
    export PATH="/Applications/ARM/bin:$PATH"
    export PATH="$HOME/Library/Python/3.9/bin:$PATH"
    export PATH="/opt/homebrew/opt/avr-gcc@12/bin:$PATH"
    export LDFLAGS="-L/opt/homebrew/opt/avr-gcc@12/lib"

    export XDG_CONFIG_HOME="$HOME/.config"
fi


source <(fzf --zsh)

export FZF_DEFAULT_COMMAND="find . -not \( -path '*.git' -prune \) -not \( -path './build' -prune \) -not \( -path '*.ccls-cache' -prune \) -not \( -path '*.venv' -prune \) -not \( -path '*__pycache__' -prune \) -type f" 

# Eza
alias ls='eza'
alias ld='eza -lDh'
alias lf='eza -lfh'
alias lh='eza -dlh .* --group-directories-first'
alias ll='eza -T'
alias lt='eza -alh --sort=modified'

# Bat
export BAT_THEME="Catppuccin Macchiato"
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
alias cat="bat"

# Duf
alias df="duf"

# Dust 
alias du="dust"

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    # Kill detached sessions

    detached_sessions=$(tmux list-sessions -F '#{session_attached} #{session_id}' | awk '/^0/{print $2}')

    if [[ ! -z $detached_sessions ]]; then
        echo $detached_sessions | xargs -n 1 tmux kill-session -t
    fi
    
    exec tmux
fi
