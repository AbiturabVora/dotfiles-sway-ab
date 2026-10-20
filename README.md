<div align="center">

# 🌙 dotfiles-sway-ab

**A clean, floating-island Sway desktop on Fedora, themed with [Catppuccin Mocha](https://github.com/catppuccin/catppuccin).**

![Fedora](https://img.shields.io/badge/Fedora-51A2DA?style=for-the-badge&logo=fedora&logoColor=white)
![Sway](https://img.shields.io/badge/Sway-68751C?style=for-the-badge&logo=wayland&logoColor=white)
![Catppuccin](https://img.shields.io/badge/Catppuccin-Mocha-cba6f7?style=for-the-badge&labelColor=1e1e2e)

</div>

<!-- Add screenshots here, for example:
![desktop](screenshots/desktop.png)
-->

---

## ✨ What's inside

| Component | Tool | Notes |
|---|---|---|
| Window manager | [Sway](https://swaywm.org) | Gaps, thin pixel borders, Catppuccin colours |
| Status bar | [Waybar](https://github.com/Alexays/Waybar) | Floating "island" modules, per-module accent colours |
| Launcher | [rofi](https://github.com/davatorium/rofi) | App icons, Apps / Run / Windows modes |
| Terminal | [foot](https://codeberg.org/dnkl/foot) | Transparent background, JetBrainsMono Nerd Font 12 |
| Power menu | [wlogout](https://github.com/ArtsyMacaw/wlogout) | Logout, suspend, reboot, shutdown |
| On-screen display | [SwayOSD](https://github.com/ErikReider/SwayOSD) | Slim volume and brightness popup |
| System info | [fastfetch](https://github.com/fastfetch-cli/fastfetch) | Custom image logo and Catppuccin colours |
| Screenshots | grim + slurp + swappy | Area, full screen, and annotate |
| Idle & lock | swayidle + swaylock | Locks the screen, then turns it off (apps keep running) |
| File manager | Thunar | GTK theme applied |
| Login screen | [SDDM](https://github.com/catppuccin/sddm) | Catppuccin Mocha Mauve, remembers last user |
| GTK theme | [Catppuccin GTK](https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme) | Dark, Papirus-Dark icons, Catppuccin cursors |

---


## Image

<img width="1920" height="1080" alt="2026-10-20_07-14-14" src="https://github.com/user-attachments/assets/477aac1e-df23-4487-a586-a4c215d51de8" />


## 🚀 Quick install

> Built for **Fedora**. The installer uses `dnf`, so other distributions need small changes.

```bash
sudo dnf install -y git
git clone git@github.com:AbiturabVora/dotfiles-sway-ab.git ~/dotfiles
cd ~/dotfiles
./install.sh --sddm
```

Use HTTPS if you haven't set up an SSH key on the new machine:

```bash
git clone https://github.com/AbiturabVora/dotfiles-sway-ab.git ~/dotfiles
```

Then log out and back in, or reload Sway with `Mod+Shift+C`.

### Installer options

| Command | What it does |
|---|---|
| `./install.sh` | Installs packages, fonts and themes, then links the configs |
| `./install.sh --links` | Only links the configs (no installs or downloads) |
| `./install.sh --sddm` | Everything above, plus the SDDM login theme (needs `sudo`) |

### What the installer does

1. Installs the packages (Sway, Waybar, rofi, foot, wlogout, fastfetch, grim, slurp, swappy, Thunar, SwayOSD and others). A failed package prints a warning and the script continues.
2. Installs the **JetBrainsMono Nerd Font**, the **Catppuccin GTK theme** and the **Catppuccin cursors**, then applies them with `gsettings`.
3. Symlinks every folder in `config/` into `~/.config`. Existing configs are **moved to `~/.dotfiles-backup/<timestamp>/`**, never deleted.
4. Copies the wallpapers to `~/Pictures`.
5. Rewrites `/home/abi` to your home directory when the username is different.
6. With `--sddm`, installs the login theme and writes `/etc/sddm.conf`.

---

## 📁 Structure

```
dotfiles/
├── install.sh
├── config/
│   ├── sway/          # sway config, screenshot.sh
│   ├── waybar/        # config.jsonc, style.css
│   ├── rofi/          # config.rasi, catppuccin-mocha.rasi
│   ├── foot/          # foot.ini
│   ├── wlogout/       # layout, style.css
│   ├── fastfetch/     # config.jsonc
│   ├── swayosd/       # style.css, config.toml
│   ├── swayidle/      # config
│   └── gtk-3.0/       # settings.ini
├── wallpapers/        # wall.png, fetch.png
└── sddm/              # sddm.conf
```

After `./install.sh` (or `./install.sh --links`), the configs in `~/.config` are **symlinks** into this repo, so editing a file there edits the repo file directly. If you copied the files by hand instead, copy changes back into `config/` yourself. To save changes:

```bash
cd ~/dotfiles
git add -A && git commit -m "update" && git push
```

---

## ⌨️ Keybindings

`$mod` is the Super (Windows) key.

| Keys | Action |
|---|---|
| `$mod + Return` | Open terminal (foot) |
| `$mod + d` | Application launcher (rofi) |
| `$mod + q` | Close window |
| `$mod + Shift + c` | Reload Sway |
| `$mod + Shift + e` | Exit Sway |
| `$mod + 1…9` | Switch workspace |
| `$mod + Shift + 1…9` | Move window to workspace |
| `$mod + f` | Fullscreen |
| `$mod + r` | Resize mode |
| `Print` | Screenshot of the whole screen to the clipboard |
| `$mod + Print` | Select an area and copy it to the clipboard |
| `$mod + Shift + s` | Select an area and save it to `~/Pictures/Screenshots` |
| `$mod + Shift + a` | Select an area and annotate it in swappy |
| Volume / brightness keys | SwayOSD popup |

Everything else follows the default Sway bindings. The full list is in `config/sway/config`.

---

## 🎨 Customising

- **Colours:** every config uses the Catppuccin Mocha palette. To change the accent, replace the mauve value (`#cba6f7`) with another colour from the [Catppuccin palette](https://catppuccin.com/palette).
- **Bar size:** in `config/waybar/config.jsonc`, change `height`, `margin-top` and `spacing`. In `style.css`, change `font-size` and `padding`.
- **Gaps:** change `gaps inner` and `gaps outer` near the bottom of the Sway config.
- **Wallpaper:** replace `wallpapers/wall.png`, or change the `output * bg ...` line at the **bottom** of the Sway config.
- **Terminal transparency:** change `alpha=` in `config/foot/foot.ini`.
- **Idle timers:** edit `config/swayidle/config`, then restart it with `pkill swayidle && swaymsg exec 'swayidle -w'`.

---

## ⚠️ Things to know

- **Order matters in the Sway config.** Fedora's own defaults load from the `include` line near the end. Anything that must override them (wallpaper, screenshot and media bindings, `swayidle`) goes **below** that line.
- **Idle lock.** The screen **locks after 60 seconds** idle and **turns off after 70**. Nothing is closed, so apps and downloads keep running, and you enter your password to return. Change the numbers in `config/swayidle/config`. Start it with `exec swayidle -w` at the bottom of the Sway config.
- **SwayOSD** comes from a COPR repository, since it is not in Fedora's main repos. The server starts with a short delay at login so D-Bus is ready.
- **Nerd Font required.** Waybar, rofi, foot and fastfetch use its icons. Without it you will see empty boxes.
- **fastfetch image logo** needs a terminal with sixel support (foot works).
- **SDDM:** test the theme before rebooting with:
  ```bash
  sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/catppuccin-mocha-mauve
  ```
  To go back to the default theme, set `Current=03-sway-fedora` in `/etc/sddm.conf`.

---

## 🧯 Troubleshooting

| Problem | Fix |
|---|---|
| Waybar has no workspace highlight | The module is `sway/workspaces`, and the active class is `.focused` |
| Red error bar after reload | Click "Toggle details". Warnings about "overwriting binding" are harmless |
| Wallpaper doesn't change | Move the `output * bg` line below the `include` line |
| Volume keys do nothing | Make sure `swayosd-server` is running: `pgrep -a swayosd` |
| Screen never locks | Check `pgrep -a swayidle` shows one process, and that `swaylock` is installed |
| `swaymsg exec swayidle -w` errors | Quote it: `swaymsg exec 'swayidle -w'` |
| Thunar won't open | `pkill -9 thunar`, then reboot or restart the session |
| Icons show as boxes | Install the Nerd Font and run `fc-cache -f` |

---

## 🙏 Credits

- [Catppuccin](https://github.com/catppuccin) for the palette and themes
- [Fausto-Korpsvart/Catppuccin-GTK-Theme](https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme) for the GTK theme
- The Sway, Waybar, rofi, foot, wlogout and SwayOSD projects

---

<div align="center">

Made on Fedora with 💜

</div>

</div>
