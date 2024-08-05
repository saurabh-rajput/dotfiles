{
  packageOverrides = pkgs: with pkgs; {
    nvim-enviornment = pkgs.buildEnv {
      name = "nvim-tools";
      paths = [
        bash-completion
        neovim
        fd
        ripgrep
        fzf
        lazygit
      ];
    };
  };
}
