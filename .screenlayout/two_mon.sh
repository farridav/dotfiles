#!/bin/sh

xrandr \
    --output HDMI-2 --off \
    --output HDMI-1 --off \
    --output DP-2 --off \
    --output eDP-1 --primary --pos 0x0 --rotate normal --mode "2560x1440" \
    --output DP-1 --same-as eDP1
