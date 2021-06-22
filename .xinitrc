#!/bin/sh

userresources=$HOME/.Xresources
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

# Polkit authentication agent
lxpolkit &

# Set default cursor
xsetroot -cursor_name left_ptr

# Start the compositor
picom --no-fading-openclose &

# Set the background image
~/.fehbg &

# Start SXHKD
sxhkd &

# Detect the screen configuration
autorandr --change

# Set the statusbar just once. Cron takes over to refresh it every minute
setstatus

# Start the WM
[[ -x $(command -v xmonad) ]] && exec xmonad
[[ -x $(command -v dwm) ]] && exec dwm
