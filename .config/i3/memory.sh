#!/bin/bash
 
USAGE=$(free -m | awk 'NR==2{printf "%.1fG", $3/1024 }')

echo '<span background="#ffffffff" foreground="#1d1d1d" >'"      $USAGE"'</span>'
