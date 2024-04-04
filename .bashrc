# .bashrc
export VISUAL=nvim
export EDITOR="$VISUAL"

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/simon/go/bin

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

alias ls='ls -alh --color=auto'
alias e='nvim'
alias vim='nvim'
alias v='nvim'
alias c='clear'
alias g='git'
alias s='sudo'
alias h='history'
alias t='dstask'


# dstask aliases
alias d='dstask next'
alias da='dstask add'
alias ds='dstask start'
alias dd='dstask done'
alias dc='dstask context'
alias dm='dstask modify'
alias dl='dstask log'
alias de='dstask edit'
alias dsync='dstask sync'
alias dnore='dstask note'
alias dstop='dstask stop'
alias drm='dstask remove'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
