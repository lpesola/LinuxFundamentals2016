#!/bin/bash

if ! [[ $1 =~ ^[0-9]+$ ]]; 
 then
 echo "please provide a positive integer"
 exit
fi

for (( c=1; c<=$1; c++ ))
 do echo $RANDOM " " $RANDOM
done
