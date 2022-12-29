#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	sudo apt update && sudo apt upgrade
	sudo apt install zsh git neovim clang clang-format tmux ccls bat
	chsh -s $(which zsh)

elif [[ "$OSTYPE" == "darwin20.0" ]]; then
	# Brew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	brew install git neovim yabai skhd clang-format alfred tmux ccls bat
fi

# Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

git config --global alias.lg "log --all --oneline --graph"


# TexLive
if [ $# -eq 1 ] && [ $1 = "latex" ]; then
    echo "Installing TexLive"

    pushd /tmp > /dev/null
        wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
        zcat install-tl-unx.tar.gz | tar xf -
        cd install-tl-*
        perl ./install-tl --no-interaction
    popd
fi

echo "Finished setup, now run PluginInstall in Vim, install the Hack Nerd Font Mono and add TexLive to path (/usr/local/texlive/<year>/bin/<system>)"


