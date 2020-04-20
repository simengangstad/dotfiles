#!/bin/bash

BG=$HOME/.config/i3/wallpaper.png

BACKGROUND_COLOR='#1d1d1dff'
WHITE='#ffffffff'
TEXT_COLOR='#ffffffff'
ERROR_COLOR='#f44336ff'

$HOME/.config/i3/i3lock-color \
-i $BG 				 \
--insidevercolor=$BACKGROUND_COLOR   \
--ringvercolor=$WHITE \
\
--insidewrongcolor=$ERROR_COLOR \
--ringwrongcolor=$ERROR_COLOR   \
\
--insidecolor=$BACKGROUND_COLOR \
--ringcolor=$BACKGROUND_COLOR \
--linecolor='#00000000' \
--separatorcolor=$BACKGROUND_COLOR   \
\
--verifcolor=$TEXT_COLOR        \
--wrongcolor=$TEXT_COLOR        \
--timecolor=$TEXT_COLOR        \
--datecolor=$TEXT_COLOR        \
--layoutcolor=$BACKGROUND_COLOR      \
--keyhlcolor=$WHITE \
--bshlcolor=$WHITE \
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
