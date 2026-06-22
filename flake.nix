{
  description = "NixOS configuration for veer";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add the fetch flake input here
    areofyl-fetch.url = "github:areofyl/fetch";

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, areofyl-fetch, sops-nix, ... }@inputs:
    let
      vars = import ./vars.nix;
    in {
      nixosConfigurations.${vars.hostname} = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      
      # Pass inputs to configuration.nix so it can use them
      specialArgs = { inherit inputs vars; };

      modules = [
        ./configuration.nix
        
        # Home Manager module
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          # Point to veer's home.nix
          home-manager.users.${vars.username} = import ./home.nix;
          
          # Make inputs available in home.nix
          home-manager.extraSpecialArgs = { inherit inputs vars; };
        }
      ];
    };
  };
}
