#!/bin/bash
# blopr

#############
# This currently just runs the host server. 

# wget 192.168.1.38:8000/main.sh
# php -S 127.0.0.1:8000
#  sudo apt install php7.0-cli


# The transpeer protocol and software. Here we go!

# Create a server ID for session
server_id=$RANDOM

# Make directories. Should totally check if they exist before but who cares. 
dir=~/files_transpeer_$server_id
mkdir $dir
servdir=$dir/serv
mkdir $servdir
indir=$dir/in
mkdir $indir

rm $servdir/*
rm $indir/*

iptobind=192.168.1.38
port=18050

# Create hello file
# Use monero address as identity
echo "TRANSPEER_PROTOCOL_1" > $servdir/transpeer_hello_base.txt # Using this base file allows for future dumping of more shit into the hello file. For now, we'll just loop through shit and download multiple things. 
echo "44UW4sPKb4XbWHm8PXr6K8GQi7jUs9i7t2mTsjDn2zK7jYZwNERfoHaC1Yy4PYs1eTCZ9766hkB6RLUf1y95EvCQNpCZnuu" >> $servdir/transpeer_hello_base.txt
echo $server_id >> $servdir/transpeer_hello_base.txt

cp $servdir/transpeer_hello_base.txt $servdir/transpeer_hello.txt

cd $servdir
nohup php -S $iptobind:$port > $dir/http.log 2>&1 &
echo $! > $dir/save_pid.txt
# https://stackoverflow.com/questions/17385794/how-to-get-the-process-id-to-kill-a-nohup-process/17389526

echo "We just launched the http server on " $port

# Replace with variable at some point but who cares
cd ~/transpeer

# This subroutine scans the existing IP lists for other transpeers. This effectively runs on nothing until the main loop starts
# script is idle for now. Output of script is file
# $servdir/$server_id.othertrans
# ./scan_for_transpeers.sh $servdir $server_id &


############### main loop ##############################33
while true
do
echo "Just started the loop!"
# In here are individual scripts for individual p2p network nodes
# They can be treated like plugins

# Run these first to populate some iplists
# These create $servdir/$network.$serverid.iplist
#
# networks/monero.sh $servdir $serverid
networks/wownero.sh $servdir $server_id
networks/aeon.sh $servdir $server_id


# Now create a listing file for peers that find us and want to know what we have

rm $servdir/$server_id.networks

#ls -1 $servdir/*.$serverid.iplist > $servdir/$serverid.networks
find $servdir/*.$server_id.iplist -printf "%f\n" > $servdir/$server_id.networks
# awk '{ print $9 }' > $servdir/$serverid.networks

# Just need an other_transpeers file of IPs with their included network
# Then the find transpeer can just look through that file for 

# Possibly change name to peerlink

# OK, now need a subroutine that will search for random IPs. 
# Also need to go through the existing peer lists and see if anyone is a transpeer

# ./findtranspeer.sh nohup blah dee blah

# Now we need something to get info from the peers we have
# OK, the main thing this loop is doing is creating data that can be served to other transpeers.
# So, first we have the IP lists of the nodes that are running local. Those can be found in $servdir/$server_id.networks,
# and the IP lists themselves are found in <network_id>.$server_id.iplist
# so currently a client connecting would first get the hello file to establish a connection
# it would then download the $server_id.networks file
# after parsing that, it would then download the <network_id>.$server_id.iplist
# So, we want this server to always be providing the most up to date data. 
# As an aside, if I could use actual code, could probably hack the torrent p2p system to do this instead of re-inventing the wheel.... but BASH!
# OK, so this server is already serving the most up to date IP list from its current networks
# The question becomes how to server other transpeers information. Do we just include the transpeer IPs and let the client then connect to them?
# Or do we download their data and host it ourselves? I think the second, because a transpeer may go offline, but its connected peers may not. 

#./other_transpeer_gather.sh $servdir $server_id
# returns 


# https://medium.com/@petehouston/upload-files-with-curl-93064dcccc76
# curl -F 'fileX=@/path/to/fileX' -F 'fileY=@/path/to/fileY' ... http://localhost/upload



# OK, now we have ip lists to share with someone who finds us. 


sleep 60
done

kill -9 `cat $dir/save_pid.txt`
rm $dir/save_pid.txt

echo "the script ended"
