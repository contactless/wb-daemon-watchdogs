#!/bin/bash

PATH=$PATH:/usr/bin:/usr/sbin

REPLY_FILE=/run/wb-dw-confed-reply

# send RPC request to confed
RANDOM_ID=`cat /dev/urandom | tr -dc "[:alpha:]" | head -c 8`

TOPIC="/rpc/v1/confed/Editor/List/$RANDOM_ID"

# run subscriber
timeout 10 mosquitto_sub -t "$TOPIC/reply" -C 1 > $REPLY_FILE & PID=$!

# wait for mosquitto_sub to establish (dirty, but whould work)
sleep 3

# publish message
mosquitto_pub -t $TOPIC -m '{"id":1,"params":{}}'

# wait for subscriber
wait $PID

# check if reply is not empty
if [ ! -s $REPLY_FILE ] ; then
    echo "wb-mqtt-confed check failed, reload wb-mqtt-confed"
    service wb-mqtt-confed restart
fi
