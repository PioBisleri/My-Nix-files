# NixOS Configuration

A modular, flake-based NixOS configuration featuring a Hyprland compositor environment on Wayland with a cohesive Catppuccin Mocha theme across the entire desktop stack. Designed as a daily-driver setup for a personal laptop, with full support for audio, Bluetooth, printing, VirtualBox, screen capture, clipboard management, speech-to-text, and text-to-speech.

The configuration is split into two layers: system-level NixOS modules under `sys-modules/` and user-level Home Manager modules under `hm-modules/`. All user-configurable values (username, hostname, timezone, email) are centralized in `vars.nix`.

---

## Features

- **Flake-based** layout with pinned inputs from nixos-unstable, home-manager, areofyl-fetch, sops-nix, and hermes-agent.
- **Hyprland** compositor with full keybindings, window rules, scratchpad, resize submap, custom animations, media/brightness/volume keys, and Catppuccin Mocha color scheme.
- **Waybar** status bar with CPU, memory, network speed, Bluetooth, PulseAudio, battery, and power menu modules, backed by custom shell scripts.
- **SDDM** display manager themed with sddm-astronaut (hyprland_kath variant), Bibata cursor, and HiDPI support.
- **PipeWire** audio stack with ALSA and PulseAudio compatibility.
- **End-to-end Catppuccin Mocha theming** covering GTK, Kitty, Waybar, Wofi, Starship, and the lock screen.
- **JetBrainsMono Nerd Font** used consistently across terminal, bar, launcher, and prompt.
- **Text-to-speech** using Kokoro models via sherpa-onnx, triggered by hotkey.
- **Speech-to-text** using Voxtype with push-to-talk, wired as a systemd user service.
- **Clipboard management** with cliphist, accessible via a Wofi-based history viewer.
- **Screenshot** workflow: hyprshot capture, quick imv preview, swappy editing.
- **Screen recording** toggle with wf-recorder.
- **Battery monitoring** with automatic power-saver profile switching.
- **Backup** SSH agent enabled.
- **Web application shortcuts** for Gemini, Discord, Instagram, NotebookLM, YouTube Music, and WhatsApp, each running as a dedicated Brave app with isolated user data directories.
- **Emoji picker** via wofi-emoji, keybound to Super+Shift+E.
- **Keybind reference** — Super+K opens a Wofi window listing all current Hyprland keybindings.
- **Secret management** with sops-nix, using age encryption backed by an ed25519 SSH key. Secrets are decrypted at activation time and mounted under `/run/secrets/`.
- **Dedicated gaming module** with Steam (gamescope session, remote play), Gamemode, MangoHud overlay, Gamescope micro-compositor, osu-lazer, and Lutris game manager, plus kernel optimizations for modded games.

---

## Project Structure

