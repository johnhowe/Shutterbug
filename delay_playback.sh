#!/bin/sh

WORKDIR=/home/john/capture
FILENAME=$WORKDIR/`date +%y%m%d.%H%M`.avi
TERM=gnome-terminal
DEFAULT=30

cd $WORKDIR

$TERM -e "mencoder -tv input=1:width=720:height=576 tv:// -nosound -ovc x264 -x264encopts threads=auto:bframes=3:weight_b:partitions=all:8x8dct:subq=6:bitrate=900 -o $FILENAME" &
#$TERM -e mencoder -tv input=3:width=320:height=240 tv:// -nosound -ovc lavc -lavcopts vcodec=mjpeg:vbitrate=3000 -o $FILENAME &
#$TERM -e mencoder -tv input=3:width=320:height=240 tv:// -nosound -ovc lavc -lavcopts vcodec=mpeg2video:vbitrate=1800 -o $FILENAME &
#$TERM -e mencoder -tv device=/dev/video:driver=v4l:input=3:width=640:height=480:norm=pal:adevice=/dev/dsp \
		#tv://1 -zoom -aspect 4:3 -nosound -ovc lavc -o $FILENAME &
#$TERM -e mencoder -tv device=/dev/video:driver=v4l:input=3:width=640:height=480:norm=pal:adevice=/dev/dsp:yadif=0 \
		#tv://1 -zoom -aspect 4:3 -nosound -ovc lavc -lavcopts vcodec=mpeg4:vbitrate=2000 -o $FILENAME &

if [ $# -eq 0 ]
then
	printf "No delay time specified. Playback will begin in %d seconds ...\n" "$DEFAULT" | cowsay
	sleep $DEFAULT
else
	printf "Please wait %d seconds for video playback ...\n" "$1" | cowsay
	sleep $1
fi

tail -f -c +0 $FILENAME | mplayer -fs -nocache -noidx -demuxer avi - && killall mencoder

printf "\n\nVideo file saved as %s \n" "$FILENAME"
