#!/bin/bash

wget -c https://weechat.org/files/src/weechat-3.2.tar.xz -O - | tar -xz

gpg --keyserver hkps://keys.openpgp.org --recv-keys A9AB5AB778FA5C3522FD0378F82F4B16DEC408F8

gpg --fingerprint A9AB5AB778FA5C3522FD0378F82F4B16DEC408F8

gpg --edit-key A9AB5AB778FA5C3522FD0378F82F4B16DEC408F8

$ gpg --verify weechat-3.2.tar.xz.asc weechat-3.2.tar.xz
