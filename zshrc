#!/bin/bash

export DOTFILES_PATH="$HOME/dots"
# Source project paths so they are globally accessible
source $DOTFILES_PATH/vars.sh
source $DOTFILES_PATH/aliases.sh
source $DOTFILES_PATH/functions.sh

export SDKMAN_DIR="/home/varun/.sdkman"
[[ -s "/home/varun/.sdkman/bin/sdkman-init.sh" ]] && source "/home/varun/.sdkman/bin/sdkman-init.sh"

export GOPATH=$HOME/go
export PATH=$HOME/.cargo/bin:/snap/bin:/usr/local/go/bin:$GOPATH/bin:$HOME/.local/share/gem/ruby/3.0.0/bin:$PATH

export PATH=$DOTFILES_PATH/language-servers/elixir:$PATH
export PATH=$HOME/.nimble/bin:$PATH

if [[ -n "$ZSH_VERSION" ]]; then
  eval "$(starship init zsh)"

  [ -s "$HOME/.asdf/asdf.sh" ] && \. "$HOME/.asdf/asdf.sh" 
  # append completions to fpath
  fpath=(${ASDF_DIR}/completions $fpath)
  # initialise completions with ZSH's compinit
  autoload -Uz compinit
  compinit
fi

