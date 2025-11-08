#!/usr/bin/env bash

# --- Volume notification script for Hyprland + PipeWire + Dunstify ---
# Dependencies: wpctl, dunstify, awk, seq

get_vol() {
  # Returns integer volume (0–100)
  wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}'
}

is_muted() {
  # Returns "true" if muted
  wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q MUTED && echo "true" || echo "false"
}

show_notif() {
  vol=$(get_vol)
  muted=$(is_muted)

  if [ "$muted" = "true" ]; then
    icon="🔇"
    msg="Muted"
    bar="░░░░░░░░░░"
  else
    if [ "$vol" -eq 0 ]; then
      icon="🔈"
    elif [ "$vol" -lt 50 ]; then
      icon="🔉"
    else
      icon="🔊"
    fi

    # Build volume bar (10 segments)
    filled=$((vol / 10))
    empty=$((10 - filled))
    bar="$(printf "%0.s█" $(seq 1 $filled))$(printf "%0.s░" $(seq 1 $empty))"
    msg="$bar  $vol%"
  fi

  dunstify -a "Volume" -r 9999 -u low "$icon Volume" "$msg"
}

case "$1" in
  up)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    show_notif
    ;;
  down)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    show_notif
    ;;
  mute)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    show_notif
    ;;
  *)
    echo "Usage: $0 {up|down|mute}"
    ;;
esac

