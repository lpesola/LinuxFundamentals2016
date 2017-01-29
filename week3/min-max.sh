#!/bin/bash

# go through all of the data in less than 10 seconds 
# (data: lost24/monitor/Y.m.d/time)
# - and find out largest and smallest value!
# print them as you run into them

#2011.10.21

max=0
min=1000
maxfile="none"
minfile="none"

find lost24 -type f -name "hp-temps.txt" |
xargs grep -H "PROCESSOR_ZONE" | (
 while read -r file x tmp y; do
    celsius=${tmp%C*}
    if [ "$max" -lt "$celsius" ]; then
     max="$celsius"
     maxfile="$file"
#     echo "uusi max $max"
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
                                                      
