#!/bin/bash
echo '<span background="#ffffff" foreground="#1d1d1d" >'"       $(awk -F, '{ print $4 }' <(sudo brightnessctl -m))"'</span>'
