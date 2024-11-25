{
  packageOverrides = pkgs: with pkgs; {
    nvim-environment = pkgs.buildEnv {
      name = "nvim-tools";
      paths = [
        # System Tools
        unzip
        xclip
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
  };
}
