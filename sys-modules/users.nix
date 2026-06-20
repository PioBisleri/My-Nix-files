{ config, pkgs, ... }: {

  users.users."veer" = {
    isNormalUser = true;
    description = "Veer";
    extraGroups = [ "networkmanager" "wheel" "vboxusers" "input" ];
    shell = pkgs.zsh;
  };

  security.polkit.enable = true;

}
