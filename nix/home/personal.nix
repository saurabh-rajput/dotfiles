{pkgs, ...}: let
  common = pkgs.callPackage ./packages.nix {inherit pkgs;};
in {
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "vishwas";
  home.homeDirectory = "/Users/vishwas";
  imports = [
    ./common.nix
  ];
  home.packages = common.packages;
}
