#!/bin/sh

TIMER_NAME=/home/kibartas/scripts/timer_name.txt

BLUE='^c#00FFFF^'
WHITE='^c#FFFFFF^'

printf "%s" $BLUE > $TIMER_NAME
printf "%s" $WHITE >> $TIMER_NAME
pkill -RTMIN+3 dwmblocks

xev -root | awk -F'[ )]+' '/^KeyPress/{a[NR+2]} NR in a{print $8; fflush()}' | 
while IFS= read -r str; do
    case $str in
        Return ) 
            sed -i --posix "s/\^c#00FFFF\^//" $TIMER_NAME
            sed -i --posix "s/\^c#FFFFFF\^//" $TIMER_NAME
            pkill -RTMIN+3 dwmblocks
            exit 0 
            ;;
        BackSpace ) 
            if test $(wc -c $TIMER_NAME | cut -d\  -f1) -gt 20; then
                sed -i "s/\^c#FFFFFF\^//" $TIMER_NAME
                truncate -s-1 $TIMER_NAME
                printf "%s" $WHITE >> $TIMER_NAME
            fi
            ;;
        ? ) sed -i "s/\^c#FFFFFF\^//" $TIMER_NAME
            printf "%s" "$str" >> $TIMER_NAME 
            printf "%s" $WHITE >> $TIMER_NAME
            ;;
    esac 
    pkill -RTMIN+3 dwmblocks
done
