#!/usr/env/bin/zsh

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
    echo "Installing lang $1"
    asdf install $1

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
    install_lang nodejs

    # Some text-editor utilities rely on a global typescript unfortuantely. What can you do :(
    npm install --global typescript-language-server typescript 
}


download_ruby() {
    install_plugin ruby https://github.com/asdf-vm/asdf-ruby.git 
    ruby_build_version="v20201225"
    echo "Using a specific ASDF ruby build version $ruby_build_version to install ruby $ruby_version"
    ASDF_RUBY_BUILD_VERSION=$ruby_build_version install_lang ruby
}

install_rust() {
    echo "Installing rust"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

configure_nim() {
    nimble install nimlsp
}

install_nim() {
    curl https://nim-lang.org/choosenim/init.sh -sSf | sh
}

manage_asdf_plugins() {
    install_plugin_erlang
    install_lang erlang

    install_plugin elixir
    install_lang elixir

    install_plugin kotlin https://github.com/asdf-community/asdf-kotlin.git
    install_lang kotlin

    install_plugin clojure https://github.com/asdf-community/asdf-clojure.git
    install_lang clojure

    # graalvm
    install_plugin graalvm https://github.com/vic/asdf-graalvm.git
    install_lang graalvm
    # gu should be exposed in $PATH in zshrc under graalvm home bin
    gu install native-image

    # special installs
    download_ruby
    download_node

    # install everything
    asdf install
}

download_asdf

manage_asdf_plugins

install_rust
install_nim
configure_nim
