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

      apps."aarch64-darwin".default = let
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
        init = pkgs.writeShellApplication {
          name = "init";
          runtimeInputs = with pkgs; [git curl bash];
          text = ''
            git clone git@github.com:vishwassharma/dotfiles.git ~/.dotfiles
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            nix run nix-darwin -- switch --flake ~/.dotfiles
            nix run home-manager/master -- switch --flake ~/.dotfiles
          '';
        };
      in {
        type = "app";
        program = "${init}/bin/init";
      };

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
