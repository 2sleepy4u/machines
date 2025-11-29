#!/usr/bin/env bash
STATE_FILE="/tmp/battery-notify-state"

#!/bin/bash

# Threshold for low battery
THRESHOLD=15

# Read battery percentage
BAT=$(cat /sys/class/power_supply/BAT0/capacity)




LAST_STATE=$(cat "$STATE_FILE" 2>/dev/null || echo "ok")
if [ "$BAT" -le "$THRESHOLD" ] && [ "$LAST_STATE" != "low" ]; then
    dunstify -u critical -i battery-caution "⚠ Battery Low" "Battery at ${BAT}%"
    echo "low" > "$STATE_FILE"
elif [ "$BAT" -gt "$THRESHOLD" ]; then
    echo "ok" > "$STATE_FILE"
fi

echo $BAT
