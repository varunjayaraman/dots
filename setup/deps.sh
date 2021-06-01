#!/bin/sh

set -eu

install_docker_compose() {
  local docker_version="1.27.4"
  local path_to_docker_compose=/usr/local/bin/docker-compose
  sudo curl -L "https://github.com/docker/compose/releases/download/$docker_version/docker-compose-$(uname -s)-$(uname -m)" -o $path_to_docker_compose
  sudo chmod +x $path_to_docker_compose

  sudo usermod -aG docker $USER newgrp docker
}

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
  openjdk-13-jre \
  htop \
  inotify-tools \
  jq \
  rlwrap \
  libtool \
  libvterm-dev \
  cmake \
  pgcli \
  libwxgtk3.0-gtk3-dev \
  xsltproc \
  fop \
  libxml2-utils \
  unixodbc-dev \
  libz-dev \
  zlib1g-dev \
  gscan2pdf \
  imagemagick

# install_docker_compose
