#!/bin/zsh

echo "Installing ohmyzsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "Installing Vundle"
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

echo "Setting up aliases for git"
git config --global alias.lg "log --all --oneline --graph"
git config --global alias.ac '!git add -A && git commit -m'

echo "Enabling clipboard support"
if [[ "$OSTYPE" == "linux-gnu" ]]; then
	sudo apt-get install powerline xclip
elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
fi

echo "Copying custom zsh theme"
cp minimized.zsh-theme $HOME/.oh-my-zsh/themes/minimized.zsh-theme

echo "Installing vivid for LS_COLORS"
wget "https://github.com/sharkdp/vivid/releases/download/v0.5.0/vivid_0.5.0_amd64.deb"
sudo dpkg -i vivid_0.5.0_amd64.deb

echo "Finished setup, now run PluginInstall in Vim"
