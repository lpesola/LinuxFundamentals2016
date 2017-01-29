#!/bin/bas

if ! [[ $1 =~ ^[0-9]+$ ]]; 
 then
 echo "please provide a positive integer"
 exit
fi

head -9 shortcat.txt
for (( c=1; c<=$1; c++ ))
 do echo "  |       |"
done
tail -6 shortcat.txt
