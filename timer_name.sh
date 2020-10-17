#!/bin/sh

TIMER_NAME=/home/kibartas/scripts/timer_name.txt

truncate -s0 $TIMER_NAME
xev -root | awk -F'[ )]+' '/^KeyPress/{a[NR+2]} NR in a{print $8; fflush()}' | 
while IFS= read -r str; do
    case $str in
        Return ) exit 0 ;;
        BackSpace ) truncate -s-1 $TIMER_NAME ;;
        ? ) printf "%s" "$str" >> $TIMER_NAME ;;
    esac 
    pkill -RTMIN+3 dwmblocks
done
