#!/bin/bash

wifi="${BLOCK_INSTANCE:-wlp0s20f3}"
status=$(cat /sys/class/net/${wifi}/operstate)
URGENT_VALUE=20

if [[ "${status}" == "up" ]]; then
	
	quality=$(grep ${wifi} /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')
	ssid=$(iwgetid -r)
	echo '<span background="#ffffff" foreground="#1d1d1d" >'"     $ssid"'</span>'
fi
