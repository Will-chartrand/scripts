#!/bin/bash

setupvolume &

# Keyboard maps
keymaps &

picom --backend glx -f &
