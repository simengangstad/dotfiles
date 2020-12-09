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

	# Rofi
	rm -rf "$HOME/.config/rofi" 
	ln -s "$SCRIPTPATH/.config/rofi" "$HOME/.config/rofi"

	# dunst
	rm -rf "$HOME/.config/dunst" 
	ln -s "$SCRIPTPATH/.config/dunst" "$HOME/.config/dunst"

	# Compton 
	rm "$HOME/.config/compton"
	ln -s "$SCRIPTPATH/.config/compton" "$HOME/.config/compton"
fi


