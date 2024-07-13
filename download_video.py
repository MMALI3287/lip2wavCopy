from pytube import YouTube
from pytube.exceptions import VideoUnavailable, PytubeError
from urllib.error import HTTPError
import os

def download_video(video_id, output_dir):
    try:
        # Download video
        yt = YouTube(f'https://www.youtube.com/watch?v={video_id}')
        stream = yt.streams.get_highest_resolution()
        if stream:
            # Get the actual filename after downloading
            filename = stream.default_filename
            # video_file = os.path.join(output_dir, filename)
            
            # Download the video
            print(f"Downloading video: {filename} ({video_id})")
            stream.download(output_path=output_dir)
        else:
            print(f"No suitable streams found for video: {video_id}")
    except VideoUnavailable as e:
        print(f"Video {video_id} is unavailable: {str(e)}")
    except PytubeError as e:
        print(f"Pytube error occurred for video {video_id}: {str(e)}")
    except HTTPError as e:
        if e.code == 400:
            print(f"HTTP Error 400: Bad Request for video {video_id}. Skipping...")
        else:
            print(f"HTTP Error {e.code} occurred for video {video_id}: {str(e)}")
    except Exception as e:
        print(f"Error downloading video {video_id}: {str(e)}")
