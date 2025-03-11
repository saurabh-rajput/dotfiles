{pkgs, ...}: let
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

  users.users.ubuntu.shell = pkgs.zsh;
}
