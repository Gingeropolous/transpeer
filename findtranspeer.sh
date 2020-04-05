#!/bin/bash

# check the servdir for iplists created by own daemons
# go through these lists looking for transpeers
# thats kind of useless though

# use wget to check the ip for a downloadable file. look for the hello file. then get listing file.
# parse the file for available files from the server
# download the individual files (store them in array and loop over array)

# Then we have a bunch of new iplist files. Store them in the servdir I guess?
# 

indir=$1

while true
do

for i in {1..255..1}

cd $indir

wget 192.168.1.$i:18050/transpeer_hello.txt
if [[ "$?" == 0 ]]; then
head -1 transpeer_hello.txt 




else
    echo "Success"
fi

done

