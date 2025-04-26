#!/bin/bash

# Install rustup -- Interactive
cd ~/Downloads
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y

if [ -d "$HOME/.cargo" ]; then
    . "$HOME/.cargo/env"
fi

cargo install --locked bat
