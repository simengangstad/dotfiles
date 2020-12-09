#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	mkdir -p $HOME/.config/i3
	mkdir -p $HOME/.config/dunst
	mkdir -p $HOME/.config/compton
	sudo add-apt-repository ppa:kgilmer/speed-ricer
	sudo apt update
	sudo apt install curl zsh git vim i3-gaps i3blocks rofi xautolock dunst fonts-font-awesome feh compton playerctl brightnessctl
	chsh -s $(which zsh)

elif [[ "$OSTYPE" == "darwin20.0" ]]; then
	# Brew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install git yabai skhd alfred 
fi

# Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git config --global alias.lg "log --all --oneline --graph"

echo "Finished setup, now run PluginInstall in Vim"


