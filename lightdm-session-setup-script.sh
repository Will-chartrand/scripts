#!/bin/bash

setupvolume &

# Keyboard maps
keymaps &

picom &

pkill changewal
changewallpapers &

redshit &

exec dbus-launch openbox-session
