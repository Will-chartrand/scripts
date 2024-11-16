#!/bin/bash

# Simple utility for turning on/off individual displays
#  The xrandr script is very specific to my three-monitor setup, as I have the leftmost monitor in portrait mode,
#  and other such inconsistencies among my monitors like resolution and whatnot

# Names of my monitors
MON1="DisplayPort-0" # Discover monitor name with: xrandr | grep " connected"
MON2="DisplayPort-1" # Discover monitor name with: xrandr | grep " connected"
MON3="HDMI-A-0"      # Discover monitor name with: xrandr | grep " connected"

# These are for the intel driver (I don't know why it has a different naming convention)
#MON1="DP-1"   # Discover monitor name with: xrandr | grep " connected"
#MON2="DP-2"   # Discover monitor name with: xrandr | grep " connected"
#MON3="HDMI-1" # Discover monitor name with: xrandr | grep " connected"

# Setup displays

# To be invoked by startup script
if [ $# -eq 0 ]; then
  xrandr --output $MON1 --mode 2560x1440 --rate 143.97 --rotate normal --primary --output $MON2 --mode 1920x1080 --rate 60.00 --left-of $MON1 --rotate left --output $MON3 --mode 1920x1080 --rate 60.00 --right-of $MON1 --rotate normal
  changewallpapers &
  #wallpapers &
  exit 1
fi

if [ "$1" = "-h" ]; then
  if [ $# -eq 1 ]; then
    echo "Flags:"
    echo "  -s  Select monitors"
    echo "    000 = none"
    echo "    010 = only middle"
    echo "  -m  shortcut for -s 010"
  fi
  exit 1
fi

if [ "$1" = "-a" ]; then
  xrandr --output $MON1 --mode 2560x1440 --rate 143.97 --rotate normal --primary --output $MON2 --mode 1920x1080 --rate 60.00 --left-of $MON1 --rotate left --output $MON3 --mode 1920x1080 --rate 60.00 --right-of $MON1 --rotate normal
  exit 1
fi

if [ "$1" = "-m" ]; then
  xrandr --output $MON1 --mode 2560x1440 --rate 143.97 --rotate normal --primary --output $MON2 --off --output $MON3 --off
  exit 1
fi

if [ "$1" = "-s" ]; then
  if [ $# -eq 1 ]; then
    echo "Input three digit binary string:\n\t 'setupdisplays -s 010'"
    echo "Left monitor is 100, middle is 010, right is 001"
  else

    # This could be implemented better, but with only eight possible configuration options I didn't bother.
    if [ $2 -eq "000" ]; then
      if [ $# -eq 2 ]; then
        echo "Are you sure? append -f to this command to confirm"
      elif [ "$3" -eq "-f" ]; then
        xrandr --output $MON1 --off --output $MON2 --off --output $MON3 --off
      fi
    fi
    if [ $2 -eq "001" ]; then
      xrandr --output $MON1 --off --output $MON2 --off --output $MON3 --mode 1920x1080 --rate 60.00 --right-of $MON1 --rotate normal
    fi
    if [ $2 -eq "010" ]; then
      xrandr --output $MON1 --mode 2560x1440 --rate 143.97 --rotate normal --primary --output $MON2 --off --output $MON3 --off
    fi
    if [ $2 -eq "011" ]; then
      xrandr --output $MON1 --mode 2560x1440 --rate 143.97 --rotate normal --primary --output $MON2 --off --output $MON3 --mode 1920x1080 --rate 60.00 --right-of $MON1 --rotate normal
    fi
    if [ $2 -eq "100" ]; then
      xrandr --output --off --output $MON2 --mode 1920x1080 --rate 60.00 --left-of $MON1 --rotate left --output $MON3 --off
    fi
    if [ $2 -eq "101" ]; then
      xrandr --output $MON1 --off --output $MON2 --mode 1920x1080 --rate 60.00 --left-of $MON1 --rotate left --output $MON3 --mode 1920x1080 --rate 60.00 --right-of $MON1 --rotate normal --primary
    fi
    if [ $2 -eq "110" ]; then
      xrandr --output $MON1 --mode 2560x1440 --rate 143.97 --rotate normal --primary --output $MON2 --mode 1920x1080 --rate 60.00 --left-of $MON1 --rotate left --output $MON3 --off
    fi
    if [ $2 -eq "111" ]; then
      xrandr --output $MON1 --mode 2560x1440 --rate 143.97 --rotate normal --primary --output $MON2 --mode 1920x1080 --rate 60.00 --left-of $MON1 --rotate left --output $MON3 --mode 1920x1080 --rate 60.00 --right-of $MON1 --rotate normal
    fi
  fi

  # Reapply wallpapers so they don't look all screwed up
  wallpapers -b

  exit 1
fi

wallpapers -b
exit 0
