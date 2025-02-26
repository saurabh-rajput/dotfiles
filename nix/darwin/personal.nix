{pkgs, ...}: let
  common = pkgs.callPackage ./packages.nix {inherit pkgs;};
in {
  home.username = "vishwas";
  home.homeDirectory = "/Users/vishwas";
  imports = [
    ./common.nix
    # ./themes/rose-pine.nix
  ];
  home.packages = common.packages;
  # programs.ghostty.settings.font-size = 14;
  # programs.ssh.extraConfig = ''
  #   Host * "test -z $SSH_TTY"
  #     IdentityAgent ~/Library/Containers/com.maxgoedjen.Secretive.SecretAgent/Data/socket.ssh
  # '';
  # programs.git.extraConfig.gpg.ssh.program = "/Applications/1Password.app/Contents/MacOS/op-ssh-sign";
  # programs.git.extraConfig.gpg.format = "ssh";
  # programs.git.extraConfig.commit.gpgSign = true;
  # programs.git = {
  #   signing.key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDckxDud0PGdGd60v/1SUa0pbWWe46FcVIbuTijwzeZR";
  # };
}
