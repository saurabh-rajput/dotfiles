{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }@inputs:
    let
      mkHm = {
        extraModules ? [],
        arch,
      }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${arch};
          modules =
            [
              # {
              #   home.packages = [rummage.packages.${arch}.default];
              # }
            ]
            ++ extraModules;
        };
    in {
      homeConfigurations = {
        "vishwas" = mkHm {
            extraModules = [ ./nix/home/personal.nix ];
            arch = "aarch64-darwin";
        };
      };
    };
}
