# dotfiles-sway-ab

My Fedora + Sway setup, themed with Catppuccin Mocha.

## What is included

- Sway (window manager)
- Waybar (status bar)
- rofi (app launcher)
- foot (terminal)
- wlogout (power menu)
- fastfetch (system info)
- starship (shell prompt)
- swayidle + swaylock (lock screen on idle)
- grim, slurp, swappy (screenshots)
- Thunar (file manager)
- SDDM (login screen)
- Catppuccin GTK theme, Papirus icons, Catppuccin cursors

## Install

This is made for Fedora. The installer uses `dnf`.

```bash
sudo dnf install -y git
git clone git@github.com:AbiturabVora/dotfiles-sway-ab.git ~/dotfiles
cd ~/dotfiles
./install.sh --sddm
```

If you have no SSH key on the new PC, clone with HTTPS instead:

```bash
git clone https://github.com/AbiturabVora/dotfiles-sway-ab.git ~/dotfiles
```

Then log out and back in, or reload Sway with `Mod+Shift+C`.

### Installer options

| Command | What it does |
|---|---|
| `./install.sh` | Install packages, fonts and themes, then link configs |
| `./install.sh --links` | Only link configs |
| `./install.sh --sddm` | Everything above, plus the SDDM login theme |

Old configs are moved to `~/.dotfiles-backup/<time>/` before linking. Nothing is deleted.

## Folder layout

```
dotfiles/
  install.sh
  sync.sh
  config/
    sway/
    waybar/
    rofi/
    foot/
    wlogout/
    fastfetch/
    swayidle/
    gtk-3.0/
    starship.toml
  wallpapers/
  sddm/
```

## Save changes to GitHub

Run the sync script from anywhere:

```bash
~/dotfiles/sync.sh "what I changed"
```

It copies your configs from `~/.config` into the repo, then commits, pulls and pushes. Do not use `sudo` with git.

To update another PC:

```bash
cd ~/dotfiles
git pull origin main
./install.sh --links
```

## Main keys

`$mod` is the Super key.

| Keys | Action |
|---|---|
| `$mod + Return` | Terminal |
| `$mod + d` | App launcher |
| `$mod + q` | Close window |
| `$mod + Shift + c` | Reload Sway |
| `$mod + 1 to 9` | Switch workspace |
| `Print` | Screenshot to clipboard |
| `$mod + Print` | Select area, copy to clipboard |
| `$mod + Shift + s` | Select area, save to `~/Pictures/Screenshots` |
| `$mod + Shift + a` | Select area, annotate in swappy |

## Notes

- Anything that must override Fedora's defaults goes below the `include` line at the bottom of the Sway config.
- The screen locks after 60 seconds idle and turns off after 70. Apps keep running. Change the numbers in `config/swayidle/config`.
- A Nerd Font (JetBrainsMono) is needed for the icons.
- The machine uses the Nvidia driver, so check the Sway config with `sway -C --unsupported-gpu`.
- Configs were written for `/home/abi`. The installer rewrites this to your home folder.

## Troubleshooting

| Problem | Fix |
|---|---|
| Wallpaper does not change | Move the `output * bg` line below the `include` line |
| Icons show as boxes | Install the Nerd Font, then run `fc-cache -f` |
| Red bar after reload | Click Toggle details. Warnings about overwriting bindings are fine |
| Screen never locks | Check `pgrep -a swayidle` and that `swaylock` is installed |
| Push is rejected | Run `git pull origin main --no-rebase`, then push again |
