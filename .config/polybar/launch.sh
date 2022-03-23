#!/bin/bash

# Terminate already running bar instances
killall -q polybar

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --config=$HOME/.config/polybar/config.ini --reload mybar 2>&1 | tee -a /var/log/polybar.log &
  done
else
  polybar --reload example &
fi

echo "Polybar launched..."
