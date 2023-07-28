#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	sudo apt update && sudo apt upgrade
	sudo apt install zsh git neovim clang clang-format tmux ccls bat ripgrep black lazygit
	chsh -s $(which zsh)

elif [[ "$OSTYPE" == "darwin20.0" ]]; then
	# Brew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install git neovim yabai skhd clang-format alfred tmux ccls bat ripgrep black lazygit
fi

# Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git config --global alias.lg "log --all --oneline --graph"

# TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Finished setup, now run PluginInstall in Vim, install the Hack Nerd Font Mono"


