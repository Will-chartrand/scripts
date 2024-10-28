#!/bin/bash

# Swap caps lock and esc keys
#setxkbmap -option "caps:swapescape"
#setxkbmap -option "caps:escape"

xkbcomp ~/.config/xkb/mykeymap.xkb $DISPLAY
xbindkeys


#xmodmap -e "remove Lock = Caps_Lock"
#xmodmap -e "keysym Escape = Caps_Lock"
#xmodmap -e "keysym Caps_Lock = Escape"
#xmodmap -e "add Lock = Caps_Lock"
