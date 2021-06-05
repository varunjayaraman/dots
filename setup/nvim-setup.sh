#!/bin/zsh

echo "Installing neovim and symlinking config files"

cd $(mktemp -d)
git clone https://github.com/neovim/neovim --depth 1
cd neovim
sudo make CMAKE_BUILD_TYPE=Release install
cd ..
rm -rf neovim

# LunarVim depends on the following:

pip3 install ranger-fm ueberzug pynvim neovim-remote

echo "done!"
