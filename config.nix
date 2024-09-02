{
  packageOverrides = pkgs: with pkgs; {
    nvim-environment = pkgs.buildEnv {
      name = "nvim-tools";
      paths = [
        # System Tools
        gcc
        glibc
        unzip
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
        # Runtime
        rustc
        cargo
        nodejs_20
        # Python Runtime
        (ruby.withPackages (ps: with ps; [ neovim ]))
        (python312.withPackages (ps: with ps; [ pip ]))
        pipx
        # Language Servers
        clang-tools
      ];
    };
  };
}
