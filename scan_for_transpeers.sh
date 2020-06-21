#!/bin/bash

# So this thing goes through the IP lists that are available from the primary p2p networks operational on the node, searching for other transpeers

servdir=$1
server_id=$2

# gotta get all files with this exension, and cat them all into one file, and then loop through each IP trying to find a transpeer

rm $servdir/allips.txt

cat $servdir/*.$server_id.iplist > $servdir/allips.txt

# So yeah, then there's a loop that goes through that one at a time (or more), scanning ports for transpeer connections. 

# fuck, will at some point need to create a format for support flags. 
# Instead of scanning, could also check from the networks that its currently using whether the networks use support flags. Well, those networks by definition are transpeer networks. So perhaps not necessary. 

# This script is put on hold, as it is silly to test. 

final file is called $servdir/$server_id.othertrans
