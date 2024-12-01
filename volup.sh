#!/bin/bash

# Increase volume of camera video and put it in corresponding folder
ffmpeg -i /mnt/Media/Camera/$1 -af "volume=5.5,alimiter=0.9" -c:v copy -c:a aac /mnt/Media/Camera/ffmpeg/$1
