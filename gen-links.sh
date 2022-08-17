#!/bin/bash
# Create the links to the files here

HERE=$(pwd)

ln -s "$HERE/i3" ~/.config/i3

for f in "$HERE"/desktops/*.desktop; do
    if [ -e "$f" ]; then 
        name=$(basename "$f")
        ln -s "$f" "$HOME/.local/share/applications/$name"
    fi
done

ln -s "$HERE/zsh/config.zsh" "$ZSH/custom/config.zsh"
ln -s "$HERE/zsh/.zshrc" "$HOME/.zshrc"
ln -s "$HERE/zsh/.p10k.zsh" "$HOME/.p10k.zsh"

ln -s "$HERE/ulauncher" "$HOME/.config/ulauncher"
