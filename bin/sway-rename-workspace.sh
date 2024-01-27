#!/bin/bash

name=$(zenity --entry --text 'Rename workspace to')
RESULT=$?
if [ "$RESULT" == "0" ]; then
    id=$(swaymsg -t get_workspaces | jq -r '.[] | select(.focused) | .num')
    swaymsg rename workspace to "${id}:${id}:${name}"
fi
