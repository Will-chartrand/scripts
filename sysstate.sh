#!/bin/bash

# Uses fa-icons
# Uses dmenu to display different power/session options
case "$(printf "  Sleep\n  Exit dwm\n  Reboot\n  Shutdown\n" | dmenu -l 10 -i -p "System:")" in
  "  Sleep") sudo echo "mem" > /sys/power/state ;;
  "  Exit dwm") pkill dwm ;;
  "  Reboot") reboot ;;
  "  Shutdown") openrc-shutdown --poweroff now;;
  *) exit 1 ;;
esac
