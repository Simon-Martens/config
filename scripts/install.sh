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

################################# SYSTEM PACKAGES & REQUIREMENTS ###########################################################################
sudo apt update
sudo apt upgrade -y
sudo apt install -y \
	tmux curl wget wl-clipboard ninja-build gettext cmake unzip xsel git vlc gnome-shell-extension-manager \
	ripgrep keepass2 fzf gzip htop make diffutils g++ gettext mono-devel dirmngr gpg curl gawk libreoffice autoconf \
	m4 libncurses5-dev libwxgtk3.2-dev libwxgtk-webview3.2-dev libgl1-mesa-dev libglu1-mesa-dev libpng-dev \
	libssh-dev unixodbc-dev xsltproc fop libxml2-utils libncurses-dev openjdk-11-jdk fd-find gnome-sushi \
	gnome-tweak-tool gir1.2-gtop-2.0 gir1.2-gtkclutter-1.0 remmina pipx postgresql inotify-tools \
	python3-pip python-is-python3 brightnessctl apt-listchanges \
  build-essential pkg-config autoconf bison clang rustc \
  libssl-dev libreadline-dev zlib1g-dev libyaml-dev libreadline-dev libncurses5-dev libffi-dev libgdbm-dev libjemalloc2 \
  libvips imagemagick libmagickwand-dev mupdf mupdf-tools gir1.2-gtop-2.0 gir1.2-clutter-1.0 \
  redis-tools sqlite3 libsqlite3-0 libmysqlclient-dev libpq-dev postgresql-client postgresql-client-common

# Install language support
sudo apt install hunspell-de-de-frami hunspell-en-gb language-pack-de language-pack-de-base language-pack-en language-pack-en-base language-pack-gnome-de language-pack-gnome-de-base language-pack-gnome-en language-pack-gnome-en-base wngerman wogerman wbritish -y


############################## LANGUAGES 
./install-go.sh
cd ~/scripts
./install-rust.sh
cd ~/scripts
./install-node.sh
cd ~/scripts
./install-zig.sh

############################# TOOLS
cd ~/scripts
./install-firefox.sh
cd ~/scripts
./install-neovim.sh
cd ~/scripts
./install-gnome-extensions.sh
cd ~/scripts
./install-lazygit.sh
cd ~/scripts
./install-localsend.sh
cd ~/scripts
./install-chrome.sh
cd ~/scripts
./install-brightness-controller.sh
cd ~/scripts
./install-zoxide.sh
cd ~/scripts
./install-flatpak.sh
cd ~/scripts
./install-docker.sh

############################ SETUP
cd ~
source ~/.bashrc
fc-cache -f # Refresh font cache
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm # Install tmux plugin manager
sudo timedatectl set-local-rtc 1 --adjust-system-clock # Avoid time issues with dual-boot setups
dconf load / < ~/scripts/dconf-settings.ini

