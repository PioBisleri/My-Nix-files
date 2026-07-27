{ config, pkgs, ... }: {

  xdg.configFile."wofi/config".text = ''
    width=900
    height=650
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
    image_size=48
    gtk_dark=true
    term=kitty
  '';

  xdg.configFile."wofi/wallpaper-config".text = ''
    width=900
    height=600
    allow_images=true
    image_size=500
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
      font-size: 16px;
      padding: 12px 16px;
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
      margin: 8px 14px;
      border: none;
      color: #cdd6f4;
      font-size: 24px;
    }

    #text:selected {
      color: #1e1e2e;
    }

    #entry {
      margin: 6px 8px;
      border: none;
      border-radius: 8px;
      background-color: transparent;
      padding: 10px;
    }

    #entry:selected {
      background-color: #cba6f7;
      color: #1e1e2e;
      outline: none;
    }

    #img {
      margin: 8px 14px;
    }
  '';

}
