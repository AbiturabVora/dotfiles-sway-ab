#!/bin/bash
# Restore SDDM theme and config (run on a fresh install)
set -e
DIR="$(cd "$(dirname "$0")" && pwd)"
sudo cp -r "$DIR"/themes/* /usr/share/sddm/themes/
sudo mkdir -p /etc/sddm.conf.d
sudo cp "$DIR"/conf.d/* /etc/sddm.conf.d/
echo "SDDM theme restored. Make sure the dependencies are installed."
