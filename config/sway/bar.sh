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
KEYBOARD_LAYOUT=$(swaymsg -t get_inputs | jq '.[0].xkb_active_layout_name')
KEYBOARD_LAYOUT="${KEYBOARD_LAYOUT:1:2}"

echo -e "$KEYBOARD_LAYOUT $SPACING $VOL_ICON $VOL $SPACING $DATE $SPACING"
