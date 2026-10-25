#!/bin/bash
# Restore SDDM theme and config (run on a fresh install)
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
sudo cp -r "$DIR"/themes/* /usr/share/sddm/themes/
sudo mkdir -p /etc/sddm.conf.d
sudo cp "$DIR"/conf.d/* /etc/sddm.conf.d/
if [ -f /etc/sddm.conf ] && grep -q '^Current=' /etc/sddm.conf; then
  echo "WARNING: /etc/sddm.conf sets a theme and overrides conf.d. Remove its [Theme] Current= line:"
  echo "  sudo nano /etc/sddm.conf"
fi
echo "SDDM theme restored. Make sure the dependencies are installed."
