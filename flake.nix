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
          pkgs = nixpkgs.legacyPackages.${arch};
          modules = extraModules;
          extraSpecialArgs = { inherit self; };
        };
    in {


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
