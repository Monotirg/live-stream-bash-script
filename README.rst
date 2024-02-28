========================
Live Stream Bash Script
========================

Overview
--------

This Bash script sets up a continuous live stream to YouTube using FFmpeg. It combines a background video, background audio, and music files from a specified directory to create a stream with text overlays for the music titles.

Features
--------

- Seamless looping of background video and audio.
- Overlay music titles onto the background video.
- Adjust background audio volume.
- Mix music audio with background audio.
- Stream the composite video and audio to YouTube Live.

Requirements
------------

- FFmpeg
- FFprobe

Usage
-----

1. Clone the repository

   
   
       git clone httpsgithub.comyour-usernameyour-repository.git

2. Navigate to the project directory

   
   
       cd your-repository

3. Set up the required directory structure and place your background video, background audio, and music files accordingly.

4. Edit the script variables in the script according to your setup, such as stream settings, YouTube settings, file paths, and font settings.

5. Make the script executable

   
   
       chmod +x livestream.sh

6. Run the script

   
   
       .livestream.sh

7. The script will continuously loop through the music files in the specified directory, overlaying the titles onto the background video and streaming the output to YouTube Live.


License
-------

This project is licensed under the MIT License. See the LICENSE file for details.
