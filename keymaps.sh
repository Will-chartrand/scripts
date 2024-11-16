#!/bin/bash

# Swap caps lock and esc keys
#setxkbmap -option "caps:swapescape"
#setxkbmap -option "caps:escape"

xkbcomp ~/.config/xkb/mykeymap.xkb $DISPLAY &
xbindkeys -f /home/willc/.config/xbindkeys/config & # config in ~/.config/xbindkeys/config
xdotool key Num_Lock &                              # use keypad numbers by default

if ! pgrep "solaar" >/dev/null; then
  solaar -w hide &
fi

#xmodmap -e "remove Lock = Caps_Lock"
#xmodmap -e "keysym Escape = Caps_Lock"
#xmodmap -e "keysym Caps_Lock = Escape"
#xmodmap -e "add Lock = Caps_Lock"
