{ config, pkgs, vars, ... }: {

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = vars.hostname;
  networking.networkmanager.enable = true;
  networking.networkmanager.unmanaged = [ "interface-name:ipv6leakintrf0" ];
  networking.firewall = {
    enable = true;
    allowPing = true;
  };

  time.timeZone = vars.timezone;

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.settings = {
    # Disable HTTP/2 to prevent multiplexing stalls over libcurl
    http2 = false;

    # Limit concurrent downloads to avoid overwhelming NAT tables / TCP connections
    max-substitution-jobs = 4;

    # Cap open socket connections to keep transfers stable
    http-connections = 25;
  };
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 14d";
  };
  nix.optimise = {
    automatic = true;
    dates = "weekly";
  };

  nixpkgs.config.allowUnfree = true;

  services.power-profiles-daemon.enable = true;
  programs.zsh.enable = true;

  system.stateVersion = "26.05";

}
