#!/bin/bash
# Create the links for all the config files to this directory
# _Note: This will rename any previous dir to "${DIR}_OLD"_

function mkln () {
    from="$1"
    to="$2"

    if ! [ -L "$to" ]; then # Move if it is not a link
        mv "$to" "$to_OLD" > /dev/null && echo "Moved $to to $to_OLD"
    else # Otherwise, yeet it
        target="$(readlink -f "$to")"
        rm "$to" && echo "Removed previous link ${to/$HOME/~} -> ${target/$HOME/~}"
    fi
    ln -s "$(pwd)/$from" "$to"
}

mkln "i3"             "$HOME/.config/i3"
mkln "zsh/config.zsh" "$ZSH/custom/config.zsh"
mkln "zsh/.zshrc"     "$HOME/.zshrc"
mkln "zsh/.p10k.zsh"  "$HOME/.p10k.zsh"
mkln ".vimrc"         "$HOME/.vimrc"
mkln "alacritty"      "$HOME/.config/alacritty"
mkln "nvim"           "$HOME/.config/nvim"
mkln "ulauncher"      "$HOME/.config/ulauncher"
mkln "autorandr"      "$HOME/.config/autorandr"
