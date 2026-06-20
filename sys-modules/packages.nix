{ config, pkgs, ... }: {

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  programs.firefox = {
    enable = true;
      };

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
  ];

}
