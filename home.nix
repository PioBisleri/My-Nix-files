{ config, pkgs, inputs, vars, ... }: {

  home.stateVersion = "26.05";

  imports = [
    inputs.areofyl-fetch.homeManagerModules.default
    ./hm-modules/packages.nix
    ./hm-modules/zsh.nix
    ./hm-modules/git.nix
    ./hm-modules/gtk.nix
    ./hm-modules/services.nix
    ./hm-modules/waybar.nix
    ./hm-modules/hyprland.nix
    ./hm-modules/wofi.nix
    ./hm-modules/kitty.nix
    ./hm-modules/hyprlock.nix
    ./hm-modules/secrets.nix
  ];

}
