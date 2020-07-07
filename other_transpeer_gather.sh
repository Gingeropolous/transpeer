#!/bin/bash

ip=$1

# This script connects to other transpeers and aggregates their data into network specific files


# https://cmdlinetips.com/2018/04/how-to-loop-through-lines-in-a-file-in-bash/
# alt https://stackoverflow.com/questions/1521462/looping-through-the-content-of-a-file-in-bash
echo "We're in the other_transpeer_gather subscript"
echo $ip
wget $ip:18050/transpeer_hello.txt
if [[ "$?" == 0 ]]; then
	echo "File downloaded"
	if [[ `head -1 transpeer_hello.txt` == "TRANSPEER_PROTOCOL_1" ]]; then
		echo "Protocol match"
		tp_id=$(sed '3q;d' transpeer_hello.txt)
		wget $ip:18050/$tp_id.networks
		net_avail=`cat $tp_id.networks`
		for i in $net_avail ;
		do
			wget $ip:18050/$i
		done
	else
		echo "Protocol check failed"
	fi
else
	echo "File check failed"
fi
rm transpeer_hello.txt



