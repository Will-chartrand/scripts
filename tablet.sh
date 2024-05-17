#!/bin/bash

# This script is now unused, as I created an xorg.conf profile that essentially does the same thing when the usb drawing tablet is plugged in
#  instead of having to call this script manually

MON1="DisplayPort-0"    # Discover monitor name with: xrandr | grep " connected"
MON2="DisplayPort-1"    # Discover monitor name with: xrandr | grep " connected"
MON3="HDMI-A-0"    # Discover monitor name with: xrandr | grep " connected"
#MON1="DP-1"   # Discover monitor name with: xrandr | grep " connected"
#MON2="DP-2"   # Discover monitor name with: xrandr | grep " connected"
#MON3="HDMI-1" # Discover monitor name with: xrandr | grep " connected"

# Setup tablet
xinput map-to-output "UGTABLET 10 inch PenTablet Pen Pen (0)" $MON1
#xinput map-to-output "UGTABLET 10 inch PenTablet Pen" $MON1
xinput set-prop "UGTABLET 10 inch PenTablet Pen Pen (0)" 'Coordinate Transformation Matrix' -1 0 1 0 -1 1 0 0 1

