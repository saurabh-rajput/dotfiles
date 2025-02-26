{...}: let
  commonCasks = import ./casks.nix;
in {
  homebrew.casks =
    [
      "kindle"
      "nordvpn"
      "slack"
      "zoom"
    ]
    ++ commonCasks;
  homebrew.brews = import ./brews.nix;
  nix.settings.trusted-users = ["vishwas" "ubuntu"];
}
