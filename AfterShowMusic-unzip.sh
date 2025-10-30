#!/bin/bash

# AfterShowMusic-unzip.sh

# USAGE:
# Pass just the holiday directory name, not the full path
# Optional: pass a second argument of "delete" to remove the existing mp3 files
# ./AfterShowMusic-unzip.sh [playlist_directory] [delete]

# EXAMPLE:
# ./AfterShowMusic-unzip.sh christmas delete

# (optional) remove existing mp3 files (skip/comment out if your music.zip is always additive and not replacing)
if [ "$2" == "delete" ]; then
  rm ~/media/aftershow/${1}/*.mp3
fi 

# move to holiday directory
mv ~/media/upload/music.zip ~/media/aftershow/${1}/music.zip

# unzip and then delete zip file
unzip -n ~/media/aftershow/${1}/music.zip && rm ~/media/aftershow/${1}/music.zip

# remove spaces in file names
cd ~/media/aftershow/${1}/
find . -name "* *" -type f -exec bash -c 'mv "$1" "${1// /_}"' _ {} \;

# Put all the mp3 file names into a playlist for mplayer
find ~/media/aftershow/${1}/* -iname \*.mp3 -type f > ~/media/aftershow/${1}/playlist.txt
