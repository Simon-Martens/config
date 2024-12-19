# .bashrc
# .bash_env is sourced if the command requires a non-interactive shell
export BASH_ENV="~/.bash_env"
export VISUAL=nvim
export EDITOR="$VISUAL"

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# SETUP PATH 

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

if [ -d "$HOME/.cargo" ]; then
    . "$HOME/.cargo/env"
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/home/simon/go/bin
export PATH=$PATH:/home/simon/.dotnet

# USER SCRIPTS

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# RUN ZELLIJ if available
# if command -v zellij &> /dev/null && [[ -z "$ZELLIJ" ]] && [[ $- == *i* ]]; then
#     if [[ "$ZELLIJ_AUTO_ATTACH" == "true" ]]; then
#         zellij attach -c
#     else
#         zellij
#     fi
#
#     if [[ "$ZELLIJ_AUTO_EXIT" == "true" ]]; then
#         exit
#     fi
# fi

alias ll='ls -salh --color=auto --hyperlink=auto'
alias e='nvim'
alias vim='nvim'
alias v='nvim'
alias c='clear'
alias g='git'
alias lg='lazygit'
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'
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
alias dn='dstask note'
alias dsync='dstask sync'
alias dnote='dstask note'
alias dstop='dstask stop'
alias drm='dstask remove'

# removal protection
alias rm='rm -I'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# COLOR SETTINGS
# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
    else
    color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls -salh --color=auto --hyperlink=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Check if kitty is running; set the ssh command accordingly
if [ -n "$KITTY_WINDOW_ID" ]; then
    alias ssh="kitten ssh"
fi

. "$HOME/.asdf/asdf.sh"
# Install Ruby Gems to ~/gems
export GEM_HOME="$HOME/gems"
export PATH="$HOME/gems/bin:$PATH"


export MANPAGER='nvim +Man!'

# tat: tmux attach
function tat {
  name=$(basename `pwd` | sed -e 's/\.//g')

  if tmux ls 2>&1 | grep "$name"; then
    tmux attach -t "$name"
  elif [ -f .envrc ]; then
    direnv exec / tmux new-session -s "$name"
  else
    tmux new-session -s "$name"
  fi
}
