{ config, pkgs, ... }: {

  services.swaync = {
    enable = true;
    settings = {
      positionX = "right";
      positionY = "top";
      control-center-margin-top = 8;
      control-center-margin-right = 8;
      control-center-margin-bottom = 8;
      control-center-margin-left = 8;
      notification-icon-size = 32;
      notification-body-image-height = 100;
      notification-body-image-width = 200;
      timeout = 5;
      timeout-low = 3;
      timeout-critical = 0;
      fit-to-screen = true;
      control-center-width = 400;
      control-center-height = 600;
      notification-window-width = 350;
      keyboard-shortcuts = true;
      image-visibility = "when-available";
      transition-time = 200;
      hide-on-clear = true;
      hide-on-action = true;
      script-fail-notify = true;
      widgets = [
        "title"
        "dnd"
        "notifications"
        "buttonsGrid"
      ];
      widget-config = {
        title = {
          text = "Notifications";
          clear-all-button = true;
          button-text = "Clear All";
        };
        dnd = {
          text = "Do Not Disturb";
        };
        buttonsGrid = {
          actions = [
            {
              label = "󰂯";
              type = "toggle-dnd";
            }
            {
              label = "󰍜";
              type = "toggle-notification-center";
            }
            {
              label = "󰆴";
              type = "clear-all-notifications";
            }
          ];
        };
      };
    };
    style = ''
      * {
        all: unset;
        font-family: "JetBrainsMono Nerd Font";
      }
      .notification-row {
        outline: none;
        margin: 0;
        padding: 0;
      }
      .notification {
        background: #1e1e2e;
        border: 2px solid #cba6f7;
        border-radius: 10px;
        margin: 4px 8px;
        padding: 8px;
      }
      .notification.critical {
        background: rgba(243, 139, 168, 0.15);
        border: 3px solid #f38ba8;
      }
      .notification.critical .summary {
        color: #f38ba8;
      }
      .notification.critical .body {
        color: #f9e2af;
      }
      .notification-content {
        background: transparent;
        padding: 4px;
      }
      .summary {
        font-size: 14px;
        font-weight: bold;
        color: #cdd6f4;
        margin: 0;
        padding: 0;
      }
      .body {
        font-size: 12px;
        color: #a6adc8;
        margin-top: 4px;
        padding: 0;
      }
      .icon {
        margin-right: 8px;
      }
      .control-center {
        background: #1e1e2e;
        border: 2px solid #cba6f7;
        border-radius: 10px;
        margin: 8px;
        padding: 8px;
      }
      .control-center-list {
        background: transparent;
      }
      .control-center-list-placeholder {
        color: #a6adc8;
        font-size: 12px;
        margin: 16px;
        text-align: center;
      }
      .widget-title {
        color: #cdd6f4;
        font-size: 16px;
        font-weight: bold;
        margin: 8px;
        padding: 4px;
      }
      .widget-title button {
        background: #45475a;
        border: none;
        border-radius: 8px;
        color: #cdd6f4;
        font-size: 12px;
        padding: 4px 12px;
      }
      .widget-title button:hover {
        background: #cba6f7;
        color: #1e1e2e;
      }
      .widget-dnd {
        color: #a6adc8;
        font-size: 12px;
        margin: 8px;
        padding: 4px;
      }
      .widget-dnd > switch {
        background: #45475a;
        border-radius: 8px;
      }
      .widget-dnd > switch:checked {
        background: #cba6f7;
      }
      .widget-buttons-grid {
        margin: 8px;
        padding: 4px;
      }
      .widget-buttons-grid > button {
        background: #45475a;
        border: none;
        border-radius: 8px;
        color: #cdd6f4;
        font-size: 16px;
        margin: 2px;
        padding: 8px;
        min-width: 40px;
        min-height: 40px;
      }
      .widget-buttons-grid > button:hover {
        background: #cba6f7;
        color: #1e1e2e;
      }
    '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };

  xdg.configFile."waybar/scripts/battery-monitor.sh" = {
    executable = true;
    text = ''
      #!/usr/bin/env bash
      BAT=/sys/class/power_supply/BAT0
      [ -f "$BAT/capacity" ] || exit 0
      capacity=$(cat "$BAT/capacity")
      status=$(cat "$BAT/status")
      profile=$(powerprofilesctl get 2>/dev/null)
      if [ "$status" = "Discharging" ] && [ "$capacity" -lt 20 ] && [ "$profile" != "power-saver" ]; then
        powerprofilesctl set power-saver
        notify-send -u critical "Battery Low" "Battery at ''${capacity}% - switched to power-saver"
      fi
    '';
  };

  systemd.user.services.battery-monitor = {
    Unit = {
      Description = "Battery monitor - auto switch to power-saver below 20%";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "%h/.config/waybar/scripts/battery-monitor.sh";
      Environment = [
        "DISPLAY=:1"
        "WAYLAND_DISPLAY=wayland-1"
        "DBUS_SESSION_BUS_ADDRESS=unix:path=%t/bus"
      ];
    };
    Install.WantedBy = [ "default.target" ];
  };

  systemd.user.timers.battery-monitor = {
    Unit = {
      Description = "Periodic battery check (every 3 min)";
    };
    Timer = {
      OnCalendar = "*:0/3";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };

  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "pidof hyprlock || hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };
      listener = [
        {
          timeout = 300;
          on-timeout = "loginctl lock-session";
        }
        {
          timeout = 600;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 1800;
          on-timeout = "systemctl suspend";
        }
      ];
    };
  };

  services.ssh-agent.enable = true;

  systemd.user.services.voxtype = {
    Unit = {
      Description = "Voxtype push-to-talk voice-to-text daemon";
      Documentation = "https://voxtype.io";
      After = [ "graphical-session.target" ];
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.voxtype-vulkan}/bin/voxtype daemon";
      Restart = "always";
      RestartSec = 2;
      Environment = [
        "WAYLAND_DISPLAY=wayland-1"
        "DISPLAY=:1"
        "DBUS_SESSION_BUS_ADDRESS=unix:path=%t/bus"
      ];
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };

  systemd.user.services.voxtype-watchdog = {
    Unit = {
      Description = "Voxtype watchdog - restart if dead";
    };
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.bash}/bin/bash -c 'if ! systemctl --user is-active -q voxtype; then systemctl --user start voxtype; fi'";
    };
    Install.WantedBy = [ "default.target" ];
  };

  systemd.user.timers.voxtype-watchdog = {
    Unit = {
      Description = "Periodic voxtype health check (every 2 min)";
    };
    Timer = {
      OnCalendar = "*:0/2";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };

  xdg.configFile."voxtype/config.toml" = {
    force = true;
    text = ''
      state_file = "auto"

      [hotkey]
      enabled = false

      [audio]
      device = "default"
      sample_rate = 16000
      max_duration_secs = 60

      [whisper]
      model = "base.en"
      language = "en"
      threads = 6
      translate = false

      [output]
      mode = "type"
      fallback_to_clipboard = true
      type_delay_ms = 0

      [output.notification]
      on_recording_start = true
      on_recording_stop = true
      on_transcription = true
    '';
  };
}
