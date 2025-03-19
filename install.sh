#!/bin/bash

export XDG_CONFIG_HOME="$HOME"/.config
mkdir -p "$XDG_CONFIG_HOME"
mkdir -p "$XDG_CONFIG_HOME"/nixpkgs

ln -sf "$PWD/nvim" "$XDG_CONFIG_HOME"/nvim

ln -sf "$PWD/.bash_profile" "$HOME"/.bash_profile
ln -sf "$PWD/.bashrc" "$HOME"/.bashrc
ln -sf "$PWD/.inputrc" "$HOME"/.inputrc
ln -sf "$PWD/.tmux.conf" "$HOME"/.tmux.conf
ln -sf "$PWD/config.nix" "$XDG_CONFIG_HOME"/nixpkgs/config.nix

# Configure Nix commands
mkdir -p ~/.config/nix
cat <<EOF >~/.config/nix/nix.conf
experimental-features = nix-command flakes
EOF

# Add channel
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update

# install Nix packages from config.nix
# nix-env -iA nixpkgs.nvim-environment
nix profile install github:saurabh-rajput/dotfiles

# tmux
# mkdir ~/.config/tmux/plugins &&
#   git clone --depth=1 https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm &&
#   ~/.config/tmux/plugins/tpm/scripts/install_plugins.sh &&
#   cd ~/.config/tmux/plugins/tmux-thumbs &&
#   expect -c "spawn ./tmux-thumbs-install.sh; send \"\r2\r\"; expect complete" 1>/dev/null

# nvim
# mkdir ~/.local/nvim &&
#   git clone --filter=blob:none --single-branch https://github.com/folke/lazy.nvim.git ~/.local/share/nvim/lazy
# nvim --headless "+Lazy! sync" +qa
# nvim --headless "+MasonUpdate" +qa
