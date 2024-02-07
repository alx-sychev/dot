# @plugins

export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
  git
  asdf
#  fzf-zsh-plugin
#  zsh-syntax-highlighting
#  vi-mode
#  laravel-sail
#  docker
#  docker-compose
#  kubectl
)

source $ZSH/oh-my-zsh.sh


# @opts

HISTSIZE=1000
SAVEHIST=1000

setopt notify
unsetopt beep
bindkey -v


# @fzf

source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh


# @aliases

alias c="clear"
alias x="exit"

alias v="nvim"

alias l1="ls -1"
alias la="ls -a"
alias ll="ls -la"
alias md="mkdir -p"

