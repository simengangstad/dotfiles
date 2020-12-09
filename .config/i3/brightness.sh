#!/bin/bash
echo "  $(awk -F, '{ print $4 }' <(brightnessctl -m))"
