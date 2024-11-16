#!/bin/bash

# Set wallpapers

# Here are various wallpaper folders that I switch to from time to time
#feh --bg-fill -z ~/Pictures/wallpapers/nordic-wallpapers/wallpapers
#feh --bg-fill -z ~/Pictures/wallpapers/justanotherstrange/distrotube
#feh --bg-fill -z ~/Pictures/wallpapers/justanotherstrange/dark
#feh --bg-fill -z ~/Pictures/wallpapers/frenzy/Pixelart

if [ $# -eq 0 ]; then
  if [ $(date +'%k') -ge 17 ]; then
    feh --bg-fill -z ~/Pictures/wallpapers/timedep/night
  elif [ $(date +'%k') -ge 12 ]; then
    feh --bg-fill -z ~/Pictures/wallpapers/timedep/day
  elif [ $(date +'%k') -ge 5 ]; then
    feh --bg-fill -z ~/Pictures/wallpapers/timedep/morning
  else
    feh --bg-fill -z ~/Pictures/wallpapers/timedep/latenight
  fi

  exit 1
fi

if [ "$1" = "-b" ]; then
  pkill -f changewallpapers
  feh --bg-fill -z ~/Pictures/wallpapers/black.png
  openrgb --mode static --color 000000 & # Might as well blackout the pc
  exit 1
fi
