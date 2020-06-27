#!/bin/zsh
#	@usage:
#	chmod 755 dumpMax.sh 
#	./dumpMax.sh 
#	
#	MAKE OUT FILE NAMEs
#OUT_FILE="MasterOut_"$(date +%s)".MP4";
SRC_FLDR="/Volumes/Untitled/DCIM/100GOPRO/";
OUT_FLDR="/Users/fickes/Desktop/_GOPROMAX_"$(date +%s);
echo $OUT_FILE;

echo "[DUMP]";
	#	default untitled mini SD card w/GoPro content
	#	rsync -av /Volumes/Untitled/DCIM/100GOPRO/*.*4 /Users/fickes/Desktop/FIX_GOPRO_OUT/
	rsync -av $SRC_FLDR*.360 $OUT_FLDR;

#	TODO >> MO BETA' 360 WORKFLOW

#	.360 need to be handled in their app
#	or reframed in AE/PR via GoPro FX Reframe 
# 	see: https://community.gopro.com/t5/en/GoPro-FX-Reframe/ta-p/412890#

echo "Until you have a good .360 footy workflow, this script only copies the SD.  There is no formatting ATM."

# echo "[FORMAT]";
#	WIPE THE DISK
# diskutil eraseDisk ExFAT Untitled /dev/disk2
