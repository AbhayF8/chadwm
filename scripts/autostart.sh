#!/bin/sh

# this is just an example!
# add your autostart stuffs here
#xrdb merge ~/.Xresources &
feh --bg-fill ~/Pictures/wall/wall.png &
# run bar script and dwm ( do not remove this )
bash ~/.config/chadwm/scripts/./bar.sh &
dwm
