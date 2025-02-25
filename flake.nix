{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    let
      pkgs = import nixpkgs { system = system; };
    in pkgs.buildEnv {
      name = "nvim-tools";
      paths = with pkgs; [
        # System Tools
        unzip
        xclip
        coreutils
        # Tools
        bash-completion
        neovim
        tmux
        curl
        fd
        ripgrep
        fzf
        lazygit
        awscli2
        direnv
        # Runtime
        rustc
        cargo
        nodejs_20
        # Python Runtime
        (ruby.withPackages (ps: with ps; [ neovim ]))
      (python312.withPackages (ps: with ps; [ pip ]))
    ];
  };
}
