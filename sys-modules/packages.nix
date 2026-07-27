{ config, pkgs, ... }: {

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    wget                   # Non-interactive network downloader
    yazi                   # Blazing-fast terminal file manager
    opencode               # AI coding assistant for terminal
    obsidian               # Knowledge base / note-taking app
    python3                # Python 3 interpreter
    voxtype-vulkan         # Push-to-talk voice-to-text daemon (Vulkan)
    wtype                  # Wayland keyboard input simulator
    libnotify              # Desktop notifications (notify-send)
    nodejs                 # JavaScript runtime
    jdk21                  # Java Development Kit 21 (LTS)
    docker                 # Container runtime & orchestration
    dconf-editor           # Low-level GNOME settings editor
    gimp                   # GNU Image Manipulation Program
  ];

}
