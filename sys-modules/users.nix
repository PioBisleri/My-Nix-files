{ config, pkgs, vars, ... }: {

  users.users."${vars.username}" = {
    isNormalUser = true;
    description = vars.fullName;
    extraGroups = [ "networkmanager" "wheel" "vboxusers" "input" ];
    shell = pkgs.zsh;
  };

  security.polkit.enable = true;

}
