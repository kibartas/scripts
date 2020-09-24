#!/bin/sh

ELAPSED_SECS=0
ELAPSED_MINS=0
ELAPSED_HOURS=0
TIME_FILE='/home/kibartas/scripts/timer.txt'
if test -n "$(cat $TIME_FILE)"; then
    ELAPSED_SECS=$(cat $TIME_FILE | cut -d: -f3)
    if test "$(echo $ELAPSED_SECS | cut -c1)" = '0'; then
        ELAPSED_SECS=$(echo $ELAPSED_SECS | cut -c2)
    fi
    ELAPSED_MINS=$(cat $TIME_FILE | cut -d: -f2)
    if test "$(echo $ELAPSED_MINS | cut -c1)" = '0'; then
        ELAPSED_MINS=$(echo $ELAPSED_MINS | cut -c2)
    fi
    ELAPSED_HOURS=$(cat $TIME_FILE | cut -d: -f1)
    if test "$(echo $ELAPSED_HOURS | cut -c1)" = '0'; then
        ELAPSED_HOURS=$(echo $ELAPSED_HOURS | cut -c2)
    fi
fi
while true; do
    ELAPSED_SECS=$((ELAPSED_SECS+1))
    if test $ELAPSED_SECS -eq 60; then
        ELAPSED_MINS=$((ELAPSED_MINS+1))
        ELAPSED_SECS=0
    fi
    if test $ELAPSED_MINS -eq 60; then
        ELAPSED_HOURS=$((ELAPSED_HOURS+1))
        ELAPSED_MINS=0
    fi
    printf "%02d:%02d:%02d\n" $ELAPSED_HOURS $ELAPSED_MINS $ELAPSED_SECS | tee $TIME_FILE
    pkill -RTMIN+3 dwmblocks
    sleep 1
done
