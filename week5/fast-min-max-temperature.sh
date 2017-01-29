#!/bin/bash

# go through all of the data in less than 10 seconds

max=0
min=1000
maxfile="none"
minfile="none"

find /tmp/lost24-lmap/ -type f -name "hp-temps.txt" |
xargs grep -H "PROCESSOR_ZONE" | (
 	while read -r file x tmp y; do
		celsius=${tmp%C*}
	        if [ "$max" -lt "$celsius" ]; then
			     max="$celsius"
			     maxfile="$file"
		fi
		if [ "$min" -gt "$celsius" ]; then
			min="$celsius"
			minfile="$file"
		fi
	done

	maxdate=${maxfile%/*}
	maxdate=${maxdate#*r/}
	mindate=${minfile%/*}
	mindate=${mindate#*r/}

	echo "maksimilämpötila: $max C aika: $maxdate"
	echo "minimilämpötila: $min C aika: $mindate"
)
