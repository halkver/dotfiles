#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
# echo "---" | tee -a /tmp/polybarexample.log
# polybar example  >>/tmp/polybarexample.log 2>&1 &

# echo "Bars launched..."


# Launch bar1 and bar2
if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload bottom >> /tmp/polybar.log 2>&1 &
  done
else
  polybar --reload bottom >> /tmp/polybar.log 2>&1 &
fi
# polybar bottom >>/tmp/polybarbottom.log 2>&1 &

echo "Bars launched..."
