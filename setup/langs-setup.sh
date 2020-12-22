#!/bin/zsh

download_asdf() {
  ASDF_VERSION="v0.8.0"
  ASDF_DIR="$HOME/.asdf"
  if [ ! -d $ASDF_DIR ]; then
    echo "ASDF folder does not exist, cloning now to $ASDF_DIR"
    git clone https://github.com/asdf-vm/asdf.git $ASDF_DIR --branch $ASDF_VERSION
  fi

  if [ -f "$ASDF_DIR/asdf.sh" ]; then
    . "$ASDF_DIR/asdf.sh" 
  fi

  echo "ASDF_DIR set to $ASDF_DIR"
  # append completions to fpath
  fpath=(${ASDF_DIR}/completions $fpath)
  # initialise completions with ZSH's compinit
  autoload -Uz compinit
  compinit 
}

install_plugin() {
  echo "Installing plugin $1"

  if [[ -z $1 && -z $2 ]]
  then
    asdf plugin-add $1 $2
  else
    asdf plugin-add $1
  fi
  if [ $? -eq 0 ]
  then
    echo "Added $1 plugin"
  else
    echo "$1 plugin already existed"
  fi
}

install_lang() {
  if [[ -z $1  && -z $2 ]]
  then
    echo "Installing lang $1 with version $2"
    asdf install $1 $2
  else
    echo "Installing lang $1 with latest version"
    asdf install $1 latest
  fi

  if [[ $? -eq 0 ]]
  then
    echo "Installed $1"
  else
    echo "$1 was already installed"
  fi
}

download_node() {
  install_plugin nodejs https://github.com/asdf-vm/asdf-nodejs.git
  zsh -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
  install_lang nodejs 14.15.3 # LTS as of time of writing
}

download_erlang() {
  install_plugin erlang
  install_lang erlang
}

download_elixir() {
  install_plugin elixir
  install_lang elixir
}

install_rust() {
  echo "Installing rust"
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

download_asdf
download_erlang
download_elixir
install_rust
download_node

