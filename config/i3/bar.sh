#!/bin/bash

SPACING="   "

DATE=$(date '+%a %d. %b %l:%M')

# Volume
SINK=$( pactl list short sinks | sed -e 's,^\([0-9][0-9]*\)[^0-9].*,\1,' | head -n 1 )
VOL=$( pactl list sinks | grep '^[[:space:]]Volume:' | head -n $(( $SINK + 1 )) | tail -n 1 | sed -e 's,.* \([0-9][0-9]*\)%.*,\1,' )
MUTED=$( pacmd list-sinks | awk '/muted/ { print $2 }' | head -n $(( $SINK + 1)) ) 

if [[ "$MUTED" == "yes" ]]; then
    VOL_ICON=""
else
    if [[ "$VOL" -gt "40" ]]; then
        VOL_ICON=""
    else
        VOL_ICON=""
    fi
fi

# Keyboard layout
CURR_LANG="$(setxkbmap -print | grep xkb_symbols | awk '{print $4}' | awk -F"+" '{print $2}')"
KEYBOARD_LAYOUT="ERR"

if [ $CURR_LANG == "us(mac)" ]; then
	KEYBOARD_LAYOUT="US"
elif [ $CURR_LANG == "no" ]; then
	KEYBOARD_LAYOUT="NO"
fi

echo -e "$KEYBOARD_LAYOUT $SPACING $VOL_ICON $VOL $SPACING $DATE $SPACING"
