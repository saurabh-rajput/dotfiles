#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Set to superior editing mode
set -o vi

# ~~~~~~~~~~~~~~~ Environment Variables ~~~~~~~~~~~~~~~~~~~~~~~~

export VISUAL=nvim
export EDITOR=nvim
export TERM=screen-256color

# get rid of mail notifications on MacOS
unset MAILCHECK

# ~~~~~~~~~~~~~~~ Path configuration ~~~~~~~~~~~~~~~~~~~~~~~~

# ~~~~~~~~~~~~~~~ History ~~~~~~~~~~~~~~~~~~~~~~~~

export HISTFILE=~/.histfile
export HISTSIZE=25000
export SAVEHIST=25000
export HISTCONTROL=ignorespace

# ~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~

# ~~~~~~~~~~~~~~~ SSH ~~~~~~~~~~~~~~~~~~~~~~~~
# SSH Script from arch wiki
# if ! pgrep -u "$USER" ssh-agent >/dev/null; then
# 	ssh-agent >"$XDG_RUNTIME_DIR/ssh-agent.env"
# fi
# if [[ ! "$SSH_AUTH_SOCK" ]]; then
# 	source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
# fi

# Only run on Ubuntu

# if [[ $(grep -E "^(ID|NAME)=" /etc/os-release | grep -q "ubuntu")$? == 0 ]]; then
# 	eval "$(ssh-agent -s)" >/dev/null
# 	eval "$(fzf --bash)"
# fi

# git
alias gp='git pull'
alias gs='git status'
alias lg='lazygit'

# fzf aliases
# use fp to do a fzf search and preview the files
alias fp="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
# search for a file with fzf and open it in vim
alias vf='nvim $(fp)'

if [[ "$OSTYPE" == "darwin"* ]]; then
  source "$HOME/.fzf.bash"
  # echo "I'm on Mac!"

  # brew bash completion
  [[ -r "/opt/homebrew/etc/profile.d/bash_completion.sh" ]] && . "/opt/homebrew/etc/profile.d/bash_completion.sh"
else
  #	source /usr/share/fzf/key-bindings.bash
  #	source /usr/share/fzf/completion.bash
  [ -f ~/.fzf.bash ] && source ~/.fzf.bash
fi

# Only needed for npm install on WSL
#export NVM_DIR="$HOME/.config/nvm"
#[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
#[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
