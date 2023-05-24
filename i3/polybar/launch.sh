#!/usr/bin/env sh

# Terminate already running bar instances
pkill polybar

skip_primary=false
# Create/remove a file in the directory (current file name with _set)
if [ ! -z $1 ] && [ $1 = "toggle" ]; then
    rm "$0_set" && skip_primary=true
fi

# Wait for all to close
while pgrep 'polybar' > /dev/null; do 0; done

# Funky shit to make each monitor on its own line and work properly in the for
#     This is probably only necessary because I don't know bash well enough...
#     But it works :shrug:
screens=$(xrandr --query | grep ' connected' | tr ' ' '|')

for m in $screens; do
    # Choose the correct bar for the screen 
    if [ $(echo $m | grep -i 'primary') ]; then
        bar=primary
    else
        bar=secondary
    fi
    if [ $bar = "primary" ] && [ $skip_primary = "true" ]; then
        continue;
    fi
    # Grab the first item (monitor name)
    m=$(echo $m | cut -d '|' -f1)
    MONITOR=$m polybar --reload --config=/home/funnyboy_roks/.config/i3/polybar/config.ini $bar &
done

# Create the set file
if [ ! $skip_primary = "true" ]; then
    touch "$0_set"
fi
