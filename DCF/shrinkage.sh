#!/bin/zsh
#	@usage:
#	chmod 755 shrinkagee.sh 
#	./shrinkagee.sh 

# $1 -- Folder containing MP4s for shrinking
SRC=$1;
# echo Source folder: $SRC;
# echo Src: $2
# echo Output: $3




# UPPERCASIFY mp4s just in case
echo "\n -------------------------------------------------------------------------------";
echo "UPPERCASIFY mp4s in $SRC_FLDR";
echo "\n -------------------------------------------------------------------------------";
	for f in $SRC*.*4; 
		do mv "$f" "${f%.*}.MP4"; 
	done

# # 1.	Make input.txt
echo "\n -------------------------------------------------------------------------------";
echo "Make input.txt in $SRC. ( remember SORT impacts assemblage )";
echo "\n -------------------------------------------------------------------------------";

# Convert transposed and horizontally flipped Equi-Angular Cubemap in side-by-side stereo format to equirectangular top-bottom stereo format:
# v360=eac:equirect:in_stereo=sbs:in_trans=1:ih_flip=1:out_stereo=tb

	#	DON'T FORGET TO CONFIRM FILE SORT IN input.txt
	# for f in `ls -1tr $SRC*.MP4`; dos ffmpeg -i $SRC$f -crf 24  -vf v360=e:e:yaw=180:pitch=0:roll=0 $SRC$f	; done
#	betas
	# for f in `ls -1tr $SRC*.s`; do ffmpeg -i $SRC$f -crf 24  -vf v360=eac:equirect:in_stereo=sbs:in_trans=1:ih_flip=1:out_stereo=tb $SRC$f; done
for f in $SRC*.*4; 
	do ffmpeg -i $f -crf 24  -vf v360=eac:flat:yaw=45$f$(date +%s)".MP4";
done
