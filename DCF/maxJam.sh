#!/bin/zsh
#	@usage:
#	chmod 755 maxJam.sh 
#	./maxJam.sh 


# First arg should be Source MP4 folder with a trailing SLASH/
#	For the time being we're ONLY dealing with MP4s from GoPro 7 & MAX
SRC_FLDR=$1;




# UPPERCASIFY mp4s just in case
echo "\n -------------------------------------------------------------------------------";
echo "UPPERCASIFY mp4s in $SRC_FLDR";
echo "\n -------------------------------------------------------------------------------";
	for f in $SRC_FLDR*.*4; 
		do mv "$f" "${f%.*}.MP4"; 
	done



# # 1.	Make input.txt
echo "\n -------------------------------------------------------------------------------";
echo "Make input.txt in $SRC_FLDR. ( remember SORT impacts assemblage )";
echo "\n -------------------------------------------------------------------------------";
	#	DON'T FORGET TO CONFIRM FILE SORT IN input.txt
	for f in `ls -1tr $SRC_FLDR*.MP4`; do echo "file '$f'" >> $SRC_FLDR"input.txt"	; done
	#echo "Check for input.txt in $SRC_FLDR";


echo "\n -------------------------------------------------------------------------------";
# # 2.	Concat MP4s
echo "Do the mashed potato in $SRC_FLDR";
	ffmpeg -f concat -safe 0 -i $SRC_FLDR"input.txt" -c copy $SRC_FLDR"MaxHeadroom.mp4";
echo "\n -------------------------------------------------------------------------------";


OUT_FILE="MaxBlaster_"$(date +%s)".MP4";


# SHRINK & 360
# #	for f in `ls -1`; do ffmpeg -i $f -vcodec h264 -acodec mp3 _$f; done
# <(for f in `ls -1tr $SRC_FLDR/*.MP4`; do ffmpeg -i $f -vcodec h264 -acodec mp3 $SML_FLDR$f; done);
# for f in `ls -1t $SRC_FLDR*.MP4`; do ffmpeg -i $f -vcodec h264 -acodec mp3 $SML_FLDR$f; done);
echo "\n -------------------------------------------------------------------------------";
echo $SRC_FLDR+"MaxHeadroom.mp4 down to $OUT_FILE down"
echo "\n -------------------------------------------------------------------------------";



# TODO: look into what each of these filters do to 360 footy
# Convert equirectangular video to cubemap with 3x2 layout and 1% padding using bicubic interpolation:
	# ffmpeg -i input.mkv -vf v360=e:c3x2:cubic:out_pad=0.01 output.mkv
# Extract back view of Equi-Angular Cubemap:
	# ffmpeg -i input.mkv -vf v360=eac:flat:yaw=180 output.mkv
# Convert transposed and horizontally flipped Equi-Angular Cubemap in side-by-side stereo format to equirectangular top-bottom stereo format:
	# v360=eac:equirect:in_stereo=sbs:in_trans=1:ih_flip=1:out_stereo=tb

	# ffmpeg -i $SRC_FLDR"MaxHeadroom.mp4" -crf 45 -vcodec h264 -acodec mp3 -vf v360=e:e:yaw=0:pitch=0:roll=0 $SRC_FLDR$OUT_FILE
	ffmpeg -i $SRC_FLDR"MaxHeadroom.mp4" -crf 24  -vf v360=e:e:yaw=0:pitch=0:roll=0 $SRC_FLDR$OUT_FILE


echo "\n -------------------------------------------------------------------------------";
echo " CLEANUP ";
echo "\n -------------------------------------------------------------------------------";

	# CLEANUP
	rm $SRC_FLDR"MaxHeadroom.mp4";
 	rm $SRC_FLDR"input.txt"

# # 5.	Inject metadata ( GUI tool )
echo "\n -------------------------------------------------------------------------------";
echo "Remember to use Spatial Media Metadata Injector open $OUT_FILE, check the box 'My video is spherical (3D)', and press 'Inject metadata'. You can now save the metadata-injected file, by the default name result_injected.mp4 . Congratulations, you have successfully reoriented the default viewing angle of your 360 spherical video file.";
echo "\n -------------------------------------------------------------------------------";









# #	LEGACY STUFFS



# Launch GoPro Player from Terminal
# /Applications/GoPro\ Player.app/Contents/MacOS/GoPro\ Player

