#!/bin/bash
#vol=$(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master))
#muted=$(awk -F"[][]" '/dB/ { print $6 }' <(amixer sget Master))
vol=($(awk -F"[][]" '{ print $2 }' <(amixer -D pulse sget Master)))
muted=($(awk -F"[][]" '{ print $4 }' <(amixer -D pulse sget Master)))
vol=$(echo $vol | sed 's/%//')
re='^[0-9]+$'

if ! [[ $vol =~ $re ]] ; then
	echo "" 
elif [ "$muted" = "off" ]; then
	echo " $vol" 
else
	if [ $vol -eq 0 ]
		then 
			echo "  $vol" 
	elif [ $vol -lt 35 ] 
		then
			echo "  $vol" 
	elif [ $vol -gt 34 ]
		then 
			echo " $vol"
	fi	
fi
