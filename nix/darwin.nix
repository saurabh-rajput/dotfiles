{self, ...}: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [];

  ids.gids.nixbld = 350;


  # Auto upgrade nix package and the daemon service.
  # services.nix-daemon.enable = true;
  # nix.package = pkgs.nix;

  # Necessary for using flakes on this system.
  nix.settings.experimental-features = "nix-command flakes";
  # Linux builders
  nix.linux-builder = { 
    enable = true; 
    ephemeral = true;
    maxJobs = 4;
    config = {
      virtualisation = {
        darwin-builder = {
          diskSize = 40 * 1024;
          memorySize = 8 * 1024;
        };
      };
      cores = 6;
    };
  };
  nix.settings.trusted-users = [ "@admin" ];

  # nix.distributedBuilds = true;

  # Set Git commit hash for darwin-version.
  system.configurationRevision = self.rev or self.dirtyRev or null;

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 6;


  # Unlocking sudo via fingerprint
  security.pam.services.sudo_local.touchIdAuth = true;
  
  # Finder shows all file extensions
  system.defaults.finder.AppleShowAllExtensions = true;
  # Default Finder folder view is the columns view
  system.defaults.finder.FXPreferredViewStyle = "clmv";
  # system.defaults.NSGlobalDomain.KeyRepeat = 2;
  # system.defaults.NSGlobalDomain.AppleInterfaceStyle = "Dark";
  # system.defaults.dock.autohide = true;
  # system.defaults.dock.mru-spaces = false;
  # system.defaults.dock.show-recents = false;
  # system.defaults.dock.tilesize = 39;

  programs.zsh.enable = true;
  homebrew.enable = true;
  homebrew.onActivation.cleanup = "uninstall";
  homebrew.taps = [
    "homebrew/services"
  ];

  # nix.extraOptions = [ "x86_64-darwin" "aarch64-darwin" ];

  # homebrew.masApps = {
  #   Magnet = 441258766;
  #   Dato = 1470584107;
  #   Reeder = 1529448980;
  #   Blackout = 1319884285;
  #   Shareful = 1522267256;
  #   Actions = 1586435171;
  #   MenuBarStats = 714196447;
  #   Things = 904280696;
  #   Keynote = 409183694;
  # };

  nixpkgs.config.allowUnfree = true;
  # The platform the configuration will be used on.
  nixpkgs.hostPlatform = "aarch64-darwin";
}
