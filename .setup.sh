#!/bin/bash
# Helpful commands to setup a new system

# Import tilix settings
dconf load /com/gexperts/Tilix/ < .tilix.dconf

# Set folder permissions on .ssh folder
find .ssh/ -type f -exec chmod 600 {} \;; find .ssh/ -type d -exec chmod 700 {} \;; find .ssh/ -type f -name "*.pub" -exec chmod 644 {} \;

