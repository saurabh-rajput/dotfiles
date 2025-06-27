{pkgs, ...}: let
  packages = with pkgs;
    [
      # System Tools
      just
      unzip
      xclip
      tree
      coreutils
      # END System Tools

      # Tools
      bash-completion
      bash-language-server
      zsh
      starship
      universal-ctags
      tmux
      # END Tools
      
      # Search and Replace
      gawk
      silver-searcher
      fd
      ripgrep
      fzf
      # END Search and Replace

      


      # Git tools
      gh
      git
      meld
      lazygit
      delta # new gen pager https://github.com/dandavison/delta
      pre-commit
      # END Git tools

      # Environment management
      nix-direnv
      direnv
      # END Environment management

      # Parsers
      jq
      tree-sitter
      # END Parsers

      # Editors
      vim
      neovim
      neovim-remote
      # END Editors
      
      curl
      awscli2

      # Runtime
      rustc
      cargo
      nodejs
      nodePackages.aws-cdk
      # Python Runtime
      (ruby.withPackages (ps: with ps; [ neovim ]))
      (python312.withPackages (ps: with ps; [ pip pyelftools click pip-tools ]))
      # Poetry 
      poetry
      poetryPlugins.poetry-plugin-export
      # END Poetry 
      uv
      plantuml
      zulu # java
      # END Runtime

    ]
    ++ (
      if pkgs.stdenv.isLinux
      then [ gcc xclip unixtools.ifconfig inotify-tools ncurses5]
      else [ ]  # darwin
    );
in {
  inherit packages;
}
