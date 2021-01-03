#!/bin/sh

set -eu

sudo apt update

sudo apt install -y git \
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
  libncurses5-dev \
  xclip \
  silversearcher-ag \
  dconf-cli \
  uuid-runtime \
  fonts-firacode \
  zlib1g-dev \
  openjdk-11-jdk # things depends on java so its good to have

curl https://nim-lang.org/choosenim/init.sh -sSf | sh
