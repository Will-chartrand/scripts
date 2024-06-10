#!/bin/bash

# Set wallpapers

# Here are various wallpaper folders that I switch to from time to time
#feh --bg-fill -z ~/Pictures/wallpapers/nordic-wallpapers/wallpapers
#feh --bg-fill -z ~/Pictures/wallpapers/justanotherstrange/distrotube
#feh --bg-fill -z ~/Pictures/wallpapers/justanotherstrange/dark
#feh --bg-fill -z ~/Pictures/wallpapers/frenzy/Pixelart


if [ $# -eq 0 ]; then
  feh --bg-fill -z ~/Pictures/wallpapers/forestsmountains
  exit 1
fi

if [ "$1" = "-b" ]; then
  pkill -f changewallpapers
  feh --bg-fill -z ~/Pictures/wallpapers/black.png
  exit 1
fi
