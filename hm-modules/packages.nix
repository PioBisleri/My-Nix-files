{ config, pkgs, ... }: {

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    fastfetch
    neovim
    btop
    htop
    gcc
    git
    ripgrep
    fd
    unzip
    gnumake
    curl
    kitty
    wofi
    waybar
    awww
    hyprshot
    wl-clipboard
    brightnessctl
    pamixer
    swappy
    grim
    slurp
    mako
    hyprlock
    hypridle
    cliphist
    starship
    tree
    bat
    wlogout
    playerctl
    qt6Packages.qt6ct
    polkit_gnome
    pavucontrol
    networkmanagerapplet
    brave
    thunar
    imv
    mpv
    catppuccin-gtk
    bibata-cursors
    hyprpicker
    wf-recorder
    sddm-astronaut
    blender
    wofi-emoji
    sops
    age
    ssh-to-age
  ];

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };

  xdg.mimeApps.enable = true;

  xdg.mimeApps.defaultApplications = {
    "x-scheme-handler/http" = "brave-browser.desktop";
    "x-scheme-handler/https" = "brave-browser.desktop";
    "text/html" = "brave-browser.desktop";
  };

  xdg.desktopEntries = {
    "gemini-web" = {
      name = "Gemini";
      exec = "brave --app=https://gemini.google.com --user-data-dir=/home/veer/.config/webapps/gemini";
      icon = "google-gemini";
      categories = [ "Network" ];
    };
    "discord-web" = {
      name = "Discord";
      exec = "brave --app=https://discord.com/app --user-data-dir=/home/veer/.config/webapps/discord";
      icon = "discord";
      categories = [ "Network" ];
    };
    "instagram-web" = {
      name = "Instagram";
      exec = "brave --app=https://instagram.com --user-data-dir=/home/veer/.config/webapps/instagram";
      icon = "instagram";
      categories = [ "Network" ];
    };
    "notebooklm-web" = {
      name = "NotebookLM";
      exec = "brave --app=https://notebooklm.google.com --user-data-dir=/home/veer/.config/webapps/notebooklm";
      icon = "notebooklm";
      categories = [ "Network" ];
    };
    "ytmusic-web" = {
      name = "YouTube Music";
      exec = "brave --app=https://music.youtube.com --user-data-dir=/home/veer/.config/webapps/ytmusic";
      icon = "youtube-music";
      categories = [ "Network" ];
    };
    "whatsapp-web" = {
      name = "WhatsApp";
      exec = "brave --app=https://web.whatsapp.com --user-data-dir=/home/veer/.config/webapps/whatsapp";
      icon = "whatsapp";
      categories = [ "Network" ];
    };
  };

  xdg.configFile."yazi/yazi.toml" = {
    text = ''
      [open]
      rules = [
        { mime = "*", use = "edit" }
      ]

      [open-editors]
      edit = [
        { run = 'nvim "$@"', block = true }
      ]
    '';
  };

  xdg.configFile."swappy/config" = {
    text = ''
      [Default]
      save_dir=/home/veer/Pictures/Screenshots
      save_filename_format=shot_%Y%m%d_%H%M%S
    '';
  };

}
