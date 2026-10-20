#!/usr/bin/env bash
# Dotfiles installer — Fedora + Sway + Catppuccin Mocha
#
# Usage:
#   ./install.sh              install packages, fonts, themes, and link configs
#   ./install.sh --links     only link configs (no packages, no downloads)
#   ./install.sh --sddm      also install the SDDM login theme (needs sudo)
#
# Existing configs are moved to ~/.dotfiles-backup/<timestamp>/ before linking.

set -uo pipefail

DOTS="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONFIG="$HOME/.config"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
OLD_USER="abi"            # username the configs were written with

DO_PACKAGES=1
DO_SDDM=0
for arg in "$@"; do
  case "$arg" in
    --links) DO_PACKAGES=0 ;;
    --sddm)  DO_SDDM=1 ;;
    -h|--help) sed -n '2,10p' "$0"; exit 0 ;;
    *) echo "Unknown option: $arg"; exit 1 ;;
  esac
done

say()  { printf '\n\033[1;35m==> %s\033[0m\n' "$*"; }
warn() { printf '\033[1;33m[warn]\033[0m %s\n' "$*"; }

# ---------------------------------------------------------------- packages
install_packages() {
  say "Installing packages"

  PKGS=(
    sway waybar foot wlogout fastfetch
    grim slurp wl-clipboard swappy swaylock swayidle jq
    thunar thunar-volman gvfs tumbler xfconf
    papirus-icon-theme brightnessctl pavucontrol blueman
    network-manager-applet git curl unzip wev
    gtk-murrine-engine gnome-themes-extra sassc qt6-qtsvg
    qt5ct qt6ct kvantum
  )
  for p in "${PKGS[@]}"; do
    sudo dnf install -y "$p" || warn "could not install $p"
  done

  # rofi: wayland build name differs between Fedora releases
  sudo dnf install -y rofi-wayland || sudo dnf install -y rofi || warn "could not install rofi"

  # swayosd lives in COPR
  sudo dnf copr enable -y erikreider/swayosd \
    && sudo dnf install -y swayosd || warn "could not install swayosd"
}

# ------------------------------------------------------------------- fonts
install_fonts() {
  say "Installing JetBrainsMono Nerd Font"
  if fc-list | grep -qi "JetBrainsMono Nerd"; then
    echo "already installed"
    return
  fi
  mkdir -p "$HOME/.local/share/fonts/JetBrainsMono"
  tmp="$(mktemp -d)"
  curl -L -o "$tmp/font.zip" \
    https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip \
    && unzip -o "$tmp/font.zip" -d "$HOME/.local/share/fonts/JetBrainsMono" >/dev/null \
    && fc-cache -f || warn "font install failed"
  rm -rf "$tmp"
}

# ------------------------------------------------------------------ themes
install_gtk_theme() {
  say "Installing Catppuccin GTK theme"
  if [ -d "$HOME/.themes/Catppuccin-Dark" ]; then
    echo "already installed"
    return
  fi
  tmp="$(mktemp -d)"
  git clone --depth 1 https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme "$tmp/gtk" \
    && (cd "$tmp/gtk/themes" && ./install.sh) || warn "GTK theme install failed"
  rm -rf "$tmp"

  # libadwaita / GTK 4 apps
  T="$HOME/.themes/Catppuccin-Dark/gtk-4.0"
  if [ -d "$T" ]; then
    mkdir -p "$CONFIG/gtk-4.0"
    ln -sf "$T/gtk.css"      "$CONFIG/gtk-4.0/gtk.css"
    ln -sf "$T/gtk-dark.css" "$CONFIG/gtk-4.0/gtk-dark.css"
    ln -sf "$T/assets"       "$CONFIG/gtk-4.0/assets"
  fi
}

install_cursor() {
  say "Installing Catppuccin cursors"
  if [ -d "$HOME/.local/share/icons/catppuccin-mocha-mauve-cursors" ]; then
    echo "already installed"
    return
  fi
  mkdir -p "$HOME/.local/share/icons"
  tmp="$(mktemp -d)"
  curl -L -o "$tmp/cursor.zip" \
    https://github.com/catppuccin/cursors/releases/latest/download/catppuccin-mocha-mauve-cursors.zip \
    && unzip -o "$tmp/cursor.zip" -d "$HOME/.local/share/icons" >/dev/null \
    || warn "cursor install failed"
  rm -rf "$tmp"
}

