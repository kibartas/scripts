#!/bin/sh

SCRIPTS=/home/kibartas/scripts

printf "%s %s\n" $(cat $SCRIPTS/timer_name.txt) $(cat $SCRIPTS/timer.txt) >> $SCRIPTS/timer.log

echo 00:00:00 > $SCRIPTS/timer.txt

pkill -RTMIN+3 dwmblocks
