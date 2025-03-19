{...}: let
  commonCasks = import ./casks.nix;
in {
  homebrew.casks =
    [
      # "zoom"
      "nordvpn"
    ]
    ++ commonCasks;
  homebrew.brews = import ./brews.nix;
  nix.settings.trusted-users = ["saurabhrajput" "ubuntu"];
}
