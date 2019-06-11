#!/bin/bash

if [ $# -ne 2 ]; then
  echo "2 argument is required."
  exit 1
fi

infile=$1
char=$2
workdir=$(dirname "$infile")
filename=$(basename "$infile")
name=${filename%.*}
ext=${filename##*.}
workprefix="${workdir%/}/${name}"

# Get picture width
width=$(identify -format "%w" $infile)

# Create rectangle
convert -draw 'fill #0000ff fill-opacity 0.6 rectangle 0,0 '$width',150' $infile "${workprefix}_rectangle.${ext}"

# Add character
convert -font Arial -pointsize 100 -gravity north -annotate 0 $char -fill white "${workprefix}_rectangle.${ext}" "${workprefix}_output.${ext}"
