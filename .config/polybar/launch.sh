#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

echo $1 

# Launch polybar
if [ $1 = "desktop" ]; then
	polybar left &
	polybar right &
else
	polybar laptop &
fi

