{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.1-2.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nix-darwin, lix-module, ... }@inputs:
    let
      # Make Darwin
      mkDarwin = {extraDarwinModules ? {}}:
        nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          specialArgs = {inherit self;};
          modules =
            [
              lix-module.nixosModules.default
              ./nix/darwin.nix
            ]
            ++ extraDarwinModules;
        };
      # Make Home
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
      darwinConfigurations = {
        dhanush = mkDarwin {
          extraDarwinModules = [./nix/darwin/personal.nix];
        };
      };

      homeConfigurations = {
        "vishwas@dhanush" = mkHm {
            extraModules = [ ./nix/home/personal.nix ];
            arch = "aarch64-darwin";
        };
      };
    };
}
