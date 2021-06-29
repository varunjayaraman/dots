#!/bin/sh

get_platform() {
  case "$(uname -s)" in
  Linux*) platform=Linux ;;
  Darwin*) platform=Mac ;;
  *) platform="UNKNOWN:${unameOut}" ;;
  esac
  echo $platform
}

echo "installing packer"

if [ -d ~/.local/share/nvim/site/pack/packer ]; then
  echo "Clearning previous packer installs"
  rm -rf ~/.local/share/nvim/site/pack
fi

echo -e "\n=> Installing packer"
git clone https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
echo -e "=> packer installed!"

rm -rf ~/.config/nvim
ln -s $DOTFILES_PATH/nvim ~/.config/nvim

# change shell in nvim config
read -p "which shell do you use?: " shellname
echo "$shellname"

if [ "$(get_platform)" = "Mac" ]; then
  gsed -i "s/bash/$shellname/g" $DOTFILES_PATH/nvim/lua/mappings.lua
else
  sed -i "s/bash/$shellname/g" $DOTFILES_PATH/nvim/lua/mappings.lua
fi

echo -e "\n=> shell changed to $shellname on nvim successfully!"
echo -e "\n=> neovim will open with some errors , just press enter" && sleep 1

# install all plugins + compile them
nvim +PackerSync
