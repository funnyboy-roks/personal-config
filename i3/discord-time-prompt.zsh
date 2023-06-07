#!/bin/zsh
#
# Prompts (using dmenu) for a time and then copies the discord format
# to the keyboard and prints to stdout

source ~/.zshrc

dt "$(dmenu -fn 'Anonymous Pro-24'< /dev/null)"