```
.
|-- flake.nix                         # Flake entry point: inputs, outputs, specialArgs
|-- flake.lock                        # Locked revisions for all flake inputs
|-- configuration.nix                 # NixOS module imports (system layer)
|-- hardware-configuration.nix        # Auto-generated hardware configuration (machine-specific)
|-- home.nix                          # Home Manager module imports (user layer)
|-- vars.nix                          # Centralized user-configurable variables
|-- .sops.yaml                        # sops-nix age key mapping for encrypted secrets
|-- .editorconfig                     # Editor style rules (2-space indent, UTF-8, LF)
|-- .gitignore                        # Nix build artifacts, swap files, direnv
|-- LICENSE                           # MIT license
|-- README.md                         # This file
|
|-- secrets/                          # sops-nix encrypted secret files
|   |-- system.yaml                   # System-level encrypted secrets
|   |-- user.yaml                     # User-level encrypted secrets
|
|-- sys-modules/                      # System-level NixOS modules
|   |-- base.nix                      # Bootloader, networking, timezone, flakes, unfree
|   |-- display.nix                   # X11, SDDM, Hyprland, US keymap
|   |-- audio.nix                     # PipeWire, ALSA, PulseAudio compat, printing
|   |-- hardware.nix                  # Bluetooth, Blueman
|   |-- users.nix                     # User account, groups, Polkit
|   |-- packages.nix                  # System packages, fonts
|   |-- virtualisation.nix            # VirtualBox host with Extension Pack
|   |-- sddm.nix                      # SDDM theme: sddm-astronaut, Bibata cursor, numlock
|   |-- gaming.nix                    # Steam, Gamescope, Gamemode, MangoHud, Lutris, osu-lazer, kernel tuning
|   |-- hermes.nix                     # Hermes AI agent service
|   |-- secrets.nix                   # sops-nix system-level secret module
|
|-- hm-modules/                       # User-level Home Manager modules
    |-- packages.nix                  # User packages, cursor, desktop entries, Yazi config
    |-- zsh.nix                       # Zsh with autosuggestions, syntax highlighting, Starship prompt
    |-- bash.nix                      # Bash with aliases and fetch startup
    |-- git.nix                       # Git identity and defaults
    |-- gtk.nix                       # Catppuccin Mocha GTK theme, Papirus icons
    |-- hyprland.nix                  # Full Hyprland configuration (keybinds, rules, animations)
    |-- hyprlock.nix                  # Lock screen with blur, clock, and date
    |-- kitty.nix                     # Kitty terminal with Catppuccin colors and blur
    |-- waybar.nix                    # Waybar bar config, CSS styling, and 9 utility scripts
    |-- wofi.nix                      # Wofi launcher and wallpaper picker config
    |-- services.nix                  # Mako, Hypridle, battery monitor, SSH agent, Voxtype
    |-- secrets.nix                   # sops-nix user-level secret module
```

---

## Prerequisites

- NixOS installed with flakes enabled.
- Git cloned repository to a local directory (typically `/etc/nixos` or a home directory).
- Superuser access for system rebuilds.

---

## Getting Started

### For the current user (same username, hostname, etc.)

```bash
# Clone the repository
git clone <repo-url> /etc/nixos

# Rebuild the system
sudo nixos-rebuild switch --flake /etc/nixos#nixos
```

### For a new user or machine

1. Edit `vars.nix` to set your own username, hostname, timezone, full name, and email.
2. Generate a hardware configuration:
   ```bash
   nixos-generate-config --show-hardware-config > /etc/nixos/hardware-configuration.nix
   ```
3. Rebuild:
   ```bash
   sudo nixos-rebuild switch --flake /etc/nixos#<your-hostname>
   ```

### Useful commands

```bash
# Rebuild and switch to the new configuration
sudo nixos-rebuild switch --flake .#nixos

# Update all flake inputs to their latest revisions
sudo nix flake update --flake /etc/nixos

# Garbage collect old generations
sudo nix-collect-garbage -d

# Optimise the Nix store
sudo nix optimise-store
```

---

## Configuration Reference

### vars.nix

A single file holding all user-specific values. Edit this file to adapt the configuration to a different user or machine.

| Variable   | Default         | Description                     |
|------------|-----------------|---------------------------------|
| username   | `"veer"`        | POSIX username for the primary user account |
| hostname   | `"nixos"`       | System hostname                 |
| timezone   | `"Asia/Kolkata"` | System timezone (IANA format)   |
| fullName   | `"Veer"`        | User's full name for account description and Git |
| email      | `"veer@nixos"`  | Email address for Git commits   |

These values are injected into both NixOS and Home Manager modules via `specialArgs` and `extraSpecialArgs` in `flake.nix`.

The configuration also generates a dedicated ed25519 SSH key (`~/.ssh/id_ed25519`) which is converted to an age key for sops-nix secret decryption. The age private key is stored at `~/.config/sops/age/keys.txt`.

---

### System Modules (sys-modules/)

#### base.nix

Configures the base system:

- **Bootloader**: systemd-boot with EFI variable write access.
- **Networking**: hostname from `vars.hostname`, NetworkManager enabled for network management.
- **Timezone**: set from `vars.timezone`.
- **Locale**: en_US.UTF-8 only.
- **Nix**: enables `nix-command` and `flakes` experimental features.
- **Unfree software**: allows packages with unfree licenses.
- **Power profiles**: power-profiles-daemon for performance/balanced/power-saver switching.
- **Shell**: Zsh enabled system-wide.
- **State version**: 26.05.

#### display.nix

Configures the display server and compositor:

