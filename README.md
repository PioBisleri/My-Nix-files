# ❄️ NixOS Configuration

Personal NixOS flake configuration for my daily driver — Hyprland on Wayland, Catppuccin Mocha themed end-to-end.

## Layout

```
├── flake.nix                    # Flake entry point
├── configuration.nix            # System module imports
├── hardware-configuration.nix   # Auto-generated hardware config
├── home.nix                     # Home-manager module imports
│
├── sys-modules/
│   ├── base.nix                 # Bootloader, networking, timezone, flakes
│   ├── display.nix             # SDDM + Hyprland
│   ├── audio.nix               # PipeWire
│   ├── hardware.nix            # Bluetooth
│   ├── packages.nix            # System-wide packages & fonts
│   ├── users.nix               # User veer (wheel, polkit)
│   └── virtualisation.nix      # VirtualBox
│
└── hm-modules/
    ├── packages.nix             # User packages + yazi config
    ├── zsh.nix                  # Zsh + starship prompt
    ├── bash.nix                 # Bash aliases
    ├── git.nix                  # Git config
    ├── hyprland.nix             # Full Hyprland config (keybinds, animations, rules)
    ├── hyprlock.nix             # Lock screen
    ├── kitty.nix                # Kitty terminal
    ├── waybar.nix               # Waybar config + style + utility scripts
    ├── wofi.nix                 # Wofi launcher
    ├── gtk.nix                  # Catppuccin GTK theme + Papirus icons
    └── services.nix             # Mako, hypridle, battery monitor
```

## Highlights

- **Flake-based** — nixos-unstable + home-manager + [areofyl-fetch](https://github.com/areofyl/fetch)
- **Hyprland** — fully configured with scratchpad, resize submap, media/brightness keys, animations
- **Waybar** — CPU, memory, net-speed, Bluetooth, pulseaudio, battery, power menu
- **Scripts** — wallpaper selector, clipboard manager (cliphist), power profiles, memory manager
- **Catppuccin Mocha** — GTK, kitty, waybar, wofi, starship all themed
- **JetBrainsMono Nerd Font** everywhere
- **Bibata cursor**, Papirus icons, Kitty terminal with blur

## Usage

```bash
# Rebuild system
sudo nixos-rebuild switch --flake .#nixos

# Update flake inputs
sudo nix flake update --flake /etc/nixos

# Garbage collect
sudo nix-collect-garbage -d
```
