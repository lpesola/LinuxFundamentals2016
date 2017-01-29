#!/bin/bash
year=$(echo "$2" | cut -c 1-4)
month=$(echo "$2" | cut -c 6-7)

#find out all the lowest and highest processor temperatures for each day in month of the year

read_temps ()
{
	for dir in $(find -type d -name "$2*" | sort)
	do
		biggest_temp="0"
		lowest_temp="100"
		#iterate through the days
		for day in  $(find $dir -name "hp-temps.txt")
		do
		#get highest and lowest temp for one day
			current_temp=$(grep PROCESSOR_ZONE $day | cut -c 32-33)
				if [ $biggest_temp -lt $current_temp ]; then
					biggest_temp=$current_temp
				fi
				if [ $lowest_temp -gt $current_temp ]; then
					lowest_temp=$current_temp
				fi
		done
		# to get the date, remove everything from the path except for the 10 last characters
		echo $(echo $dir | sed -r 's/.*(.{10})/\1/') $biggest_temp $lowest_temp >> min-max-temp.dat
	done
}

# generate gnuplot script to use (jpeg: ukko's gnuplot doesn't have the option to use eps)
cat > hi-lo-month << _EndOfDoc_
set terminal jpeg
set style data linespoints
set xlabel "Date"
set ylabel "Temperatures"
set timefmt "%Y.%m.%d"
set yrange [ 0 : 30 ]
set xdata time
set format x "%d.%m.%Y"
set datafile separator " "
set title "Highest temperatures in $month of $year"
set xrange [ "$year.$month.01":"$year.$month.30" ]
_EndOfDoc_

while getopts "c:w:b:a:h" opt; do
	case $opt in
	# only lowest temps
		c)
		 read_temps
		 echo 'plot "min-max-temp.dat" using 1:3' >> hi-lo-month
		 gnuplot hi-lo-month > min-max-temps-$year-$month.jpeg
		 ;;
	# only highest temps
		w)
		read_temps
		echo 'plot "min-max-temp.dat" using 1:2' >> hi-lo-month
	     	gnuplot hi-lo-month > min-max-temps-$year-$month.jpeg
		;;
	# both
	   	b)
	     	 read_temps
		 echo 'plot "min-max-temp.dat" using 1:2, "min-max-temp.dat" using 1:3' >> hi-lo-month
		gnuplot hi-lo-month > min-max-temps-$year-$month.jpeg
		;;
	# use ascii instead of jpeg, in that case print both lines (assuming only one option at a time is specified)
		a)
		 read_temps
		 echo 'set terminal dumb' >> hi-lo-month
		 echo 'plot "min-max-temp.dat" using 1:2, "min-max-temp.dat" using 1:3' >> hi-lo-month
	     	 gnuplot hi-lo-month > min-max-temps-$year-$month.txt
		;;
 		h)
 		 echo "Usage: min-max-opts.sh -[cwbah] year.month \n\
				-c output lowest temperatures
			      	-w output highest temperatures
				-b output highest & lowest temperatures
				-a use ASCII instead of jpeg
				-h print this help"
				exit 1
		;;
	esac
done