# # #	MAKE OUT FILE NAMEs
# # OUT_FILE="MasterOut_"$(date +%s)".MP4";
# # SRC_FLDR="/Users/fickes/Desktop/_MAXOUT/";
# # OUT_FLDR="/Users/fickes/Desktop/_MAXOUT_$(date +%s)/";
# # BAK_FLDR="/Volumes/BACKUP/_GOPROMAX_/_MAXOUT_$(date +%s)/";

# #	TODO: convert these to input params so you don't have to hard
# #	code paths

# #	GoPro Batch Export 360 > MP4s
# #	Run this script

# #	JamMax $src_folder
# SRC_FLDR = $1;
# SML_FLDR = "$1/smaller/";


# # 1.	Make input.txt
# printf "file '%s'\n" $SRC_FLDR*.mp4 | sort -V > $SRC_FLDRinput.txt

# # 2. FFMPEG COPY ( TO SHRINK ) EACH MP4
# #	for f in `ls -1`; do ffmpeg -i $f -vcodec h264 -acodec mp3 _$f; done
# <(for f in `ls -1tr $SRC_FLDR/*.MP4`; do ffmpeg -i $f -vcodec h264 -acodec mp3 $SML_FLDR$f; done);

# # 2.	Concat MP4s
# ffmpeg -f concat -i $SRC_FLDRinput.txt -c copy $SML_FLDRconcatenated.mp4

# # 3.	re-orient 360
# # TODO: find the sweet yaw|pitch|roll settings for that 360 bubble look
# ffmpeg -i $SML_FLDRconcatenated.mp4 -vf v360=e:e:yaw=60:pitch=0:roll=0 $SML_FLDRresult.mp4

# # 4.	Inject metadata ( GUI tool )
# echo "Remember to use Spatial Media Metadata Injector open result.mp4 , check the box "My video is spherical (3D)", and press "Inject metadata". You can now save the metadata-injected file, by the default name result_injected.mp4 . Congratulations, you have successfully reoriented the default viewing angle of your 360 spherical video file."



# # echo $OUT_FILE;

# # echo "[DUMP]";
# # 	#	default untitled mini SD card w/GoPro content
# # 	#	rsync -av /Volumes/Untitled/DCIM/100GOPRO/*.*4 /Users/fickes/Desktop/FIX_GOPRO_OUT/
# # 	rsync -av $SRC_FLDR*.360 $OUT_FLDR;

# # #	TODO >> MO BETA' 360 WORKFLOW

# # #	.360 need to be handled in their app
# # #	or reframed in AE/PR via GoPro FX Reframe 
# # # 	see: https://community.gopro.com/t5/en/GoPro-FX-Reframe/ta-p/412890#

# # echo "Until you have a good .360 footy workflow, this script only copies the SD.  There is no formatting ATM."

# # echo "[FORMAT]";
# #	WIPE THE DISK
# # diskutil eraseDisk ExFAT Untitled /dev/disk2

# #	MAX WORKFLOW IDEA:

# 	# 1. GOPRO PLAYER BATCH EXPORT : SD >> DESKTOP ( FULL ON MP4 )
# # TODO: figure out how to CLI this step with "GoPro Player"

# 	# 2. FFMPEG COPY ( TO SHRINK ) EACH MP4
# 	#	for f in `ls -1`; do ffmpeg -i $f -vcodec h264 -acodec mp3 _$f; done
# 	# <(for f in `ls -1tr $SRC_FLDR/*.MP4`; do ffmpeg -i $f -vcodec h264 -acodec mp3 $OUT_FLDR$f; done);

# 	# 3. FFMPEG CONCAT SHRUNK.MP4S >> MASTER360-SHRUNK-$TIME.MP4
# 	# ffmpeg -f concat -i input.txt -c copy concatenated.mp4
# 	# ffmpeg -f concat -safe 0 -i <(for f in `ls -1tr $OUT_FLDR/*.MP4`; do echo "file '$f'"; done) -c copy $OUT_FLDR/$OUT_FILE;

# 	# 	4. 360 to flat file?
# 	#	see: https://www.reddit.com/r/GoProMAX/comments/fbiu7p/stitching_together_concatenating_360_gopro_max/fjey4sm/
# 	# ffmpeg -i $OUT_FLDR/$OUT_FILE -vf v360=e:e:yaw=60:pitch=0:roll=0 $OUT_FLDR/360_FINAL.MP4

# 	# 5. BACKUP ALL MEDIA TO \Volumes\BACKUP\_GOPROMAX_\_GOPROMAX-$TIME

# 	# 6. FORMAT SD -> BACK TO SHOOTING	




	

