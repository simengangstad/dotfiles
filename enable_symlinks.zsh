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
ln -s "$SCRIPTPATH/.config/i3" "$HOME/.config/i3"

rm "$HOME/.config/i3/i3lock-color"
ln -sv "$SCRIPTPATH/i3lock-color/build/i3lock" "$HOME/.config/i3/i3lock-color"

# Rofi
rm -rf "$HOME/.config/rofi" 
ln -s "$SCRIPTPATH/.config/rofi" "$HOME/.config/rofi"

# Compton 
rm "$HOME/.config/compton.conf"
ln -sv "$SCRIPTPATH/.config/compton.conf" "$HOME/.config/compton.conf"

# Theme
rm -rf "$HOME/.themes/minimized-dark" 
ln -s "$SCRIPTPATH/.themes/minimized-dark" "$HOME/.themes/minimized-dark"

# Dunst
rm -rf "$HOME/.config/dunst" 
ln -s "$SCRIPTPATH/.config/dunst" "$HOME/.config/dunst"

# Spotify tui 
rm "$HOME/.config/spotify-tui/config.yml" 
ln -sv "$SCRIPTPATH/.config/spotify-tui/config.yml" "$HOME/.config/spotify-tui/config.yml"


