[[ -f $HOME/.aliases ]] && source $HOME/.aliases

source ~/.antigen.zsh

antigen use oh-my-zsh

antigen bundles <<EOBUNDLES
  git
  git-extras
  knife
  npm
  ssh-agent
  sudo
  vagrant
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zsh-users/zsh-syntax-highlighting
EOBUNDLES

antigen theme cloud

antigen apply
