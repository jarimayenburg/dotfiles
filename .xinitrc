#!/bin/bash

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

# Start random wallpaper daemon
#randwald -l &

# Detect the screen configuration
autorandr --change

# Start Dunst
dunst &

# Start the statusbar daemon
statusbard &

# Start the CPU load monitoring daemon
[[ -x $(command -v cpuloadd) ]] && cpuloadd &

# Start a daemon that listens to systemd lock events and runs betterlockscreen
[[ -x $(command -v xss-lock) ]] && xss-lock -- betterlockscreen -l &

# Start the WM
[[ -x $(command -v startdwm) ]] && exec startdwm
