#!/bin/bash

set -eu

function install_clojure() {
  local clojure_version="1.10.3.855"
  curl -O https://download.clojure.org/install/linux-install-$clojure_version.sh
  chmod +x linux-install-$clojure_version.sh
  sudo ./linux-install-$clojure_version.sh

  # install lein
  curl https://raw.githubusercontent.com/technomancy/leiningen/stable/bin/lein > lein
  sudo mv lein /usr/local/bin/lein
  sudo chmod +x /usr/local/bin/lein
}

install_clojure
