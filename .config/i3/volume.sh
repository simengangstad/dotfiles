#!/bin/bash
vol=$(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master))
muted=$(awk -F"[][]" '/dB/ { print $6 }' <(amixer sget Master))
vol=${vol:0:-1}

re='^[0-9]+$'

if ! [[ $vol =~ $re ]] ; then
	echo "" 
elif [ "$muted" = "off" ]; then
	echo " $vol" 
else
	if [ $vol -eq 0 ]
		then 
			echo " $vol" 
	elif [ $vol -lt 50 ] 
		then
			echo " $vol" 
	elif [ $vol -gt 49 ]
		then 
			echo " $vol"
	fi	
fi
