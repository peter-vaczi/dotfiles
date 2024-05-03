#!/usr/bin/env bash

item0=" lock"
item1=" logout"
item2=" suspend"
item3=" hibernate"
item4=" reboot"
item5=" shutdown"

menu="$item0|$item1|$item2|$item3|$item4|$item5"
choice=$(echo "$menu" | rofi -dmenu -location 3 -l 6 -sep '|' -theme-str 'window {width: 200px;}' -format i)

case $choice in
    0) swaymsg exec $HOME/bin/sway-scripts/lock.sh ;;
    1) swaymsg exit ;;
    2) systemctl suspend ;;
    3) systemctl hibernate ;;
    4) systemctl reboot ;;
    5) systemctl -i poweroff ;;
esac

