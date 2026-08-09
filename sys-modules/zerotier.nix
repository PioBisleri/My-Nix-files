{ config, pkgs, vars, ... }: {
  services.zerotierone = {
    enable = true;
    joinNetworks = [ vars.zerotierNetwork ];
  };
}
