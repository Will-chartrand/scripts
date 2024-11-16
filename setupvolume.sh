#!/bin/bash

setupwireplumber &

# Setup volume
volnoti -a 0.05 -t 1 # for displaying volume visually
pactl set-sink-volume @DEFAULT_SINK@ 50%
pkill -RTMIN+11 dwmblocks
