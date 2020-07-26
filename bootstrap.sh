#!/bin/bash

echo "Installing ohmyzsh"
sudo apt install curl zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "Installing Vim"
sudo apt install vim 

echo "Setting up aliases for git"
git config --global alias.lg "log --all --oneline --graph"

echo "Enabling clipboard support"
sudo apt-get install xclip
echo "Installing vivid for LS_COLORS"
wget "https://github.com/sharkdp/vivid/releases/download/v0.5.0/vivid_0.5.0_amd64.deb"
sudo apt install ./vivid_*.deb

echo "Installing i3 and dunst"
mkdir -p $HOME/.config/i3
mkdir -p $HOME/.config/dunst
mkdir -p $HOME/.icons
mkdir -p $HOME/.themes
sudo add-apt-repository ppa:kgilmer/speed-ricer
sudo apt update
sudo apt install i3-gaps i3blocks rofi xautolock compton dunst fonts-font-awesome feh

echo "Installing playerctl"
wget "https://github.com/altdesktop/playerctl/releases/download/v2.1.1/playerctl-2.1.1_amd64.deb"
sudo apt install ./playerctl-*.deb

echo "Installing i3lock-color"
sudo apt install pkg-config libpam0g-dev libcairo2-dev libfontconfig1-dev libxcb-composite0-dev libev-dev libx11-xcb-dev libxcb-xkb-dev libxcb-xinerama0-dev libxcb-randr0-dev libxcb-image0-dev libxcb-util-dev libxcb-xrm-dev libxkbcommon-dev libxkbcommon-x11-dev libjpeg-dev autoconf
git clone https://github.com/Raymo111/i3lock-color.git
pushd i3lock-color
	autoreconf -fiv

	rm -rf build/
	mkdir -p build 
	pushd build/
		../configure --prefix=/usr --sysconfdir=/etc --disable-sanitizers
		make
	popd
popd

echo "Installing powerline fonts"
git clone https://github.com/powerline/fonts.git
pushd fonts
	./install.sh
popd	

echo "Copying custom zsh theme"
cp minimized.zsh-theme $HOME/.oh-my-zsh/themes/minimized.zsh-theme


chsh -s $(which zsh)
echo "Finished setup, now run PluginInstall in Vim and remember to install Font Awesome"


