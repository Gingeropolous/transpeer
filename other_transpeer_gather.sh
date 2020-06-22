#!/bin/bash

# This script connects to other transpeers and aggregates their data into network specific files


# https://cmdlinetips.com/2018/04/how-to-loop-through-lines-in-a-file-in-bash/
# alt https://stackoverflow.com/questions/1521462/looping-through-the-content-of-a-file-in-bash

all_lines=`cat $servdir/$server_id.othertrans`

mkdir $servdir/newag
cd $servdir/newag

for ip in $all_lines ; 
do
	echo $ip
	# gah i can't decide if this should be done in the original find transpeer loop. Fuckit just put it here. 
	wget $ip:18050/transpeer_hello.txt
	if [[ "$?" == 0 ]]; then
	head -1 transpeer_hello.txt 



done
