#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu" ]]; then

    sudo apt update && sudo apt upgrade

    # Environment
    sudo apt install -y zsh python3-venv
    pip3 install tldr

    # Development
    sudo apt install -y neovim

    # Navigation, files & search
    sudo apt install -y fzf zoxide eza ripgrep bat duf

    mkdir -p ~/.local/bin
    ln -s /usr/bin/batcat ~/.local/bin/bat

    # Git
    sudo apt install -y git

    LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
    tar xf lazygit.tar.gz lazygit
    sudo install lazygit /usr/local/bin
    rm -r lazygit lazygit.tar.gz

    # File manager
    wget https://github.com/sxyazi/yazi/releases/download/v25.5.31/yazi-x86_64-unknown-linux-gnu.zip
    unzip yazi-x86_64-unknown-linux-gnu.zip
    cp yazi-x86_64-unknown-linux-gnu/yazi ~/.local/bin/yazi
    rm -r yazi-x86_64-unknown-linux-gnu.zip yazi-x86_64-unknown-linux-gnu
    sudo apt install -y 7zip jq poppler-utils fd-find ripgrep fzf zoxide imagemagick

    # Kitty
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
    ln -sf ~/.local/kitty.app/bin/kitty ~/.local/kitty.app/bin/kitten ~/.local/bin/
    cp ~/.local/kitty.app/share/applications/kitty.desktop ~/.local/share/applications/
    cp ~/.local/kitty.app/share/applications/kitty-open.desktop ~/.local/share/applications/
    sed -i "s|Icon=kitty|Icon=/home/$USER/.local/kitty.app/share/icons/hicolor/256x256/apps/kitty.png|g" ~/.local/share/applications/kitty*.desktop
    sed -i "s|Exec=kitty|Exec=/home/$USER/.local/kitty.app/bin/kitty|g" ~/.local/share/applications/kitty*.desktop
    echo 'kitty.desktop' >~/.config/xdg-terminals.list

    # Enable zsh
    chsh -s "$(which zsh)"

else

    # Brew
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Environment
    brew install alfred skhd yabai
    pip3 install tldr

    # Development
    brew install neovim

    # Navigation, files & search
    brew install fzf zoxide eza ripgrep bat duf

    # Git
    brew install git lazygit

    # File manager
    brew install yazi sevenzip jq poppler fd ripgrep fzf zoxide resvg imagemagick font-symbols-only-nerd-font

    # Kitty
    curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
fi

# Create config directory
mkdir ~/.config

# Setup bat theme
mkdir -p "$(bat --config-dir)/themes"
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Macchiato.tmTheme
wget -P "$(bat --config-dir)/themes" https://github.com/catppuccin/bat/raw/main/themes/Catppuccin%20Latte.tmTheme
bat cache --build

# Rust & cargo
curl https://sh.rustup.rs -sSf | sh

# Cargo packages
cargo install du-dust tree-sitter-cli

# Oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "Finished setup, next steps:"
echo "1. Do ./enable_symlinks.zsh"
echo "2. Install cmake-language-server via pip"
echo "3. Install Hack Nerd Font Mono"
echo "4. Remap caps lock to escape (on gnome): gsettings set org.gnome.desktop.input-sources xkb-options "['caps:escape']""
echo "5. Log out to refresh the shell"
echo "(optional, macOS) Disable SIP for advanced yabai features."
echo "(optional, macOS) Add sudoer manually:\n '$(whoami) ALL = (root) NOPASSWD: sha256:$(shasum -a 256 $(which yabai) | awk "{print \$1;}") $(which yabai) --load-sa' to '/private/etc/sudoers.d/yabai'"
