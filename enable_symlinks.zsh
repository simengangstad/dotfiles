#!/bin/zsh

SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

for entry in .*; do
	if [ ! -d $entry ] && [ $entry != '.gitignore' ] && [[ $entry != *.swp ]] && [[ $entry != '.DS_Store' ]]; then
		rm "$HOME/$entry"
		ln -sv "$SCRIPTPATH/$entry" "$HOME"
	fi	
done

if [[ "$OSTYPE" == "linux-gnu" ]]; then
    rm -rf "$HOME/.config/regolith3"

    ln -s "$SCRIPTPATH/config/regolith3" "$HOME/.config/regolith3"

else
	rm -rf "$HOME/.config/yabai" 
	rm -rf "$HOME/.config/skhd" 

	ln -s "$SCRIPTPATH/config/yabai" "$HOME/.config/yabai"
	ln -s "$SCRIPTPATH/config/skhd" "$HOME/.config/skhd"
fi

rm -rf "$HOME/.config/nvim"
rm -rf "$HOME/.config/kitty"
rm -rf "$HOME/.config/gdb"
rm -rf "$HOME/.config/bat"
rm -rf "$HOME/.config/lazygit"

ln -s "$SCRIPTPATH/config/nvim" "$HOME/.config/nvim"
ln -s "$SCRIPTPATH/config/kitty" "$HOME/.config/kitty"
ln -s "$SCRIPTPATH/config/gdb" "$HOME/.config/gdb"
ln -s "$SCRIPTPATH/config/bat" "$HOME/.config/bat"
ln -s "$SCRIPTPATH/config/lazygit" "$HOME/.config/lazygit"



