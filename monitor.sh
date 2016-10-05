#!/bin/bash
#Current BEER NAME
beer1name=""
beer2name="kwik-e-mart"

#Directories
dir1="/home/pi/fermenter"

#Current Date and Time
today=$(date +"%F-%H:%M")

# First part is for the BEER 1 Temperature
tc1=$(cat /sys/bus/w1/devices/28-800000035ddb/w1_slave | grep  -E -o ".{0,0}t=.{0,5}" | cut -c 3-)
tc=$(echo "scale=1;(($tc1 / 1000))" |bc)
tf=$(echo "scale=1;((9/5) * $tc) + 32" |bc)

#Seocnd Part is for the BEER 2 Temperature or AMBIENT
tc2=$(cat /sys/bus/w1/devices/28-800000013c31/w1_slave | grep  -E -o ".{0,0}t=.{0,5}" | cut -c 3-)
tcc=$(echo "scale=1;(($tc2 / 1000))" |bc)
tff=$(echo "scale=1;((9/5) * $tcc) + 32" |bc)

beer1=$tf
beer2=$tff

#echo $today
#echo "Beer 1 Temp is: $beer1"
#echo "Beer 2 Temp is: $beer2"

if [ -z "$beer1name" ]
then
	:
else
	#mkdir -p /home/pi/beer/$beer1name
	#dir1="/home/pi/fermenter"
	echo "$today,$beer1" >> $dir1/$beer1name.csv
	grep -q "DATE,TEMPERATURE" $dir1/$beer1name.csv || sed -i '1s/^/DATE,TEMPERATURE\n/' $dir1/$beer1name.csv
fi

if [ -z "$beer2name" ]
then
        :
else
	#mkdir -p /home/pi/beer/$beer2name
        #dir2="/home/pi/fermenter"
        echo "$today,$beer2" >> $dir1/$beer2name.csv
	grep -q "DATE,TEMPERATURE" $dir1/$beer2name.csv || sed -i '1s/^/DATE,TEMPERATURE\n/' $dir1/$beer2name.csv
fi

