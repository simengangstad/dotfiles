export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

plugins=(
	git
    history-substring-search
)

source $ZSH/oh-my-zsh.sh

# User configuration

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^P" up-line-or-beginning-search
bindkey "^N" down-line-or-beginning-search

alias mkdir='mkdir -pv'
alias vim='nvim'
bindkey -v

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	export LC_ALL=en_US.UTF-8  
	export LANG=en_US.UTF-8
	export TERM=xterm-256color
    export PATH="$HOME/.local/bin:$PATH"
    export PATH="/mnt/c/arduino-cli:$PATH"
    export PATH="/usr/local/texlive/2022/bin/x86_64-linux:$PATH"
    export PATH="/opt/SEGGER/JLink:$PATH"
    export LD_LIBRARY_PATH="/usr/lib/x86_64-linux-gnu"
elif [[ "$OSTYPE" == "darwin22.0" ]]; then
	ZSH_DISABLE_COMPFIX="true"
	alias icloud="cd $HOME/Library/Mobile\ Documents/com~apple~CloudDocs"
	export PATH=/opt/homebrew/bin:$PATH
	export PATH=/Applications/ARM/bin:$PATH
    export TERM="xterm-256color"
fi

echo $2

if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    # Kill detached sessions
    tmux list-sessions -F '#{session_attached} #{session_id}' | awk '/^0/{print $2}' | xargs -n 1 tmux kill-session -t
    exec tmux
fi
