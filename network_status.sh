#!/bin/sh

DEFAULT_COLOR='^c#FFFFFF^'
RED='^c#FF0000^'
GREEN='^c#00FF00^'

#Prep
SSID=$(iw wlp3s0 info | grep -e 'ssid' | cut -sf2- -d\ )
IP=$(ip route get 1 | awk '{print $7;exit}')

#Getting problems running this. Seems to be something with color. Dwm crashes if I run the script with this in SSID_IP variable
#SIGNAL_STRENGTH=$(awk 'NR==3 {print int($3 / 10)}' /proc/net/wireless)

if test -z $IP; then 
    SSID_IP="$RED No connection $DEFAULT_COLOR" 
else 
    SSID_IP="$GREEN $IP @ $SSID $DEFAULT_COLOR"
fi
#if test -z $IP; then SSID_IP="No connection"; else SSID_IP="($SIGNAL_STRENGTH) $IP @ $SSID"; fi

#Output
echo "$SSID_IP"
