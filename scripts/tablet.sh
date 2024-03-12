#!/bin/sh
# Configure my drawing tablet

# for i in $(seq 10); do
#     if xsetwacom list devices | grep -q Wacom; then
#         break
#     fi
#     sleep 1
# done

# list=$(xsetwacom list devices)
# pad=$(echo "${list}" | awk '/pad/{print $7}')
# stylus=$(xsetwacom list devices | awk '/stylus/{print $7}')
# 
# if [ -z "${pad}" ]; then
#     exit 0
# fi

primary_monitor="$(xrandr | grep ' connected primary' | cut -d' ' -f1)"
stylus_device="$(xsetwacom list devices | grep 'STYLUS' | sed 's/\s\+id:.\+$//')"

echo "stylus_device = $stylus_device"
echo "primary_monitor = $primary_monitor"

xsetwacom set "$stylus_device" MapToOutput $primary_monitor
