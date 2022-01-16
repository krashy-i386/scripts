#!/bin/sh

# RTMP stream powered by ffmpeg

QUAL="medium"															# Preset
VC="libx264"															# Video Codec
AC="libmp3lame"														# Audio Codec


read -p "Source: " IN
read -p "Additional Flags (Optional): " OPTS
read -p "Resolution: " RES
read -p "Framerate: " FPS
read -p "Video Bitrate: " VBR
VBR=${VBR:="100K"}
read -p "Audio Bitrate: " ABR
ABR=${ABR:="128K"}
read -p "Server URL: " URL
URL=${URL:="rtmp://a.rtmp.youtube.com/live2"}
read -s -p "Stream Key: " KEY

ffmpeg \
	-re -vsync -1 -i "$IN" $OPTS \
	-vcodec $VC -preset $QUAL -pix_fmt yuv420p -vf scale=$RES -r $FPS -g $(($FPS * 2)) -b:v $VBR \
	-acodec $AC -ar 44100	-b:a $ABR -bufsize 512K \
	-f flv "$URL/$KEY"
