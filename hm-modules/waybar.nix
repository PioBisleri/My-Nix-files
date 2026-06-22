{ config, pkgs, ... }: {

  xdg.configFile."waybar/config" = {
    text = ''

      {
        "layer": "top",
        "position": "top",
        "height": 36,
        "margin-bottom": 8,
        "margin-left": 12,
        "margin-right": 12,
        "margin-top": 6,
        "modules-left": ["custom/launcher", "hyprland/workspaces", "hyprland/window"],
        "modules-center": ["clock"],
        "modules-right": ["custom/cpu", "custom/memory", "custom/net-speed", "network", "bluetooth", "pulseaudio", "battery", "custom/power"],
        "custom/launcher": {
          "format": "\uf313",
          "on-click": "wofi --show drun",
          "tooltip": false
        },
        "hyprland/workspaces": {
          "format": "{name}",
          "on-click": "activate"
        },
        "hyprland/window": {
          "format": "{}",
          "max-length": 50,
          "separate-outputs": true
        },
        "clock": {
          "format": "\uf450 {:%I:%M %p}",
          "tooltip-format": "{:%A, %B %d, %Y}",
          "interval": 60
        },
        "custom/cpu": {
          "format": "\uf2db {}%",
          "exec": "top -bn1 | grep 'Cpu(s)' | awk '{print $2}' | cut -d'%' -f1",
          "interval": 5,
          "tooltip": false,
          "on-click": "kitty --class floating-term -o initial_window_width=80c -o initial_window_height=24c -e btop"
        },
        "custom/memory": {
          "return-type": "json",
          "format": "\uf233  {}",
          "exec": "free | awk '/^Mem:/ {used=$3/1024/1024; total=$2/1024/1024; printf \"{\\\"text\\\": \\\"%.0f%%\\\", \\\"tooltip\\\": \\\"Used: %.1fGiB / %.1fGiB\\\"}\", $3/$2*100, used, total}'",
          "interval": 30,
          "tooltip": true,
          "on-click": "~/.config/waybar/scripts/memory-manager.sh"
        },
        "network": {
          "format-wifi": "\uf1eb  {signalStrength}%",
          "format-ethernet": "\uf6ff  {ipaddr}",
          "format-disconnected": "\uf072  Disconnected",
          "tooltip-format": "{ifname} via {essid}",
          "on-click": "kitty --class floating-term -o initial_window_width=80c -o initial_window_height=24c -e nmtui connect"
        },
        "bluetooth": {
          "format": "\uf294",
          "format-disabled": "",
          "format-connected": "\uf293 {device_alias}",
          "format-no-controller": "",
          "tooltip-format": "{controller_alias}\\n{device_alias}",
          "on-click": "blueman-manager"
        },
        "pulseaudio": {
          "format": "{icon} {volume}%",
          "format-icons": {
            "default": ["\uf026", "\uf027", "\uf028"]
          },
          "on-click": "pavucontrol",
          "scroll-step": 5,
          "on-scroll-up": "pamixer -i 5",
          "on-scroll-down": "pamixer -d 5"
        },
        "battery": {
          "format": "{icon} {capacity}%",
          "format-icons": ["\uf244", "\uf243", "\uf242", "\uf241", "\uf240"],
          "format-charging": "\uf0e7 {capacity}%",
          "tooltip-format": "{timeTo}",
          "interval": 60,
          "on-click": "~/.config/waybar/scripts/power-profiles.sh"
        },
        "custom/power": {
          "format": "\uf011",
          "on-click": "~/.config/waybar/scripts/power-menu.sh",
          "tooltip": false
        }
      }
    '';
  };

  xdg.configFile."waybar/style.css" = {
    text = ''
      * {
        border: none;
        border-radius: 0;
        font-family: "JetBrainsMono Nerd Font", sans-serif;
        font-size: 13px;
        min-height: 0;
      }

      window#waybar {
        background: rgba(30, 30, 46, 0.85);
        color: #cdd6f4;
        border-radius: 14px;
        transition-property: background-color;
        transition-duration: 0.5s;
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      #workspaces button {
        padding: 0 6px;
        margin: 4px 2px;
        background: transparent;
        color: #6c7086;
        border-radius: 6px;
        transition: all 0.2s ease;
      }

      #workspaces button.active {
        background: rgba(203, 166, 247, 0.2);
        color: #cba6f7;
      }

      #workspaces button.urgent {
        background: rgba(243, 139, 168, 0.2);
        color: #f38ba8;
      }

      #workspaces button:hover {
        background: rgba(203, 166, 247, 0.1);
        color: #cdd6f4;
        box-shadow: none;
        text-shadow: none;
      }

      #custom-launcher {
        font-size: 16px;
        padding: 0 12px;
        margin: 4px 2px;
        color: #cba6f7;
      }

      #window {
        padding: 0 10px;
        margin: 4px 2px;
        background: rgba(49, 50, 68, 0.7);
        border-radius: 8px;
        color: #bac2de;
      }

      #clock {
        padding: 0 12px;
        margin: 4px 2px;
        background: rgba(49, 50, 68, 0.7);
        border-radius: 10px;
        color: #cdd6f4;
      }

      #network {
        padding: 0 10px;
        margin: 4px 2px;
        background: rgba(49, 50, 68, 0.7);
        border-radius: 8px;
        color: #94e2d5;
      }

      #network.disconnected {
        color: #f38ba8;
      }

      #bluetooth {
        padding: 0 10px;
        margin: 4px 2px;
        background: rgba(49, 50, 68, 0.7);
        border-radius: 8px;
        color: #89b4fa;
      }

      #bluetooth.disabled {
        color: #6c7086;
      }

      #pulseaudio {
        padding: 0 10px;
        margin: 4px 2px;
        background: rgba(49, 50, 68, 0.7);
        border-radius: 8px;
        color: #cdd6f4;
      }

      #pulseaudio.muted {
        color: #f38ba8;
      }

      #battery {
        padding: 0 10px;
        margin: 4px 2px;
        background: rgba(49, 50, 68, 0.7);
        border-radius: 8px;
        color: #a6e3a1;
      }

      #battery.warning {
        color: #f9e2af;
      }

      #battery.critical {
        color: #f38ba8;
      }

      #custom-cpu {
        padding: 0 10px;
        margin: 4px 2px;
        background: rgba(49, 50, 68, 0.7);
        border-radius: 8px;
        color: #89dceb;
      }

      #custom-memory {
        padding: 0 10px;
        margin: 4px 2px;
        background: rgba(49, 50, 68, 0.7);
        border-radius: 8px;
        color: #f9e2af;
      }

      #custom-net-speed {
        padding: 0 10px;
        margin: 4px 2px;
        background: rgba(49, 50, 68, 0.7);
        border-radius: 8px;
        color: #a6e3a1;
      }

      #custom-power {
        padding: 0 12px;
        margin: 4px 2px;
        font-size: 15px;
        color: #f38ba8;
      }

      #custom-power:hover {
        background: rgba(243, 139, 168, 0.15);
        border-radius: 8px;
      }

      tooltip {
        background: rgba(30, 30, 46, 0.95);
        border: 1px solid rgba(203, 166, 247, 0.4);
        border-radius: 8px;
        color: #cdd6f4;
      }

      tooltip label {
        padding: 6px 10px;
      }
    '';
  };

  xdg.configFile."waybar/scripts/power-menu.sh" = {
    text = ''
      #!/usr/bin/env bash
      entries="Shutdown
Reboot
Lock
Logout"
      selected=$(echo -e "$entries" | wofi --width 200 --height 250 --dmenu --cache-file /dev/null --prompt "Power Menu")
      case $selected in
          Shutdown) systemctl poweroff ;;
          Reboot) systemctl reboot ;;
          Lock) hyprlock ;;
          Logout) hyprctl dispatch exit ;;
      esac
    '';
    executable = true;
  };

    xdg.configFile."waybar/scripts/wallpaper-select.sh" = {
    text = ''
      #!/usr/bin/env bash
      WALLPAPER_DIR="$HOME/Pictures/wallpaper"
      SYMLINK="$HOME/.cache/current-wallpaper.jpg"

      mkdir -p "$(dirname "$SYMLINK")"

      ENTRIES=""
      for f in "$WALLPAPER_DIR"/*; do
        [ -f "$f" ] || continue
        [ -n "$ENTRIES" ] && ENTRIES+="\n"
        ENTRIES+="img:$f"
      done

      SELECTED=$(echo -e "$ENTRIES" | wofi --dmenu --prompt "Select Wallpaper" --conf ~/.config/wofi/wallpaper-config)
      if [ -z "$SELECTED" ]; then
        exit 0
      fi

      FILEPATH="''${SELECTED#img:}"
      [ -f "$FILEPATH" ] || exit 0

      ln -sf "$FILEPATH" "$SYMLINK"
      awww img "$SYMLINK" --transition-type fade --transition-duration 3
    '';
    executable = true;
  };

  


xdg.configFile."waybar/scripts/net-speed.sh" = {
    text = ''
      #!/usr/bin/env bash
      ICON_DOWN=$(printf '\xef\x81\xa3')
      ICON_UP=$(printf '\xef\x81\xa2')

      INTERFACE=$(ip route get 8.8.8.8 2>/dev/null | awk '{print $5; exit}')
      [ -z "$INTERFACE" ] && echo "{\"text\": \"$ICON_DOWN 0 $ICON_UP 0\", \"tooltip\": \"No connection\"}" && exit 0

      LINE=$(grep "$INTERFACE" /proc/net/dev 2>/dev/null | sed 's/.*://')
      [ -z "$LINE" ] && echo "{\"text\": \"$ICON_DOWN 0 $ICON_UP 0\"}" && exit 0

      RX1=$(echo "$LINE" | awk '{print $1}')
      TX1=$(echo "$LINE" | awk '{print $9}')
      sleep 1
      LINE=$(grep "$INTERFACE" /proc/net/dev | sed 's/.*://')
      RX2=$(echo "$LINE" | awk '{print $1}')
      TX2=$(echo "$LINE" | awk '{print $9}')

      RX_SPEED=$(( (RX2 - RX1) / 1024 ))
      TX_SPEED=$(( (TX2 - TX1) / 1024 ))

      if [ "$RX_SPEED" -ge 1024 ]; then
        RX_DISP="$((RX_SPEED / 1024)).$(((RX_SPEED % 1024) * 10 / 1024))MB"
      else
        RX_DISP="''${RX_SPEED}KB"
      fi

      if [ "$TX_SPEED" -ge 1024 ]; then
        TX_DISP="$((TX_SPEED / 1024)).$(((TX_SPEED % 1024) * 10 / 1024))MB"
      else
        TX_DISP="''${TX_SPEED}KB"
      fi

      echo "{\"text\": \"$ICON_DOWN $RX_DISP $ICON_UP $TX_DISP\"}"
    '';
    executable = true;
  };

  xdg.configFile."waybar/scripts/power-profiles.sh" = {
    text = ''
      #!/usr/bin/env bash
      PROFILES=$(powerprofilesctl list | grep -oP '^(\s{2}|\* )\K\S+(?=:)')
      MENU=$(echo "$PROFILES" | while IFS= read -r p; do echo "$p"; done)
      SELECTED=$(echo "$MENU" | wofi --dmenu --prompt "Power Profile" --width 300 --height 200)
      [ -z "$SELECTED" ] && exit 0
      powerprofilesctl set "$SELECTED"
    '';
    executable = true;
  };

  xdg.configFile."waybar/scripts/clipboard.sh" = {
    text = ''
      #!/usr/bin/env bash
      cliphist list | python3 -c "
      import sys
      for l in sys.stdin:
          l = l.rstrip('\n')
          if '\t' in l:
              parts = l.split('\t', 1)
              escaped = parts[1].replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;').replace(\"'\", '&#39;')
              print(f'{parts[0]}\t{escaped}')
          else:
              print(l)
      " | wofi --dmenu --prompt Clipboard | cliphist decode | wl-copy
    '';
    executable = true;
  };


  xdg.configFile."waybar/scripts/memory-manager.sh" = {
    text = ''
      #!/usr/bin/env bash
      entries="Memory Info
Clear RAM Cache"
      selected=$(echo -e "$entries" | wofi --dmenu --prompt "Memory Manager" --width 300 --height 200 --cache-file /dev/null)
      case $selected in
          "Memory Info")
              kitty --class floating-term -o initial_window_width=80c -o initial_window_height=24c -e bash -c 'free -h; echo; echo "Press Enter to exit"; read'
              ;;
          "Clear RAM Cache")
              kitty --class floating-term -e bash -c 'echo "Clearing RAM cache..."; sync && echo 3 | sudo tee /proc/sys/vm/drop_caches > /dev/null; echo "RAM cache cleared! Press Enter to exit."; read'
              ;;
      esac
    '';
    executable = true;
  };







  xdg.configFile."waybar/scripts/screenshot.sh" = {
    text = ''
      #!/usr/bin/env bash
      DIR=$HOME/Pictures/Screenshots
      NAME=shot_$(date +%Y%m%d_%H%M%S).png
      mkdir -p "$DIR"
      FILE=$DIR/$NAME

      case "''${1:-region}" in
        region)  hyprshot -m region -o "$DIR" -f "$NAME" || exit 1 ;;
        output)  hyprshot -m output -o "$DIR" -f "$NAME" || exit 1 ;;
        window)  hyprshot -m window -o "$DIR" -f "$NAME" || exit 1 ;;
      esac

      notify-send -i "$FILE" -t 7000 "Screenshot" "Click preview to edit"
      imv -s 0.15 -x "$FILE" 2>/dev/null &
      IMV_PID=$!
      (sleep 7; kill "$IMV_PID" 2>/dev/null) &
      wait "$IMV_PID" 2>/dev/null
      swappy -f "$FILE"
    '';
    executable = true;
  };



  xdg.configFile."waybar/scripts/tts-speak.sh" = {
    text = ''
      #!/usr/bin/env bash
      set -u
      CACHE_DIR=''${XDG_CACHE_HOME:-$HOME}/.cache/tts/kokoro
      MODEL_DIR="$CACHE_DIR"
      MODEL_URL="https://github.com/k2-fsa/sherpa-onnx/releases/download/tts-models/kokoro-en-v0_19.tar.bz2"
      MODEL_FILE="$MODEL_DIR/model.onnx"
      TOKENS_FILE="$MODEL_DIR/tokens.txt"
      DATA_DIR="$MODEL_DIR/espeak-ng-data"
      VOICES_FILE="$MODEL_DIR/voices.bin"
      SID=0
      SHERPA="/run/current-system/sw/bin/sherpa-onnx-offline-tts"

      if [ ! -f "$MODEL_FILE" ]; then
        mkdir -p "$MODEL_DIR"
        ARCHIVE="/tmp/kokoro.tar.bz2"
        notify-send -t 5000 "TTS" "Downloading Kokoro model..."
        curl -L -o "$ARCHIVE" "$MODEL_URL" 2>&1
        if [ $? -ne 0 ]; then
          notify-send -u critical "TTS" "Download failed!"
          exit 1
        fi
        tar -xjf "$ARCHIVE" -C "$MODEL_DIR" --strip-components=1 2>/dev/null || tar -xjf "$ARCHIVE" -C "$MODEL_DIR" 2>/dev/null
        rm -f "$ARCHIVE"
        if [ ! -f "$MODEL_FILE" ]; then
          notify-send -u critical "TTS" "Model extraction failed!"
          exit 1
        fi
        notify-send -t 3000 "TTS" "Model ready!"
      fi

      MODE=''${1:-selection}
      if [ "$MODE" = "--clipboard" ]; then
        TEXT=$(wl-paste 2>/dev/null)
        [ -z "$TEXT" ] && TEXT=$(wl-paste --primary 2>/dev/null)
      else
        notify-send -t 2000 "TTS" "Select text..."
        sleep 0.5
        TEXT=$(wl-paste --primary 2>/dev/null)
        [ -z "$TEXT" ] && TEXT=$(wl-paste 2>/dev/null)
        if [ -z "$TEXT" ] && command -v wtype &>/dev/null; then
          wtype -M ctrl c -m ctrl 2>/dev/null
          sleep 0.3
          TEXT=$(wl-paste 2>/dev/null)
        fi
      fi

      TEXT=$(echo "$TEXT" | head -c 500)
      [ -z "$TEXT" ] && notify-send -t 3000 "TTS" "No text found" && exit 0

      notify-send -t 2000 "TTS" "Generating speech..."
      OUTPUT_WAV=/tmp/tts_output.wav
      "$SHERPA" --kokoro-model="$MODEL_FILE" --kokoro-tokens="$TOKENS_FILE" --kokoro-data-dir="$DATA_DIR" --kokoro-voices="$VOICES_FILE" --sid="$SID" --num-threads=6 --output-filename="$OUTPUT_WAV" "$TEXT" 2>/dev/null

      if [ -f "$OUTPUT_WAV" ]; then
        pw-play "$OUTPUT_WAV" 2>/dev/null || aplay "$OUTPUT_WAV" 2>/dev/null || notify-send -u critical "TTS" "Playback failed"
        rm -f "$OUTPUT_WAV"
      else
        notify-send -u critical "TTS" "Speech generation failed"
      fi
    '';
    executable = true;
  };

  xdg.configFile."waybar/scripts/keybinds.sh" = {
    text = ''
      #!/usr/bin/env bash
      CONFIG="$HOME/.config/hypr/hyprland.conf"
      [ -f "$CONFIG" ] || { notify-send "Keybinds" "Config not found"; exit 1; }

      entries=$(grep -E '^\s*bind[el]*\s*=' "$CONFIG" | \
        sed 's/\$mod/Super/g' | \
        sed 's/^[[:space:]]*bind[el]*\s*=\s*//' | \
        sed 's/exec, //' | \
        sed 's/submap, //')

      echo "$entries" | wofi --dmenu --prompt "Keybinds (Escape to close)" --width 900 --height 600 --cache-file /dev/null
    '';
    executable = true;
  };

}