apply_gsettings() {
  say "Applying GTK settings"
  S=org.gnome.desktop.interface
  gsettings set $S gtk-theme 'Catppuccin-Dark'        2>/dev/null || warn "gsettings gtk-theme failed"
  gsettings set $S icon-theme 'Papirus-Dark'          2>/dev/null || true
  gsettings set $S cursor-theme 'catppuccin-mocha-mauve-cursors' 2>/dev/null || true
  gsettings set $S color-scheme 'prefer-dark'         2>/dev/null || true
}

# ------------------------------------------------------------------- links
link_configs() {
  say "Linking configs into $CONFIG"
  mkdir -p "$CONFIG"

  for src in "$DOTS"/config/*; do
    [ -e "$src" ] || continue
    name="$(basename "$src")"
    dest="$CONFIG/$name"

    if [ -L "$dest" ] && [ "$(readlink -f "$dest")" = "$(readlink -f "$src")" ]; then
      echo "ok      $name (already linked)"
      continue
    fi
    if [ -e "$dest" ] || [ -L "$dest" ]; then
      mkdir -p "$BACKUP"
      mv "$dest" "$BACKUP/$name"
      echo "backup  $name -> $BACKUP/$name"
    fi
    ln -s "$src" "$dest"
    echo "link    $name"
  done

  # wallpapers
  if [ -d "$DOTS/wallpapers" ]; then
    mkdir -p "$HOME/Pictures"
    cp -n "$DOTS"/wallpapers/* "$HOME/Pictures/" 2>/dev/null || true
    mkdir -p "$HOME/Pictures/Screenshots"
  fi

  # scripts that must be executable
  chmod +x "$DOTS"/config/sway/*.sh 2>/dev/null || true
  chmod +x "$DOTS"/config/rofi/*.sh 2>/dev/null || true

  # configs were written for /home/$OLD_USER; rewrite for this machine
  if [ "$USER" != "$OLD_USER" ]; then
    say "Rewriting /home/$OLD_USER -> $HOME"
    grep -rl "/home/$OLD_USER" "$DOTS/config" 2>/dev/null \
      | xargs -r sed -i "s#/home/$OLD_USER#$HOME#g"
  fi
}

# -------------------------------------------------------------------- sddm
install_sddm() {
  say "Installing SDDM Catppuccin theme"
  tmp="$(mktemp -d)"
  curl -L -o "$tmp/sddm.zip" \
    https://github.com/catppuccin/sddm/releases/latest/download/catppuccin-mocha-mauve-sddm.zip \
    && sudo unzip -o "$tmp/sddm.zip" -d /usr/share/sddm/themes/ >/dev/null \
    || { warn "SDDM theme download failed"; rm -rf "$tmp"; return; }
  rm -rf "$tmp"

  if [ -f "$DOTS/sddm/sddm.conf" ]; then
    sudo cp "$DOTS/sddm/sddm.conf" /etc/sddm.conf
  else
    printf '[Theme]\nCurrent=catppuccin-mocha-mauve\n\n[Users]\nRememberLastUser=true\nRememberLastSession=true\n' \
      | sudo tee /etc/sddm.conf >/dev/null
  fi
  echo "SDDM theme set. Test with:"
  echo "  sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/catppuccin-mocha-mauve"
}

# -------------------------------------------------------------------- main
if [ "$DO_PACKAGES" -eq 1 ]; then
  install_packages
  install_fonts
  install_gtk_theme
  install_cursor
fi

link_configs

if [ "$DO_PACKAGES" -eq 1 ]; then
  apply_gsettings
fi

if [ "$DO_SDDM" -eq 1 ]; then
  install_sddm
fi

say "Done"
echo "Log out and back in (or reload Sway with Mod+Shift+C)."
[ -d "$BACKUP" ] && echo "Your old configs were saved in $BACKUP"
exit 0
