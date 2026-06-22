{ config, pkgs, ... }:

{
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession.enable = true;
  };

  programs.gamemode.enable = true;

  hardware.opengl.driSupport32Bit = true;

  environment.systemPackages = with pkgs; [
    gamescope
    osu-lazer-bin
    mangohud
    lutris
  ];

  boot.kernel.sysctl = {
    "vm.max_map_count" = 2147483642;
  };
}
