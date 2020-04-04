#!/bin/bash

daemon=/home/fastpc/cruc_480/aeon/build/Linux/master/release/bin/aeond
ip=127.0.0.1
servdir=$1
serverid=$2
rpcport=11181

white=$($daemon --rpc-bind-ip $ip --rpc-bind-port $port print_pl | grep white | awk '{print $3}' | cut -f 1 -d ":")
white_a=($white)

echo ${white_a[@]} > $servdir/aeon.$serverid.iplist
