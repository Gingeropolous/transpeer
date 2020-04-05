#!/bin/bash

#############
# This currently just runs the host server. 

# wget 192.168.1.38:8000/main.sh
# php -S 127.0.0.1:8000
#  sudo apt install php7.0-cli


# The transpeer protocol and software. Here we go!

# Make directories. Should totally check if they exist before but who cares. 
dir=~/files_transpeer
mkdir $dir
servdir=$dir/serv
mkdir $servdir
indir=$dir/in
mkdir $indir

rm $servdir/*
rm $indir/*

iptobind=192.168.1.38
port=18050

# Create a server ID for session
serverid=$RANDOM

# Create hello file
echo "44UW4sPKb4XbWHm8PXr6K8GQi7jUs9i7t2mTsjDn2zK7jYZwNERfoHaC1Yy4PYs1eTCZ9766hkB6RLUf1y95EvCQNpCZnuu" > $servdir/transpeer_hello.txt
echo $serverid >> $servdir/transpeer_hello.txt

cd $servdir
nohup php -S $iptobind:$port > $dir/http.log 2>&1 &
echo $! > $dir/save_pid.txt
# https://stackoverflow.com/questions/17385794/how-to-get-the-process-id-to-kill-a-nohup-process/17389526

echo "We just launched the http server on " $port

cd ~/transpeer

while true
do
echo "Just started the loop!"
# In here are individual scripts for individual p2p network nodes
# They can be treated like plugins

# Run these first to populate some iplists
networks/monero.sh $servdir $serverid
networks/wownero.sh $servdir $serverid
networks/aeon.sh $servdir $serverid


# Now create a listing file for peers that find us and want to know what we have

rm $servdir/$serverid.networks

#ls -1 $servdir/*.$serverid.iplist > $servdir/$serverid.networks
find $servdir/*.$serverid.iplist -printf "%f\n" > $servdir/$serverid.networks
# awk '{ print $9 }' > $servdir/$serverid.networks


# OK, now need a subroutine that will search for random IPs. 
# Also need to go through the existing peer lists and see if anyone is a transpeer

# ./findtranspeer.sh nohup blah dee blah


# https://medium.com/@petehouston/upload-files-with-curl-93064dcccc76
# curl -F 'fileX=@/path/to/fileX' -F 'fileY=@/path/to/fileY' ... http://localhost/upload



# OK, now we have ip lists to share with someone who finds us. 


sleep 60
done

kill -9 `cat $dir/save_pid.txt`
rm $dir/save_pid.txt

echo "the script ended"
