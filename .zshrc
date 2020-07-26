export LC_ALL=en_US.UTF-8  
export LANG=en_US.UTF-8
export TERM=xterm-256color
export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="minimized"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	export LS_COLORS="$(vivid generate snazzy)"
fi

plugins=(
	git
	virtualenv
)

source $ZSH/oh-my-zsh.sh

# User configuration

# source /opt/ros/melodic/setup.zsh
# source $HOME/develop/catkin_ws/devel/setup.zsh
alias open="xdg-open"

alias mkdir='mkdir -pv'
export VIRTUAL_ENV_DISABLE_PROMPT=

bindkey -v


