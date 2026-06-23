{ config, pkgs, ... }: {

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  environment.systemPackages = with pkgs; [
    vim
    wget
    neovim
    git
    fastfetch
    yazi
    opencode
    obsidian
    python3
    btop
    sherpa-onnx
    voxtype-vulkan
    wtype
    libnotify
  ];

}
