#!/bin/bash
# Script to setup a new ubuntu dev environment including
#   - prerequisites
#   - neovim (from source)
#   - go, rust, node toolchains
#   - lazygit
#   - zellij
#   - google chrome
#
sudo apt update
sudo apt upgrade -y
sudo apt install curl wget wl-clipboard ninja-build gettext cmake unzip build-essential xsel alacritty git vlc gnome-shell-extension-manager -y

# Build neovim
mkdir source
cd source
git clone git@github.com:neovim/neovim.git
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo 
sudo make install

# Install latest go version
cd ~/Downloads
CURRENT_VERSION=$(go version | awk '{print $3}')
VERSION=$(curl -s https://go.dev/dl/?mode=json | jq -r '.[0].version')

echo "Current Go version: $CURRENT_VERSION"

if [ "$CURRENT_VERSION" = "$VERSION" ]; then
  echo "Go is already up to date!"
else
  echo "Downloading Go $VERSION..."
  wget -q https://go.dev/dl/$VERSION.linux-amd64.tar.gz

  echo "Removing old Go version..."
  sudo rm -rf /usr/local/go

  echo "Installing..."
  sudo tar -C /usr/local -xzf $VERSION.linux-amd64.tar.gz

  echo "Cleaning up..."
  rm $VERSION.linux-amd64.tar.gz

  echo "Go $VERSION installed!"
fi

# Install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# Install rustup -- Interactive
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

# Install zellij
cd
source .bashrc
cargo install --locked zellij

# Install nvm & node
cd ~/source
git clone git@github.com:nvm-sh/nvm.git
cd nvm
./install.sh
cd
source .bashrc
nvm install node

# Google Chrome
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f
