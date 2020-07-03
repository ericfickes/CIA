#!/bin/zsh
#	@usage:
#	chmod 755 dump.sh 
#	./dump.sh 
#	
#	MAKE OUT FILE NAMEs
SRC_FLDR="/Volumes/Untitled/DCIM/100GOPRO/";
OUT_FLDR="/Users/fickes/Desktop/_GOPRO7_"$(date +%s);
OUT_FILE="MasterOut_"$(date +%s)".MP4";
# echo $OUT_FILE;

echo "[DUMP]";
	#	default untitled mini SD card w/GoPro content
	#	rsync -av /Volumes/Untitled/DCIM/100GOPRO/*.*4 /Users/fickes/Desktop/FIX_GOPRO_OUT/
	rsync -av $SRC_FLDR*.MP4 $OUT_FLDR;

#	TODO >> .WAV support


# UPPERCASIFY
#	for f in /Users/fickes/Desktop/FIX_GOPRO_OUT/*.*4; 
#		do mv "$f" "${f%.*}.MP4"; 
#	done




echo "[CONCAT]";
	#	merge MP4s into one master
	# ffmpeg -i /Volumes/Untitled/DCIM/100GOPRO/*.MP4  -c:a copy -c:v copy $OUT_FILE
	#	ffmpeg -r 60 -f image2 -pattern_type glob -i "/Volumes/Untitled/DCIM/100GOPRO/*?MP4" -vcodec libx264 -crf 20 -pix_fmt yuv420p output60.mp4
#	ffmpeg -f concat -i /Users/fickes/Desktop/FIX_GOPRO_OUT/*.MP4 -c copy $OUT_FILE;

# shopt -s globstar
# for file in ./**/*.mp3; do
#   some command "$file"
# done

#	STEP1
#	SEE:	https://gist.github.com/josby/3643defc43c484315439f31a0c6ecddd
#	GOPRO MP4s must be sorted by Date Modified in order to concat in order!!!
#	Sorting by name causes some glithcy discontinuities

#	IPSO FACTO -> BASH PITFALL 1 -- http://mywiki.wooledge.org/BashPitfalls#for_f_in_.24.28ls_.2A.mp3.29
#	It freaking works
	ffmpeg -f concat -safe 0 -i <(for f in `ls -1tr $OUT_FLDR/*.MP4`; do echo "file '$f'"; done)-crf 24 -c copy $OUT_FLDR/$OUT_FILE;
#	$PWD/

#	STEP2

#	$ cat mylist.txt
#	file '/path/to/file1'
#	file '/path/to/file2'
#	file '/path/to/file3'

#	$ ffmpeg -f concat -safe 0 -i mylist.txt -c copy output.mp4

echo "[FORMAT]";
#	WIPE THE DISK
diskutil eraseDisk ExFAT Untitled /dev/disk2
