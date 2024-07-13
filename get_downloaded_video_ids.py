import os

def get_downloaded_video_ids(output_dir):
    downloaded_videos = set()
    if os.path.exists(output_dir):
        for filename in os.listdir(output_dir):
            if filename.endswith(".mp4"):
                video_id = os.path.splitext(filename)[0]
                downloaded_videos.add(video_id)
    return downloaded_videos
