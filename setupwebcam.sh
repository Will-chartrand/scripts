#!/bin/bash

# Setup webcam
guvcview -d /dev/video1 --profile=default.gpfl
sleep 1 
pkill -f "guvcview"
