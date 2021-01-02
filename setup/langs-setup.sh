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
    asdf plugin-add $1 $2
    if [ $? -eq 0 ]
    then
        echo "Added $1 plugin"
    else
        echo "$1 plugin already existed"
    fi
}

install_lang() {
    echo "Installing lang $1 with version $2"
    asdf install $1 $2

    if [[ $? -eq 0 ]]
    then
        echo "Installed $1"
    else
        echo "$1 was already installed"
    fi
}

download_node() {
    global_node_default="14.15.3"

    install_plugin nodejs https://github.com/asdf-vm/asdf-nodejs.git
    zsh -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
    install_lang nodejs $global_node_default # LTS as of time of writing

    asdf global nodejs $global_node_default
    # Some text-editor utilities rely on a global typescript unfortuantely. What can you do :(
    npm install --global typescript-language-server typescript 
}

download_erlang() {
    install_plugin erlang
    install_lang erlang latest
}

download_elixir() {
    install_plugin elixir
    install_lang elixir latest
}

download_ruby() {
    install_plugin ruby https://github.com/asdf-vm/asdf-ruby.git 
    ruby_build_version="v20201225"
    ruby_version="3.0.0"
    echo "Using a specific ASDF ruby build version $ruby_build_version to install ruby $ruby_version"
    ASDF_RUBY_BUILD_VERSION=$ruby_build_version install_lang ruby $ruby_version
}

install_rust() {
    echo "Installing rust"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

configure_nim() {
    nimble install nimlsp
}

download_asdf
download_erlang
download_elixir
install_rust
download_node
download_ruby
configure_nim

