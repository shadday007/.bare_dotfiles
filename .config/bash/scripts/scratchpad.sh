#!/usr/bin/bash

if [ -z $1 ]; then
    echo "Usage: $0 <name of hidden scratchpad window>"
    exit 1
fi

pids=$(xdotool search --class ${1})

for pid in $pids; do
    echo "Toggle $pids"
    bspc node $pid --flag hidden -f
done

if [ -z "$pids" ];then 
    source ~/.config/bash/scripts/note
fi
