#!/bin/bash                                                                                                                                                                                                                                                                  
for pic in $(ls -1 $1 | grep .jpg)
	do
		inputfile=$pic
		prefix=${inputfile%.jpg}
		outputfile=$1/$prefix-hipstah.jpg
		convert -sepia-tone 60% +polaroid $inputfile $outputfile
	done
