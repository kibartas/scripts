#!/bin/sh

if test -z "$(ps -C timer_status.sh --no-heading)"; then
    /home/kibartas/scripts/timer_status.sh &
else
    pkill timer_status.sh
fi
