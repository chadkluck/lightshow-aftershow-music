#Ensure that MPlayer is not running
sudo killall mplayer
#Start Playback
sudo mplayer -shuffle -loop 0 -playlist /home/fpp/media/aftershow/halloween/playlist.txt