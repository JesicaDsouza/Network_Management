#!/bin/bash
declare -a name
read -p "Enter hostnames : " name
for i in ${name[@]}
do
ping -c 1 $i &> /dev/null

if [ $? -ne 0 ]; then
	echo "`date`: ping failed, $i host is down!"
else
	echo "`date`: ping successful, $i host is up!"
fi
done