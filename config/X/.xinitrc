setxkbmap "us,ru" -option grp:alt_shift_toggle
sxhkd &
slstatus &
picom -b
xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap

exec dwm
