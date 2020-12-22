#!/bin/bash

# Source project paths so they are globally accessible
source $HOME/dots/vars.sh
source $HOME/dots/aliases.sh
source $HOME/dots/functions.sh

export SDKMAN_DIR="/home/varun/.sdkman"
[[ -s "/home/varun/.sdkman/bin/sdkman-init.sh" ]] && source "/home/varun/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export GOPATH=$HOME/go
export PATH=$HOME/.cargo/bin:/snap/bin:/usr/local/go/bin:$HOME/go/bin:$PATH

eval "$(starship init zsh)"

[ -s "$HOME/.asdf/asdf.sh" ] && \. "$HOME/.asdf/asdf.sh" 
# append completions to fpath
fpath=(${ASDF_DIR}/completions $fpath)
# initialise completions with ZSH's compinit
autoload -Uz compinit
compinit
