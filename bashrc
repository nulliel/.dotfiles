[[ $- != *i* ]] && return
[[ -f /etc/bashrc ]] && . /etc/bashrc

# General Exports
export HISTIGNORE='*'

# Node Exports
export BABEL_CACHE_PATH=$home/.cache/babel.json
export N_PREFIX=$HOME/n

command -v zsh >/dev/null 2>&1 || {
  read -p "$*Please install zsh. Press [Enter] to continue..."
}

zsh

