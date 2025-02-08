#!/bin/bash
# This script allows me to adjust the various parameters of my webcam fairly quickly from the command line.

# Open gui for changing parameters
if [ $# -eq 0 ]; then
  pavucontrol
  exit 1
fi

# Return
currVolume=$(amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }' | tr -d %)

if [ $1 = "-g" ]; then
  muted=$(pactl get-sink-mute @DEFAULT_SINK@ | grep "yes" | wc -l)

  if [ "$muted" == 1 ]; then
    echo "---"
  fi
  echo $(amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }')
  exit 1
fi

if [ "$2" = "up" ]; then
  if [ "$currVolume" == 100 ]; then
    notify-send -t 1800 "MAX" -h string:x-canonical-private-synchronous:anything
    exit 1
  fi

  pactl set-sink-volume @DEFAULT_SINK@ +5%
fi

if [ "$2" = "down" ]; then
  if [ "$currVolume" == 0 ]; then
    notify-send -t 1800 "MUTE" -h string:x-canonical-private-synchronous:anything
    exit 1
  fi
  pactl set-sink-volume @DEFAULT_SINK@ -5%
fi

if [ "$1" = "mute" ]; then
  if [ $(amixer sget Master | grep 'Right:' | grep off | wc -l) == "1" ]; then
    notify-send -t 1800 "MUTE OFF" -h string:x-canonical-private-synchronous:anything
  else
    notify-send -t 1800 "MUTE ON" -h string:x-canonical-private-synchronous:anything
  fi
  exit 1
fi

currVolume=$(amixer sget Master | grep 'Right:' | awk -F'[][]' '{ print $2 }' | tr -d %)
if [ "$currVolume" == 0 ]; then
  notify-send -t 1800 "MUTE" -h string:x-canonical-private-synchronous:anything
elif [ "$currVolume" == 100 ]; then
  notify-send -t 1800 "MAX" -h string:x-canonical-private-synchronous:anything
else
  hashtags=$(eval printf "%.0s\#" $(seq 1 $(echo "scale=0; ($currVolume) / 5" | bc -l)))
  dashes=$(eval printf "%.0s\-" $(seq 1 $(echo "scale=0; 20 - ($currVolume) / 5" | bc -l)))
  volString="${hashtags}${dashes}"
  notify-send -t 1800 $volString -h string:x-canonical-private-synchronous:anything
fi

exit 0
