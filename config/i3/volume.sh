#!/bin/bash

volume=($(awk -F"[][]" '{ print $2 }' <(amixer -D pipewire sget Master)))
muted=($(awk -F"[][]" '{ print $4 }' <(amixer -D pipewire sget Master)))
volume=$(echo $volume | sed 's/%//')

if ! [[ $volume =~ $('^[0-9]+$') ]] ; then
	echo "󰖁" 
elif [ "$muted" = "off" ]; then
	echo "󰖁 $volume" 
else
    echo " $volume" 
fi
