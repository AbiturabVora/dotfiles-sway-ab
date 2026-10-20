#!/bin/bash
dir="$HOME/Pictures/Screenshots"
mkdir -p "$dir"
file="$dir/$(date +%Y-%m-%d_%H-%M-%S).png"

case "$1" in
  full) grim - | wl-copy ;;
  area) geo=$(slurp) || exit 0; grim -g "$geo" - | wl-copy ;;
  save) geo=$(slurp) || exit 0; grim -g "$geo" "$file" ;;
  edit) geo=$(slurp) || exit 0; grim -g "$geo" - | swappy -f - ;;
esac
