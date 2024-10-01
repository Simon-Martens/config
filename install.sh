#!/bin/bash
# Script to setup a new ubuntu dev environment including
#   - prerequisites
#   - neovim (from source)
#   - go, rust, node toolchains
#   - lazygit
#   - zellij
#   - google chrome
#   - keepass2
#

sudo apt update
sudo apt upgrade -y
sudo apt install curl wget wl-clipboard ninja-build gettext cmake unzip build-essential xsel alacritty git vlc gnome-shell-extension-manager ripgrep keepass2 fzf gzip htop make diffutils g++ gettext mono-devel dirmngr gpg curl gawk libreoffice autoconf m4 libncurses5-dev libwxgtk3.2-dev libwxgtk-webview3.2-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev openjdk-11-jdk -y 

# Install language support
sudo apt install hunspell-de-de-frami hunspell-en-gb language-pack-de language-pack-de-base language-pack-en language-pack-en-base language-pack-gnome-de language-pack-gnome-de-base language-pack-gnome-en language-pack-gnome-en-base wngerman wogerman wbritish -y

# Build neovim
mkdir source
cd source
git clone git@github.com:neovim/neovim.git
cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo 
sudo make install

# isntall asdf 
git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
source ~/.bashrc 
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
asdf plugin add erlang git@github.com:asdf-vm/asdf-erlang.git
asdf plugin add elixir git@github.com:asdf-vm/asdf-elixir.git
asdf plugin add golang git@github.com:asdf-community/asdf-golang.git
asdf plugin add rust git@github.com:asdf-community/asdf-rust.git
asdf plugin add dotnet git@github.com:hensou/asdf-dotnet.git
asdf plugin add air https://github.com/pdemagny/asdf-air.git

asdf install air latest
asdf install erlang latest
asdf install nodejs latest
asdf install elixir latest

asdf global nodejs latest
asdf global erlang latest
asdf global air latest
asdf global elixir latest

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
