echo "installing packer"

set -eu

rm -rf ~/.config/nvim

if [ -d ~/.local/share/nvim/site/pack/packer ]; then
  echo "Clearning previous packer installs"
  rm -rf ~/.local/share/nvim/site/pack
fi

echo -e "\n=> Installing packer"
git clone https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
echo -e "=> packer installed!"

ln -s $DOTFILES_PATH/inkdrop-nvim ~/.config/nvim

nvim +PackerSync
