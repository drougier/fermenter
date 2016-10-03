#!/bin/bash
# First part is for the BEER 1 Temperature
tc1=$(cat /sys/bus/w1/devices/28-800000035ddb/w1_slave | grep  -E -o ".{0,0}t=.{0,5}" | cut -c 3-)
tc=$(echo "scale=1;(($tc1 / 1000))" |bc)
tf=$(echo "scale=1;((9/5) * $tc) + 32" |bc)

#Seocnd Part is for the BEER 2 Temperature or AMBIENT
tc2=$(cat /sys/bus/w1/devices/28-800000035ddb/w1_slave | grep  -E -o ".{0,0}t=.{0,5}" | cut -c 3-)
tcc=$(echo "scale=1;(($tc1 / 1000))" |bc)
tff=$(echo "scale=1;((9/5) * $tc) + 32" |bc)

beer1=$tf
beer2=$tff

echo "Beer 1 Temp is: $beer1"
echo "Beer 2 (or Ambient) Temp is: $beer2"
