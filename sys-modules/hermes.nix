{ config, pkgs, vars, inputs, ... }: {

  services.hermes-agent = {
    enable = true;
    addToSystemPackages = true;
  };

}
