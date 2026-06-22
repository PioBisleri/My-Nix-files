{ config, pkgs, ... }: {

  xdg.configFile."hypr/hyprlock.conf".text = ''
    background {
      monitor =
      path = /home/veer/.cache/current-wallpaper.jpg
      blur_passes = 3
      blur_size = 8
      brightness = 0.7
    }

    input-field {
      monitor =
      size = 300, 50
      outline_thickness = 2
      dots_size = 0.2
      dots_spacing = 0.5
      dots_center = true
      outer_color = rgba(0, 0, 0, 0)
      inner_color = rgba(49, 50, 68, 0.8)
      font_color = #cdd6f4
      fade_on_empty = true
      placeholder_text = Password...
      hide_input = false
      round = 10
      check_color = #a6e3a1
      fail_color = #f38ba8
      position = 0, -80
      halign = center
      valign = center
    }

    label {
      monitor =
      text = cmd[update:1000] echo "$(date '+%I:%M %p')"
      font_size = 72
      font_family = JetBrainsMono Nerd Font
      color = #cdd6f4
      position = 0, 40
      halign = center
      valign = center
    }

    label {
      monitor =
      text = cmd[update:86400000] echo "$(date '+%A, %B %d')"
      font_size = 20
      font_family = JetBrainsMono Nerd Font
      color = #bac2de
      position = 0, -20
      halign = center
      valign = center
    }
  '';

}