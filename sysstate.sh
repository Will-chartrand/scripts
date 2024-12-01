#!/bin/bash

# Uses fa-icons
# Uses dmenu to display different power/session options
case "$(printf "s:  Sleep\ne:  Exit dwm\nr:  Reboot\nd:  Shutdown\n" | dmenu -l 10 -i -p "System:")" in
"s:  Sleep") sudo echo "mem" >/sys/power/state ;;
"e:  Exit dwm") pkill dwm ;;
"r:  Reboot") reboot ;;
"d:  Shutdown") poweroff ;;
*) exit 1 ;;
esac
