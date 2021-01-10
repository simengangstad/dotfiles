export ZSH=$HOME/.oh-my-zsh

ZSH_THEME="robbyrussell"

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	export LC_ALL=en_US.UTF-8  
	export LANG=en_US.UTF-8
	export TERM=xterm-256color
	alias open="xdg-open"
	alias copy="xclip -sel clip"
	
	source /opt/ros/noetic/setup.zsh
	source ~/catkin_ws/devel/setup.zsh
	# export dotnet_cli_telemetry_optout=1
elif [[ "$OSTYPE" == "darwin20.0" ]]; then
	ZSH_DISABLE_COMPFIX="true"
fi

plugins=(
	git
)

source $ZSH/oh-my-zsh.sh

# User configuration

alias mkdir='mkdir -pv'
bindkey -v



