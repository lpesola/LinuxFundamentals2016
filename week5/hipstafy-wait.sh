#!/bin/bash

hipstafolder="/home/kala/sdd/Kuvat/hipstafy-dropbox"

inotifywait -m -e create -e moved_to "$hipstafolder" | while read -r x y pic
do
 echo "$pic in $hipstafolder"
 ./hipstafy.sh $pic $hipstafolder
done


