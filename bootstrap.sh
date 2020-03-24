#!/bin/bash

echo "Installing ohmyzsh"
sudo apt install curl zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "Installing Vim and dependencies"
sudo apt install vim cmake python3-dev
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "Setting up aliases for git"
git config --global alias.lg "log --all --oneline --graph"
git config --global alias.ac '!git add -A && git commit -m'

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	echo "Enabling clipboard support"
	sudo apt-get install xclip
	echo "Installing vivid for LS_COLORS"
	wget "https://github.com/sharkdp/vivid/releases/download/v0.5.0/vivid_0.5.0_amd64.deb"
	sudo apt install ./vivid_*.deb

	echo "Installing i3 and dunst"
	sudo add-apt-repository ppa:kgilmer/speed-ricer
	sudo apt update
	mkdir -p $HOME/.config/i3
	mkdir -p $HOME/.config/dunst
	sudo apt install i3-gaps i3blocks fonts-font-awesome rofi xautolock compton dunst
	
	echo "Installing playerctl"
	wget "https://github.com/altdesktop/playerctl/releases/download/v2.1.1/playerctl-2.1.1_amd64.deb"
	sudo apt install ./playerctl-*.deb

	echo "Installing icons, themes and feh"
	sudo add-apt-repository ppa:noobslab/icons
	sudo apt update && sudo apt install ultra-flat-icons gtk2-engines-murrine libglib2.0-dev libxml2-utils feh 

	echo "Installing i3lock-color"
	git clone https://github.com/Raymo111/i3lock-color.git
	cd i3lock-color
	sudo apt install pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev autoconf
	autoreconf -fiv
	
	rm -rf build/
	mkdir -p build && cd build/

	../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
	make
	cd ../..
fi

echo "Copying custom zsh theme"
cp minimized.zsh-theme $HOME/.oh-my-zsh/themes/minimized.zsh-theme


chsh -s $(which zsh)
echo "Finished setup, now run PluginInstall in Vim"

if [[ "$OSTYPE" == "darwin" ]]; then
	echo "Remember to import the minimized theme into Terminal.app"
fi

