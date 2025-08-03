#!/usr/bin/env bash

get_volume_json() {
    local sink_info=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null)
    local mute_info=$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null)
    
    # Extract volume percentage (first channel)
    local volume=$(echo "$sink_info" | grep -oP '\d+%' | head -n1 | tr -d '%')
    volume=${volume:-0}
    
    # Check if muted
    local muted=$(echo "$mute_info" | grep -q "no" && echo "false" || echo "true")
    
    # Output JSON format for EWW
    echo "{\"volume\": \"$volume\", \"muted\": \"$muted\"}"
}

# Output initial state
get_volume_json

# Monitor for changes using pactl subscribe
pactl subscribe | while read -r event; do
    if [[ $event =~ sink ]]; then
        get_volume_json
    fi
done
