#!/bin/bash

# NEed to treat this like the client to transpeers server, so should run alone

# check the servdir for iplists created by own daemons
# go through these lists looking for transpeers
# thats kind of useless though

# use wget to check the ip for a downloadable file. look for the hello file. then get listing file.
# parse the file for available files from the server
# download the individual files (store them in array and loop over array)

# Then we have a bunch of new iplist files. Store them in the servdir I guess?
# 

# Could also use trick of requesting a specific network when running this script. 
# And instead of a hello message, simply tries and downloads a file. If the file does not exist, it does not download


# Really this script can be broken apart / deleted, and instead can use other_transpeer_gather as called from a random IP shoved into it.
# For adding a new transpeer, simply need to check if the IP already exists in the other.transpeers file

#https://stackoverflow.com/questions/6482377/check-existence-of-input-argument-in-a-bash-shell-script

if [ $# -eq 0 ]
  then
	echo "PLease include argument for directory where data is stored"
	echo "./findtranspeer ~/in_directory, for example"
	exit
fi

indir=$1
cd $indir

# This will eventually be a loop that just checks random IPs
#while true
#do

#for i in {1..2..1}
#{
ip=192.168.1.38

~/transpeer/other_transpeer_gather.sh $ip

~/transpeer/aggregate_transpeer_data.sh

#}
#done

