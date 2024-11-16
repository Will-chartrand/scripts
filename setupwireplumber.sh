#!/bin/bash

pkill pipewire
pkill wireplumber

pipewire &
pipewire-pulse &
wireplumber &
