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
    firefox
    thunar
    imv
    mpv
    catppuccin-gtk
    bibata-cursors
    hyprpicker
    wf-recorder
    sddm-astronaut
    chromium
    blender
    wofi-emoji
  ];

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
  };

  xdg.desktopEntries = {
    "gemini-web" = {
      name = "Gemini";
      exec = "chromium --app=https://gemini.google.com --user-data-dir=~/.config/webapps/gemini";
      icon = "google-gemini";
      categories = [ "Network" ];
    };
    "discord-web" = {
      name = "Discord";
      exec = "chromium --app=https://discord.com/app --user-data-dir=~/.config/webapps/discord";
      icon = "discord";
      categories = [ "Network" ];
    };
    "instagram-web" = {
      name = "Instagram";
      exec = "chromium --app=https://instagram.com --user-data-dir=~/.config/webapps/instagram";
      icon = "instagram";
      categories = [ "Network" ];
    };
    "notebooklm-web" = {
      name = "NotebookLM";
      exec = "chromium --app=https://notebooklm.google.com --user-data-dir=~/.config/webapps/notebooklm";
      icon = "notebooklm";
      categories = [ "Network" ];
    };
    "ytmusic-web" = {
      name = "YouTube Music";
      exec = "chromium --app=https://music.youtube.com --user-data-dir=~/.config/webapps/ytmusic";
      icon = "youtube-music";
      categories = [ "Network" ];
    };
    "whatsapp-web" = {
      name = "WhatsApp";
      exec = "chromium --app=https://web.whatsapp.com --user-data-dir=~/.config/webapps/whatsapp";
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
      save_dir=${config.home.homeDirectory}/Pictures/Screenshots
      save_filename_format=shot_%Y%m%d_%H%M%S
    '';
  };

}
