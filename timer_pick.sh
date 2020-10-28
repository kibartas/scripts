#!/bin/sh

SCRIPTS=/home/kibartas/scripts
TIMER_NAME=$SCRIPTS/timer_name.txt
TIMER_TXT=$SCRIPTS/timer.txt
TIMER_LOG=$SCRIPTS/timer.log
LINE_COUNT=$(wc -l $TIMER_LOG | cut -d\  -f1)
CURRENT_TIMER=$(printf "%s %s" $(cat $TIMER_NAME) $(cat $TIMER_TXT))
LINE_COUNTER=0

get_line() {
    LINE=$(awk -F\\n -v line=$LINE_COUNTER -v currentTimer="$CURRENT_TIMER" '{ if (FNR==line) print $1; else if (line==0) print currentTimer; }' $TIMER_LOG)
}

# Colors
GREEN='^c#00FF00^'
YELLOW='^c#FFFF00^'
WHITE='^c#FFFFFF^'

$SCRIPTS/timer_util.sh

get_line
echo $LINE

echo $GREEN$(echo $LINE | cut -d\  -f1) > $TIMER_NAME
echo $(echo $LINE | cut -d\  -f2)$WHITE > $TIMER_TXT
pkill -RTMIN+3 dwmblocks

#truncate -s0 $TIMER_NAME

xev -root | awk -F'[ )]+' '/^KeyPress/{a[NR+2]} NR in a{print $8; fflush()}' | 
while IFS= read -r str; do
    case $str in
        Down ) 
            if test $LINE_COUNTER -lt $LINE_COUNT; then
                LINE_COUNTER=$(($LINE_COUNTER+1)) 
            fi
            ;;
        Up ) 
            if test $LINE_COUNTER -gt 0; then
                LINE_COUNTER=$(($LINE_COUNTER-1))
            fi 
            ;;
        Return ) 
            if test $LINE_COUNTER -ne 0; then
                echo $CURRENT_TIMER >> $TIMER_LOG
            fi
            echo $LINE | cut -d\  -f1 > $TIMER_NAME
            echo $LINE | cut -d\  -f2 > $TIMER_TXT
            pkill -RTMIN+3 dwmblocks
            exit 0 
            ;;
    esac 
    get_line
    if test $LINE_COUNTER -eq 0; then
        COLOR=$GREEN
    else
        COLOR=$YELLOW
    fi
    echo $COLOR$(echo $LINE | cut -d\  -f1) > $TIMER_NAME
    echo $(echo $LINE | cut -d\  -f2)$WHITE > $TIMER_TXT
    pkill -RTMIN+3 dwmblocks
done
