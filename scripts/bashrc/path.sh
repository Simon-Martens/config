#!/bin/bash

if [ -d "$HOME/bin" ]; then
	PATH="$HOME/bin:$PATH"
	export PATH
fi
