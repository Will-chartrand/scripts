#!/bin/bash
# This script allows me to adjust the various parameters of my webcam fairly quickly from the command line.

# Path to my desired webcam
videoinput=$(readlink -f /dev/v4l/by-id/usb-Microsoft_Microsoft®_LifeCam_Studio_TM_-video-index0)
ctrl=""

# Open tui for changing parameters
if [ $# -eq 0 ]; then

  while read -n 1 input; do
    echo
    case $input in
    d)
      echo "focus toggle"
      v4l2-ctl -d $videoinput --set-ctrl focus_automatic_continuous=$(($(v4l2-ctl -d $videoinput --get-ctrl focus_automatic_continuous | grep 0 | wc -l)))
      ctrl="focus_automatic_continuous"
      ;;
    f)
      echo "focus increase"
      v4l2-ctl -d $videoinput --set-ctrl focus_absolute=$(($(v4l2-ctl -d $videoinput --get-ctrl focus_absolute | cut -d' ' -f2) - 4))
      ctrl="focus_absolute"
      ;;
    F)
      echo "focus decrease"
      v4l2-ctl -d $videoinput --set-ctrl focus_absolute=$(($(v4l2-ctl -d $videoinput --get-ctrl focus_absolute | cut -d' ' -f2) - 4))
      ctrl="focus_absolute"
      ;;
    b)
      echo "brightness increase"
      v4l2-ctl -d $videoinput --set-ctrl brightness=$(($(v4l2-ctl -d $videoinput --get-ctrl brightness | cut -d' ' -f2) + 10))
      ctrl="brightness"
      ;;
    B)
      echo "brightness decrease"
      v4l2-ctl -d $videoinput --set-ctrl brightness=$(($(v4l2-ctl -d $videoinput --get-ctrl brightness | cut -d' ' -f2) - 10))
      ctrl="brightness"
      ;;
    z)
      echo "zoom increase"
      v4l2-ctl -d $videoinput --set-ctrl zoom_absolute=$(($(v4l2-ctl -d $videoinput --get-ctrl zoom_absolute | cut -d' ' -f2) + 10))
      ctrl="zoom_absolute"
      ;;
    Z)
      echo "zoom decrease"
      v4l2-ctl -d $videoinput --set-ctrl zoom_absolute=$(($(v4l2-ctl -d $videoinput --get-ctrl zoom_absolute | cut -d' ' -f2) - 10))
      ctrl="zoom_absolute"
      ;;
    p)
      echo "pan increase"
      v4l2-ctl -d $videoinput --set-ctrl pan_absolute=$(($(v4l2-ctl -d $videoinput --get-ctrl pan_absolute | cut -d' ' -f2) + 3600))
      ctrl="pan_absolute"
      ;;
    P)
      echo "pan decrease"
      v4l2-ctl -d $videoinput --set-ctrl pan_absolute=$(($(v4l2-ctl -d $videoinput --get-ctrl pan_absolute | cut -d' ' -f2) - 3600))
      ctrl="pan_absolute"
      ;;
    t)
      echo "tilt increase"
      v4l2-ctl -d $videoinput --set-ctrl tilt_absolute=$(($(v4l2-ctl -d $videoinput --get-ctrl tilt_absolute | cut -d' ' -f2) + 3600))
      ctrl="tilt_absolute"
      ;;
    T)
      echo "tilt decrease"
      v4l2-ctl -d $videoinput --set-ctrl tilt_absolute=$(($(v4l2-ctl -d $videoinput --get-ctrl tilt_absolute | cut -d' ' -f2) - 3600))
      ctrl="tilt_absolute"
      ;;
    esac
    v4l2-ctl -d $videoinput --list-ctrls | grep "$ctrl"
  done

  exit 1
fi

if [ "$1" = "-p" ]; then
  if [ $# -eq 1 ]; then
    #ffplay -framerate 30 -input_format mjpeg -video_size 1920x1080 -aspect 16:9 -window_title Webcam -fast -vf "hflip" "$videoinput"
    ffplay -framerate 30 -input_format mjpeg -video_size 1920x1080 -window_title Webcam -fast -vf "hflip" -fflags nobuffer "$videoinput"
  fi
  exit 1
fi

if [ "$1" = "-r" ]; then
  if [ $# -eq 1 ]; then
    sudo sh -c "echo 0 > /sys/bus/usb/devices/1-8/authorized"
    sudo sh -c "echo 1 > /sys/bus/usb/devices/1-8/authorized"
  fi
  exit 1
fi

if [ "$1" = "-b" ]; then
  if [ $# -eq 1 ]; then
    echo "30-255, default=133"
  else
    brightness="$2"
    v4l2-ctl -d "$videoinput" --set-ctrl brightness="$brightness"
  fi
  exit 1
fi

if [ "$1" = "-b2" ]; then
  videoinput="/dev/video0"
  if [ $# -eq 1 ]; then
    echo "30-255, default=133"
  else
    brightness="$2"
    v4l2-ctl -d "$videoinput" --set-ctrl brightness="$brightness"
  fi
  exit 1
fi

if [ "$1" = "-c" ]; then
  if [ $# -eq 1 ]; then
    echo "0-10, default=5"
  else
    contrast="$2"
    v4l2-ctl -d "$videoinput" --set-ctrl contrast="$contrast"
  fi
  exit 1
fi

if [ "$1" = "-z" ]; then
  if [ $# -eq 1 ]; then
    echo "0-317, default=0"
  else
    zoom_absolute="$2"
    v4l2-ctl -d "$videoinput" --set-ctrl zoom_absolute="$zoom_absolute"
  fi
  exit 1
fi

exit 0
