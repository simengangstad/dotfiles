#!/bin/bash

wifi="${BLOCK_INSTANCE:-wlp0s20f3}"
status=$(cat /sys/class/net/${wifi}/operstate)
URGENT_VALUE=20

if [[ "${status}" == "up" ]]; then
	
	quality=$(grep ${wifi} /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')
	ssid=$(iwgetid -r)
	echo "  $ssid"
	#if [[ -d "/sys/class/net/${device}/wireless" ]]; then
	#	quality=$(grep ${device} /proc/net/wireless | awk '{ print int($3 * 100 / 70) }')
	#	echo "$ssid ${quality}%"

	#	if [[ "${quality}" -le "${URGENT_VALUE}" ]]; then
	#		exit 33
	#	fi
	#fi
fi
