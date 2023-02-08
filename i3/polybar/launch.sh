#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
#while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload --config=/home/funnyboy_roks/.config/i3/polybar/config.ini main &
  done
else
  polybar --reload --config=/home/funnyboy_roks/.config/i3/polybar/config.ini main &
fi

#exec polybar --reload --config=/home/funnyboy_roks/.config/i3/polybar/config.ini main
