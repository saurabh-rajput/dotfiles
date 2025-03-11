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

      # Configuration for arm macos
      apps."aarch64-darwin".default = let
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
        init = pkgs.writeShellApplication {
          name = "init";
          runtimeInputs = with pkgs; [git curl bash];
          text = ''
            # Apple Silicon Macs can install Rosetta, which enables the system to run binaries for Intel CPUs transparently
            softwareupdate --install-rosetta --agree-to-license

            git clone git@github.com:vishwassharma/dotfiles.git ~/.dotfiles
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            # nix run nix-darwin -- switch --flake ~/.dotfiles
            nix run nix-darwin/master#darwin-rebuild -- switch --flake ~/.dotfiles
            nix run home-manager/master -- switch --flake ~/.dotfiles
            # 
            # nix run nixpkgs#darwin.linux-builder
          '';
        };
      in {
        type = "app";
        program = "${init}/bin/init";
      };

      # Configuration for intel x86_64-linux
      apps."x86_64-linux".default = let
        pkgs = nixpkgs.legacyPackages."x86_64-linux";
        init = pkgs.writeShellApplication {
          name = "init";
          text = ''
            nix run home-manager/master -- switch --flake ~/.dotfiles
          '';
        };
      in {
        type = "app";
        program = "${init}/bin/init";
      };

      darwinConfigurations = {
        "macbook" = mkDarwin {
          extraDarwinModules = [./nix/darwin/personal.nix];
        };
      };

      homeConfigurations = {
        "vishwas" = mkHm {
            extraModules = [ ./nix/home/personal.nix ];
            arch = "aarch64-darwin";
        };
        "vishwas@macbook" = mkHm {
            extraModules = [ ./nix/home/personal.nix ];
            arch = "aarch64-darwin";
        };
        "ubuntu" = mkHm {
          extraModules = [ ./nix/home/personal.nix ];
          arch = "x86_64-linux";
        };
      };
    };
}
