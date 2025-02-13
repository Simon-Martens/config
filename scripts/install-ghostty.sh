#!/bin/bash

cd ~
cd source
git clone git@github.com:ghostty-org/ghostty.git
cd ghostty
git pull

# Install dependencies, change if neccessary
sudo apt install libgtk-4-dev libadwaita-1-dev git -y

# Requires zig (as of now .13)
zig build -Doptimize=ReleaseFast

sudo cp -r zig-out/share /usr/local/
sudo cp zig-out/bin/ghostty /usr/local/bin/ 
