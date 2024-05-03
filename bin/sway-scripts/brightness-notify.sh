#!/bin/bash
set -x

VALUE=$(brightnessctl get)
MAX=$(brightnessctl max)
VALUE=$((VALUE * 100 / MAX))
TEXT="Brightness: ${VALUE}%"

notify-send \
    --expire-time 800 \
    --hint string:x-canonical-private-synchronous:brightness \
    --hint "int:value:$VALUE" \
    --hint "int:transient:1" \
    "${TEXT}"
