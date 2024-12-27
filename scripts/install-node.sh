#!/bin/bash

# Install nvm & node
cd ~/source
git clone git@github.com:nvm-sh/nvm.git
cd nvm
./install.sh
cd
source .bashrc
nvm install node

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

npm install -g @fsouza/prettierd
