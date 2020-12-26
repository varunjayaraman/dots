#!/bin/zsh

# This is a dotfile setup implementation for linux/ubuntu. Most of this should be transferrable to Macs or any unix-based system, but I created a
# separate file because the original implementation I wrote *was* specific to Mac

sudo apt update


# We duplicate this information from zshrc because this information might not have been loaded from the zshrc
DOTFILES_PATH="$HOME/dots"
setup_path="$DOTFILES_PATH/setup"

# Installs basic utilities necessary for configuring
# a development environment, and also configures shell
# to be ZSH
. $setup_path/deps.sh

if [[ -n "$ZSH_VERSION" ]]; then
  echo "Shell is already zsh, continuing..."
else
  chsh -s $(which zsh)
  echo "Please relogin to make sure your shell is now ZSH"
  exit
fi

configs=(
  "tmux.conf"
  "gitconfig"
  "agignore"
  "zshrc"
)

for config in $configs; do rm -f "$HOME/.$config" && sudo ln -s "$DOTFILES_PATH/$config" "$HOME/.$config"; done

setup_scripts=(
  "nvim-setup.sh"
  "docker-setup.sh"
  "langs-setup.sh"
  "snaps-setup.sh"
  "emacs-setup.sh"
)
for script in $setup_scripts; do . $setup_path/$script; done

# Setup asdf global versions
rm ~/.tool-versions
sudo ln -s $DOTFILES_PATH/tool-versions $HOME/.tool-versions
