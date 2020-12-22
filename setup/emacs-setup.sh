#!/bin/zsh

echo "Creating symlink for emacs init.el..."
emacs_dir="$HOME/.emacs.d"
if [! -d $emacs_dir ]; then
  rm -rf $emacs_dir
  mkdir $emacs_dir
  ln -s $DOTFILES_PATH/emacs/init.el $HOME/.emacs.d/init.el
fi
