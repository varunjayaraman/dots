#!/bin/zsh

echo "Installing neovim and symlinking config files"

cd $(mktemp -d)
git clone https://github.com/neovim/neovim --depth 1
cd neovim
sudo make CMAKE_BUILD_TYPE=Release install
cd ..
rm -rf neovim

ln -s $DOTFILES_PATH/nvim ~/.config/nvim

# setup packer
echo "setting up packer, a plugin manager for neovim"
git clone https://github.com/wbthomason/packer.nvim \
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

echo "done!"
