#!/usr/bin/env bash
# bright.sh — control brightness and show dunstify notification

# --- Functions ---
get_brightness() {
    brightnessctl get | awk -v max=$(brightnessctl max) '{print int($1 / max * 100)}'
}

progress_bar() {
    local val=$1
    local filled=$((val / 10))
    local empty=$((10 - filled))
    printf "%0.s█" $(seq 1 "$filled")
    printf "%0.s░" $(seq 1 "$empty")
}

show_brightness_notif() {
    local bright=$1
    local icon
    if [ "$bright" -lt 30 ]; then
        icon="🌙"
    elif [ "$bright" -lt 70 ]; then
        icon="🔆"
    else
        icon="☀️"
    fi
    local bar
    bar=$(progress_bar "$bright")
    local msg="$bar  $bright%"
    dunstify -a "Brightness" -r 9998 -u low "$icon Brightness" "$msg"
}

# --- Main logic ---
case "$1" in
    up)
        brightnessctl set +2%
        ;;
    down)
        brightnessctl set 2%-
        ;;
    *)
        echo "Usage: $0 {up|down}"
        exit 1
        ;;
esac

bright=$(get_brightness)
show_brightness_notif "$bright"

