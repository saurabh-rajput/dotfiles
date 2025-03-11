{pkgs, ...}: let
  packages = with pkgs;
    [
      # chromedriver
      gawk
      gh
      git
      delta
      jq
      just
      nix-direnv
      silver-searcher
      tree-sitter
      vim
      zsh
      starship
      universal-ctags

      # System Tools
      unzip
      xclip
      # Tools
      bash-completion
      bash-language-server
      neovim
      neovim-remote
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
      nodejs
      # Python Runtime
      (ruby.withPackages (ps: with ps; [ neovim ]))
      (python312.withPackages (ps: with ps; [ pip pyelftools ]))
    ]
    ++ (
      if pkgs.stdenv.isLinux
      then [ xclip unixtools.ifconfig inotify-tools ncurses5]
      else [ ]  # darwin
    );
in {
  inherit packages;
}
