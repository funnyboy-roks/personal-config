#!/bin/zsh
#
# Prompts (using dmenu) for a time and then copies the discord format
# to the keyboard and prints to stdout

source ~/.zshrc

dt $(echo "$1" "$(dmenu -fn 'Anonymous Pro-24' < /dev/null)" | cut -d' ' -f1-)
