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
rm "$HOME/.config/compton-laptop.conf"
ln -sv "$SCRIPTPATH/.config/compton-laptop.conf" "$HOME/.config/compton-laptop.conf"
rm "$HOME/.config/compton-desktop.conf"
ln -sv "$SCRIPTPATH/.config/compton-desktop.conf" "$HOME/.config/compton-desktop.conf"


# Theme
rm -rf "$HOME/.themes/minimized-dark" 
ln -s "$SCRIPTPATH/.themes/minimized-dark" "$HOME/.themes/minimized-dark"

# dunst
rm -rf "$HOME/.config/dunst" 
ln -s "$SCRIPTPATH/.config/dunst" "$HOME/.config/dunst"

# Albert
rm -rf "$HOME/.config/albert/albert.conf" 
ln -sv "$SCRIPTPATH/.config/albert/albert.conf" "$HOME/.config/albert/albert.conf"
mkdir "$HOME/.local/share/albert/org.albert.frontend.widgetboxmodel" 
rm -rf "$HOME/.local/share/albert/org.albert.frontend.widgetboxmodel/themes/minimized-dark.qss" 
cp "$SCRIPTPATH/.config/albert/minimized-dark.qss" "$HOME/.local/share/albert/org.albert.frontend.widgetboxmodel/themes/minimized-dark.qss" 

# Icons 
rm -rf "$HOME/.icons/Vimix-Doder-dark" 
rm -rf "$HOME/.icons/Vimix-Doder" 
rm -rf "$HOME/.icons/Bibata_Ice" 
ln -s "$SCRIPTPATH/.icons/Vimix-Doder-dark" "$HOME/.icons/Vimix-Doder-dark"
ln -s "$SCRIPTPATH/.icons/Vimix-Doder" "$HOME/.icons/Vimix-Doder"
ln -s "$SCRIPTPATH/.icons/Bibata_Ice" "$HOME/.icons/Bibata_Ice"


