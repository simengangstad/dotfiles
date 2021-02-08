#!/bin/bash

vol=($(awk -F"[][]" '{ print $2 }' <(amixer -D pulse sget Master)))
muted=($(awk -F"[][]" '{ print $4 }' <(amixer -D pulse sget Master)))
vol=$(echo $vol | sed 's/%//')
re='^[0-9]+$'
output=""

if ! [[ $vol =~ $re ]] ; then
	output="" 
elif [ "$muted" = "off" ]; then
	output=" $vol" 
else
	if [ $vol -eq 0 ]
		then 
			output=" $vol" 
	elif [ $vol -lt 35 ] 
		then
			output="  $vol" 
	elif [ $vol -gt 34 ]
		then 
			output="  $vol"
	fi	
fi

echo "$output"
