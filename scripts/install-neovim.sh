#!/bin/bash

# Building neovim from source
sudo apt install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
cd ~
mkdir source
cd source
git clone git@github.com:neovim/neovim.git
cd neovim
git pull
make CMAKE_BUILD_TYPE=RelWithDebInfo 
sudo make install

