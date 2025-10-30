# Set-Up Music for Pre/Post Show

I had been using the AfterHours plug-in, but was finding it hard to find streaming stations and I no longer wanted to use the bandwidth. I just wanted to use my own playlist.

Adapted from post on the [Falcon Christmas Forum: Playing random music when show is off](https://falconchristmas.com/forum/index.php?topic=5632.0).

The post was from 2016, and I decided to update it with complete step by step instructions.

These instructions:

- Create a separate directory to store holiday MP3 files
- Install and utilize mplayer
- Create 2 shell scripts which are added to the schedule and playlist
- Upload a zip file containing all songs to play
- Unzip and generate a playlist file

The script that starts the songs uses a random shuffle.

## Initial Set-Up

Use SSH to remote into your Falcon Player device or open a command shell from the Falcon Player web interface.

### 1. Create a directory (this will be separate from your sequence music).

```bash
mkdir -p ~/media/aftershow/christmas
```

### 2. Check if mplayer is installed (probably not).

```bash
which mplayer
```

### 3. Install mplayer if not already installed.

```bash
sudo apt update && sudo apt -y install mplayer
```

### 4. Create and Upload two scripts:

One to start the music:

```sh
#AfterShowMusic-start-christmas.sh
# Ensure that MPlayer is not running
sudo killall mplayer
# Start Playback in random order
sudo mplayer -shuffle -loop 0 -playlist /home/fpp/media/aftershow/christmas/playlist.txt
```

A Second to stop the music:

```sh
#AfterShowMusic-stop.sh
#Ensure that MPlayer is not running
sudo killall mplayer
```

> Note that you can use the same stop script for all holidays, but the start script points to a specific holiday directory (which I will get to later).

Upload these via the Falcon player web interface under scripts.

### 6. Schedule start and stop scripts

For pre-show music, add the start script to a daily schedule. Then be sure to execute the stop script before your show playlist begins (Lead In).

For post-show music, add the start script to the end of your sequence (Lead Out). Also be sure to schedule a daily stop.

For example:

- In Scheduler:
    - add a start script: Black Friday to Epiphany, Everyday, 3:00 PM, Command, Run Script: AfterShowMusic-start-christmas.sh
	- add an end script: 2025-10-01 to 2028-12-31, Everyday, 1:00 AM, Command, Run Script: AfterShowMusic-stop.sh
- In Holiday Specific Playlist:
	- Lead In: Script: AfterShowMusic-stop.sh, Blocking false
	- Lead Out: Script: AfterShowMusic-start-christmas.sh, Blocking false

## Add Music

Upload a zip file of your music via the Falcon Player web interface. (Make sure it is named music.zip, otherwise you will need to change the filename in the next command.)

This will place it in the ~/media/upload/ directory.

We will now use the Falcon browser CLI or Putty to SSH and run the commands to move the zip file, extract, and create a playlist.

I separate my music into holidays under the `~/media/aftershow/` directory. For this example, we will use `christmas`.

Move the zip to ~/media/aftershow/christmas, extract, and create playlist:

```bash
# (optional) remove existing mp3 files (skip/comment out if your music.zip is additive and not replacing)
rm ~/media/aftershow/christmas/*.mp3
mv ~/media/upload/music.zip ~/media/aftershow/christmas/music.zip
cd ~/media/aftershow/christmas/
unzip -n music.zip && rm music.zip
# remove spaces in file names
find . -name "* *" -type f -exec bash -c 'mv "$1" "${1// /_}"' _ {} \;
find ~/media/aftershow/christmas/* -iname \*.mp3 -type f > ~/media/aftershow/christmas/playlist.txt
```