- **X11**: enabled as a prerequisite for SDDM.
- **SDDM**: display manager enabled (full theme configuration in `sddm.nix`).
- **Keyboard layout**: US layout.
- **Hyprland**: enabled via `programs.hyprland`.

#### audio.nix

Configures audio and printing:

- **Printing**: CUPS enabled.
- **PulseAudio**: explicitly disabled in favor of PipeWire.
- **PipeWire**: enabled with ALSA (including 32-bit support) and PulseAudio compatibility layer.
- **RTKit**: real-time scheduling for audio daemons.

#### hardware.nix

Configures Bluetooth hardware:

- **Bluetooth**: enabled, powers on at boot.
- **Blueman**: Bluetooth management GUI installed and enabled.

#### users.nix

Configures the primary user account:

- **User account**: created with username from `vars.username`, full name from `vars.fullName`.
- **Groups**: networkmanager, wheel (sudo), vboxusers (VirtualBox), input.
- **Shell**: Zsh.
- **Polkit**: authentication agent for GUI privilege elevation.

#### packages.nix

Installs system-wide packages:

- **Nerd Font**: JetBrainsMono Nerd Font (used by terminal, bar, launcher, and prompt).

- **System packages**: vim, wget, neovim, git, fastfetch, yazi, opencode, obsidian, python3, btop, sherpa-onnx (TTS engine), voxtype-vulkan (speech-to-text), wtype (Wayland keystroke injection), libnotify (desktop notifications), llama-cpp-vulkan (local LLM inference with GPU acceleration), gamescope (game micro-compositor), osu-lazer-bin (rhythm game), mangohud (performance overlay), lutris (game manager).

#### virtualisation.nix

- **VirtualBox**: host support enabled with Extension Pack (USB 2.0/3.0, RDP, PXE boot).

#### sddm.nix

Configures the SDDM display manager theme:

- **Theme**: sddm-astronaut with the embedded `hyprland_kath` variant.
- **Numlock**: auto-enabled on login.
- **HiDPI**: enabled for high-resolution displays.
- **Cursor**: Bibata-Modern-Ice, size 24.
- **Qt multimedia**: installed for theme animations and sounds.

#### gaming.nix

Dedicated gaming module to keep game dependencies isolated from the base system:

- **Steam**: enabled with 32-bit graphics libraries, remote play firewall, dedicated server firewall, and automatic gamescope session wrapping.
- **Gamemode**: CPU governor and I/O priority optimization; games request it automatically.
- **MangoHud**: Vulkan/OpenGL performance overlay (FPS, temperatures, clock speeds), toggle with Shift+F12 inside games.
- **Packages**: gamescope (Wayland micro-compositor for frame pacing and VRR), osu-lazer-bin (rhythm game), mangohud (standalone overlay support), lutris (game manager for GOG, Epic, Battle.net, emulators).
- **Kernel tuning**: `vm.max_map_count` increased to 2147483642 for heavily modded games (Minecraft, Skyrim, Cities: Skylines).
- **32-bit OpenGL**: explicit `driSupport32Bit = true` for legacy game compatibility.

#### secrets.nix

System-level sops-nix secret management:

- **Import**: `inputs.sops-nix.nixosModules.sops` for NixOS integration.
- **SSH key path**: points to `/home/{username}/.ssh/id_ed25519` for age decryption.
- **Default file**: reads from `secrets/system.yaml`.
- **Usage**: system secrets (WiFi credentials, API tokens) are decrypted at activation time and mounted under `/run/secrets/`, never entering the Nix store.

---

#### hermes.nix

Hermes AI agent integration:

- **Service**: enables `services.hermes-agent` for NixOS-level AI agent functionality.
- **Source**: provided by the `hermes-agent` flake input (`github:NousResearch/hermes-agent`), imported as `hermes-agent.nixosModules.default`.
- **Packages**: `addToSystemPackages = true` includes the Hermes CLI tool in the system environment.

---

### Home Manager Modules (hm-modules/)

#### packages.nix

Configures user-level packages and desktop environment:

- **Session variables**: EDITOR set to neovim.
- **User packages** (55+): fastfetch, neovim, btop, htop, gcc, git, ripgrep, fd, unzip, gnumake, curl, kitty, wofi, waybar, awww (wallpaper daemon), hyprshot, wl-clipboard, brightnessctl, pamixer, swappy, grim, slurp, mako, hyprlock, hypridle, cliphist, starship, tree, bat, wlogout, playerctl, qt6ct, polkit_gnome, pavucontrol, networkmanagerapplet, brave, thunar, imv, mpv, catppuccin-gtk, bibata-cursors, hyprpicker, wf-recorder, sddm-astronaut, blender, wofi-emoji (emoji picker), sops (secret encryption CLI), age (encryption backend), ssh-to-age (SSH-to-age key conversion).
- **Cursor**: Bibata-Modern-Classic, size 24, linked to GTK.
- **Desktop entries**: six Brave-based web application shortcuts for Gemini, Discord, Instagram, NotebookLM, YouTube Music, and WhatsApp, each with an isolated `--user-data-dir`.
- **Default browser**: Brave set as the default browser via `xdg.mimeApps` MIME associations for HTTP, HTTPS, and HTML.
- **Yazi config**: opens all files in neovim.
- **Swappy config**: saves screenshots to `~/Pictures/Screenshots` with a timestamped filename format.

#### zsh.nix

Configures the Zsh shell:

- **Autosuggestions**: fish-like completions based on history.
- **Syntax highlighting**: real-time command coloring.
- **Completion system**: enhanced tab completion.
- **Aliases** (30+):
  - Nix: `rebuild`, `flake-update`, `garbage`, `clean`, `search`, `generations`.
  - Navigation: `..`, `...`, `ls`, `ll`, `la`, `l`.
  - Safety: `rm -i`, `cp -i`, `mv -i`.
  - Shortcuts: `cat` -> bat, `vim`/`vi` -> nvim, `y` -> yazi, `g`/`gs`/`ga`/`gc`/etc. -> git.
  - System: `df -h`, `du -h`, `free -h`, `ps auxf`, `ports` (ss -tulanp).
- **History**: 10,000 entries, deduplication, ignores commands prefixed with a space.
- **Init script**: defines a `mkcd` function (mkdir + cd), runs `fetch`, evaluates `starship init`.
- **Starship prompt**: full Catppuccin Mocha palette, shows OS icon, username, directory, git branch/status, time, command duration, Nix shell indicator. Prompt character uses mauve on success, red on error.

#### bash.nix

A lighter Bash configuration for fallback use:

- **Fetch**: runs the areofyl-fetch system information script on startup.
- **Aliases**: core Nix commands, `ls`/`ll`, colored grep, `:q` -> exit (vim escape hatch).

#### git.nix

Configures Git:

- **User identity**: name from `vars.fullName`, email from `vars.email`.
- **Default branch**: main.
- **Pull strategy**: rebase by default for a clean linear history.

#### gtk.nix

Configures GTK theming:

- **Theme**: Catppuccin Mocha with Mauve accent color, built via `catppuccin-gtk` with explicit accent and variant overrides.
- **Icons**: Papirus-Dark.
- **Dark mode**: GTK3 and GTK4 both prefer dark themes.
- **Data files**: theme symlinked to `~/.local/share/themes/` for applications that scan that directory.

#### hyprland.nix

The largest module (approximately 250 lines), containing the full Hyprland compositor configuration as a flat config string.

**Environment variables**:

- Cursor theme (Bibata-Modern-Classic, size 24).
- Qt dark mode via `QT_QPA_PLATFORMTHEME=qt6ct`.
- Editor set to neovim.
- Wayland backend for Electron apps (`NIXOS_OZONE_WL=1`).

**Window rules**:

- Floating terminal (840x520, centered) for utility commands.
- Btop system monitor terminal.
- Pavucontrol (600x500, centered).
- Blueman-manager (800x600, centered).
- NetworkManager connection editor (700x550, centered).
- imv image viewer (320x240, top-left corner).

**Autostart**:

- awww wallpaper daemon, Waybar, Mako notifications.
- cliphist clipboard history daemon (text and image).
- Polkit authentication agent.

**Keybinding categories**:

