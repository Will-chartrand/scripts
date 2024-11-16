#!/bin/bash

# Uses my copyregion.sh script to first copy a user-selected region of the screen to the clipboard
#  then uses ocrdesktop to recognize the characters, optically.
copyregion
ocrdesktop -Cno | xclip -selection "c"
