export DOTFILES=$HOME/dot

export EDITOR=nvim
export TERMINAL=st
export BROWSER=chromium

export PATH=$PATH:$DOTFILES/scripts

if [ "$(tty)" = "/dev/tty1" ]; then
    exec startx
fi
