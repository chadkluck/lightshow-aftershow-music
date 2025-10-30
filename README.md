# Set-Up Music for Pre/Post Show

I had been using the AfterHours plug-in, but was finding it hard to find streaming stations and I no longer wanted to use the bandwidth. I just wanted to use my own playlist directly from the Pi.

The method I am using is adapted from a post on the [Falcon Christmas Forum: Playing random music when show is off](https://falconchristmas.com/forum/index.php?topic=5632.0).

The post was from 2016, and I decided to update it with complete step by step instructions along with a few scripts.

These instructions:

1. Install mplayer if not already installed
2. Upload the scripts
3. Create the directory structure for holiday music
4. Upload music in a zip file
5. Unzip and create playlist using a script
6. Schedule start and stop scripts

All the scripts will utilize a holiday specific directory to store the music:

`~/media/aftershow/{holiday}`

## Initial Set-Up

Use SSH to remote into your Falcon Player device or open a command shell from the Falcon Player web interface.

### 1. Install mplayer if not already installed

Check if mplayer is already installed:

```bash
which mplayer
```

Install if not already installed:

```bash
sudo apt update && sudo apt -y install mplayer
```

### 2. Upload Scripts

We will use 3 scripts:

- [AfterShowMusic-unzip.sh](./AfterShowMusic-unzip.sh) : to unzip and create playlist from uploaded music zip file
- [AfterShowMusic-start.sh](./AfterShowMusic-start.sh) : to start playing music for a specific holiday
- [AfterShowMusic-stop.sh](./AfterShowMusic-stop.sh) : to stop playing music

Upload these 3 scripts via the Falcon player web interface under scripts.

### 3. Create the directory structure for holiday music

All the scripts will utilize a holiday specific directory to store the music:

`~/media/aftershow/{holiday}`

Create a holiday directory, for example for `christmas` use:

```bash
mkdir -p ~/media/aftershow/christmas
```

### 4. Upload Music in a Zip file

Upload a zip file of your music via the Falcon Player web interface.

Make sure it is named `music.zip`, otherwise you will need to change the filename.

This will place it in the ~/media/upload/ directory. If you didn't name it `music.zip` you can rename it now.

### 5. Unzip and Create Playlist using a script

We will now use the Falcon browser CLI or Putty to SSH and run the commands to move the zip file, extract, and create a playlist.

Run the unzip script to move the zip file, extract the mp3 files, and create a playlist.

> Note: The scripts remove the zip file when complete. Make sure you keep local copies of your music, or modify the scripts to move a copy to an archival directory on the Pi.

This example is for `christmas`, use whatever holiday directory you created to store the music.

```bash
./AfterShowMusic-unzip.sh christmas delete
```

The optional `delete` argument will remove any existing mp3 files in the holiday directory before unzipping the new files. If you want to keep existing files and just add new ones, skip the `delete` argument.

### 6. Schedule start and stop scripts

For pre-show music, add the start script to a daily schedule. Then be sure to execute the stop script before your show playlist begins (Lead In).

For post-show music, add the start script to the end of your sequence (Lead Out). Also be sure to schedule a daily stop.

For example:

- In Scheduler:
    - add a start script: Black Friday to Epiphany, Everyday, 3:00 PM, Command, Run Script: AfterShowMusic-start.sh with argument for holiday directory (such as `christmas`)
	- add an end script: 2025-10-01 to 2030-12-31, Everyday, 1:00 AM, Command, Run Script: AfterShowMusic-stop.sh (It doesn't matter if it never starts for the day, just run the stop script every day)
- In Holiday Specific Playlist:
	- Lead In: Script: AfterShowMusic-stop.sh, Blocking false
	- Lead Out: Script: AfterShowMusic-start.sh, Blocking false, With argument for holiday directory (such as `christmas`)
