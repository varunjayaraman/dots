#!/bin/zsh

echo "Running script"


download_asdf() {
    ASDF_VERSION="v0.8.0"
    ASDF_DIR="$HOME/.asdf"
    if [ ! -d $ASDF_DIR ]; then
        echo "ASDF folder does not exist, cloning now to $ASDF_DIR"
        git clone https://github.com/asdf-vm/asdf.git $ASDF_DIR --branch $ASDF_VERSION
    fi

    if [ -f "$ASDF_DIR/asdf.sh" ]; then
        \. "$ASDF_DIR/asdf.sh" 
    fi

    echo "ASDF_DIR set to $ASDF_DIR"
    # append completions to fpath
    fpath=(${ASDF_DIR}/completions $fpath)
    # initialise completions with ZSH's compinit
    autoload -Uz compinit
    compinit 
}

download_node() {
    asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    sh -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'

    asdf install nodejs latest
}

download_erlang() {
    asdf plugin-add erlang
    asdf install erlang latest
}

download_elixir() {
    asdf plugin-add elixir
    asdf install elixir latest
}

download_asdf
download_node
download_erlang
download_elixir

