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
      # Home Manager
      mkHm = {
        extraModules ? [],
        arch,
      }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {  system = arch; };
          modules = extraModules;
        };
    in {

      homeConfigurations = {
        "vishwas@dhanush" = mkHm {
          extraModules = [ ./nix/home/personal.nix ];
          arch = "aarch64-darwin";
        };
      };
    };
}
