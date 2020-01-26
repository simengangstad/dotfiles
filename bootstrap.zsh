#!/bin/zsh

echo "Installing ohmyzsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "Setting up aliases for git"
git config --global alias.lg "log --all --oneline --graph"
git config --global alias.ac '!git add -A && git commit -m'

