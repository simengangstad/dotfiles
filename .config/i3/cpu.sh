#!/bin/bash
 
USAGE=$[100-$(vmstat 1 2|tail -1|awk '{print $15}')]
 
echo '<span background="#ffffffff" foreground="#1d1d1d" >'"      $USAGE%"'</span>'
