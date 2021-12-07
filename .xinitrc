#!/bin/sh

userresources=$HOME/.Xresources
userresourcescolors=$HOME/.Xresources-colors
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$userresourcescolors" ]; then
    xrdb -merge "$userresourcescolors"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

[ -x "$HOME/.fehbg" ] && ~/.fehbg

[ -x "$HOME/.xinit-input.sh" ] && ~/.xinit-input.sh

# adjust colors at night
redshift &

# deal with devices being connected and disconnected
xplugd

# enable compositing
picom -b

# notifications
dunst &

# fix displays
xrandr --output DisplayPort-3 --left-of DisplayPort-2

# turn off DPMS and blanking
xset s off -dpms

session=${1-i3}
case $session in
  2bwm) exec 2bwm;;
  bspwm) exec bspwm;;
  openbox) exec openbox-session;;
  i3) exec i3;;
  *) exec $1;;
esac
