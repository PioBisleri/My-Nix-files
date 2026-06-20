{ config, pkgs, ... }: {

  programs.git = {
    enable = true;
    settings = {
      user.name = "veer";
      user.email = "veer@nixos";
      init.defaultBranch = "main";
      pull.rebase = true;
    };
  };

}