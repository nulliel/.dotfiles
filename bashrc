[[ $- != *i* ]] && return
[[ -f /etc/bashrc ]] && . /etc/bashrc

# Aliases
alias watchNode="watch -n0 'ps -eH | grep node -B 2'"

# Scripts
eval "$(ssh-agent -s)"

# Exports
export N_PREFIX=$HOME/n
