#!/bin/bash

# Backup my home directory
rsync -avzz --delete --exclude '.cache' --exclude '/.local/share/Steam' ~/ /mnt/Media/Backup/artix/home/willc/
