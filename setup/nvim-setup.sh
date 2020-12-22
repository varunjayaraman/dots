#!/bin/zsh

echo "Installing neovim and symlinking config files"

sudo add-apt-repository ppa:neovim-ppa/stable

sudo add-apt-repository ppa:neovim-ppa/unstable

sudo apt update

sudo apt install neovim

neovim_dir="$HOME/.config/nvim"
mkdir -p $neovim_dir
touch $neovim_dir/init.vm
curl -fLo $neovim_dir/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Creating symlink for .vimrc"
if [ ! -e $neovim_dir/init.vim ]; then
  sudo ln -s $DOTFILES_PATH/nvimrc $neovim_dir/init.vim
fi
