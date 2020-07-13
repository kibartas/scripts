#!/bin/sh

status=''

POWER_SUPPLY=/sys/class/power_supply/BAT1
# white
DEFAULT_COLOR='^c#FFFFFF^'
RED='^c#FF0000^'
BLACK='^c#000000^'
GREEN='^c#00FF00^'
LINE_COLOR=$DEFAULT_COLOR
NETWORK_COLOR=$DEFAULT_COLOR
BATTERY_COLOR=$DEFAULT_COLOR

keyboard_info() {
    LAYOUT=$(~/builds/xkblayout-state/xkblayout-state print "%s") 
}

network_info() {
    SSID_IP=$(iw wlp3s0 info | grep -e 'ssid' -e 'addr' | sed -Ee 's/(addr|ssid)/ /')
    IP=$(ip route get 1 | awk '{print $7;exit}')
    SSID=$(echo $SSID_IP | cut -sf2- -d\ )
    SIGNAL_STRENGTH=0.$(awk 'NR==3 {print int($3 / 10)}' /proc/net/wireless)

    if test -z $IP; then
        SSID_IP="No connection" 
        NETWORK_COLOR=$RED
    else
        SSID_IP="($SIGNAL_STRENGTH) $IP @ $SSID"
        NETWORK_COLOR=$GREEN
    fi
}

battery_info() {
    BATTERY_CAPACITY=$(cat $POWER_SUPPLY/capacity)
    BATTERY_STATUS=$(cat $POWER_SUPPLY/status)

    if test $BATTERY_CAPACITY -le 20 -a $BATTERY_STATUS = "Discharging"; then
        BATTERY_COLOR=$RED
        BATTERY_STATUS="▼"
    elif test $BATTERY_STATUS = "Discharging"; then
        BATTERY_STATUS="▼"
        BATTERY_COLOR=$DEFAULT_COLOR
    elif test $BATTERY_STATUS = "Charging"; then
        BATTERY_STATUS="▲"
        BATTERY_COLOR=$GREEN
    elif test $BATTERY_STATUS = "Full"; then
        BATTERY_STATUS="Full"
        BATTERY_COLOR=$GREEN
    fi
}

partition_info() {
    SPACE_LEFT=$(df -h | grep '/$' | awk '{print $4, " available. Size: " $2}')
}

audio_info() {
    # get volume in percentages and status [off/on]
    AUDIO_INFO=$(amixer get 'Master',0 | grep -m1 '%' | grep -Eo '\[.*\]' | sed 's/[][]//g')
    AUDIO_STATUS=$(echo $AUDIO_INFO | awk '{print $2}')
    AUDIO_VOLUME=$(echo $AUDIO_INFO | awk '{print $1}')

    if test $AUDIO_STATUS = 'on'; then
        AUDIO_STATUS="On"
    elif test $AUDIO_STATUS = 'off'; then
        AUDIO_STATUS="Off"
    fi
}

backlight_info() {
    BACKLIGHT=$(enlighten | grep -Eo '[0-9]{1,3}%')
}

while true; do

    battery_info
    network_info
    partition_info
    audio_info
    backlight_info
    keyboard_info

    status="$LINE_COLOR Lang: $LAYOUT ^d^ | $LINE_COLOR Sun: $BACKLIGHT ^d^ | $LINE_COLOR Audio: $AUDIO_VOLUME $AUDIO_STATUS ^d^| $LINE_COLOR $SPACE_LEFT ^d^| $NETWORK_COLOR $SSID_IP ^d^ | $BATTERY_COLOR$BATTERY_CAPACITY% $BATTERY_STATUS ^d^ | $LINE_COLOR $(date +"%a %F %T") ^d^"

    echo $status

    xsetroot -name "$(echo $status)"
done
