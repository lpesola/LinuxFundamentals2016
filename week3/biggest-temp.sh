#!/bin/bash

# Write a bash script that finds the file (and temperature) which contains 
# the maximum processor temperature from November, 2011


curent_file="none"
biggest_temp="0"
for file in $(find -path "*/2011.11*/hp-temps.txt")
	do
		 current_temp=$(grep PROCESSOR_ZONE $file | cut -c 32-33)
		 if [ $biggest_temp -lt $current_temp ]; then
			 current_file=$file
			 biggest_temp=$current_temp
		 fi
	done

echo "biggest temperature:" $biggest_temp
echo "in file: " $current_file

