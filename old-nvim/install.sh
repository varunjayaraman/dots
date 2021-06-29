echo "installing packer"

if [ -d ~/.local/share/nvim/site/pack/packer ]; then
  echo "Clearning previous packer installs"
  rm -rf ~/.local/share/nvim/site/pack
fi

echo -e "\n=> Installing packer"
git clone https://github.com/wbthomason/packer.nvim \
  ~/.local/share/nvim/site/pack/packer/start/packer.nvim
echo -e "=> packer installed!"

nvim +PackerSync
