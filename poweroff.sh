#!/bin/bash

ddcutil setvcp --bus=5 D6 05
ddcutil setvcp --bus=6 D6 05

openrc-shutdown --poweroff now
