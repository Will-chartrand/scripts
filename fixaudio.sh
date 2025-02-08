#!/bin/bash

# This unmutes the rear-out on Zara
pactl set-sink-mute alsa_output.pci-0000_00_1f.3.analog-stereo 0
