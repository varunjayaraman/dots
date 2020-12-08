#!/bin/bash

# Source project paths so they are globally accessible
source $HOME/dotfiles/vars.sh
source $HOME/dotfiles/aliases.sh
source $HOME/dotfiles/functions.sh

export SDKMAN_DIR="/home/varun/.sdkman"
[[ -s "/home/varun/.sdkman/bin/sdkman-init.sh" ]] && source "/home/varun/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH=$HOME/.cargo/bin:$PATH
