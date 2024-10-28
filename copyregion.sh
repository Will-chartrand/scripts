#!/bin/bash

# Use scrot to select area of screen (-s) and then execute (-e) the following string
#  which in turn calls xclip (clipboard utility) to copy the selection to the clipboard
#  and then (&&) move the file that scrot created ($f) to my screenshots directory
scrot -s -e 'xclip -selection clipboard -t image/png -i $f && mv $f ~/Pictures/Screenshots/'
