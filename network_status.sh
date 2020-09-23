#!/bin/sh

# DWMBLOCKS config information
DWMBLOCKS_BLOCK_SIZE=80
DWMBLOCKS_DELIMITER=5
DWMBLOCKS_BLOCK_SIZE=$(($DWMBLOCKS_BLOCK_SIZE-$DWMBLOCKS_DELIMITER))

DEFAULT_COLOR='^c#FFFFFF^'
RED='^c#FF0000^'
GREEN='^c#00FF00^'

#Prep
#SSID=$(iw wlp3s0 info | grep -e 'ssid' | cut -sf2- -d\ )
IP=$(ip route get 1 | awk '{print $7;exit}')
SSID="kenhamthescienceguy"

# Fixed the problem
SIGNAL_STRENGTH=0.$(awk 'NR==3 {print int($3 / 10)}' /proc/net/wireless)

if test -z $IP; then 
    SSID_IP="$RED No connection $DEFAULT_COLOR" 
else 
    SSID_IP="$GREEN($SIGNAL_STRENGTH) $IP @ $SSID$DEFAULT_COLOR"
    LEN=$(echo $SSID_IP | wc -m)
    if test $LEN -ge $DWMBLOCKS_BLOCK_SIZE; then
        HOW_MUCH_TRUNC=$(($LEN-$DWMBLOCKS_BLOCK_SIZE+3))
        SSID_LEN=$(echo $SSID | wc -m)
        TRUNC_TO=$(($SSID_LEN-$HOW_MUCH_TRUNC))
        SSID=$(echo $SSID | cut -c1-$TRUNC_TO)
        SSID=$(echo $SSID"...")
        SSID_IP="$GREEN($SIGNAL_STRENGTH) $IP @ $SSID$DEFAULT_COLOR"
    fi

fi

#Output
echo $SSID_IP
