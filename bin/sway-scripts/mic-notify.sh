#!/bin/sh

TEXT=$(pactl get-source-mute @DEFAULT_SOURCE@)

notify-send \
    --app-name sway \
    --expire-time 800 \
    --hint string:x-canonical-private-synchronous:mic \
    "${TEXT}"
