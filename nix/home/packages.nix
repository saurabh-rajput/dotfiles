{pkgs, ...}: let
  packages = with pkgs;
    [
      alejandra
      autoconf
      autogen
      automake
      awscli2
      chromedriver
      cmake
      direnv
      fzf
      gawk
      gh
      git
      jq
      just
      lazygit
      neovim
      neovim-remote
      nix-direnv
      bash-language-server
      ripgrep
      silver-searcher
      tmux
      tree-sitter
      vim
      zsh
    ]
    ++ (
      if pkgs.stdenv.isLinux
      then [gcc coreutils xclip unixtools.ifconfig inotify-tools ncurses5]
      else []
    );
in {
  inherit packages;
}
