#!/bin/bash

BG=$HOME/.config/i3/sierra.png

BACKGROUND_COLOR='#1d1d1dff'
BACKGROUND_LIGHTER_COLOR='#303030ff'
WHITE='#ffffffff'
TEXT_COLOR='#ffffffff'
ERROR_COLOR='#e74c3cff'

$HOME/.config/i3/i3lock-color \
-i $BG 				 \
--insidevercolor=$BACKGROUND_COLOR   \
--ringvercolor=$WHITE \
\
--insidewrongcolor=$ERROR_COLOR \
--ringwrongcolor=$ERROR_COLOR   \
\
--insidecolor=$BACKGROUND_COLOR \
--ringcolor=$BACKGROUND_LIGHTER_COLOR \
--linecolor='#00000000' \
--separatorcolor=$WHITE \
\
--verifcolor=$TEXT_COLOR        \
--wrongcolor=$TEXT_COLOR        \
--timecolor=$TEXT_COLOR        \
--datecolor=$TEXT_COLOR        \
--layoutcolor=$ERROR_COLOR \
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
--time-font="San Francisco Display" \
--date-font="FontAwesome" \
-t
