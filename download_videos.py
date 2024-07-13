import os
from pytube import YouTube
from download_video import download_video
from get_downloaded_video_ids import get_downloaded_video_ids

def download_videos(input_file, output_dir):
    # Create the output directory if it doesn't exist
    os.makedirs(output_dir, exist_ok=True)
    
    # Get set of already downloaded video IDs
    downloaded_videos = get_downloaded_video_ids(output_dir)
    
    # Read video IDs from input_file
    video_ids_to_download = []
    
    with open(input_file, 'r') as f:
        video_ids = f.readlines()
        
    for i in range(len(video_ids)):
        video_ids[i] = video_ids[i].strip()
        
    print(f"\nInput File: {input_file}")    
    print(f"Total videos to download: {len(video_ids)}")
    print(f"Total videos already downloaded: {len(downloaded_videos)}")
    videos_to_download=len(video_ids) - len(downloaded_videos)
    print(f"Total videos to download: {videos_to_download}")
    print(f"\nVideo Ids:\n{video_ids}\n")
    print(f"\nDownloaded Videos:\n{downloaded_videos}\n")
    
    if videos_to_download >0:    
        for video_id in video_ids:
            video_id = video_id
            title = YouTube(f'https://www.youtube.com/watch?v={video_id}').title
            if title not in downloaded_videos:
                video_ids_to_download.append(video_id)
            else:
                print(f"Video: {title} ({video_id}) already exists...")
            
        # Download the remaining videos
        for video_id in video_ids_to_download:
            download_video(video_id, output_dir)
    else:
        print("No videos to download...\n")
            
    
