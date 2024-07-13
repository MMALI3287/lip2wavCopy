#!/bin/bash

# Ensure a directory argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Directory containing the text files (train.txt, val.txt, test.txt)
DIR="$1"

# Function to download videos using youtube-dl
download_videos() {
    local input_file="$1"
    local output_dir="$2"
    
    mkdir -p "$output_dir"

    while IFS= read -r video_id; do
        echo "Downloading video: $video_id"
        youtube-dl -f best "https://www.youtube.com/watch?v=$video_id" -o "$output_dir/%(id)s.%(ext)s"
    done < "$input_file"
}

# Download videos for train.txt
echo "Downloading Train set"
download_videos "$DIR/train.txt" "$DIR/videos/train"

# Download videos for val.txt
echo "Downloading Val set"
download_videos "$DIR/val.txt" "$DIR/videos/val"

# Download videos for test.txt
echo "Downloading Test set"
download_videos "$DIR/test.txt" "$DIR/videos/test"

FILES=$1/videos/*
DST_DIR=$1/intervals
mkdir -p $DST_DIR

for f in $FILES
do
	echo $f
	fname=$(basename $f)
	fname="${fname%.*}"
	mkdir "$DST_DIR/$fname"
	/usr/bin/ffmpeg -loglevel panic -i $f -acodec copy -f segment -vcodec copy \
			-reset_timestamps 1 -map 0 -segment_time 30 "$DST_DIR/$fname/cut-%d.mp4"
done