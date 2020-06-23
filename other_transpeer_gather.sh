#!/bin/bash

# This script connects to other transpeers and aggregates their data into network specific files


# https://cmdlinetips.com/2018/04/how-to-loop-through-lines-in-a-file-in-bash/
# alt https://stackoverflow.com/questions/1521462/looping-through-the-content-of-a-file-in-bash

all_lines=`cat $servdir/$server_id.othertrans`

mkdir $servdir/newag
cd $servdir/newag

for ip in $all_lines ;  # could take this out of the loop and make this script so that ips are thrown into it from a higher routine
do
	echo $ip
	wget $ip:18050/transpeer_hello.txt
	if [[ "$?" == 0 ]]; then
	tp_id=$(sed '3q;d' transpeer_hello.txt)
	wget $ip:18050/$tp_id.networks
	net_avail=`cat $tp_id.networks`
	for i in $net_avail ;
	do
		wget $ip:18050/$i
	done
fi
rm transpeer_hello.txt
done

# This aggregation might be moved to a subroutine to make the above capable of being looped from a higher routine

cat *.networks > networks.all
cut -f 1 -d "." networks.all | sort | uniq > networks.uniq

networks_uniq=`cat networks.uniq`
for i in $networks_uniq ;
do
cat $i.*.iplist > $i.second
done


