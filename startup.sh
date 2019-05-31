#!/bin/bash

# start our composite manager
exec compton -b

# onscreen keyboard
exec /usr/bin/onboard

# Set the bg color
exec /usr/bin/feh --bg-center "/home/david/Pictures/wallpaper/$(ls -1 ~/Pictures/wallpaper/ | shuf -n 1)"

# Start the network manager
exec /usr/sbin/nm-applet

# Start the bluetooth manager applet
exec sudo /usr/sbin/blueman-applet

# Set the keyboard to GB
exec setxkbmap gb

# Start xfce power manager
exec sudo /usr/sbin/xfce4-power-manager
