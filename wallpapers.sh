#!/bin/bash

# Set wallpapers

# Here are various wallpaper folders that I switch to from time to time
#feh --bg-fill -z ~/Pictures/wallpapers/nordic-wallpapers/wallpapers
#feh --bg-fill -z ~/Pictures/wallpapers/justanotherstrange/distrotube
#feh --bg-fill -z ~/Pictures/wallpapers/justanotherstrange/dark
#feh --bg-fill -z ~/Pictures/wallpapers/frenzy/Pixelart


if [ $# -eq 0 ]; then
  #feh --bg-fill -z ~/Pictures/wallpapers/minion
  feh --bg-scale -z ~/Pictures/wallpapers/minion
  exit 1
fi

if [ "$1" = "-b" ]; then
  pkill -f changewallpapers
  feh --bg-fill -z ~/Pictures/wallpapers/black.png
  openrgb --mode static --color 000000 & # Might as well blackout the pc
  exit 1
fi
