#!/bin/zsh

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

for entry in .*; do
	if [ ! -d $entry ] && [ $entry != '.gitignore' ] && [ $entry != '.zprofile' ] && [[ $entry != *.swp ]] && [[ $entry != '.DS_Store' ]]; then
		rm "$HOME/$entry"
		ln -sv "$SCRIPTPATH/$entry" "$HOME"
	fi	
done

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    rm -rf "$HOME/.config/nvim"
    rm -rf "$HOME/.config/i3"
    rm -rf "$HOME/.config/dunst"
    rm -rf "$HOME/.config/kitty"
    rm -rf "$HOME/.config/picom"
    rm -rf "$HOME/.config/gdb"

	ln -s "$SCRIPTPATH/config/nvim" "$HOME/.config/nvim"
	ln -s "$SCRIPTPATH/config/i3" "$HOME/.config/i3"
	ln -s "$SCRIPTPATH/config/dunst" "$HOME/.config/dunst"
	ln -s "$SCRIPTPATH/config/kitty" "$HOME/.config/kitty"
	ln -s "$SCRIPTPATH/config/picom" "$HOME/.config/picom"
	ln -s "$SCRIPTPATH/config/gdb" "$HOME/.config/gdb"

elif [[ "$OSTYPE" == "darwin22.0" ]]; then
	rm -rf "$HOME/.config/yabai" 
	rm -rf "$HOME/.config/skhd" 
	rm -rf "$HOME/.config/nvim"
    rm -rf "$HOME/.config/gdb"

	ln -s "$SCRIPTPATH/config/yabai" "$HOME/.config/yabai"
	ln -s "$SCRIPTPATH/config/skhd" "$HOME/.config/skhd"
	ln -s "$SCRIPTPATH/config/nvim" "$HOME/.config/nvim"
	ln -s "$SCRIPTPATH/config/kitty" "$HOME/.config/kitty"
	ln -s "$SCRIPTPATH/config/gdb" "$HOME/.config/gdb"
fi



