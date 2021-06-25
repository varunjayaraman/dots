#!/bin/sh

# Install Lua and build from source
lua_version=5.4.3
curl -R -O http://www.lua.org/ftp/lua-$lua_version.tar.gz
tar -zxf lua-$lua_version.tar.gz
cd lua-$lua_version
make linux test
sudo make install
cd $DOTFILES_PATH/setup
rm -rf lua-$lua_version
rm lua-$lua_version.tar.gz

luarocks_version=3.7.0
wget https://luarocks.org/releases/luarocks-$luarocks_version.tar.gz
tar zxpf luarocks-$luarocks_version.tar.gz
cd luarocks-$luarocks_version
./configure && make && sudo make install
cd $DOTFILES_PATH/setup
rm luarocks-$luarocks_version.tar.gz
rm -rf luarocks-$luarocks_version
