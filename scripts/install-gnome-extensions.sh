#!/bin/bash

# Gnome Extensions from Shell
pipx install gnome-extensions-cli --system-site-packages
gext install speedinator@liam.moe
gext install dash-to-panel@jderose9.github.com
gext install BingWallpaper@ineffable-gmail.com
gext install tophat@fflewddur.github.io

# We need to install the Gesture improvement extensions from github if needed:
# https://github.com/jamespo/gnome-extensions/releases/tag/gnome46
