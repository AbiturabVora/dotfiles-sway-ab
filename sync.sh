#!/usr/bin/env bash
# Copy live configs into the repo (if they are not already symlinked), then commit and push.
# Usage: ./sync.sh "what I changed"
set -e
cd "$(dirname "$(readlink -f "$0")")"

DIRS=(sway waybar rofi foot wlogout fastfetch swayidle swayosd dunst gtk-3.0)

for d in "${DIRS[@]}"; do
  src="$HOME/.config/$d"
  dst="config/$d"
  [ -d "$src" ] || continue
  if [ "$(readlink -f "$src")" != "$(readlink -f "$dst")" ]; then
    mkdir -p "$dst"
    if command -v rsync >/dev/null; then
      rsync -a --delete --exclude 'config.d/99-local.conf' "$src/" "$dst/"
    else
      cp -a "$src/." "$dst/"
    fi
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
