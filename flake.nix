{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.92.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager, lix-module, ... }@inputs:
    let
      # Darwin
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

      # Home Manager
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
      # Script to run on darwin
      apps."aarch64-darwin".default = let
        pkgs = nixpkgs.legacyPackages."aarch64-darwin";
        init = pkgs.writeShellApplication {
          name = "init";
          runtimeInputs = with pkgs; [git curl bash];
          text = ''
            git clone https://github.com/vishwassharma/dotfiles-devpod ~/.dotfiles
            bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            nix run nix-darwin -- switch --flake ~/.dotfiles
            nix run home-manager/master -- switch --flake ~/.dotfiles
          '';
        };
      in {
        type = "app";
        program = "${init}/bin/init";
      };

      # Script to run on linux
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
        dhanush = mkDarwin {
          extraDarwinModules = [./nix/darwin/personal.nix];
        };
      };

      homeConfigurations = {
        "vishwas@dhanush" = mkHm {
          extraModules = [./nix/home/personal.nix];
          arch = "aarch64-darwin";
        };
      };
    };
    # Flake Utils Start 
    # flake-utils.lib.eachDefaultSystem (system:
    #   let
    #     pkgs = import nixpkgs { system = system; };
    #   in {
    #     # Packages Begin
    #     packages = {
    #       default = pkgs.buildEnv {
    #         name = "nvim-tools";
    #         paths = with pkgs; [
    #           # System Tools
    #           unzip
    #           xclip
    #           coreutils
    #           # Tools
    #           bash-completion
    #           neovim
    #           tmux
    #           curl
    #           fd
    #           ripgrep
    #           fzf
    #           lazygit
    #           awscli2
    #           direnv
    #           # Runtime
    #           rustc
    #           cargo
    #           nodejs_20
    #           # Python Runtime
    #           (ruby.withPackages (ps: with ps; [ neovim ]))
    #         (python312.withPackages (ps: with ps; [ pip ]))
    #       ];
    #     };
    #   };
    #   # Packages END
    # });
    # # # Flake Utils End
}
