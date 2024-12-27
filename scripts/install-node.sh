#!/bin/bash

# Install nvm & node
cd ~/source
git clone git@github.com:nvm-sh/nvm.git
cd nvm
./install.sh
cd
source .bashrc
nvm install node
