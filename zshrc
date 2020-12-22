#!/bin/bash

export DOTFILES_PATH="$HOME/dots"
# Source project paths so they are globally accessible
source $DOTFILES_PATH/vars.sh
source $DOTFILES_PATH/aliases.sh
source $DOTFILES_PATH/functions.sh

export SDKMAN_DIR="/home/varun/.sdkman"
[[ -s "/home/varun/.sdkman/bin/sdkman-init.sh" ]] && source "/home/varun/.sdkman/bin/sdkman-init.sh"

export GOPATH=$HOME/go
export PATH=$HOME/.cargo/bin:/snap/bin:/usr/local/go/bin:$GOPATH/bin:$PATH

if [[ -n "$ZSH_VERSION" ]]; then
  echo "Setting prompt to starship prompt"
  eval "$(starship init zsh)"

  echo "Adding asdf completions"
  [ -s "$HOME/.asdf/asdf.sh" ] && \. "$HOME/.asdf/asdf.sh" 
  # append completions to fpath
  fpath=(${ASDF_DIR}/completions $fpath)
  # initialise completions with ZSH's compinit
  autoload -Uz compinit
  compinit
fi

