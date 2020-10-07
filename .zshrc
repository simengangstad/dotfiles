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

alias mkdir='mkdir -pv'
export PATH=/opt/gcc-arm-none-eabi-6-2017-q2-update/bin:$PATH
export PATH=/home/simengangstad/develop/ardupilot/tools/autotest:$PATH
export PATH=/usr/lib/ccache:$PATH

bindkey -v


source /opt/ros/noetic/setup.zsh
source ~/catkin_ws/devel/setup.zsh
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
export dotnet_cli_telemetry_optout=1

