#!/bin/bash

WALL="$1"
[-z "$WALL"] && exit 1

swww img "$WALL" --transition-type wipe
--transition-duration 2
matugen image "$WALL"

pkill waybar && waybar &
pkill swaync && swaync &
pkill rofi

hyprctl reload