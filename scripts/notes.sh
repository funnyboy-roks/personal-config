#!/bin/sh

PORT=4000

live-reload -p $PORT build &> /dev/null &
live_reload_pid=$!
echo "live_reload_pid=$live_reload_pid"

fd '.*\.md' md | entr -ns 'blog-rs && pkill -HUP live-reload' &
loop_pid=$!
echo "loop_pid=$loop_pid"
trap_action () {
    echo "Killing live_reload_pid=$live_reload_pid"
    kill $live_reload_pid
    echo "Killing loop_pid=$loop_pid"
    kill $loop_pid
}

trap trap_action INT

sleep .1 && firefox --new-window http://localhost:$PORT &> /dev/null

wait
