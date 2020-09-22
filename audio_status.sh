#!/bin/sh

#Prep

# get volume in percentages and status [off/on]
AUDIO_INFO=$(amixer get 'Master',0 | grep -m1 '%' | grep -Eo '\[.*\]' | sed 's/[][]//g')
AUDIO_STATUS=$(echo $AUDIO_INFO | awk '{print $2}')
AUDIO_VOLUME=$(echo $AUDIO_INFO | awk '{print $1}')

if test $AUDIO_STATUS = 'on'; then
    AUDIO_STATUS="On"
elif test $AUDIO_STATUS = 'off'; then
    AUDIO_STATUS="Off"
fi

#Output
echo "$AUDIO_VOLUME $AUDIO_STATUS"
