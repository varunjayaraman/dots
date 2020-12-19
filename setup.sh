# This is a dotfile setup implementation for linux/ubuntu. Most of this should be transferrable to Macs or any unix-based system, but I created a
# separate file because the original implementation I wrote *was* specific to Mac

sudo apt update

DOTFILES_PATH="$HOME/dots"

# install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable edge"
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo apt install silversearcher-ag

# utils sudo apt install fzf
sudo apt install xclip

# Python
sudo apt install pip3

# Github CLI
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-key C99B11DEB97541F0

sudo apt-add-repository https://cli.github.com/packages

sudo apt update
sudo apt install gh

# setup dotfiles
echo "Creating symlink for .tmux.conf"
sudo ln -s $DOTFILES_PATH/tmux.conf $HOME/.tmux.conf

echo "Creating symlink for gitconfig..."
sudo ln -s $HOME/dots/gitconfig $HOME/.gitconfig

echo "Creating symlink for .agignore"
ln -s $HOME/dots/agignore $HOME/.agignore

echo "Creating symlink for emacs init.el..."
ln -s $HOME/dots/emacs/init.el $HOME/.emacs.d/init.el

echo "Downloading zsh"
sudo apt install zsh
chsh -s $(which zsh)

# install neovim
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage

chmod u+x nvim.appimage

sudo mv nvim.appimage /usr/bin/nvim

mkdir -p ~/.config/nvim
touch ~/.config/nvim/init.vm
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Creating symlink for .vimrc"
if [ ! -e $HOME/.config/nvim/init.vim ]; then
  sudo ln -s $DOTFILES_PATH/nvimrc $HOME/.config/nvim/init.vim
fi

# Terminal color profiles
sudo apt install dconf-cli uuid-runtime
bash -c  "$(wget -qO- https://git.io/vQgMr)"

# Bluetooth
snap install bluez

# Install rust & cargo
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

sudo curl -L https://github.com/rust-analyzer/rust-analyzer/releases/latest/download/rust-analyzer-linux -o /usr/local/bin/rust-analyzer

sudo chmod +x /usr/local/bin/rust-analyzer

rustup component add rustfmt
rustup component add clippy

# install haskell
sudo apt-get install haskell-platform

# Fonts
sudo apt install fonts-firacode
