#!/usr/bin/env sh

DIR="$HOME/44Bars/home/config/polybar"

# Terminate already running bar instances and env programs
pkill polybar
# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch
polybar top
polybar-msg action volume hook 0
