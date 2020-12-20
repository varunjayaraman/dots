# This is a dotfile setup implementation for linux/ubuntu. Most of this should be transferrable to Macs or any unix-based system, but I created a
# separate file because the original implementation I wrote *was* specific to Mac

sudo apt update

DOTFILES_PATH="$HOME/dots"

# install docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io

sudo apt install silversearcher-ag \
		 xclip

# setup dotfiles
echo "Creating symlink for .tmux.conf"
sudo ln -s $DOTFILES_PATH/tmux.conf $HOME/.tmux.conf

echo "Creating symlink for gitconfig..."
sudo ln -s $DOTFILES_PATH/gitconfig $HOME/.gitconfig

echo "Creating symlink for .agignore"
ln -s $DOTFILES_PATH/agignore $HOME/.agignore

echo "Creating symlink for emacs init.el..."
mkdir $HOME/.emacs.d
ln -s $DOTFILES_PATH/emacs/init.el $HOME/.emacs.d/init.el

sudo add-apt-repository ppa:neovim-ppa/stable
sudo add-apt-repository ppa:neovim-ppa/unstable
sudo apt update
sudo apt install neovim

mkdir -p ~/.config/nvim
touch ~/.config/nvim/init.vm
curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Creating symlink for .vimrc"
if [ ! -e $HOME/.config/nvim/init.vim ]; then
  sudo ln -s $DOTFILES_PATH/nvimrc $HOME/.config/nvim/init.vim
fi

echo "Creating symlink for zshrc"
rm ~/.zshrc
sudo ln -s $DOTFILES_PATH/zshrc $HOME/.zshrc

echo "Installing rust"
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# Terminal color profiles
sudo apt install dconf-cli uuid-runtime

# Fonts
sudo apt install fonts-firacode

