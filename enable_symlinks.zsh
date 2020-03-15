#!/bin/zsh

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

for entry in .*; do
	if [ ! -d $entry ] && [ $entry != '.gitignore' ] && [[ $entry != *.swp ]]; then
		rm "$HOME/$entry"
		ln -sv "$SCRIPTPATH/$entry" "$HOME"
	fi	
done

# i3
rm -rf "$HOME/.config/i3" 
ln -s "$SCRIPTPATH/i3" "$HOME/.config/i3"

# Rofi
rm -rf "$HOME/.config/rofi" 
ln -s "$SCRIPTPATH/rofi" "$HOME/.config/rofi"

rm "$HOME/.config/i3/i3lock-color"
ln -sv "$SCRIPTPATH/i3lock-color/build/i3lock" "$HOME/.config/i3/i3lock-color"

