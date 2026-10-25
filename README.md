# dotfiles-sway-ab

My Fedora Sway setup in Catppuccin Mocha.

<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/c5f89f79-372c-4449-bb80-dec7060475b9" />


## What's inside

Sway, Waybar, rofi, foot, dunst, wlogout, swayidle, swayosd, fastfetch, starship, Nemo, SDDM theme, Catppuccin GTK theme, Papirus icons and cursors.

## Install

```bash
sudo dnf install -y git
git clone https://github.com/AbiturabVora/dotfiles-sway-ab.git ~/dotfiles
cd ~/dotfiles
./install.sh
```

Options:

- `./install.sh --links` only links the configs, with no installs
- `./install.sh --sddm` also installs the login theme

Old configs are saved to `~/.dotfiles-backup/` before linking. Then log out and back in.

## Keys

`Mod` is the Super key.

| Keys | Action |
|---|---|
| `Mod` + `Return` | Terminal |
| `Mod` + `Space` | App launcher |
| `Mod` + `q` | Close window |
| `Mod` + `f` | Fullscreen |
| `Mod` + `Shift` + `Space` | Toggle floating |
| `Mod` + `1`-`9` | Switch workspace |
| `Mod` + `Shift` + `c` | Reload Sway |
| `Print` | Screenshot to clipboard |
| `Mod` + `Print` | Area screenshot |
| `Mod` + `Shift` + `s` | Save area screenshot |
| `Mod` + `Shift` + `a` | Annotate area screenshot |

## Save changes

```bash
~/dotfiles/sync.sh "what I changed"
```

## Notes

- Install a Nerd Font or icons will show as boxes. The installer does this for you.
- Per-machine settings (monitors, touchpad) go in `config/sway/config.d/99-local.conf`, which is not tracked by git.
- NVIDIA hybrid laptop lagging? Run Sway on the integrated GPU. Find it with `ls -l /dev/dri/by-path/`, then put this in `~/.config/environment.d/sway.conf` and log out and in:
  ```
  WLR_DRM_DEVICES=/dev/dri/card1
  ```
- Never run git with `sudo`.

## Credits

[Catppuccin](https://github.com/catppuccin) and [Fausto-Korpsvart's GTK theme](https://github.com/Fausto-Korpsvart/Catppuccin-GTK-Theme).
