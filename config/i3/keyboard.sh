#!/bin/bash

current_layout="$(setxkbmap -print | grep xkb_symbols | awk '{print $4}' | awk -F"+" '{print $2}')"

if [ $current_layout == "us(mac)" ]; then
    echo "󰌌 US"
elif [ $current_layout == "no(mac)" ]; then
    echo "󰌌 NO"
else
    echo "󰌐 ERR"
fi
