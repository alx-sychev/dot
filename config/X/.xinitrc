setxkbmap "us,ru" -option grp:alt_shift_toggle
[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources
sxhkd &
slstatus &

exec dwm
