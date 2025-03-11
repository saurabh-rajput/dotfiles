{pkgs, lib, ...}: let
  common = pkgs.callPackage ./packages.nix {inherit pkgs;};
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "ubuntu";
  home.homeDirectory = "/home/ubuntu";
  imports = [
    ./common.nix
  ];
  home.packages = common.packages;

  # users.ubuntu.shell = pkgs.zsh;
  # Set zsh as default shell on activation
  # home.activation.make-zsh-default-shell = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
  #   # if zsh is not the current shell
  #   PATH="/usr/bin:/bin:$PATH"
  #   ZSH_PATH="/home/ubuntu/.nix-profile/bin/zsh"
  #   if [[ $(getent passwd ubuntu) != *"$ZSH_PATH" ]]; then
  #     echo "setting zsh as default shell (using chsh). password might be necessay."
  #     if grep -q $ZSH_PATH /etc/shells; then
  #       echo "adding zsh to /etc/shells"
  #       run echo "$ZSH_PATH" | sudo tee -a /etc/shells
  #     fi
  #     echo "running chsh to make zsh the default shell"
  #     run chsh -s $ZSH_PATH ubuntu
  #     echo "zsh is now set as default shell !"
  #   fi
  # '';
}
