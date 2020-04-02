#!/bin/bash

# wget 192.168.1.38:8000/main.sh
# php -S 127.0.0.1:8000
#  sudo apt install php7.0-cli


# The transpeer protocol and software. Here we go!

# Make directories. Should totally check if they exist before but who cares. 
dir=~/files_transpeer
mkdir $dir
servdir=~/files_transpeer/serv
mkdir $servdir

iptobind=192.168.1.38
port=18050

cd $servdir
nohup php -S $iptobind:$port > $dir/http.log 2>&1 &
echo $! > $dir/save_pid.txt
# https://stackoverflow.com/questions/17385794/how-to-get-the-process-id-to-kill-a-nohup-process/17389526

cd $dir

while true
do
# In here are individual scripts for individual p2p network nodes
# They can be treated like plugins
networks/monero.sh $servdir
networks/bitcoin.sh
networks/wownero.sh


sleep 10
done

# This is the path for your monerod binary.
# monerod=monerod

# This is the ip of your local daemon. If you're not running an open node, 127.0.0.1 is fine.
daemon=192.168.1.170

echo $monerod
echo $daemon

###

echo "Check network white nodes for domains to add"

white=$($monerod --rpc-bind-ip $daemon print_pl | grep white | awk '{print $3}' | cut -f 1 -d ":")
white_a=($white)



for i in "${opennodes[@]}"
do
   : 
	echo "Checking ip: "$i
	l_hit="$(curl -X POST http://$daemon:18081/getheight -H 'Content-Type: application/json' | grep height | cut -f 2 -d : | cut -f 1 -d ,)"
	r_hit="$(curl -m 0.5 -X POST http://$i:18081/getheight -H 'Content-Type: application/json' | grep height | cut -f 2 -d : | cut -f 1 -d ,)"
	echo "Local Height: "$l_hit
	echo "Remote Height: "$r_hit
        mini=$(( $l_hit-10 ))
        echo "minimum is " $mini
        maxi=$(( $l_hit+10 ))
        echo "max is " $maxi
        if [[ "$r_hit" ==  "$l_hit"  ]] || [[ "$r_hit" > "$mini" && "$r_hit" < "$maxi" ]]
        then
        echo "################################# Daemon $i is good" 
        ### Time to write these good ips to a file of some sort!
        ### Apparently javascript needs some weird format in order to randomize, so I'll make two outputs
        echo $i >> open_nodes.txt
	let ctr=ctr+1
	else
	echo "$i is closed"
	fi
done


# http://stackoverflow.com/questions/16753876/javascript-button-to-pick-random-item-from-array
# http://www.javascriptkit.com/javatutors/randomorder.shtml


