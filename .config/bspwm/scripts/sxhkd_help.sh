#!/bin/bash

cat ~/.config/bspwm/sxhkd/* | awk '/^[a-z]/ && last {print $0,"\t",last} {last=""} /^#/{last=$0}' | column -t -s $'\t' | rofi -dmenu -i
