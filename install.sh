#!/bin/bash
# Script to setup a new ubuntu dev environment including
#   - prerequisites
#   - neovim (from source)
#   - go, rust, node toolchains
#   - lazygit
#   - zellij
#   - google chrome
#   - keepass2
#   - gnome extensions
#   uvm.

sudo apt update
sudo apt upgrade -y
sudo apt install curl wget wl-clipboard ninja-build gettext cmake unzip build-essential xsel alacritty git vlc gnome-shell-extension-manager ripgrep keepass2 fzf gzip htop make diffutils g++ gettext mono-devel dirmngr gpg curl gawk libreoffice autoconf m4 libncurses5-dev libwxgtk3.2-dev libwxgtk-webview3.2-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev openjdk-11-jdk fd-find gnome-sushi gnome-tweak-tool gir1.2-gtop-2.0 gir1.2-gtkclutter-1.0 remmina pipx postgresql -y 

# More libs (copied from omakub)
sudo apt install -y \
  build-essential pkg-config autoconf bison clang rustc \
  libssl-dev libreadline-dev zlib1g-dev libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev libjemalloc2 \
  libvips imagemagick libmagickwand-dev mupdf mupdf-tools gir1.2-gtop-2.0 gir1.2-clutter-1.0 \
  redis-tools sqlite3 libsqlite3-0 libmysqlclient-dev libpq-dev postgresql-client postgresql-client-common

# Install language support
sudo apt install hunspell-de-de-frami hunspell-en-gb language-pack-de language-pack-de-base language-pack-en language-pack-en-base language-pack-gnome-de language-pack-gnome-de-base language-pack-gnome-en language-pack-gnome-en-base wngerman wogerman wbritish -y

# Default terminal
sudo update-alternatives --set x-terminal-emulator /usr/bin/alacritty

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

# Install LocalSend
LOCALSEND_VERSION=$(curl -s "https://api.github.com/repos/localsend/localsend/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
wget -O localsend.deb "https://github.com/localsend/localsend/releases/latest/download/LocalSend-${LOCALSEND_VERSION}-linux-x86-64.deb"
sudo apt install -y ./localsend.deb

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
cargo install eza

# Install nvm & node
# cd ~/source
# git clone git@github.com:nvm-sh/nvm.git
# cd nvm
# ./install.sh
# cd
# source .bashrc
# nvm install node

# Google Chrome
cd ~/Downloads
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
sudo apt-get install -f

# Docker
# Add the official Docker repo
sudo install -m 0755 -d /etc/apt/keyrings
sudo wget -qO /etc/apt/keyrings/docker.asc https://download.docker.com/linux/ubuntu/gpg
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update

# Install Docker engine and standard plugins
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras

# Give this user privileged Docker access
sudo usermod -aG docker ${USER}

# Limit log size to avoid running out of disk
echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json

cd ~/Downloads
LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -sLo lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz"
tar -xf lazydocker.tar.gz lazydocker
sudo install lazydocker /usr/local/bin

# Refresh font cache
fc-cache -f

# Gnome Extensions from Shell
pipx install gnome-extensions-cli --system-site-packages
gext install speedinator@liam.moe
gext install dash-to-panel@jderose9.github.com
gext install BingWallpaper@ineffable-gmail.com
gext install tophat@fflewddur.github.io
 
# Compile gsettings schemas in order to be able to set them
# sudo cp /.local/share/gnome-shell/extensions/dash-to-panel@jderose9.github.com/schemas/org.gnome.shell.extensions.dash-to-panel.gschema.xml /usr/share/glib-2.0/schemas/
# sudo glib-compile-schemas /usr/share/glib-2.0/schemas/
#
# Instead, we import the dconf settings from a file:
cd
dconf load / < ./dconf_settings.ini