- Emoji picker (wofi-emoji).
- Keybind reference viewer.
- Application launchers (terminal, browser, file manager).
- Web application shortcuts (6 Brave PWAs).
- Screenshots (region, output, window) with swappy editing.
- Screen recording toggle.
- Workspace navigation and window movement.
- Window operations (kill, toggle float, fullscreen, pin, split, cycle).
- Scratchpad for temporary windows.
- Resize submap for precise window resizing.
- Volume, media, and brightness hardware keys.
- TTS and speech-to-text hotkeys.
- Color picker.
- Power menu and lock screen.
- Hyprland reload.

**Animations**: custom bezier curve (0.05, 0.9, 0.1, 1.05) with 7-10 frame animations for windows, borders, fade, and workspace transitions.

**Appearance**:

- Gaps: 5px inner, 10px outer.
- Border: 2px, active `#cba6f7` (mauve), inactive `#45475a` (surface1).
- Rounding: 10px.
- Opacity: 0.96 active, 0.90 inactive.
- Blur: enabled, size 4, 2 passes.
- Shadows: enabled, range 12, render power 3.

**Input**:

- US keyboard layout.
- Touchpad natural scroll and tap-to-click.

#### hyprlock.nix

Lock screen configuration:

- **Background**: current wallpaper (from cache) displayed with 3-pass blur, 8px blur size, 0.7 brightness dim.
- **Clock**: 72pt JetBrainsMono Nerd Font, 12-hour format with AM/PM, updated every second.
- **Date**: 20pt, showing weekday and full date, updated daily.
- **Password field**: centered, 300x50, 10px rounding, dark inner background, mauve check color, red fail color, placeholder text.

#### kitty.nix

Kitty terminal configuration:

- **Font**: JetBrainsMono Nerd Font, 12px.
- **Appearance**: 85% background opacity, 2px background blur, 12px window padding, no window decorations.
- **Colors**: full Catppuccin Mocha terminal palette (16 standard colors, foreground, background, selection, cursor, URLs).
- **Tab bar**: powerline style, mauve active tab, surface0 inactive tab.

#### secrets.nix

User-level sops-nix secret management:

- **Import**: `inputs.sops-nix.homeManagerModules.sops` for Home Manager integration.
- **SSH key path**: points to `/home/{username}/.ssh/id_ed25519` for age decryption.
- **Default file**: reads from `secrets/user.yaml`.
- **Usage**: user secrets (API tokens, personal access keys) are decrypted at activation time and mounted under `/run/secrets/`, accessible only by the owning user. Secrets are never stored in the Nix store.

#### waybar.nix

Waybar status bar with custom styling and 9 utility scripts (approximately 520 lines total).

**Bar layout** (top, 36px height):

- **Left**: launcher button, Hyprland workspaces, focused window title.
- **Center**: clock (12-hour, updates every 60s).
- **Right**: CPU, memory, network speed, Wi-Fi status, Bluetooth status, PulseAudio volume, battery, power menu.

**Module details**:

- Launcher: Nerd Font rocket icon, left-click opens Wofi.
- Workspaces: click to activate, highlights active workspace in mauve.
- Window title: up to 50 characters, per-output.
- CPU: parsed from `top`, 5s interval, left-click opens btop.
- Memory: free percentage with GiB tooltip, 30s interval, left-click opens memory manager.
- Network speed: custom script parsing `/proc/net/dev`, shows up/down speeds.
- Network: Wi-Fi signal percentage or Ethernet IP, left-click opens nmtui.
- Bluetooth: connected device alias, left-click opens Blueman.
- PulseAudio: volume percentage with icon, scroll to adjust, left-click opens pavucontrol.
- Battery: capacity percentage with 5-level icon, charging indicator, time-remaining tooltip, left-click opens power profile selector.
- Power: power-off icon, left-click opens power menu.

**Style**: Catppuccin Mocha color scheme, translucent dark background, 14px rounding, distinct colors per module (teal for network, blue for Bluetooth, green for battery, yellow for memory, sky for CPU, red for power).

**Custom scripts**:

