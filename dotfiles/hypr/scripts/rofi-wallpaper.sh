#!/bin/bash

WALLDIR="$HOME/Pictures/Wallpapers"
CACHEDIR="$HOME/.cache/wallpaper-thumbs"

mkdir -p "$CACHEDIR"

gen_thumb() {
    img="$1"
    name=$(basename "$img")
    thumb="$CACHEDIR/$name.png"

    if [ ! -f "$thumb" ]; then
        magick "$img" -resize 256x256^ -gravity center -extent 256x256 "$thumb"
    fi

    echo -e "$name\0icon\x1f$thumb"
}

SELECTED=$(find "$WALLDIR" -type f \( \
    -iname "*.jpg" -o -iname "*.png" -o -iname "*.jpeg" \
    -o -iname "*.webp" -o -iname "*.avif" \) \
| while read -r img; do
    gen_thumb "$img"
done | rofi -dmenu -show-icons -p "Wallpaper")

[ -z "$SELECTED" ] && exit 0

"$HOME/.config/hypr/scripts/changewp.sh" "$WALLDIR/$SELECTED"