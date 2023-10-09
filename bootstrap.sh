#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	sudo apt update && sudo apt upgrade
	sudo apt install -y zsh git clang clang-format tmux ccls bat ripgrep black fzf make cmake npm python3-venv python3-pip exuberant-ctags unzip 
    	pip install cmakelint

	# Lazygit
	LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
	curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
	tar xf lazygit.tar.gz lazygit
	sudo install lazygit /usr/local/bin
	rm -r lazygit lazygit.tar.gz

    mkdir ~/.local/bin
    mkdir ~/.local/app

	# Neovim
    curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz
    tar xf nvim-linux64.tar.gz
	mkdir ~/.local/app
	mv nvim-linux64 ~/.local/app/nvim
	ln -s ~/.local/app/nvim/bin/nvim ~/.local/bin/nvim
	rm nvim-linux64.tar.gz

    # Tree-sitter
    curl -LO https://github.com/tree-sitter/tree-sitter/releases/download/v0.20.8/tree-sitter-linux-x64.gz
    gunzip tree-sitter-linux-x64.gz 
    mv tree-sitter-linux-x64 ~/.local/bin/tree-sitter
    chmod u+x ~/.local/bin/tree-sitter

	# Enable zsh
	chsh -s $(which zsh)
elif [[ "$OSTYPE" == "darwin20.0" ]]; then
	# Brew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install git neovim skhd clang-format alfred tmux ccls bat ripgrep black lazygit tree-sitter make cmake node ctags 

    # Reduce time for window animations
    defaults -currentHost write -g NSWindowResizeTime -float 0.065
fi

# Create config directory
mkdir ~/.config

# Rust & cargo
curl https://sh.rustup.rs -sSf | sh

# Packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git config --global alias.lg "log --all --oneline --graph"

# TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Finished setup, now install the Hack Nerd Font Mono"


