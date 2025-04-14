#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then

    sudo apt update && sudo apt upgrade
    sudo apt install -y zsh git neovim clang-format tmux ccls bat ripgrep make cmake bat fzf python3-venv

    # Symlink batcat to bat
    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat

    # Kitty
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
    ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
    cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
    sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
    sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
    echo 'kitty.desktop' >~/.config/xdg-terminals.list

    # Lazygit
    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm -r lazygit lazygit.tar.gz

    # Enable zsh
    chsh -s $(which zsh)

else

    # Brew
    # /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"
    brew install git neovim clang-format tmux ccls bat ripgrep lazygit make cmake bat fzf git-delta duf alfred skhd yabai zoxide eza

    # Kitty
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin

    # Packages
    brew install lua
    brew install switchaudio-osx
    brew install nowplaying-cli

    brew tap FelixKratz/formulae
    brew install sketchybar

    # Fonts
    brew install --cask sf-symbols
    brew install --cask font-sf-mono
    brew install --cask font-sf-pro

    curl -L https://github.com/kvndrsslr/sketchybar-app-font/releases/download/v2.0.28/sketchybar-app-font.ttf -o $HOME/Library/Fonts/sketchybar-app-font.ttf
    (git clone https://github.com/FelixKratz/SbarLua.git /tmp/SbarLua && cd /tmp/SbarLua/ && make install && rm -rf /tmp/SbarLua/)
fi

# Create config directory
mkdir ~/.config

# Setup bat theme
mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
bat cache --build

# Rust & cargo
curl https://sh.rustup.rs -sSf | sh

# Cargo packages
cargo install du-dust tree-sitter-cli

# Packer
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

echo "Finished setup, next steps:"
echo "1. Do ./enable_symlinks.zsh"
echo "2. Install cmake-language-server via pip"
echo "3. Install Hack Nerd Font Mono"
echo "4. Remap caps lock to escape (on gnome): gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape']""
echo "5. Log out to refresh the shell"
echo "(optional, macOS) Disable SIP for advanced yabai features."
echo "(optional, macOS) Add sudoer manually:\n '$(whoami) ALL = (root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | awk "{print \$1;}") $(which yabai) --load-sa' to '/private/etc/sudoers.d/yabai'"
