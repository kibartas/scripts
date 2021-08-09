#!/bin/sh

# DWMBLOCKS config information
DWMBLOCKS_BLOCK_SIZE=80
DWMBLOCKS_DELIMITER=5
DWMBLOCKS_BLOCK_SIZE=$(($DWMBLOCKS_BLOCK_SIZE-$DWMBLOCKS_DELIMITER))

DEFAULT_COLOR='^c#FFFFFF^'
RED='^c#FF0000^'
GREEN='^c#00FF00^'


ETH=$(ip route | grep default | grep enp2s0f1 | awk '{print $9}')
if test $ETH; then # Ethernet
    IP="$GREEN $ETH "
    echo "$IP$DEFAULT_COLOR"
else #Wireless
    SSID=$(iw wlp3s0 info | grep -e 'ssid' | cut -sf2- -d\ )
    IP="$(ip route | grep default | grep wlp3s0 | awk '{print $9}')"
    if test -z "$IP"; then 
        SSID_IP="$RED No connection $DEFAULT_COLOR" 
    else 
        SSID_IP="$GREEN $IP @ $SSID$DEFAULT_COLOR"
        LEN=$(echo $SSID_IP | wc -m)
        if test $LEN -ge $DWMBLOCKS_BLOCK_SIZE; then
            HOW_MUCH_TRUNC=$(($LEN-$DWMBLOCKS_BLOCK_SIZE+3))
            SSID_LEN=$(echo $SSID | wc -m)
            TRUNC_TO=$(($SSID_LEN-$HOW_MUCH_TRUNC))
            SSID=$(echo $SSID | cut -c1-$TRUNC_TO)
            SSID=$(echo $SSID"...")
            SSID_IP="$IP @ $SSID$DEFAULT_COLOR"
        fi
    fi
    echo $SSID_IP
fi


#Output
echo $SSID_IP
