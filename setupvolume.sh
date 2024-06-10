#!/bin/bash

# Setup volume
volnoti -a 0.2   # for displaying volume visually
pactl set-sink-volume @DEFAULT_SINK@ 50%
pkill -RTMIN+11 dwmblocks
