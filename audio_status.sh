#!/bin/sh

#Prep

extract() {
    INFO=$(amixer get "$1" | awk '{ if (NR==6) print $5 $6 }' | sed -E -e "s/\[//g" -e "s/\]/ /g")
}

# get volume in percentages and status [off/on]
extract "Master"; AUDIO_INFO=$INFO
AUDIO_STATUS=$(echo $AUDIO_INFO | cut -d\  -f2)
AUDIO_VOLUME=$(echo $AUDIO_INFO | cut -d\  -f1)
extract "Capture"; MIC_INFO=$INFO
MIC_STATUS=$(echo $MIC_INFO | cut -d\  -f2)
MIC_VOLUME=$(echo $MIC_INFO | cut -d\  -f1)

#Output
echo "$AUDIO_VOLUME $AUDIO_STATUS | Mic: $MIC_STATUS"
