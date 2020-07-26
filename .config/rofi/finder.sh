#!/usr/bin/env zsh 

# If there are any arguments passed
if [[ -n "$@" ]]; then
	# Check if the argument passed is a file path or directory, in other words we chose an item after
	# searching or just initially
	if [[ -d "$HOME/$1"  ]] || [[ -f "$HOME/$1" ]]
	then
		coproc xdg-open "$HOME/$1" > /dev/null
	# We are searching initially
	else
		# Look up in database, get only items wit file:// prefix, remove said prefix and remove $HOME prefix
		result=$(recoll -t -e -b -f $1 | grep 'file://' | sed -e 's|^ *file://||' | sed -e "s|$HOME/||")
		for entry in $result
		do
			echo $entry
		done
	fi
fi

