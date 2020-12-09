#!/bin/zsh

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

for entry in .*; do
	if [ ! -d $entry ] && [ $entry != '.gitignore' ] && [[ $entry != *.swp ]]; then
		rm "$HOME/$entry"
		ln -sv "$SCRIPTPATH/$entry" "$HOME"
	fi	
done

if [[ "$OSTYPE" == "linux-gnu" ]]; then
	# i3
	rm -rf "$HOME/.config/i3" 
	ln -s "$SCRIPTPATH/.config/i3" "$HOME/.config/i3"

	rm "$HOME/.config/i3/i3lock-color"
	ln -sv "$SCRIPTPATH/i3lock-color/build/i3lock" "$HOME/.config/i3/i3lock-color"

	# Rofi
	rm -rf "$HOME/.config/rofi" 
	ln -s "$SCRIPTPATH/.config/rofi" "$HOME/.config/rofi"

	# Picom 
	rm "$HOME/.config/picom"
	ln -s "$SCRIPTPATH/.config/picom" "$HOME/.config/picom"


	# Theme
	rm -rf "$HOME/.themes/minimized-dark" 
	ln -s "$SCRIPTPATH/.themes/minimized-dark" "$HOME/.themes/minimized-dark"

	# dunst
	rm -rf "$HOME/.config/dunst" 
	ln -s "$SCRIPTPATH/.config/dunst" "$HOME/.config/dunst"

	# Polybar
	rm -rf "$HOME/.config/polybar" 
	ln -s "$SCRIPTPATH/.config/polybar" "$HOME/.config/polybar"

	# Icons 
	rm -rf "$HOME/.icons/Vimix-Doder-dark" 
	rm -rf "$HOME/.icons/Vimix-Doder" 
	rm -rf "$HOME/.icons/Bibata_Ice" 
	ln -s "$SCRIPTPATH/.icons/Vimix-Doder-dark" "$HOME/.icons/Vimix-Doder-dark"
	ln -s "$SCRIPTPATH/.icons/Vimix-Doder" "$HOME/.icons/Vimix-Doder"
	ln -s "$SCRIPTPATH/.icons/Bibata_Ice" "$HOME/.icons/Bibata_Ice"
fi


