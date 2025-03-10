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
    # ".bin".source = ../../bin;
    # ".bin".recursive = true;
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
    escapeTime = 0;
    keyMode = "vi";
    mouse = true;
    prefix = "C-a";
    baseIndex = 1;
    terminal = "xterm-ghostty";
    shell = "${pkgs.zsh}/bin/zsh";
    plugins = with pkgs.tmuxPlugins; [
      sensible
      tmux-which-key
      yank
    ];
    # extraConfig = ''
    #   ## Tmux configuration
    #
    #   # List of plugins
    #   set -g @plugin 'tmux-plugins/tpm'
    #   # A set of tmux options that should be acceptable to everyone
    #   set -g @plugin 'tmux-plugins/tmux-sensible' # https://github.com/tmux-plugins/tmux-sensible
    #
    #   # Persists tmux environment across system restarts
    #   # set -g @plugin 'tmux-plugins/tmux-resurrect' # https://github.com/tmux-plugins/tmux-resurrect
    #   # which process to restore
    #   # set -g @resurrect-processes 'mosh-client'
    #   # pane ka content bhi restore karna hai 
    #   # set -g @resurrect-capture-pane-contents 'on'
    #
    #   # tmux-continuum
    #   # Continuous saving of tmux environment. 
    #   # Automatic restore when tmux is started.
    #   # set -g @plugin 'tmux-plugins/tmux-continuum' # https://github.com/tmux-plugins/tmux-continuum
    #   # set -g @continuum-save-interval '60'
    #   # set -g @continuum-restore 'on'
    #   # set -g status-right 'Continuum status: #{continuum_status}'
    #
    #   # tmux-yank
    #   # Copy to system clipboard in tmux supports
    #   # linux, macos and windows syssystem for linux
    #   set -g @plugin 'tmux-plugins/tmux-yank'
    #
    #
    #
    #   # Start index of window/pane with 1, because we're humans, not computers
    #   set -g base-index 1
    #   setw -g pane-base-index 1
    #
    #   # Enable mouse support
    #   set-option -g history-limit 25000
    #   set -g mouse on
    #
    #   # for neovim
    #   set -sg escape-time 10
    #   set-option -g focus-events on
    #
    #
    #   ## ======================================
    #   ## KEYBOARD BINDINGS
    #   ## ======================================
    #
    #   # Basic configuration
    #   # Change prefix key to C-a, easier to type, same to "screen"
    #   unbind C-b
    #   set -g prefix C-a
    #   bind-key C-a last-window
    #
    #   # set window split
    #   bind-key | split-window -h
    #   bind-key _ split-window
    #
    #   # clear the terminal history
    #   # bind -n C-k clear-history
    #
    #   # Rename session and window
    #   bind r command-prompt -I "#{window_name}" "rename-window '%%'"
    #   bind R command-prompt -I "#{session_name}" "rename-session '%%'"
    #
    #
    #   # easy reload config
    #   bind-key C-r source-file ~/.tmux.conf \; display-message "~/.tmux.conf reloaded."
    #
    #   # hjkl pane traversal
    #   bind h select-pane -L
    #   bind j select-pane -D
    #   bind k select-pane -U
    #   bind l select-pane -R
    #
    #   # set to main-horizontal, 66% height for main pane
    #   bind m run-shell "~/.tmux/scripts/resize-adaptable.sh -l main-horizontal -p 66"
    #   # Same thing for verical layouts
    #   bind M run-shell "~/.tmux/scripts/resize-adaptable.sh -l main-vertical -p 50"
    #
    #   ## ======================================
    #   ## END KEYBOARD BINDINGS
    #   ## ======================================
    #
    #
    #   # set -g default-command "reattach-to-user-namespace -l $SHELL"
    #
    #   ## ======================================
    #   ## HACK
    #   ## Ref: https://github.com/tony/tmux-config/blob/master/.tmux.conf
    #   ## ======================================
    #
    #   # Vi copypaste mode
    #   set-window-option -g mode-keys vi
    #   if-shell "test '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -ge 4 \)'" 'bind-key -Tcopy-mode-vi v send -X begin-selection; bind-key -Tcopy-mode-vi y send -X copy-selection-and-cancel'
    #   if-shell '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -lt 4\) -o #{$TMUX_VERSION_MAJOR} -le 1' 'bind-key -t vi-copy v begin-selection; bind-key -t vi-copy y copy-selection'
    #
    #   # rm mouse mode fail
    #   if-shell '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -ge 1\)' 'set -g mouse off'
    #   if-shell '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -lt 1\) -o #{$TMUX_VERSION_MAJOR} -le 1' 'set -g mode-mouse off'
    #
    #
    #   # fix pane_current_path on new window and splits
    #   if-shell "test '#{$TMUX_VERSION_MAJOR} -gt 1 -o \( #{$TMUX_VERSION_MAJOR} -eq 1 -a #{$TMUX_VERSION_MINOR} -ge 8 \)'" 'unbind c; bind c new-window -c "#{pane_current_path}"'
    #   if-shell "test '#{$TMUX_VERSION_MAJOR} -gt 1 -o \( #{$TMUX_VERSION_MAJOR} -eq 1 -a #{$TMUX_VERSION_MINOR} -ge 8 \)'" "unbind '\"'; bind '\"' split-window -v -c '#{pane_current_path}'"
    #   if-shell "test '#{$TMUX_VERSION_MAJOR} -gt 1 -o \( #{$TMUX_VERSION_MAJOR} -eq 1 -a #{$TMUX_VERSION_MINOR} -ge 8 \)'" 'unbind v; bind v split-window -h -c "#{pane_current_path}"'
    #   if-shell "test '#{$TMUX_VERSION_MAJOR} -gt 1 -o \( #{$TMUX_VERSION_MAJOR} -eq 1 -a #{$TMUX_VERSION_MINOR} -ge 8 \)'" 'unbind "%"; bind % split-window -h -c "#{pane_current_path}"'
    #
    #   # Try screen256-color (https://github.com/tmux/tmux/issues/622):
    #   set -g default-terminal "screen-256color"
    #   if-shell "test '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -ge 6 \)'" 'set -g default-terminal "screen-256color"'
    #   if-shell "test '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -ge 6 \)'" 'set -ga terminal-overrides ",screen-256color:Tc"'
    #   if-shell '\( #{$TMUX_VERSION_MAJOR} -eq 2 -a #{$TMUX_VERSION_MINOR} -lt 6\) -o #{$TMUX_VERSION_MAJOR} -le 1' 'set -g default-terminal "screen-256color"'
    #   ## ======================================
    #   ## END HACK
    #   ## ======================================
    #
    #   # Automatic tpm installation 
    #   if "test ! -d ~/.tmux/plugins/tpm" \
    #      "run 'git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins'"
    #   # Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
    #   run '~/.tmux/plugins/tpm/tpm'
    # '';
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
      dev = "tmux new -A main";
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