| Script | Description |
|---|---|
| `power-menu.sh` | Wofi-based power menu with Shutdown, Reboot, Lock, Logout options. |
| `wallpaper-select.sh` | Lists all images in `~/Pictures/wallpaper/` as visual thumbnails in Wofi; on selection, creates a symlink at `~/.cache/current-wallpaper.jpg` and applies it via awww with a fade transition. |
| `net-speed.sh` | Measures network RX/TX speeds over a 1-second window by reading `/proc/net/dev`, scales to KB or MB as appropriate, returns JSON for Waybar display. |
| `power-profiles.sh` | Lists available power profiles via `powerprofilesctl`, lets the user select one via Wofi. |
| `clipboard.sh` | Displays cliphist history entries in Wofi with HTML-sanitized preview text; on selection, decodes and copies the entry back to the clipboard. |
| `memory-manager.sh` | Two options: show memory info (free -h) in a terminal, or clear the RAM cache (sync + drop_caches). |
| `screenshot.sh` | Captures a screenshot in region, output, or window mode via hyprshot; shows a preview in imv for 7 seconds, then opens swappy for editing and saving. |
| `tts-speak.sh` | Downloads the Kokoro English TTS model on first run, then generates speech from selected text (primary selection) or clipboard content using sherpa-onnx-offline-tts; plays the result through PulseAudio/Wayland pipe. |
| `keybinds.sh` | Parses the active Hyprland config for all `bind`/`bindel`/`binde` lines, replaces `$mod` with `Super`, and displays them in a Wofi searchable window. Triggered by Super+K. |

#### wofi.nix

Wofi application launcher and wallpaper picker configuration:

- **Main launcher**: 600x450, centered, drun mode, app icons enabled (32px), GTK dark mode, Kitty as terminal.
- **Wallpaper picker**: 600x400, image size 400px for wallpaper thumbnail previews.
- **Style**: Catppuccin Mocha colors, 2px mauve border, 12px rounding, 95% opaque background, mauve selection highlight with dark text, rounded input field with focus border.

#### services.nix

Background services managed by Home Manager:

- **Mako notifications**: Catppuccin Mocha themed (dark background, mauve border), 5-second default timeout, 350x120 max size, top-right anchor, overlay layer, grouped by category.
- **Battery monitor**: systemd timer running every 3 minutes. Checks if the battery is discharging below 20% and the power profile is not already power-saver; if so, switches to power-saver and shows a critical notification.
- **Hypridle**: idle management daemon with three stages:
  - 5 minutes: lock screen.
  - 10 minutes: DPMS display off.
  - 30 minutes: system suspend.
- **SSH agent**: enabled for key-based authentication.
- **Voxtype**: systemd user service for push-to-talk speech-to-text. Uses the Vulkan-accelerated Voxtype daemon with auto-restart on failure. Configuration uses the base.en Whisper model, 16 kHz sample rate, 60-second max duration, 6 threads, with output typed directly (clipboard fallback), and notifications for recording start, stop, and transcription events.

---

## Key Bindings

All bindings use the Super (Windows) modifier unless noted otherwise.

### Application Launchers

| Key | Action |
|---|---|
| Super + Return | Open Kitty terminal |
| Super + B | Open Brave |
| Super + Shift + B | Open Brave (new window) |
| Super + E | Open Thunar file manager |
| Super + Space | Open Wofi application launcher |
| Super + T | Open floating terminal (840x520) |
| Super + Shift + E | Open Wofi emoji picker |
| Super + K | Open Wofi keybind reference viewer |
| Super + W | Open wallpaper selector |
| Ctrl + Shift + Escape | Open btop system monitor in Kitty |

### Web Application Shortcuts

| Key | Application |
|---|---|
| Super + A | Gemini (Brave PWA) |
| Super + D | Discord (Brave PWA) |
| Super + I | Instagram (Brave PWA) |
| Super + N | NotebookLM (Brave PWA) |
| Super + Shift + Y | YouTube Music (Brave PWA) |
| Super + Shift + W | WhatsApp (Brave PWA) |

### Window Management

| Key | Action |
|---|---|
| Super + Q | Kill active window |
| Super + M | Exit Hyprland |
| Super + V | Toggle floating |
| Super + F | Toggle fullscreen |
| Super + Shift + F | Fullscreen state 3 (fullscreen + focus) |
| Super + J | Toggle split layout |
| Super + P | Pin window |
| Ctrl + Tab | Cycle to next window |
| Super + C | Color picker (hyprpicker, copies to clipboard) |
| Super + Left/Right/Up/Down | Move focus |
| Super + Shift + Left/Right/Up/Down | Move window |
| Super + Ctrl + Left/Right/Up/Down | Resize active window by 20px |
| Super + R | Enter resize submap |

