#!/bin/bash

battery_information=$(acpi -b | grep 'Battery 0')
battery_information_array=( $battery_information )
battery_status=$(echo ${battery_information_array[2]} | tr ',' ' ')
battery_level=$(echo ${battery_information_array[3]} | tr '%,' ' ')

if [[ $batter_status -eq "Discharging" ]]; then
	if [[ $battery_level -le 10 ]]; then
		notify-send -u critical -t 5000 "Battery level: $battery_level" 
	fi
fi
