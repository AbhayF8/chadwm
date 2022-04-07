#!/bin/sh

# this is just an example!
# add your autostart stuffs here
#xrdb merge ~/.Xresources &
feh --bg-fill ~/Pictures/wall/wall.png &
# run bar script and dwm ( do not remove this )
bash ~/.config/chadwm/scripts/./dwmbar.sh &

#
safeeyes &
light -S 50.2
# stalonetray --icon-size=16 --kludges=force_icons_size &
redshift &
if 
[[ $(xrandr -q | grep " connected" | cut -d ' ' -f1 | tail -n 1) == "HDMI-A-0" ]]
then 
alacritty -e kodi &
fi
#
/usr/local/bin/dwm
