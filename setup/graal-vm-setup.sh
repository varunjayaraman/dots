#!/bin/sh

set -eu

install_graal_vm() {
  local graal_version="20.3.0"
  local platform=$(uname -s)
  local path_to_graal=""
  local graal_dir="graalvm-ce-java11-$graal_version"

  case $platform in
    Darwin)
      path_to_graal="/opt"
      sudo mkdir -p $path_to_graal
      sudo wget -c https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-$graal_version/graalvm-ce-java11-$platform-amd64-$graal_version.tar.gz -O - | sudo tar -xz -C $path_to_graal
      sudo xattr -r -d com.apple.quarantine $path_to_graal/$graal_dir
      ;;

    Linux)
      path_to_graal="/usr/local/bin"
      sudo mkdir -p $path_to_graal
      sudo wget -c https://github.com/graalvm/graalvm-ce-builds/releases/download/vm-$graal_version/graalvm-ce-java11-$platform-amd64-$graal_version.tar.gz -O - | sudo tar -xz -C $path_to_graal
      ;;

    *)
      echo 'Other OS'
      ;;
  esac

  sudo ln -sFf $path_to_graal/$graal_dir /usr/local/bin/graalvm
}

install_graal_vm
