#!/bin/sh

set -eu

sudo apt update

sudo apt install git \
  build-essential \
  ripgrep \
  tmux \
  zsh \
  curl \
  wget \
  apt-transport-https \
  ca-certificates \
  gnupg-agent \
  software-properties-common \
  libssl-dev \
  gnome-tweaks \
  automake \
  autoconf \
  libncurses5-dev

chsh -s $(which zsh)

sudo snap install code --classic
sudo snap install telegram-desktop
sudo snap install firefox
sudo snap install emacs --classic
sudo snap install slack --classic

sudo snap refresh


