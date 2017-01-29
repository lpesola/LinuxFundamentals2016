#!/bin/sh

inputfile="$2"/"$1"
prefix=${1%.jpg}
postfix=${1#*.}
outputfile="$2"/hipstafied/"$prefix"-hipstah."$postfix"
convert -sepia-tone 60% +polaroid $inputfile $outputfile
