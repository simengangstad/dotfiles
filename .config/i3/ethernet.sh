#!/bin/bash
 
IF=$(ip addr | grep -B1 -A1 ether)
IPN_RE='([^ ]+:)([ ]+)([^ ]+):'
IPN=$([[ $IF =~ $IPN_RE ]] && echo -n ${BASH_REMATCH[3]})
ETHERNET_STATUS=$(cat /sys/class/net/$IPN/operstate)
 
if [ "$ETHERNET_STATUS" = "up" ]; then
  echo '<span background="#ffffffff" foreground="#1d1d1d" >'"    "'</span>'
fi
