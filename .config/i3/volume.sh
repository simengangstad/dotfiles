#!/bin/bash
#vol=$(awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master))
#muted=$(awk -F"[][]" '/dB/ { print $6 }' <(amixer sget Master))
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

echo '<span background="#ffffffff" foreground="#1d1d1d" >'"     $output"'</span>'
