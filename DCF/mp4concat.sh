#!/bin/bash

# $1 -- extension, like MP4
# $2 -- output file name

echo Extension: $1
echo Src: $2
echo Output: $3

echo Files:
find . -name \*.$1 -printf "file '$PWD/%p'\n" | sort


# ffmpeg -f concat -i <(find $2 -name "*.$1" -printf "file '$PWD/%p'\n" | sort) -c copy $3