export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	export LC_ALL=en_US.UTF-8  
	export LANG=en_US.UTF-8
	export TERM=xterm-256color
elif [[ "$OSTYPE" == "darwin21.0" ]]; then
	ZSH_DISABLE_COMPFIX="true"
	alias icloud="cd $HOME/Library/Mobile\ Documents/com~apple~CloudDocs"
	export PATH=/opt/homebrew/bin:$PATH
fi

plugins=(
	git
)

source $ZSH/oh-my-zsh.sh

# User configuration

alias mkdir='mkdir -pv'
alias vim='nvim'
bindkey -v
