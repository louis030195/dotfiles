#!/usr/bin/env bash

export PATH="$HOME/bin:$PATH"

# Load dotfiles
for file in ~/.{exports,aliases,extra}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file"
done
unset file

# Shell options
shopt -s nocaseglob 2>/dev/null
shopt -s histappend 2>/dev/null
shopt -s cdspell 2>/dev/null
shopt -s autocd 2>/dev/null
shopt -s globstar 2>/dev/null

# Git completion
if type _git &> /dev/null; then
    complete -o default -o nospace -F _git g
fi

# SSH completion
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config 2>/dev/null | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh

# Bash completion
[ -f /etc/bash_completion ] && . /etc/bash_completion

# Start in home directory
cd ~
