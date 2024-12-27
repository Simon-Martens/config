#!/bin/bash

cd ~
cd source
git clone git@github.com:ghostty-org/ghostty.git
cd ghostty

# Install dependencies, change if neccessary
sudo apt install libgtk-4-dev libadwaita-1-dev git

# Requires zig (as of now .13)
zig build -Doptimize=ReleaseFast

# Create directories if they don't exist
sudo mkdir -p usr/share/icons/hicolor/128x128/apps/
sudo mkdir -p usr/share/icons/hicolor/128x128@2/apps/
sudo mkdir -p usr/share/icons/hicolor/16x16/apps/
sudo mkdir -p usr/share/icons/hicolor/16x16@2/apps/
sudo mkdir -p usr/share/icons/hicolor/256x256/apps/
sudo mkdir -p usr/share/icons/hicolor/256x256@2/apps/
sudo mkdir -p usr/share/icons/hicolor/32x32/apps/
sudo mkdir -p usr/share/icons/hicolor/32x32@2/apps/
sudo mkdir -p usr/share/icons/hicolor/512x512/apps/

sudo cp -r images/icons/icon_128.png usr/share/icons/hicolor/128x128/apps/com.mitchellh.ghostty.png
sudo cp -r images/icons/icon_128@2.png usr/share/icons/hicolor/128x128@2/apps/com.mitchellh.ghostty.png
sudo cp -r images/icons/icon_16.png usr/share/icons/hicolor/16x16/apps/com.mitchellh.ghostty.png
sudo cp -r images/icons/icon_16x16@2.png usr/share/icons/hicolor/16x16@2/apps/com.mitchellh.ghostty.png
sudo cp -r images/icons/icon_256.png usr/share/icons/hicolor/256x256/apps/com.mitchellh.ghostty.png
sudo cp -r images/icons/icon_256@2.png usr/share/icons/hicolor/256x256@2/apps/com.mitchellh.ghostty.png 
sudo cp -r images/icons/icon_32.png usr/share/icons/hicolor/32x32/apps/com.mitchellh.ghostty.png
sudo cp -r images/icons/icon_32@2.png usr/share/icons/hicolor/32x32@2/apps/com.mitchellh.ghostty.png
sudo cp -r images/icons/icon_512.png usr/share/icons/hicolor/512x512/apps/com.mitchellh.ghostty.png

sudo mkdir -p usr/share/applications/
sudo cp -r dist/linux/app.desktop usr/share/applications/com.mitchellh.ghostty.desktop

sudo mkdir -p usr/share/bash-completion/completions/
sudo cp -r src/shell-integration/bash/ghostty.bash usr/share/bash-completion/completions/ghostty.bash

sudo mkdir -p usr/share/ghostty/
sudo mkdir -p usr/share/ghostty/themes/
sudo cp -r src/shell-integration usr/share/ghostty/



