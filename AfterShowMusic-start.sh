#!/bin/bash

# AfterShowMusic-start.sh

# USAGE: 
# Pass just the holiday directory name, not the full path
# ./AfterShowMusic-start.sh [playlist_directory]
# ./AfterShowMusic-start.sh christmas
# ./AfterShowMusic-start.sh halloween

# Ensure that FPP is not running
sudo killall fpp

# Ensure that MPlayer is not running
sudo killall mplayer

# Start Playback (shuffle, infinate loop, christmas is default if no arg passed to script)
sudo mplayer -shuffle -loop 0 -playlist ~/media/aftershow/${1:-christmas}/playlist.txt
