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
)

source $ZSH/oh-my-zsh.sh

# User configuration

alias open="xdg-open"
alias copy="xclip -sel clip"

alias mkdir='mkdir -pv'

bindkey -v


source /opt/ros/noetic/setup.zsh
source ~/catkin_ws/devel/setup.zsh
export dotnet_cli_telemetry_optout=1

