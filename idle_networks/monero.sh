#!/bin/bash

monerod=monerod
daemon=127.0.0.1
servdir=$1
serverid=$2

white=$($monerod --rpc-bind-ip $daemon --rpc-bind-port 18081 print_pl | grep white | awk '{print $3}' | cut -f 1 -d ":")
white_a=($white)

echo ${white_a[@]} > $servdir/monero.$serverid.iplist
