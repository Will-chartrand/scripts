#!/bin/bash
# This script allows me to adjust the various parameters of my webcam fairly quickly from the command line.


# Open gui for changing parameters
if [ $# -eq 0 ]; then
  pavucontrol
  exit 1;
fi

if [ "$1" = "-r" ]; then
  if [ $# -eq 1 ]; then
    currVolume=$(amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }' | tr -d %)
    roundedVolume=$(($currVolume+2))
    roundedVolume=$(($roundedVolume/5))
    roundedVolume=$(($roundedVolume*5))
    pactl set-sink-volume @DEFAULT_SINK@ "$roundedVolume"%
  fi
  exit 1;
fi

exit 0
