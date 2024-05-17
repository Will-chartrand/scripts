#!/bin/bash
# NAME
#     brightness.sh - Increase/decrease/ brightness using xrandr gamma attribute
# SYNOPSIS
#     brightness.sh <Up|Down|GammaUp|GammaDown|ResetBrightness|ResetGamma>
#
# Script based off of solution found at https://askubuntu.com/questions/1150339/increment-brightness-by-value-using-xrandr
#
# Code uses bc command for calcultions involving decimal values

MON1="DisplayPort-0"    # Discover monitor name with: xrandr | grep " connected"
MON2="DisplayPort-1"    # Discover monitor name with: xrandr | grep " connected"
MON3="HDMI-A-0"    # Discover monitor name with: xrandr | grep " connected"
#MON1="DP-1"   # Discover monitor name with: xrandr | grep " connected"
#MON2="DP-2"   # Discover monitor name with: xrandr | grep " connected"
#MON3="HDMI-1" # Discover monitor name with: xrandr | grep " connected"
STEP=5        # Step Up/Down brightnes by: 5

# Change gamma (rgb) values incrementally by these
deltared=0.0
deltagreen=0.05
deltablue=0.06

CurrBright=$(xrandr --verbose --current | grep ^"$MON1" -A5 | tail -n1)
CurrBright="${CurrBright##* }" # Get brightness level with decimal place

CurrGamma=$(xrandr --verbose --current | grep ^"$MON1" -A5 | head -n5 | tail -n1)
CurrGamma="${CurrGamma##* }" # Get Gamma string

# Get and invert gamma values
#  - xrandr does this weird thing where the rgb values are printed as their inverse,
#    so we need to counteract that until this bug is fixed
rgb=($(echo $CurrGamma | tr ":" " "))

red=${rgb[0]}
#[[ $(echo "$red >= 1.00" | bc) ]] &&
red=$(echo "scale=2; 1.00 / $red" | bc)
green=${rgb[1]}
#[[ $(echo "$green >= 1.00" | bc) ]] &&
green=$(echo "scale=2; 1.00 / $green" | bc)
blue=${rgb[2]}
#[[ $(echo "$blue != 1.00" | bc) ]] &&
blue=$(echo "scale=2; 1.00 / $blue" | bc)

CurrGamma="$red:$green:$blue" # Reconstruct gamma value

Left=${CurrBright%%"."*} # Extract left of decimal point
Right=${CurrBright#*"."} # Extract right of decimal point

MathBright="0"
[[ "$Left" != 0 && "$STEP" -lt 10 ]] && STEP=10 # > 1.0, only .1 works
[[ "$Left" != 0 ]] && MathBright="$Left"00      # 1.0 becomes "100"
[[ "${#Right}" -eq 1 ]] && Right="$Right"0      # 0.5 becomes "50"
MathBright=$((MathBright + Right))

[[ "$1" == "Up" || "$1" == "+" ]] && MathBright=$((MathBright + STEP))
[[ "$1" == "Down" || "$1" == "-" ]] && MathBright=$((MathBright - STEP))
[[ "$1" == "ResetBrightness" || "$1" == "-" ]] && MathBright=100
[[ "$1" == "ResetGamma" || "$1" == "-" ]] && CurrGamma="1:1:1"

# Change gamma value
if [[ "$1" == "GammaUp" ]]; then
	red=$(echo "$red + $deltared" | bc)
	green=$(echo "$green + $deltagreen" | bc)
	blue=$(echo "$blue + $deltablue" | bc)
	CurrGamma="$red:$green:$blue" # Reconstruct gamma value
fi
if [[ "$1" == "GammaDown" ]]; then
	red=$(echo "$red - $deltared" | bc)
	green=$(echo "$green - $deltagreen" | bc)
	blue=$(echo "$blue - $deltablue" | bc)
	CurrGamma="$red:$green:$blue" # Reconstruct gamma value
fi

[[ "${MathBright:0:1}" == "-" ]] && MathBright=0 # Negative not allowed
[[ $MathBright -gt 999 ]] && MathBright=999      # Can't go over 9.99

if [[ "${#MathBright}" -eq 3 ]]; then
	MathBright="$MathBright"000 # Pad with lots of zeros
	CurrBright="${MathBright:0:1}.${MathBright:1:2}"
else
	MathBright="$MathBright"000 # Pad with lots of zeros
	CurrBright=".${MathBright:0:2}"
fi

# Set new brightness and gamma for all three defined monitors
xrandr --output "$MON1" --brightness "$CurrBright" --gamma "$CurrGamma"
xrandr --output "$MON2" --brightness "$CurrBright" --gamma "$CurrGamma"
xrandr --output "$MON3" --brightness "$CurrBright" --gamma "$CurrGamma"
