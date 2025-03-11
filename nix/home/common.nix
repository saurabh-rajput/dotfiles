{pkgs, ...}: {
  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".bin".source = ../../bin;
    ".bin".recursive = true;
    ".config".source = ../../config;
    ".config".recursive = true;
    ".gitignore_global".source = ../../gitignore_global;
    # ".vsnip/elixir.json".source = ../../vsnip/elixir.json;
    ".xterm-256color.terminfo".source = ../../xterm-256color.terminfo;
  };

  # xdg.enable = true;

  programs.tmux = {
    enable = true;
    sensibleOnTop = false;
    escapeTime = 10;
    keyMode = "vi";
    prefix = "C-a";
    baseIndex = 1;
    terminal = "xterm-ghostty";
    shell = "${pkgs.zsh}/bin/zsh";
    plugins = with pkgs.tmuxPlugins; [
      # sensible
      tmux-which-key
      yank
    ];
    # Enable mouse support
    mouse = true;
    # Maximum number of lines held in window history
    historyLimit = 25000;
    extraConfig = ''
    
    
      set -a terminal-features '*:usstyle'
      set -as terminal-features ',xterm-ghostty:clipboard'
      set -g allow-passthrough all
      set -s set-clipboard on
      set -g set-titles on
      set -g set-titles-string "#S (#W)"
      set-option -g focus-events on

      ## ======================================
      ## KEYBOARD BINDINGS
      ## ======================================
      bind-key C-a last-window

      # set window split
      bind-key | split-window -h
      bind-key \\ split-window -h -c '#{pane_current_path}'
      bind-key _ split-window
      bind-key - split-window -v -c '#{pane_current_path}'

      #Smart pane switching with awareness of Vim splits.
      # See: https://github.com/christoomey/vim-tmux-navigator
      
      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?(view|n?vim?x?)(diff)?$'"

      bind-key -n C-h if-shell "$is_vim" "send-keys C-h"  "select-pane -L"
      bind-key -n C-j if-shell "$is_vim" "send-keys C-j"  "select-pane -D"
      bind-key -n C-k if-shell "$is_vim" "send-keys C-k"  "select-pane -U"
      bind-key -n C-l if-shell "$is_vim" "send-keys C-l"  "select-pane -R"
      bind-key -n C-'\' if-shell "$is_vim" "send-keys C-\\" "select-pane -l"

      bind-key -T copy-mode-vi C-h select-pane -L
      bind-key -T copy-mode-vi C-j select-pane -D
      bind-key -T copy-mode-vi C-k select-pane -U
      bind-key -T copy-mode-vi C-l select-pane -R
      bind-key -T copy-mode-vi C-'\' select-pane -l

      #  Reload Configuration 
      bind-key C-r source-file ~/.config/tmux/tmux.conf \; display "Reloaded ~/.config/tmux/tmux.conf"

      bind C-m display-popup -E -w "90%" -h "90%" -e XDG_CONFIG_HOME="$HOME/.config" "lazygit"
      bind C-h display-popup -E -w "90%" -h "90%"  "fzf-prs"
      bind C-i display-popup -E -w "90%" -h "90%"  "fzf-issues"

      unbind-key C-d

      # Copy helper
      bind-key -T copy-mode-vi 'v' send -X begin-selection
      bind-key -T copy-mode-vi 'y' send -X copy-selection-and-cancel

      # bind-key -T vi-copy v begin-selection
      # bind-key -T vi-copy y copy-pipe "reattach-to-user-namespace pbcopy"
      
      # unbind -T vi-copy Enter

      # clear the terminal history
      # bind -n C-k clear-history
    
      # Rename session and window
      bind r command-prompt -I "#{window_name}" "rename-window '%%'"
      bind R command-prompt -I "#{session_name}" "rename-session '%%'"
    
    
      # # hjkl pane traversal
      # bind h select-pane -L
      # bind j select-pane -D
      # bind k select-pane -U
      # bind l select-pane -R
    
      # # set to main-horizontal, 66% height for main pane
      # bind m run-shell "~/.tmux/scripts/resize-adaptable.sh -l main-horizontal -p 66"
      # # Same thing for verical layouts
      # bind M run-shell "~/.tmux/scripts/resize-adaptable.sh -l main-vertical -p 50"
    
      ## ======================================
      ## END KEYBOARD BINDINGS
      ## ======================================
    '';
  };

  # programs.ssh = {
  #   enable = true;
  #   forwardAgent = true;
  # };

  programs.git = {
    enable = true;
    userName = "Vishwas Sharma";
    userEmail = "vishwasinventor@gmail.com";
    aliases = {
      co = "checkout";
    };
    # signing = {
    #   key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDckxDud0PGdGd60v/1SUa0pbWWe46FcVIbuTijwzeZR";
    # };
    # delta = {
    #   enable = true;
    # };
    # includes = [
    #   {path = "~/.gitconfig.local";}
    # ];

    extraConfig = {
      push = {
        autoSetupRemote = true;
        followTags = true;
      };
      color.branch = "auto";
      core = {
        excludesFile = "~/.gitignore_global";
        editor = "nvim";
        # pager = "cat";
      };
      # pager = {
      #   diff = false;
      # };
      # pull.ff = "only";
      init.defaultBranch = "master";
      # gpg.format = "ssh";
      # gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      # commit.gpgSign = true;
      # rebase.updateRefs = true;
    };
  };

  # programs.btop.enable = true;
  # programs.btop.settings.color_theme = "tokyo-night";
  # programs.btop.settings.theme_background = true;

  programs.zsh = {
    enable = true;
    autocd = true;
    enableVteIntegration = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    plugins = [
      {
        name = "ohmyzsh-key-bindings";
        src = pkgs.fetchFromGitHub {
          owner = "kytta";
          repo = "ohmyzsh-key-bindings";
          rev = "main";
          sha256 = "sha256-BXIYzHxmHHThMko+f87HL0/Vak53Mfdr/4VCrll8OiM=";
        };
      }
    ];
    sessionVariables = {
      EDITOR = "nvim";
      ERL_AFLAGS = "-kernel shell_history enabled";
      KERL_BUILD_DOCS = "yes";
      CLOUD = "$HOME/Library/Mobile Documents/com~apple~CloudDocs/";
      ICLOUD = "$HOME/Library/Mobile Documents/com~apple~CloudDocs";
    };

    shellAliases = {
      dev = "tmux new -A -s main";
    };

    initExtra = ''
      export EDITOR=nvim

      if uname -a | grep -i "darwin" > /dev/null; then
        eval $(/opt/homebrew/bin/brew shellenv)
      fi

      path() {
        echo $PATH | tr ':' '\n'
      }

      # aliases that use env vars or spaces
      export PATH="$HOME/.bin:$PATH"
      # export PATH="$HOME/.local/bin:$PATH"
    '';
  };

  # programs.bat.enable = true;
  # programs.bat.themes = {
  #   kanagawa = {
  #     src = pkgs.fetchFromGitHub {
  #       owner = "obergodmar";
  #       repo = "kanagawa-tmTheme"; # Bat uses sublime syntax for its themes
  #       rev = "edb1e41256421a7b26348c80146bcff2c3e37f34";
  #       sha256 = "5Gj0Jz6UUm55v5d7V7E89ujUDSn0aGsZrOMS5FXduAE=";
  #     };
  #     file = "Kanagawa.tmTheme";
  #   };
  # };

  programs.fzf = {
    enable = true;
    defaultCommand = "rg --files --hidden --glob '!.git/'";
  };
  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      aws = {
        symbol = "  ";
      };
      buf = {
        symbol = " ";
      };
      c = {
        symbol = " ";
      };
      cmake = {
        symbol = " ";
      };
      conda = {
        symbol = " ";
      };
      crystal = {
        symbol = " ";
      };
      dart = {
        symbol = " ";
      };
      directory = {
        read_only = " 󰌾";
      };
      docker_context = {
        symbol = " ";
      };
      elixir = {
        symbol = " ";
      };
      elm = {
        symbol = " ";
      };
      fennel = {
        symbol = " ";
      };
      fossil_branch = {
        symbol = " ";
      };
      git_branch = {
        symbol = " ";
      };
      git_commit = {
        tag_symbol = "  ";
      };
      golang = {
        symbol = " ";
      };
      guix_shell = {
        symbol = " ";
      };
      haskell = {
        symbol = " ";
      };
      haxe = {
        symbol = " ";
      };
      hg_branch = {
        symbol = " ";
      };
      hostname = {
        ssh_symbol = " ";
      };
      java = {
        symbol = " ";
      };
      julia = {
        symbol = " ";
      };
      kotlin = {
        symbol = " ";
      };
      lua = {
        symbol = " ";
      };
      memory_usage = {
        symbol = "󰍛 ";
      };
      meson = {
        symbol = "󰔷 ";
      };
      nim = {
        symbol = "󰆥 ";
      };
      nix_shell = {
        symbol = " ";
      };
      nodejs = {
        symbol = " ";
      };
      ocaml = {
        symbol = " ";
      };
      os = {
        symbols = {
          Alpaquita = " ";
          Alpine = " ";
          AlmaLinux = " ";
          Amazon = " ";
          Android = " ";
          Arch = " ";
          Artix = " ";
          CachyOS = " ";
          CentOS = " ";
          Debian = " ";
          DragonFly = " ";
          Emscripten = " ";
          EndeavourOS = " ";
          Fedora = " ";
          FreeBSD = " ";
          Garuda = "󰛓 ";
          Gentoo = " ";
          HardenedBSD = "󰞌 ";
          Illumos = "󰈸 ";
          Kali = " ";
          Linux = " ";
          Mabox = " ";
          Macos = " ";
          Manjaro = " ";
          Mariner = " ";
          MidnightBSD = " ";
          Mint = " ";
          NetBSD = " ";
          NixOS = " ";
          Nobara = " ";
          OpenBSD = "󰈺 ";
          openSUSE = " ";
          OracleLinux = "󰌷 ";
          Pop = " ";
          Raspbian = " ";
          Redhat = " ";
          RedHatEnterprise = " ";
          RockyLinux = " ";
          Redox = "󰀘 ";
          Solus = "󰠳 ";
          SUSE = " ";
          Ubuntu = " ";
          Unknown = " ";
          Void = " ";
          Windows = "󰍲 ";
        };
      };
      package = {
        symbol = "󰏗 ";
      };
      perl = {
        symbol = " ";
      };
      php = {
        symbol = " ";
      };
      pijul_channel = {
        symbol = " ";
      };
      python = {
        symbol = " ";
      };
      rlang = {
        symbol = "󰟔 ";
      };
      ruby = {
        symbol = " ";
      };
      rust = {
        symbol = "󱘗 ";
      };
      scala = {
        symbol = " ";
      };
      swift = {
        symbol = " ";
      };
      zig = {
        symbol = " ";
      };
      gradle = {
        symbol = " ";
      };
    };
    # settings = {
    #   format = ''
    #     [┌](bold white) $time
    #     [│](bold white)$all'';
    #   command_timeout = 1000;
    #   character = {
    #     format = "[└ ](bold white)$symbol ";
    #     success_symbol = "[](bold yellow)";
    #     error_symbol = "[](bold red)";
    #   };
    #   cmd_duration = {
    #     min_time = 5000;
    #     format = "took [$duration](bold yellow)";
    #   };
    #   git_metrics = {
    #     disabled = false;
    #   };
    #   time = {
    #     disabled = false;
    #     use_12hr = true;
    #     format = "[$time](bold yellow)";
    #   };
    #   aws = {
    #     symbol = "  ";
    #   };
    #   conda = {
    #     symbol = " ";
    #   };
    #   dart = {
    #     symbol = " ";
    #   };
    #   directory = {
    #     read_only = " ";
    #     style = "bold blue";
    #     substitutions = {
    #       "/Library/Mobile Documents/com~apple~CloudDocs" = "/iCloud";
    #     };
    #   };
    #   docker_context = {
    #     disabled = true;
    #     symbol = " ";
    #   };
    #   elixir = {
    #     symbol = " ";
    #   };
    #   elm = {
    #     symbol = " ";
    #   };
    #   git_branch = {
    #     symbol = " ";
    #   };
    #   golang = {
    #     symbol = " ";
    #   };
    #   hg_branch = {
    #     symbol = " ";
    #   };
    #   java = {
    #     symbol = " ";
    #   };
    #   julia = {
    #     symbol = " ";
    #   };
    #   memory_usage = {
    #     symbol = " ";
    #   };
    #   nim = {
    #     symbol = " ";
    #   };
    #   nix_shell = {
    #     symbol = " ";
    #   };
    #   package = {
    #     symbol = " ";
    #     disabled = true;
    #   };
    #   perl = {
    #     symbol = " ";
    #   };
    #   php = {
    #     symbol = " ";
    #   };
    #   python = {
    #     symbol = " ";
    #   };
    #   ruby = {
    #     symbol = " ";
    #   };
    #   rust = {
    #     symbol = "󱘗 ";
    #   };
    #   scala = {
    #     symbol = " ";
    #   };
    #   shlvl = {
    #     symbol = " ";
    #   };
    #   swift = {
    #     symbol = "󰛥 ";
    #   };
    # };
  };

  # programs.mise = {
  #   enable = false;
  # };

  programs.ghostty = {
    enable = true;
    package = null;
    installBatSyntax = false;
    settings = {
      font-family = "UbuntuMono Nerd Font Mono";
      font-size = 14;
      font-thicken = false;

      cursor-style = "block";
      cursor-style-blink = true;
      shell-integration-features = "no-cursor";
    };
  };

  programs.lazygit = {
    enable = true;
    settings = {
      git = {
        paging = {
          colorArg = "always";
          pager = "delta --paging=never";
          useConfig = false;
        };
        commit = {
          signOff = false;
          verbose = "default";
        };
        branchLogCmd = "git log --graph --color=always --abbrev-commit --decorate --date=relative --pretty=medium {{branchName}} --";
        allBranchesLogCmd = "git log --graph --all --color=always --abbrev-commit --decorate --date=relative  --pretty=medium";
        overrideGpg = false;
        disableForcePushing = false;
        confirmOnQuit = false;
        os = {
          open = "open -- {{filename}}";
          openLink = "open {{link}}";
        };
        disableStartupPopups = false;
        notARepository = "prompt";
      };
    };
  };

  programs.home-manager.enable = true;
}
