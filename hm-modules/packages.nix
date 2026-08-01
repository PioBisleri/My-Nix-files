{ config, pkgs, vars, ... }: {

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.packages = with pkgs; [
    fastfetch              # Fast system info display
    vim                    # The classic linux editor 
    neovim                 # Modern Vim fork with Lua plugin architecture
    btop                   # Resource monitor with GPU/disk stats
    gcc                    # GNU C/C++ compiler collection
    git                    # Distributed version control
    ripgrep                # Ultra-fast recursive regex search
    fd                     # Fast user-friendly find alternative
    unzip                  # Extract ZIP archives
    unrar                  # Extract RAR archives
    opencode               # AI coding assistant for terminal
    gnumake                # Build automation tool
    curl                   # Data transfer with URL syntax
    kitty                  # GPU-accelerated terminal emulator
    wofi                   # Wayland-native app launcher
    waybar                 # Highly customizable Wayland status bar
    awww                   # Live wallpaper daemon for Hyprland
    hyprshot               # Screenshot tool for Hyprland
    wl-clipboard           # Wayland clipboard utilities (wl-copy/paste)
    brightnessctl          # Screen backlight brightness control
    pamixer                # PulseAudio/PipeWire volume control (CLI)
    swappy                 # Screenshot annotation / quick-edit tool
    grim                   # Wayland screenshot capture
    slurp                  # Wayland region/highlight selector
    swaynotificationcenter # Sway notification center with history panel
    hyprlock               # Hyprland-native screen locker
    hypridle               # Hyprland idle management daemon
    cliphist               # Wayland clipboard history manager
    starship               # Minimal, fast, customizable shell prompt
    tree                   # Display directory structure as a tree
    bat                    # cat clone with syntax highlighting + Git
    wlogout                # Wayland logout/power menu
    playerctl              # Media player CLI controller (MPRIS)
    qt6Packages.qt6ct      # Qt6 configuration tool (theming/fonts)
    polkit_gnome           # Polkit authentication agent (GNOME)
    pavucontrol            # PulseAudio volume control (GUI)
    networkmanagerapplet   # NetworkManager system tray
    brave                  # Privacy-focused Chromium-based browser
    vscode                 # Generic code editor
    libmtp                 # MTP device communication library
    mtpfs                  # FUSE filesystem for MTP devices
    jmtpfs                 # FUSE filesystem for MTP devices (Java)
    imv                    # Wayland-native image viewer
    mpv                    # Minimalist video player (HW-accelerated)
    catppuccin-gtk         # Catppuccin GTK theme (Mocha Mauve)
    bibata-cursors         # Modern cursor theme
    hyprpicker             # Color picker for Hyprland
    wf-recorder            # Wayland screen recorder (wlroots)
    sddm-astronaut         # SDDM login theme (astronaut)
    wofi-emoji             # Emoji picker for wofi
    file-roller            # Archive manager GUI
    sops                   # Secret management (encrypted YAML/JSON)
    age                    # Simple modern file encryption
    ssh-to-age             # Convert SSH keys to AGE keys
    qbittorrent            # BitTorrent client
    proton-vpn             # ProtonVPN CLI client
    fzf                    # Fuzzy finder (history/file search)
    zoxide                 # Smarter cd — learns your directory habits
    lazygit                # Terminal UI for Git
    ffmpeg                 # Audio/video recording, conversion, streaming
    obs-studio             # Screen recording and live streaming
    mission-center         # System monitor (task manager-style GUI)
    nix-output-monitor     # Pretty Nix build output with timing/progress
    nil                    # Nix language server (LSP)
    nixpkgs-fmt            # Nix code formatter
    cava                   # Audio visualizer (terminal)
    cavasik                # Audio visualizer based on CAVA with extended capabilities
    appimage-run           # Run AppImage files on NixOS
    yt-dlp                 # YouTube/video downloader
    nix-tree               # Interactive Nix dependency tree
    nix-index              # nix-index + command-not-found
    comma                  # Run uninstalled packages via nix shell
    jq                     # JSON processor
    yq                     # YAML/JSON/XML processor (use `yq-go` in nixpkgs)
    tmux                   # Terminal multiplexer
    wireshark              # Network protocol analyzer
    nmap                   # Network scanner
    bind.dnsutils          # dig, nslookup, host
    imagemagick            # Image conversion/manipulation
    sox                    # Audio processing
    handbrake              # Video transcoder
    zathura                # Minimal PDF viewer
    kdePackages.kdenlive   # Qt video editor with VAAPI GPU acceleration
    inkscape               # Vector graphics editor
    audacity               # Sound editor with graphical UI
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
      exec = "brave --app=https://gemini.google.com --user-data-dir=/home/${vars.username}/.config/webapps/gemini";
      icon = "google-gemini";
      categories = [ "Network" ];
    };
    "discord-web" = {
      name = "Discord";
      exec = "brave --app=https://discord.com/app --user-data-dir=/home/${vars.username}/.config/webapps/discord";
      icon = "discord";
      categories = [ "Network" ];
    };
    "instagram-web" = {
      name = "Instagram";
      exec = "brave --app=https://instagram.com --user-data-dir=/home/${vars.username}/.config/webapps/instagram";
      icon = "instagram";
      categories = [ "Network" ];
    };
    "notebooklm-web" = {
      name = "NotebookLM";
      exec = "brave --app=https://notebooklm.google.com --user-data-dir=/home/${vars.username}/.config/webapps/notebooklm";
      icon = "notebooklm";
      categories = [ "Network" ];
    };
    "ytmusic-web" = {
      name = "YouTube Music";
      exec = "brave --app=https://music.youtube.com --user-data-dir=/home/${vars.username}/.config/webapps/ytmusic";
      icon = "youtube-music";
      categories = [ "Network" ];
    };
    "whatsapp-web" = {
      name = "WhatsApp";
      exec = "brave --app=https://web.whatsapp.com --user-data-dir=/home/${vars.username}/.config/webapps/whatsapp";
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
      save_dir=/home/${vars.username}/Pictures/Screenshots
      save_filename_format=shot_%Y%m%d_%H%M%S
    '';
  };


  xdg.configFile."Thunar/volman.xml" = {
    text = ''
      <?xml version="1.0" encoding="UTF-8"?>
      <channel name="thunar-volman" version="1.0">
        <property name="automount-media" type="bool" value="true"/>
        <property name="automount-drives" type="bool" value="true"/>
        <property name="autoopen-media" type="bool" value="true"/>
        <property name="autophoto" type="bool" value="true"/>
      </channel>
    '';
  };
}
