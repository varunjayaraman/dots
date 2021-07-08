#!/bin/bash

set -eu

function install_clojure() {
  local clojure_version="1.10.3.855"
  curl -O https://download.clojure.org/install/linux-install-$clojure_version.sh
  chmod +x linux-install-$clojure_version.sh
  sudo ./linux-install-$clojure_version.sh
}

install_clojure
