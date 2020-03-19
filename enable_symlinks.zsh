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

rm "$HOME/.config/i3/i3lock-color"
ln -sv "$SCRIPTPATH/i3lock-color/build/i3lock" "$HOME/.config/i3/i3lock-color"

# Rofi
rm -rf "$HOME/.config/rofi" 
ln -s "$SCRIPTPATH/rofi" "$HOME/.config/rofi"

# Compton
rm "$HOME/.config/compton.conf"
ln -sv "$SCRIPTPATH/compton.conf" "$HOME/.config/compton.conf"

# Theme
rm -rf "$HOME/.themes/minimized-dark" 
ln -s "$SCRIPTPATH/minimized-dark" "$HOME/.themes/minimized-dark"

rm -rf "$HOME/.icons/oreo_blue_cursors" 
ln -s "$SCRIPTPATH/oreo_blue_cursors" "$HOME/.icons/oreo_blue_cursors"


