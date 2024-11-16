#!/bin/bash

# Use scrot to select area of screen (-s) and then execute (-e) the following string
#  which in turn calls xclip (clipboard utility) to copy the selection to the clipboard
#  and then (&&) move the file that scrot created ($f) to my screenshots directory
#
#scrot -s -e 'xclip -selection clipboard -t image/png -i $f && mv $f ~/Pictures/Screenshots/'

# Use maim to save selection to screenshots folder and copy to clipboard using xclip
path="$HOME/Pictures/Screenshots/maim_$(date +%F-%T).png" && maim -s "$path" && xclip -selection clipboard -t image/png "$path"
