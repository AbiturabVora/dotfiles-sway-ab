<div align="center">

# 🌙 dotfiles-sway-ab

**A floating-island Sway desktop on Fedora, wrapped in [Catppuccin Mocha](https://github.com/catppuccin/catppuccin).**

![Fedora](https://img.shields.io/badge/Fedora-51A2DA?style=for-the-badge&logo=fedora&logoColor=white)
![Sway](https://img.shields.io/badge/Sway-68751C?style=for-the-badge&logo=wayland&logoColor=white)
![Catppuccin](https://img.shields.io/badge/Catppuccin-Mocha-cba6f7?style=for-the-badge&labelColor=1e1e2e)
![Shell](https://img.shields.io/badge/Starship-DD0B78?style=for-the-badge&logo=starship&logoColor=white)

[Install](#-quick-install) · [Structure](#-structure) · [Keys](#%EF%B8%8F-keybindings) · [Sync](#-keeping-it-in-sync) · [Troubleshooting](#-troubleshooting)

</div>

<!-- Add screenshots here:
<p align="center"><img src="screenshots/desktop.png" width="90%"></p>
-->

---

## ✨ What's inside

| | Component | Details |
|---|---|---|
| 🪟 | **Sway** | Gaps, thin pixel borders, Catppuccin colours |
| 📊 | **Waybar** | Floating "island" modules, one accent colour per module |
| 🚀 | **rofi** | App icons with Apps, Run and Windows modes |
| 💻 | **foot** | Transparent background, JetBrainsMono Nerd Font 12 |
| ⏻ | **wlogout** | Logout, suspend, reboot and shutdown |
| 🖼️ | **fastfetch** | Custom image logo with Catppuccin colours |
| 💜 | **starship** | Catppuccin powerline prompt |
| 🔒 | **swayidle + swaylock** | Lock after 3 minutes, screen off 10 seconds later |
| 📸 | **grim + slurp + swappy** | Full screen, area, and annotated screenshots |
| 📁 | **Thunar** | Themed with the GTK theme |
| 🔐 | **SDDM** | Catppuccin Mocha Mauve login, remembers last user |
| 🎨 | **Theming** | Catppuccin GTK, Papirus-Dark icons, Bibata cursor |

---


## Looks

<img width="1918" height="1073" alt="image" src="https://github.com/user-attachments/assets/d6d71de4-2895-4ecb-a109-2cb783edeef4" />



## 🚀 Quick install

> Built for **Fedora**. The installer uses `dnf`, so other distributions need small changes.

```bash
sudo dnf install -y git
git clone git@github.com:AbiturabVora/dotfiles-sway-ab.git ~/dotfiles
cd ~/dotfiles
./install.sh --sddm
```

No SSH key on the new PC? Clone over HTTPS instead:

```bash
git clone https://github.com/AbiturabVora/dotfiles-sway-ab.git ~/dotfiles
```

Then log out and back in, or reload Sway with `Mod` + `Shift` + `C`.

### 🔧 Installer options

| Command | What it does |
|---|---|
| `./install.sh` | Installs packages, fonts and themes, then links configs |
| `./install.sh --links` | Only links configs, with no installs |
| `./install.sh --sddm` | Everything above, plus the SDDM login theme |

> 🛟 **Safe by design:** existing configs are moved to `~/.dotfiles-backup/<time>/` before linking. Nothing is deleted.

### 🧩 Not handled by the installer

Two things are set up by hand:

```bash
# prompt
sudo dnf install starship
echo 'eval "$(starship init bash)"' >> ~/.bashrc

# cursor: download Bibata-Modern-Classic.tar.xz from
# https://github.com/ful1e5/Bibata_Cursor/releases, then:
mkdir -p ~/.local/share/icons
tar -xf ~/Downloads/Bibata-Modern-Classic.tar.xz -C ~/.local/share/icons
```

---

## 📁 Structure

```
dotfiles/
├── install.sh
├── sync.sh
├── config/
│   ├── sway/          # sway config, screenshot.sh
│   ├── waybar/        # config.jsonc, style.css
│   ├── rofi/          # config.rasi, catppuccin-mocha.rasi
│   ├── foot/          # foot.ini
│   ├── wlogout/       # layout, style.css
│   ├── fastfetch/     # config.jsonc
│   ├── swayidle/      # config
│   ├── gtk-3.0/       # settings.ini
│   └── starship.toml
├── wallpapers/        # wall.png, fetch.png
└── sddm/              # sddm.conf
```

---

## 🔄 Keeping it in sync

**Save your changes to GitHub with one command:**

```bash
~/dotfiles/sync.sh "what I changed"
```

It copies your configs from `~/.config` into the repo, then commits, pulls and pushes.

**Update another PC:**

```bash
cd ~/dotfiles
git pull origin main
./install.sh --links
```

> ⚠️ Never run git with `sudo`. Root has no SSH key, and it leaves root-owned files inside `.git`.

---

## ⌨️ Keybindings

`Mod` is the Super (Windows) key.

| Keys | Action |
|---|---|
| `Mod` + `Return` | Open terminal |
| `Mod` + `d` | App launcher |
| `Mod` + `q` | Close window |
| `Mod` + `Shift` + `c` | Reload Sway |
| `Mod` + `1` … `9` | Switch workspace |
| `Mod` + `f` | Fullscreen |
| `Print` | Screenshot of the whole screen to the clipboard |
| `Mod` + `Print` | Select an area and copy it |
| `Mod` + `Shift` + `s` | Select an area and save it to `~/Pictures/Screenshots` |
| `Mod` + `Shift` + `a` | Select an area and annotate it in swappy |

Volume and brightness keys use Fedora's default bindings. Everything else follows default Sway.

---

## 🎨 Customising

- **Accent colour:** replace mauve (`#cba6f7`) with another colour from the [Catppuccin palette](https://catppuccin.com/palette).
- **Bar size:** change `height`, `margin-top` and `spacing` in `config/waybar/config.jsonc`.
- **Gaps:** change `gaps inner` and `gaps outer` near the bottom of the Sway config.
- **Wallpaper:** replace `wallpapers/wall.png`, or edit the `output * bg` line.
- **Terminal transparency:** change `alpha=` in `config/foot/foot.ini`.
- **Idle timers:** edit `config/swayidle/config`, then run `pkill swayidle && swaymsg exec 'swayidle -w'`.
- **Cursor:** set in three places, `gsettings`, `config/gtk-3.0/settings.ini` and the `seat seat0 xcursor_theme` line in the Sway config.

---

## 📝 Good to know

- 📌 **Order matters.** Fedora's defaults load from the `include` line near the end of the Sway config. Anything that must override them (wallpaper, screenshot keys, swayidle) goes **below** that line.
- 🔒 **Idle lock.** The screen locks after **3 minutes** and turns off 10 seconds later. Apps keep running, and you enter your password to return.
- 🟢 **Nvidia.** The machine uses the proprietary driver, so check the Sway config with `sway -C --unsupported-gpu`.
- 🔤 **Nerd Font required.** Waybar, rofi, foot and fastfetch use its icons.
- 🖼️ **fastfetch image logo** needs a terminal with sixel support. foot has it.
- 🏠 **Paths.** Configs were written for `/home/abi`, and the installer rewrites this to your home folder.
- 🖥️ **SDDM.** Test the theme before you reboot:
  ```bash
  sddm-greeter-qt6 --test-mode --theme /usr/share/sddm/themes/catppuccin-mocha-mauve
  ```
  To go back to the default, set `Current=03-sway-fedora` in `/etc/sddm.conf`.

---

## 🧯 Troubleshooting

| Problem | Fix |
|---|---|
| Wallpaper does not change | Move the `output * bg` line below the `include` line |
| Icons show as boxes | Install the Nerd Font, then run `fc-cache -f` |
| Red bar after reload | Click **Toggle details**. Warnings about overwriting bindings are fine |
| Screen never locks | Check `pgrep -a swayidle` and that `swaylock` is installed |
| Cursor looks wrong | Check the cursor name in `settings.ini` and the Sway config |
| App closes at once on Wayland | Try `GDK_BACKEND=x11 app` or `WEBKIT_DISABLE_DMABUF_RENDERER=1 app` |
| Push is rejected | Run `git pull origin main --no-rebase`, then push again |
| `Permission denied (publickey)` | You used `sudo`, or the SSH key isn't loaded. Test with `ssh -T git@github.com` |

---

## 🙏 Credits

- [Catppuccin](https://github.com/catppuccin) for the palette and themes
- [Fausto-Korpsvart/Catppuccin-GTK-Theme](https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme) for the GTK theme
- [Bibata Cursor](https://github.com/ful1e5/Bibata_Cursor) for the cursor
- The Sway, Waybar, rofi, foot, wlogout, starship and fastfetch projects

---

<div align="center">

Made on Fedora with 💜

</div>
