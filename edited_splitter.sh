#!/bin/bash

# Ensure a directory argument is provided
if [ $# -eq 0 ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

# Directory containing the video files (train.txt, val.txt, test.txt)
DIR="$1"
DST_DIR="$DIR/intervals"
mkdir -p "$DST_DIR"

# Loop through each video file in videos/test
for f in "$DIR/videos/test"/*.mp4
do
    echo "Processing file: $f"
    fname=$(basename "$f")
    fname="${fname%.*}"
    echo "Base name: $fname"
    
    # Create directory for segments
    mkdir -p "$DST_DIR/test/$fname"
    
    # Segment the video using ffmpeg
    /usr/bin/ffmpeg -loglevel panic -i "$f" -acodec copy -f segment -vcodec copy \
            -reset_timestamps 1 -map 0 -segment_time 30 "$DST_DIR/test/$fname/cut-%d.mp4"
done

# Loop through each video file in videos/train
for f in "$DIR/videos/train"/*.mp4
do
    echo "Processing file: $f"
    fname=$(basename "$f")
    fname="${fname%.*}"
    echo "Base name: $fname"
    
    # Create directory for segments
    mkdir -p "$DST_DIR/train/$fname"
    
    # Segment the video using ffmpeg
    /usr/bin/ffmpeg -loglevel panic -i "$f" -acodec copy -f segment -vcodec copy \
            -reset_timestamps 1 -map 0 -segment_time 30 "$DST_DIR/train/$fname/cut-%d.mp4"
done

# Loop through each video file in videos/val
for f in "$DIR/videos/val"/*.mp4
do
    echo "Processing file: $f"
    fname=$(basename "$f")
    fname="${fname%.*}"
    echo "Base name: $fname"
    
    # Create directory for segments
    mkdir -p "$DST_DIR/val/$fname"
    
    # Segment the video using ffmpeg
    /usr/bin/ffmpeg -loglevel panic -i "$f" -acodec copy -f segment -vcodec copy \
            -reset_timestamps 1 -map 0 -segment_time 30 "$DST_DIR/val/$fname/cut-%d.mp4"
done
