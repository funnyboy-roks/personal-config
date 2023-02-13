#!/bin/bash
# Create the links to the files here

HERE=$(pwd)

if ! [ -e "$HOME/.config/i3" ]; then
    ln -s "$HERE/i3" ~/.config/i3
fi

for f in "$HERE"/desktops/*.desktop; do
    if [ -e "$f" ]; then 
        name=$(basename "$f")
        ln -s "$f" "$HOME/.local/share/applications/$name"
    fi
done

ln -s "$HERE/zsh/config.zsh" "$ZSH/custom/config.zsh"
ln -s "$HERE/zsh/.zshrc" "$HOME/.zshrc"
ln -s "$HERE/zsh/.p10k.zsh" "$HOME/.p10k.zsh"
ln -s "$HERE/.vimrc" "$HOME/.vimrc"
ln -s "$HERE/alacritty" "$HOME/.config/alacritty"
ln -s "$HERE/nvim" "$HOME/.config/nvim"

if ! [ -e "$HOME/.config/ulauncher" ]; then
    ln -s "$HERE/ulauncher" "$HOME/.config/ulauncher"
fi
