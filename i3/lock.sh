#!/bin/bash

BG=$HOME/.config/i3/wallpaper.png

# Color palette: https://github.com/jacoborus/tender.vim 

BACKGROUND_COLOR='#303030ff'
BACKGROUND_COLOR_DIMMED='#ffffffff'
TEXT_COLOR='#ffffffff'
ERROR_COLOR='#f43753ff'
INPUT_COLOR='#44778dff'

$HOME/.config/i3/i3lock-color \
-i $BG 				 \
--insidevercolor=$BACKGROUND_COLOR   \
--ringvercolor=$INPUT_COLOR     \
\
--insidewrongcolor=$BACKGROUND_COLOR \
--ringwrongcolor=$ERROR_COLOR   \
\
--insidecolor=$BACKGROUND_COLOR \
--ringcolor=$BACKGROUND_COLOR_DIMMED        \
--linecolor=$BACKGROUND_COLOR        \
--separatorcolor=$BACKGROUND_COLOR   \
\
--verifcolor=$TEXT_COLOR        \
--wrongcolor=$TEXT_COLOR        \
--timecolor=$TEXT_COLOR        \
--datecolor=$TEXT_COLOR        \
--greetercolor=#ff00ffff \
--layoutcolor=$BACKGROUND_COLOR      \
--keyhlcolor=$INPUT_COLOR 	\
--bshlcolor=$INPUT_COLOR 	\
\
--screen 1            \
--clock               \
--indicator           \
--radius=100 \
\
--timestr="%H:%M"     \
--datestr=""     \
--wrongtext="" \
--veriftext="" \
--noinputtext="" \
--verif-font="FontAwesome" \
--wrong-font="FontAwesome" \
--time-font="System Ubuntu" \
--date-font="FontAwesome" \
-t

