#!/bin/bash

daemon=/home/fastpc/cruc_480/wownero/build/Linux/master/release/bin/wownerod
ip=127.0.0.1
servdir=$1
serverid=$2
rpcport=34568
network=wownero

#$daemon --rpc-bind-ip $ip --rpc-bind-port $port print_pl 
#| grep white | awk '{print $3}' | cut -f 1 -d ":"

white=$($daemon --rpc-bind-ip $ip --rpc-bind-port $port print_pl | grep white | awk '{print $3}' | cut -f 1 -d ":")
white_a=($white)

echo ${white_a[@]} > $servdir/$network.$serverid.iplist
