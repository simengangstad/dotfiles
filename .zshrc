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
eval $($HOME/.linuxbrew/bin/brew shellenv)
alias open="xdg-open"

alias mkdir='mkdir -pv'
export CUDA_HOME=/usr/local/cuda
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib65
export PATH=$PATH:$CUDA_HOME/bin
export VIRTUAL_ENV_DISABLE_PROMPT=
export PATH=$PATH:$HOME/Firmware/build/px4_sitl_default/bin

