#!/bin/sh
ksuperkey -e 'Super_L=Alt_L|F1' &
ksuperkey -e 'Super_R=Alt_L|F1' &
# this is just an example!
# add your autostart stuffs here
#xrdb merge ~/.Xresources &
feh --bg-fill ~/Pictures/wall/wall.png &
# run bar script and dwm ( do not remove this )
bash ~/.config/chadwm/scripts/./dwmbar.sh &

#Autostart apps
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


#Starting DWM
/usr/local/bin/dwm