### Resize Submap

While in resize mode (entered via Super + R):

| Key | Action |
|---|---|
| Left/Right/Up/Down | Resize active window by 30px |
| Escape or Return | Exit resize mode |

### Workspaces

| Key | Action |
|---|---|
| Super + 1-9 | Switch to workspace N |
| Super + Shift + 1-9 | Move window to workspace N |
| Super + Tab | Next workspace |
| Super + Shift + Tab | Previous workspace |
| Super + Shift + Minus | Move window to empty workspace |
| Super + Grave | Toggle scratchpad |
| Super + Shift + Grave | Move window to scratchpad |

### Screenshots and Recording

| Key | Action |
|---|---|
| Super + Shift + S | Screenshot (region) -> imv preview -> swappy edit |
| Super + Print | Screenshot (output/monitor) |
| Print | Screenshot (active window) |
| Super + Shift + R | Toggle screen recording (wf-recorder) |

### Media and Hardware Keys

| Key | Action |
|---|---|
| XF86AudioRaiseVolume | Increase volume by 5% |
| XF86AudioLowerVolume | Decrease volume by 5% |
| XF86AudioMute | Toggle mute |
| XF86AudioPlay | Play/pause media |
| XF86AudioNext | Next track |
| XF86AudioPrev | Previous track |
| XF86MonBrightnessUp | Increase brightness by 5% |
| XF86MonBrightnessDown | Decrease brightness by 5% |

### Speech and Utilities

| Key | Action |
|---|---|
| F10 | Text-to-speech (selected text) |
| Shift + F10 | Text-to-speech (clipboard content) |
| F9 (press) | Start speech-to-text recording |
| F9 (release) | Stop speech-to-text recording |

### System Controls

| Key | Action |
|---|---|
| Super + L | Lock screen |
| Super + Escape | Open power menu (shutdown, reboot, lock, logout) |
| Super + Shift + L | Turn off displays (DPMS) |
| Super + Alt + R | Reload Hyprland configuration |

---

## Customization Guide

To adapt this configuration to a different machine or user:

1. **Fork or clone** the repository to your target machine.

2. **Edit `vars.nix`** with your own details:
   ```nix
   {
     username = "your-username";
     hostname = "your-hostname";
     timezone = "Your/Timezone";
     fullName = "Your Name";
     email = "your@email.com";
   }
   ```

3. **Generate hardware configuration** on the target machine:
   ```bash
   nixos-generate-config --show-hardware-config > hardware-configuration.nix
   ```

4. **Review and adjust**:
   - If your display or GPU differs from the AMD-based setup, check `sys-modules/base.nix` for kernel modules.
   - If you do not use VirtualBox, remove or comment out `sys-modules/virtualisation.nix` from `configuration.nix`.
   - If you use a different keyboard layout, update it in `sys-modules/display.nix` and `hm-modules/hyprland.nix`.

5. **Rebuild**:
   ```bash
   sudo nixos-rebuild switch --flake .#your-hostname
   ```

6. **Optional**: customize theme colors by editing the Catppuccin palette values in individual modules (hyprland.nix, waybar.nix, kitty.nix, wofi.nix, zsh.nix starship config, etc.).

---

## Flake Inputs

| Input | Source | Description |
|---|---|---|
| nixpkgs | github:NixOS/nixpkgs/nixos-unstable | Nixpkgs channel (unstable) |
| home-manager | github:nix-community/home-manager | Home Manager (follows nixpkgs) |
| areofyl-fetch | github:areofyl/fetch | System information fetch tool displayed on shell startup |
| sops-nix | github:Mic92/sops-nix | Secret management — decrypts age-encrypted secrets at activation time, mounts under /run/secrets/ |
| hermes-agent | github:NousResearch/hermes-agent | AI agent for NixOS — system service and CLI integration |

---

## License

MIT. See the LICENSE file for details.
