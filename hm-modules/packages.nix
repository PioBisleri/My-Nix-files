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
    impala
  ];

  home.pointerCursor = {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
    size = 24;
    gtk.enable = true;
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

}
