#!/bin/bash

# Stream settings
VBR="6500k"            # Video bitrate
FPS=30                  # Frames per second
CRF=24                  # Constant Rate Factor
PRESET="fast"           # Encoding preset
GOP=3                   # Group of Pictures

# YouTube settings
YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"   # YouTube RTMP server URL
KEY="YOUTUBE KEY"   # Stream key

# Background video for looping
BACKGROUND_VIDEO="background_video/rain.mp4"

# Background audio for looping
BACKGROUND_AUDIO="background_audio/artillery.mp3"
BACKGROUND_AUDIO_VOLUME="0"    # Background audio volume level

# Music directory
MUSIC_DIR="music/lofi"
MUSIC_VOLUME=1  # Music volume level

# Font settings for text overlay
FONT="fonts/WonderNight-K7ZaZ.ttf"
FONTSIZE=72
FONTCOLOR="#FFFFFF"

# Function to get filename from a given path
get_filename() {
    filepath=$1
    filename=$(basename -- "$filepath")
    name="${filename%.*}"
    echo $name
}

# Function to get duration of a media file using ffprobe
get_duration() {
    filepath=$1
    duration=$(ffprobe -i "$filepath" -show_entries format=duration -v quiet -of csv="p=0")
    echo $duration
}

# Main loop for continuous streaming
while true; do
    # Iterate over each music file in the specified directory
    for music in "$MUSIC_DIR"/*; do
        title=$(get_filename "$music")  # Get music title
        duration=$(get_duration "$music")   # Get music duration

        # Use ffmpeg to stream video with text overlay and audio mixing
        ffmpeg -re \
        -stream_loop -1 -i "$BACKGROUND_VIDEO" \
        -i "$music" \
        -stream_loop -1 -i "$BACKGROUND_AUDIO" \
        -filter_complex " \
            [0]trim=duration=$duration[v0];
            [v0]drawtext=fontfile=$FONT:text=$title:fontsize=$FONTSIZE:fontcolor=$FONTCOLOR:x=20:y=50[v];
            [2:a]volume=$BACKGROUND_AUDIO_VOLUME[a1];
            [1:a][a1]amix=inputs=2[a2];
            [a2]atrim=duration=$duration[a]
        " \
        -map [v] -map [a]:a \
        -vcodec libx264 -pix_fmt yuv420p -preset:v ultrafast -r $FPS -b:v $VBR -g $GOP \
        -acodec libmp3lame -qscale:a 3 -ar 44100 -threads 6 -b:a 712000 \
        -f flv $YOUTUBE_URL/$KEY
    done
done
