#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

LAUNCH_COMMAND="ck-launch-session"
#DEFAULT="wmii"
DEFAULT="stumpwm"

uim-xim &
export XMODIFIERS=@im=uim
export GTK_IM_MODULE="uim"
export QT_IM_MODULE=uim

setxkbmap us -variant colemak

xset r rate 255
xset r 66

xset -dpms
xset s off

urxvtd -q -o -f

#synergys --config ~/.synergy.conf


#if [[ "$1" != "kde" ]]; then xcompmgr & fi

case "$1" in
    kde)
        exec $LAUNCH_COMMAND startkde;;
    gnome)
        exec $LAUNCH_COMMAND gnome-session;;
    sawfish)
        #cairo-compmgr &
        nitrogen --restore
        exec $LAUNCH_COMMAND sawfish;;
    stumpwm)
        xsetroot -cursor_name left_ptr
        nitrogen --restore
        #eval `<$HOME/.fehbg`
        exec $LAUNCH_COMMAND $HOME/sys/src/stumpwm/stumpwm;;
    twm)
        exec twm;;
    wmii)
        xcompmgr &
        nitrogen --restore
        exec $LAUNCH_COMMAND wmii;;
esac

exec $LAUNCH_COMMAND $DEFAULT
