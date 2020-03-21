#!/bin/bash
vol=$(/usr/share/i3blocks/volume 5 pulse)
vol=${vol:0:-1}

re='^[0-9]+$'

if ! [[ $vol =~ $re ]] ; then
	echo "" 
else
	if [ $vol -eq 0 ]
		then 
			echo "  $vol" 
	elif [ $vol -lt 50 ] 
		then
			echo "  $vol" 
	elif [ $vol -gt 49 ]
		then 
			echo "  $vol"
	fi	
fi
