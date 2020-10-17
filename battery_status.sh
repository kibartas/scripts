#!/bin/sh

#Prep
POWER_SUPPLY=/sys/class/power_supply/BAT1
BATTERY_CAPACITY=$(cat $POWER_SUPPLY/capacity)
BATTERY_STATUS=$(cat $POWER_SUPPLY/status)
DEFAULT_COLOR='^c#FFFFFF^'
RED='^c#FF0000^'
GREEN='^c#00FF00^'
LINE_COLOR=$DEFAULT_COLOR
NETWORK_COLOR=$DEFAULT_COLOR
BATTERY_COLOR=$DEFAULT_COLOR

# I've added an acpi rule for when the charger gets plugged/unplugged it should a signal to dwmblocks. This sleep timer is here because this script gets run instantly when I plug/unplug my charger. The problem with instant run is that battery status doesn't change instantly. It changes in a bit more than a second
sleep 2

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

#Output
echo "$BATTERY_COLOR$BATTERY_CAPACITY% $BATTERY_STATUS$DEFAULT_COLOR"
