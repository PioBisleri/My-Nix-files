{
  description = "NixOS configuration for veer";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      
      specialArgs = { inherit inputs vars; };
      modules = [
        ./configuration.nix
        
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          
          home-manager.users.${vars.username} = import ./home.nix;
          
          home-manager.extraSpecialArgs = { inherit inputs vars; };
        }
      ];
    };
  };
}
