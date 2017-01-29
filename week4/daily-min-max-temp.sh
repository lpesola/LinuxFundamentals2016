

#!/bin/bash
# Modify the scripts so that also minimum temp is printed
# for each day in 2011.11
 # iterate through all times, pick the one with the highest processor temperature
 # print date and temperature in a file
 # call gnuplot script for that file to create a plot with a title and labels for both axes,
 # linespoint format

 # find all days in 11/2011
for dir in $(find lost24 -type d -name 2011.11.* | sort)
	do
		biggest_temp="0"
		lowest_temp="100"
		#iterate through the days
		for day in  $(find $dir -name "hp-temps.txt")
			do
			#get highest and lowest temp for the day
				current_temp=$(grep PROCESSOR_ZONE $day | cut -c 32-33)
					if [ $biggest_temp -lt $current_temp ]; then
						biggest_temp=$current_temp
					fi
					if [ $lowest_temp -gt $current_temp ]; then
						echo "low " $lowest_temp
						echo "current " $current_temp
						lowest_temp=$current_temp
					fi
			done
			# to get the date, remove everything from the path except for the 10 last characters
			echo $(echo $dir | sed -r 's/.*(.{10})/\1/') $biggest_temp $lowest_temp >> min-max-temp.dat
	done

# hi-lo-temp-plot gnuplot script automatically creates the desired file
# (in jpeg: ukko cluster's gnuplot doesn't have the option to use eps)
gnuplot hi-lo-temp-plot

