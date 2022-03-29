#!/bin/bash

# Terminate already running bar instances
polybar-msg cmd quit

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --config=$HOME/.config/polybar/config.ini --reload mybar 2>&1 | tee -a /var/log/polybar.log & disown
  done
else
  polybar --reload example &
fi

echo "Polybar launched..."
