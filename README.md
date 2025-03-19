# Dotfiles

Slimmed-down dotfiles for all use cases

These dotfiles are now managed using Nix on macOS and Linux.

macOS utilizes nix-darwin in order to manage homebrew dependencies, and both macOS and Linux utilize home-manager for dotfiles and nixpkgs.

## Getting Started

Install Nix

```bash
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

Run the installer

```bash
nix run github:saurabh-rajput/dotfiles
```

## Usage

You can see the current tasks by running `just --list`

```bash
 just --list
Available recipes:
    brew            # update homebrew
    fix-shell-files # fix shell files. this happens sometimes with nix-darwin
    flake-update    # update your flake.lock
    hm              # run home-manager switch
    rebuild         # rebuild either nix-darwin or NixOS
```


FIX:

Incase you are not able to connect to services when are you in your ssh from mac
```
infocmp -x | ssh SERVERNAME -- tic -x -
```

## References

- (LazyVim for Ambitious Developers)[https://lazyvim-ambitious-devs.phillips.codes/]
- (Nix Inspired dot files)[https://github.com/mhanberg/.dotfiles]
