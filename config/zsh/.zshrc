HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

setopt notify
unsetopt beep
bindkey -v

plugins=(
#  git
#  fzf-zsh-plugin
#  zsh-syntax-highlighting
#  vi-mode
#  laravel-sail
#  docker
#  docker-compose
#  kubectl
)

# source $ZSH/oh-my-zsh.sh

alias c="clear"
alias x="exit"

alias v="nvim"

alias la="ls -a"
alias ll="ls -la"
alias md="mkdir -p"

