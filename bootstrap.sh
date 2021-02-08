#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	sudo apt update && sudo apt upgrade
	sudo apt install zsh git vim i3-gaps i3blocks dunst dmenu feh fonts-font-awesome
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


