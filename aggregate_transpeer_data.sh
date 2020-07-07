#!/bin/bash

# This is dangling, needs context. Was ppulled from gather transper data scipr

cat *.networks > networks.all

cut -f 1 -d "." networks.all | sort | uniq > networks.uniq

echo "This is the data from other transpeers"
cat $servdir/newag/networks.uniq

networks_uniq=`cat networks.uniq`
for i in $networks_uniq ;
do
cat $i.*.iplist > $i.second
done


