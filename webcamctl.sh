#!/bin/bash

# This script allows me to adjust the various parameters of my webcam fairly quickly from the command line.

# Path to my desired webcam
videoinput="/dev/video1"

# Open gui for changing parameters
if [ $# -eq 0 ]; then
  guvcview;
  exit 1;
fi

if [ "$1" = "-b" ]; then
  if [ $# -eq 1 ]; then
    echo "30-255, default=133";
  else
    brightness="$2";
    v4l2-ctl -d "$videoinput" --set-ctrl brightness="$brightness";
  fi
  exit 1;
fi

if [ "$1" = "-p" ]; then
  if [ $# -eq 1 ]; then
    ffplay -framerate 30 -input_format mjpeg -video_size 1920x1080 -window_title Webcam -fast -vf "hflip" "$videoinput"
  fi
  exit 1;
fi

if [ "$1" = "-c" ]; then
  if [ $# -eq 1 ]; then
    echo "0-10, default=5";
  else
    contrast="$2";
    v4l2-ctl -d "$videoinput" --set-ctrl contrast="$contrast";
  fi
  exit 1;
fi

if [ "$1" = "-z" ]; then
  if [ $# -eq 1 ]; then
    echo "0-317, default=0";
  else
    zoom_absolute="$2";
    v4l2-ctl -d "$videoinput" --set-ctrl zoom_absolute="$zoom_absolute";
  fi
  exit 1;
fi

exit 0
