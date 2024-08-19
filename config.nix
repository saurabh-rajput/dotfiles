{
  packageOverrides = pkgs: with pkgs; {
    nvim-environment = pkgs.buildEnv {
      name = "nvim-tools";
      paths = [
        bash-completion
        neovim
        fd
        ripgrep
        fzf
        lazygit
        awscli2
        nodejs_20
        protobuf_26
      ];
    };
  };
}
