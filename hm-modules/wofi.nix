{ config, pkgs, ... }: {

  xdg.configFile."wofi/config".text = ''
    width=600
    height=450
    location=center
    show=drun
    prompt=Apps
    filter_rate=100
    allow_markup=true
    no_actions=true
    halign=fill
    orientation=vertical
    content_halign=fill
    insensitive=false
    allow_images=true
    image_size=32
    gtk_dark=true
    term=kitty
  '';

  xdg.configFile."wofi/wallpaper-config".text = ''
    width=600
    height=400
    allow_images=true
    image_size=400
    filter_rate=100
    gtk_dark=true
  '';

  xdg.configFile."wofi/style.css".text = ''
    window {
      margin: 0px;
      border: 2px solid #cba6f7;
      border-radius: 12px;
      background-color: rgba(30, 30, 46, 0.95);
      font-family: "JetBrainsMono Nerd Font", sans-serif;
    }

    #input {
      margin: 8px;
      border: none;
      border-radius: 8px;
      background-color: #313244;
      color: #cdd6f4;
      font-size: 14px;
      padding: 8px 12px;
    }

    #input:focus {
      border: 1px solid #cba6f7;
    }

    #inner-box {
      margin: 4px;
      border: none;
      background-color: transparent;
    }

    #outer-box {
      margin: 4px;
      border: none;
      background-color: transparent;
    }

    #scroll {
      margin: 0px;
      border: none;
      background-color: transparent;
    }

    #text {
      margin: 4px 8px;
      border: none;
      color: #cdd6f4;
      font-size: 13px;
    }

    #text:selected {
      color: #1e1e2e;
    }

    #entry {
      margin: 2px 4px;
      border: none;
      border-radius: 8px;
      background-color: transparent;
      padding: 4px;
    }

    #entry:selected {
      background-color: #cba6f7;
      color: #1e1e2e;
      outline: none;
    }

    #img {
      margin: 4px 8px;
    }
  '';

}