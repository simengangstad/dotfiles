#!/bin/bash
echo '<span background="#303030" foreground="#ffffff" >'"       $(awk -F, '{ print $4 }' <(sudo brightnessctl -m))"'</span>'
