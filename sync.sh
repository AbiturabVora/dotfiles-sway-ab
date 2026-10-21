#!/usr/bin/env bash
set -e
cd ~/dotfiles

for d in sway waybar rofi foot wlogout fastfetch swayidle gtk-3.0; do
  src="$HOME/.config/$d"
  dst="config/$d"
  [ -d "$src" ] || continue
  if [ "$(readlink -f "$src")" != "$(readlink -f "$dst")" ]; then
    rsync -a --delete "$src/" "$dst/"
  fi
done

src="$HOME/.config/starship.toml"
if [ -f "$src" ] && [ "$(readlink -f "$src")" != "$(readlink -f config/starship.toml)" ]; then
  cp "$src" config/starship.toml
fi

git add -A
git commit -m "${1:-update}" || echo "Nothing new to commit"
git pull origin main --no-rebase
git push origin main
