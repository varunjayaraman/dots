#!/bin/zsh

# Resources zshrc
function rz() {
  source ~/.zshrc && rehash
}

function get_op_pw() {
  pass=$(op get item $1 | jq -r '.details.fields[] | select(.designation=="password").value')

  if [ -n "$pass" ]
    then 
      echo $pass | xclip -selection clipboard
      echo "Password was copied - clipboard will be wiped in 15 seconds"
      sleep 15
      echo "" | xclip -selection clipboard
      echo "Clipboard reset."
  fi
}

function hard_docker_reset() {
  docker stop $(docker ps -aq)
  docker rm $(docker ps -aq)
  docker rmi -f $(docker images -aq)
}

function load_hmx_functions() {
  source $HOME/workspace/healthmetrix/dotfiles/functions.sh
}

function btl_connect_to() {
  until bluetoothctl connect $1; do echo "trying to connect..."; sleep 1; done
}

function btl_disconnect_to() {
  until bluetoothctl disconnect $1; do echo "trying to disconnect from $1"; sleep 1; done
}

function connect_to_wh_700_headphones() {
  btl_connect_to "70:26:05:39:DF:A6"

  # until bluetoothctl connect 70:26:05:39:DF:A6; do echo "trying to connect..."; sleep 1; done
}

function connect_to_soundlink_speaker() {
  btl_connect_to "60:AB:D2:09:85:CB"
}

function disconnect_to_wh_700_headphones() {
  btl_disconnect_to "70:26:05:39:DF:A6"
  # until bluetoothctl disconnect 70:26:05:39:DF:A6; do echo "trying to disconnect from Sony WH 700"; sleep 1; done
}

function disconnect_to_soundlink_speaker() {
  btl_disconnect_to "60:AB:D2:09:85:CB"
}

function delete_all_branches_but_master() {
  git branch | grep -v "master" | xargs git branch -D
}

function validate_cert() {
  openssl x509 -in $1 -text -noout
}

# Utility functions to ease PATH-building syntax
function path_prepend() {
    local path_search_dir=$1
    export PATH="${path_search_dir}:${PATH}"
}

function path_append() {
    local path_search_dir=$1
    export PATH="${PATH}:${path_search_dir}"
}

function use_graalvm() {
  case $(uname -s) in
    Darwin)
      export JAVA_HOME=/opt/graalvm/Contents/Home
      ;;
    Linux)
      export JAVA_HOME=/opt/graalvm
      ;;
  esac

  path_prepend ${JAVA_HOME}/bin
  java -version
}

function use_java() {
  export JAVA_HOME=$(/usr/libexec/java_home -v 14)  # Mac OSX java trick
  path_prepend ${JAVA_HOME}/bin
  java -version
}
