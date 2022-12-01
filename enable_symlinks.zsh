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
    rm -rf "$HOME/.config/sway"
    rm -rf "$HOME/.config/wofi"
    rm -rf "$HOME/.config/alacritty"
    rm -rf "$HOME/.config/gdb"

	ln -s "$SCRIPTPATH/config/nvim" "$HOME/.config/nvim"
	ln -s "$SCRIPTPATH/config/sway" "$HOME/.config/sway"
	ln -s "$SCRIPTPATH/config/wofi" "$HOME/.config/wofi"
	ln -s "$SCRIPTPATH/config/alacritty" "$HOME/.config/alacritty"
	ln -s "$SCRIPTPATH/config/gdb" "$HOME/.config/gdb"

elif [[ "$OSTYPE" == "darwin22.0" ]]; then
	rm -rf "$HOME/.config/yabai" 
	rm -rf "$HOME/.config/skhd" 
	rm -rf "$HOME/.config/nvim"
    rm -rf "$HOME/.config/gdb"

	ln -s "$SCRIPTPATH/config/yabai" "$HOME/.config/yabai"
	ln -s "$SCRIPTPATH/config/skhd" "$HOME/.config/skhd"
	ln -s "$SCRIPTPATH/config/nvim" "$HOME/.config/nvim"
	ln -s "$SCRIPTPATH/config/alacritty" "$HOME/.config/alacritty"
	ln -s "$SCRIPTPATH/config/gdb" "$HOME/.config/gdb"
fi



