{ config, pkgs, ... }: {

  services.mako = {
    enable = true;
    settings = {
      background-color = "#1e1e2e";
      text-color = "#cdd6f4";
      border-color = "#cba6f7";
      border-radius = 10;
      border-size = 2;
      default-timeout = 5000;
      ignore-timeout = true;
      markup = true;
      font = "JetBrainsMono Nerd Font 11";
      padding = "12,16";
      margin = "8,8";
      width = 350;
      height = 120;
      max-visible = 5;
      anchor = "top-right";
      layer = "overlay";
      group-by = "category";
      sort = "+time";
      actions = true;
    };
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

}