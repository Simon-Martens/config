#!/usr/bin/env bash

export BASH_ENV="~/.bash_env"
export TERMINAL="ghostty"

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
fi
