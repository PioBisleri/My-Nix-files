{ config, pkgs, ... }: {

  imports = [
    ./hardware-configuration.nix
    ./sys-modules/base.nix
    ./sys-modules/display.nix
    ./sys-modules/audio.nix
    ./sys-modules/hardware.nix
    ./sys-modules/users.nix
    ./sys-modules/packages.nix
    ./sys-modules/virtualisation.nix
  ];

}
