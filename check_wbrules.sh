#!/bin/bash

PATH=$PATH:/usr/bin:/usr/sbin

PREV_UPTIME_FILE=/run/wb-dw-prev-uptime

# read uptime field in wb-rules system device
UPTIME=`mosquitto_sub -C 1 -t "/devices/system/controls/Current uptime" | head -1`

# check if it has changed
if [ -f $PREV_UPTIME_FILE ]; then
    PREV=`cat $PREV_UPTIME_FILE`
    if [ "$PREV" == "$UPTIME" ]; then
        echo "wb-rules check failed, reload wb-rules"
        service wb-rules restart
    fi
fi

# save new uptime
echo $UPTIME > $PREV_UPTIME_FILE
